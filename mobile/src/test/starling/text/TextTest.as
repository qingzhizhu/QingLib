package test.starling.text 
{
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	/**
	 * 字体
	 * @author gengkun123@gmail.com
	 */
	public class TextTest extends Sprite 
	{
		[Embed(source = "../../../../../assets/fonts/1x/desyrel.png")]
		private var _FONT : Class;
		[Embed(source = "../../../../../assets/fonts/1x/desyrel.fnt", mimeType = "application/octet-stream")]
		private var _FONT_DATA : Class;
		
		public function TextTest() 
		{
			var sprite : Sprite = new Sprite();
			var txt : TextField = new TextField(100, 30, "this is a text!");
			sprite.addChild(txt);
			//---------位图字体----------
			var texture : Texture = Texture.fromBitmap(new _FONT());
			var xml : XML = XML(new _FONT_DATA());
			TextField.registerBitmapFont(new BitmapFont(texture, xml));
			txt = new TextField(100, 30, "this is bitmap font!", "Desyrel");;// , -1, 0xFFFFFF);
			txt.border = true;
			txt.autoSize = "bothDirections";
			txt.autoScale = true;
			txt.bold = true;
			txt.hAlign = "right";
			txt.vAlign = "bottom";
			//txt.kerning
			txt.italic = true;
			txt.underline = true;
			txt.useHandCursor = true;
			txt.fontSize = BitmapFont.NATIVE_SIZE; // the native bitmap font size, no scaling
            txt.color = Color.WHITE; // use white to use the texture as it is (no tinting)
			
			txt.y = 50;
			sprite.addChild(txt);
			
			addChild(sprite);
		}
		
	}

}