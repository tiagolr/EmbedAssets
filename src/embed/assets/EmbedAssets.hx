package embed.assets;

/**
 * 
 * @author TiagoLr ( ~~~ProG4mr~~~ )
 */

 import haxe.Serializer;
 import haxe.Unserializer;
 import haxe.macro.Context;
 import haxe.io.Bytes;
 import haxe.io.BytesData;
 
 
class EmbedAssets 
{
	
	#if macro	
	static var mImageKeys		:Array<String>		= new Array<String>();
	static var mImageEncData	:Array<String>		= new Array<String>();
	
	static var mSoundKeys		:Array<String>		= new Array<String>();
	static var mSoundEncData	:Array<String>		= new Array<String>();
	
	static var mTextKeys		:Array<String>		= new Array<String>();
	static var mTextEncData		:Array<String>		= new Array<String>();
	
	static var mFontKeys		:Array<String>		= new Array<String>();
	static var mFontEncData		:Array<String>		= new Array<String>();
	
	static var mByteKeys		:Array<String>		= new Array<String>();
	static var mByteEncData		:Array<String>		= new Array<String>();
	#end	
	
	static public var imageKeys		:Array<String>		= new Array<String>();
	static public var imageData		:Array<BytesData>	= new Array<BytesData>();
	
	static public var soundKeys		:Array<String>		= new Array<String>();
	static public var soundData		:Array<BytesData>	= new Array<BytesData>();
	
	static public var textKeys		:Array<String>		= new Array<String>();
	static public var textData		:Array<String>		= new Array<String>();
	
	static public var fontKeys		:Array<String>		= new Array<String>();
	static public var fontData		:Array<BytesData>	= new Array<BytesData>();
	
	static public var byteKeys		:Array<String>		= new Array<String>();
	static public var byteData		:Array<BytesData>	= new Array<BytesData>();
	
	/**
	 * Creates the embed data for the assets. 
	 * @param	path The path to the asset.
	 * @param	type Asset type can be "IMAGE", "TEXT" or "BYTES".
	 * @param	name The unique name associated with this asset.
	 */
	@:macro public static function serialize(path:String, type:String, name:String)
	{
		var rawText;
		var rawBytes = neko.io.File.getBytes(path);
		var serialized = Serializer.run(rawBytes);
		
		switch(type) {
			case "IMAGE": 
				mImageKeys.push(name);
				mImageEncData.push(serialized);			
			case "SOUND": 
				mSoundKeys.push(name);
				mSoundEncData.push(serialized);
			case "FONT"	: 
				mFontKeys.push(name);
				mFontEncData.push(serialized);
			case "TEXT" : 
				mTextKeys.push(name);
				mTextEncData.push(rawBytes.toString());
			case "BYTES": 
				mByteKeys.push(name);
				mByteEncData.push(serialized);
			default: null;
		}	
		
       return Context.makeExpr("null", Context.currentPos());
	}

	@:macro static function getImageKeys()
	{
        return Context.makeExpr(mImageKeys,Context.currentPos());
	}
	
	@:macro static function getImageData()
	{
        return Context.makeExpr(mImageEncData,Context.currentPos());
	}
	
	@:macro static function getSoundKeys()
	{
        return Context.makeExpr(mSoundKeys,Context.currentPos());
	}
	
	@:macro static function getSoundData()
	{
        return Context.makeExpr(mSoundEncData,Context.currentPos());
	}
	
	@:macro static function getFontKeys()
	{
        return Context.makeExpr(mFontKeys,Context.currentPos());
	}
	
	@:macro static function getFontData()
	{
        return Context.makeExpr(mFontEncData,Context.currentPos());
	}
	
	@:macro static function getByteKeys()
	{
        return Context.makeExpr(mByteKeys,Context.currentPos());
	}
	
	@:macro static function getByteData()
	{
        return Context.makeExpr(mByteEncData,Context.currentPos());
	}
	
	@:macro static function getTextKeys()
	{
        return Context.makeExpr(mTextKeys,Context.currentPos());
	}
	
	@:macro static function getTextData()
	{
        return Context.makeExpr(mTextEncData,Context.currentPos());
	}
	
	/**
	 * Unserializes data and have Resources class to convert the data to 
	 * BitmapData, Sound, Text(String), ByteArray, and Font formats.
	 * 
	 * Before calling this method, add an eventListener to the stage 
	 * with type "ASSETS_LOADED".
	 * When this event is fired, Resources.instance is ready 
	 * to provide the embed assets with their type.
	 */
	public static function init()
	{
		setImageData(getImageKeys(), getImageData());
		setSoundData(getSoundKeys(), getSoundData());
		setFontData(getFontKeys(), getFontData());
		setTextData(getTextKeys(), getTextData());
		setByteData(getByteKeys(), getByteData());
	}

	static function setImageData(keys:Array<String> ,data:Array<String>) {
		if (keys.length > 0) {
			imageKeys = keys;
			for (i in 0...keys.length) {
				imageData.push(cast (Unserializer.run(data[i]), Bytes).getData());
			}
		}
	}
	
	static function setSoundData(keys:Array<String> ,data:Array<String>) {
		if (keys.length > 0) {
			soundKeys = keys;
			for (i in 0...keys.length) {
				soundData.push(cast (Unserializer.run(data[i]), Bytes).getData());
			}
		}
	}
	
	static function setTextData(keys:Array<String> ,data:Array<String>) {
		if (keys.length > 0) {
			textKeys = keys;
			textData = data;
		}
	}
	
	static function setFontData(keys:Array<String> ,data:Array<String>) {
		if (keys.length > 0) {
			fontKeys = keys;
			for (i in 0...keys.length) {
				fontData.push(cast (Unserializer.run(data[i]), Bytes).getData());
			}
		}
	}
	
	static function setByteData(keys:Array<String> ,data:Array<String>) {
		if (keys.length > 0) {
			byteKeys = keys;
			for (i in 0...keys.length) {
				byteData.push(cast (Unserializer.run(data[i]), Bytes).getData());
			}
		}
	}
	
	


	private function new() { }

 }