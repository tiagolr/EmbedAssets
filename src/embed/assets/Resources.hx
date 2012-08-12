package embed.assets;


import nme.display.Bitmap;
import nme.events.Event;
import nme.display.BitmapData;
import nme.Lib;
import nme.display.Loader;
import nme.display.LoaderInfo;
import nme.media.Sound;
import nme.text.Font;
import nme.utils.ByteArray;
import haxe.io.BytesData;

/**
 * 
 * @author TiagoLr ( ~~~ProG4mr~~~ )
 */

class Resources
{
	static private var canInstanciate				:Bool = true;
	static private var _instance					:Resources = new Resources();
	static public var instance(get_instance, null)	:Resources;
	
	static var BitmapDataHash	:Hash<BitmapData>	= new Hash<BitmapData>();
	static var SoundsHash		:Hash<Sound>		= new Hash<Sound>();
	static var FontsHash		:Hash<Font>			= new Hash<Font>();
	static var BytesHash		:Hash<ByteArray>	= new Hash<ByteArray>();
	static var TextHash			:Hash<String>		= new Hash<String>();
	
	private var fBitmapsReady	:Bool;
	private var fSoundsReady	:Bool;
	private var fFontsReady		:Bool;
	private var fTextReady		:Bool;
	private var fBytesReady		:Bool;
	
	private var imageKeys		:Array<String>;
	private var imageData		:Array<BytesData>;
	
	private var soundKeys		:Array<String>;
	private var soundData		:Array<BytesData>;
	
	private var textKeys		:Array<String>;
	private var textData		:Array<String>;
	
	private var fontKeys		:Array<String>;
	private var fontData		:Array<BytesData>;
	
	private var byteKeys		:Array<String>;
	private var byteData		:Array<BytesData>;
	
	public function new() 
	{
		if (canInstanciate == false) {
			throw "Resources is a singleton, please use Resources.instance";
		}
		canInstanciate = false;	
	}
	
	static public function init() 
	{
		instance.imageKeys	= EmbedAssets.imageKeys;
		instance.imageData 	= EmbedAssets.imageData;
		
		instance.byteKeys 	= EmbedAssets.byteKeys;
		instance.byteData	= EmbedAssets.byteData;
		
		instance.fontKeys	= EmbedAssets.fontKeys;
		instance.fontData	= EmbedAssets.fontData;
		
		instance.soundKeys	= EmbedAssets.soundKeys;
		instance.soundData	= EmbedAssets.soundData;
		
		instance.textKeys	= EmbedAssets.textKeys;
		instance.textData 	= EmbedAssets.textData;
		
		instance.createBitmapData();
		instance.createSoundData();
		instance.createTextData();
		instance.createByteData();
		instance.createFontData();
	}
	
	/**
	 * Starts bitmapData asset type load cycle, this function is repeatly called
	 * until all the assets of this type are loaded/created,  the calls are made after 
	 * each each has been loaded and converted and stored.
	 */
	private function createBitmapData() 
	{
		if (imageKeys.length == 0) {
			fBitmapsReady = true;
			testForAllReady();
			return;				// Breaks this asset load cycle.
		}
		
		var loader:Loader = new Loader();
		loader.loadBytes(imageData.pop());
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteLoadBitmapData);
				
	}
	
	private function onCompleteLoadBitmapData(e:Event):Void 
	{
		var bitmapData:BitmapData = cast((cast(e.currentTarget, LoaderInfo).content), Bitmap).bitmapData;
		BitmapDataHash.set(imageKeys.pop(), bitmapData);
		createBitmapData();
	}
	

	/**
	 * Starts sound asset type load cycle, this function is repeatly called
	 * until all the assets of this type are loaded/created,  the calls are made after 
	 * each each has been loaded and converted and stored.
	 */
	private function createSoundData() 
	{
		if (soundKeys.length == 0) {
			fSoundsReady = true;
			testForAllReady();
			return;				// Breaks this asset load cycle.
		}
	}
	
	private function createTextData() 
	{
		while ( textKeys.length != 0 ) {
			TextHash.set(textKeys.pop(), textData.pop());
		}
			
		fTextReady = true;
		testForAllReady();
	}

	private function createByteData() 
	{
		while ( byteKeys.length != 0 ) {
			BytesHash.set(byteKeys.pop(), byteData.pop());
		}
			
		fBytesReady = true;
		testForAllReady();		
		
	}
	/**
	 * Starts font asset type load cycle, this function is repeatly called
	 * until all the assets of this type are loaded/created,  the calls are made after 
	 * each each has been loaded and converted and stored.
	 */
	private function createFontData() 
	{
		if (fontKeys.length == 0) {
			fFontsReady = true;
			testForAllReady();
			return;				// Breaks this asset load cycle.
		}
	}
	
	private function testForAllReady() {
		if (fBitmapsReady	&&
			fSoundsReady 	&&
			fTextReady		&&
			fFontsReady		&&
			fBytesReady		)
			Lib.stage.dispatchEvent(new Event("ASSETS_LOADED"));
	}
	
	static public function getBitmapData( name:String ):BitmapData {
		if ( false == BitmapDataHash.exists( name ) ) 
			throw "Invalid BitmapData request " + name;
		
			return BitmapDataHash.get( name );
	}
	
	static public function getText( name:String ):String {
		if ( false == TextHash.exists( name ))
			throw "Invalid Text request " + name;
			
			return TextHash.get( name );
	}
	
	static public function getBytes( name:String ):ByteArray {
		if ( false == BytesHash.exists( name ) )
			throw "Invalid ByteArray request " + name;
			
			return BytesHash.get( name );
	}
	
	
	static private function get_instance():Resources 
	{
		return _instance;
	}
	


}