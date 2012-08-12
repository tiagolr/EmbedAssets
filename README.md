EmbedAssets is an haxe nme tool that stores serializes and stores external assets in your code using  haxe macros.

____________

### Usage example:

```hx

// Assets serialization 
EmbedAssets.serialize("images/testimage.png", "IMAGE", "ImgTest");
Lib.stage.addEventListener("ASSETS_LOADED", onAssetsLoaded);
EmbedAssets.init();
Resources.init();		

private function onAssetsLoaded(e:Event):Void 
{
	addChild(new Bitmap(Resources.getBitmapData("ImgTest")));
}

```hx



### Suported assets type:
At the moment, files can be serialized, stored and retreived as:

<ul>
<li>BitmapData 	- use "IMAGE"	as type argument for serialize method. (use this for png, jpeg).</li>
<li>String  	- use "TEXT" 	as type argument for serialize method. (use this for anyfile you want to retreive as a string).</li>
<li>ByteArray	- use "BYTES" 	as type argument for serialize method. (use this for anything else).</li>
</ul>

### Notes:

<ul>
<li>For now there is no support for Sound or Font type, let me know if you figure how they can be created from bytearrays.</li>
</ul>