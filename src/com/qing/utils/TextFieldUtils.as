package com.qing.utils 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class TextFieldUtils 
	{
		/**
		 * 只改变一次textfield 的颜色,在text后面设置，不采用defaultTextFormat.
		 * @param text
		 * @param color
		 * 
		 */		
		public static function changeTextColor(txt:TextField, color:uint):void{
			var tf : TextFormat = txt.defaultTextFormat;
			tf.color = color;
			txt.setTextFormat(tf);
		}
		
		public static function setTextFormatDetail(txt:TextField, font:String=null, size:Object=null, color:Object=null, bold:Object=null, italic:Object=null, underline:Object=null, url:String=null, target:String=null, align:String=null, leftMargin:Object=null, rightMargin:Object=null, indent:Object=null, leading:Object=null):void {
			//var tf : TextFormat = new TextFormat(font, size, color, bold, italic, underline, url, target, align, leftMargin, rightMargin, indent, leading);
			var tf : TextFormat = txt.defaultTextFormat;
			tf.font = font;
			tf.size = size;
			tf.color = color;
			tf.bold = bold;
			tf.italic = italic;
			tf.underline = underline;
			tf.url = url;
			tf.target = target;
			tf.align = align;
			tf.leftMargin = leftMargin;
			tf.rightMargin = rightMargin;
			tf.indent = indent;
			tf.leading = leading;
			txt.defaultTextFormat = tf;
		}
		
		/*public static function setTextFormat(txt:TextField, tf:TextFormat):void {
			txt.defaultTextFormat = tf;
		}*/
		
	}

}