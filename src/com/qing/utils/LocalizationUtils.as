package com.qing.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
//	import flashx.textLayout.utils.CharacterUtil;
	
	public class LocalizationUtils
	{
		
		private static const ARIAL_UNICODE_FONT:String = "Arial Unicode MS";
		//private static const SONGTI_FONT:String = "宋体";
		
		/**Languages that need to use some "native" font*/
		private static const SPECIAL_LANGUAGES:Array =
			[
				"ru",
				"zt",	// Traditional Chinese
				"zs",	// Chinese
				"zh",	// Chinese
				"ja",	// Japanese
				"th",	// Thai
				"ar",	// Arabic
				"el",	// Greek
				"sr",	// Serbian
				"hi",	// Hindi
				"ko",   // Korean
				"ch",	//chinese
			];
		
		/**Languages that have issues in with line spacing*/
		private static const LINE_SPACE_ISSUE_LANGUAGES:Array =
			[
				"hi" //Hindi
			];
		
		/**
		 * Returns true if language has special characters and needs to use some "native" font
		 
		public static function languageHasSpecialCharacters():Boolean
		{
			return SPECIAL_LANGUAGES.indexOf(Config.smLanguageCode) != -1;
		}*/
		
		/**
		 * Returns true if language Flash has issues in line splitting.
		 
		public static function languageHasLineSpaceIssues():Boolean
		{
			return LINE_SPACE_ISSUE_LANGUAGES.indexOf(Config.smLanguageCode) != -1;
		}*/
		
		
		/**
		 * Replaces the embedded fonts from the all the textfields in the DisplayObject d
		 */
		public static function replaceFonts( mc:DisplayObject) : void
		{
			//if(languageHasSpecialCharacters())
			//{
				CallForAllChildren(mc, replaceFont, null);
			//}
		}
		
		/**
		 * Replaces the embedded fonts from the DisplayObject d, if it is a TextField
		 */
		public static function replaceFont(d:DisplayObject, args:Array = null) : void
		{
			//if(languageHasSpecialCharacters())
			//{
				var tf:TextField = d as TextField;
				if (tf)
				{
					tf.mouseEnabled = false;
					if (tf.defaultTextFormat.font !=  ARIAL_UNICODE_FONT)//SONGTI_FONT)//
					{
						
						const text:String = tf.text;
						const format:TextFormat = tf.defaultTextFormat;
						const fontSizeDec:int = 1;//2;
						const fontSize: int = int(format.size);
						
						const newFormat:TextFormat = new TextFormat(/*SONGTI_FONT,*/ARIAL_UNICODE_FONT,
							fontSize > 10 ? fontSize - fontSizeDec : fontSize, format.color, format.bold, format.italic,
							format.underline, format.url, format.target, format.align, format.leftMargin, format.rightMargin,
							format.indent, format.leading < 0 ? 2 : format.leading );
						
						tf.defaultTextFormat = newFormat;
						tf.useRichTextClipboard = true;
						tf.embedFonts = false;
						tf.text = text;
						
					}
				}
			//}
		}
		
		
		
		public static function CallForAllChildren( root:DisplayObject, func:Function, args:Array ) : void
		{
			var i:int = 0;
			
			if (root is DisplayObjectContainer)
			{
				var doc:DisplayObjectContainer = DisplayObjectContainer(root);
				func(root, args);
				for ( i = 0; i<doc.numChildren; i++ )
				{
					var o:DisplayObject = doc.getChildAt(i);
					CallForAllChildren( o, func, args);
				}
			}
			else
			{
				func(root, args);
			}
		}
		
		
		/**
		 * Checks that texts are split by linespaces, not in the middle of words
		 * Fixes a problem with Hindi and maybe some other languages too
		 */
		public static function fixLineSpacing( tf:TextField ):void
		{
			//if(!languageHasLineSpaceIssues())
			//{
				//return;
			//}
			var numLines:int = tf.numLines;
			//try to fix splitline for hindi
			var modifiedText:String = "";
			var remainderText:String = "";
			var index:int = 0;
			const text:String = tf.text;
			
			if(tf.numLines > 1)
			{
				for(var i:int = 0; i < numLines; i++)
				{
					var line:String = tf.getLineText(i);
					line = remainderText + line;
					index += line.length;
					remainderText = "";
					//Do we need to go back for previous whiteSpace
					if((i < (numLines - 1)))
					{
						var char:int = text.charCodeAt(index);
						var lineEnd:String = line.substring(line.length - 1);
						
						var correctSplit:Boolean = /*CharacterUtil.*/isWhitespace(char) || lineEnd == "\r" || lineEnd == "\n";
						if(!correctSplit)
						{
							remainderText = line.substring(line.lastIndexOf(" ") + 1);
							line = line.substring(0, line.lastIndexOf(" "));
							line = line + "\r";
						}
					}
					modifiedText += line;
				}
				if(modifiedText)
				{
					tf.text = modifiedText;
				}
			}
		}
		
		private static function isWhitespace(char:int):Boolean{
			
			switch(char){
				case 0x0020:
				case 0x1680:
				case 0x180E:
				case 0x2000:
				case 0x2001:
				case 0x2002:
				case 0x2003:
				case 0x2004:
				case 0x2005:
				case 0x2006:
				case 0x2007:
				case 0x2008:
				case 0x2009:
				case 0x200A:
				case 0x202F:
				case 0x205F:
				case 0x3000:
				case 0x2028:
				case 0x2029:
				case 0x0009:
				case 0x000A:
				case 0x000B:
				case 0x000C:
				case 0x000D:
				case 0x0085:
				case 0x00A0:
					return true;
			}
			return false;
		}
		
	}
}