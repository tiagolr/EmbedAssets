# EmbedAssets

EmbedAssets is an haxe nme tool that allows you to store external assets inside the binaries at compile-time using macros, and retreive them at run-time.
____________

### Suported asset types:

Files of any type can be embed in the compiled code. They can be retreived as:

<ul>
<li>BitmapData  - using "IMAGE" as serialize() argument. (use this for png, jpeg).</li>
<li>String      - using "TEXT" as serialize() argument. (use this for anyfile you want to retreive as a string).</li>
<li>ByteArray   - using "BYTES" as type argument for serialize method. (use this for anything else).</li>
</ul>

### Usage example:


```text

// Assets serialization 

private function init() {
    EmbedAssets.serialize("images/testimage.png", "IMAGE", "ImgTest");
    Lib.stage.addEventListener("ASSETS_LOADED", onAssetsLoaded);
    EmbedAssets.init();
    Resources.init();		
}

private function onAssetsLoaded(e:Event):Void 
{
	addChild(new Bitmap(Resources.getBitmapData("ImgTest")));
}

```
<ul>
<li>Files are stored at compile-time using EmbedAssets.serialize() method.</li>
<li>Files can be retreived from Resources class using getBitmapData(), getText() or getBytes() method (like mne.Assets).</li>
<li>More information one the arguments are availibe in the sc.</li>
</ul>

### Notes:

<ul>
<li>For now there is no support for Sound or Font types, let me know if you figure how they can be created from bytearrays.</li>
</ul>