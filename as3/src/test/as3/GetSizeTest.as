package test.as3
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.media.Video;
	import flash.net.URLRequest;
	import flash.sampler.getSize;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	import org.bytearray.explorer.events.SWFExplorerEvent;
	import org.bytearray.explorer.SWFExplorer;
	
	/**
	 * get size , 默认值和内存
	 * @author Kevin Geng
	 */
	public class GetSizeTest extends Sprite
	{
		
		public function GetSizeTest()
		{
			init();
			/* 想用SWFExplorer 不能用。。。。
			var explorer:SWFExplorer = new SWFExplorer();
			
			explorer.load(new URLRequest("assets/playerglobal.swc"));
			
			explorer.addEventListener(SWFExplorerEvent.COMPLETE, assetsReady);
			
			function assetsReady(e:SWFExplorerEvent):void
			{
				
// outputs : org.groove.Funk,org.funk.Soul,org.groove.Jazz
				trace(e.definitions);
				
// outputs : org.groove.Funk,org.funk.Soul,org.groove.Jazz
				trace(e.target.getDefinitions());
				
// ouputs : 3
				trace(e.target.getTotalDefinitions());
			
			}
			return;
			return;*/
			
			var temp:*;
			//{ region boolean
			text("-------------Boolean-------------");
			var boolean1:Boolean = true;
			showSize(boolean1);
			//} endregion
			
			//{ region 
			text("-------------int, uint, Number-------------");
			var int1:int;
			showSize(int1);
			int1 = 10;
			showSize(int1, "10");
			int1 = int.MAX_VALUE;
			showSize(int1, "int.MAX_VALUE, change to Number");
			int1 = int.MIN_VALUE + 1;
			showSize(int1, "int.MIN_VALUE, change to Number");
			
			var uint1:uint;
			showSize(uint1, "? not unit?");
			uint1 = 2147483847; // int.MAX_VALUE + 10;
			showSize(uint1, "? not unit?int.MAX_VALUE");
			uint1 = uint.MAX_VALUE;
			showSize(uint1, "uint.MAX_VALUE, change to Number");
			
			var num:Number;
			showSize(num);
			temp = Number.MAX_VALUE;
			showSize(temp, "NUMBER.MAX_VALUE");
			temp = Number.MIN_VALUE;
			showSize(temp, "Number.MIN_VALUE");
			
			//} endregion
			
			//{ region String
			text("-------------String-------------");
			var str:String;
			showSize(str, "null is 4 bytes.");
			str = "";
			showSize(str, "empty is 24 bytes or 40.");
			str = "01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789abcdefghigk01234567890123456789";
			showSize(str, str);
			str = "abc你好";
			showSize(str, "中文");
			//} endregion
			
			//{ region object
			text("-------------Object-------------");
			var obj:*;
			showSize(obj, "* type is void; value is undefined. size 4.");
			temp = {};
			showSize(temp, "object");
			temp = new Object();
			showSize(temp, "new object");
			temp.name = "test";
			showSize(temp, "object.name");
			//} endregion
			
			//{ region Array vector
			text("-------------Array,Vector.<T>-------------");
			var arr:Array;
			showSize(arr);
			arr = [];
			showSize(arr, "new");
			//for (var i:int = 0; i < 100; i++)
			arr.push(10);
			showSize(arr, "push int");
			
			var vec:Vector.<int>;
			showSize(vec);
			vec = new Vector.<int>();
			showSize(vec, "new");
			vec.push(10);
			showSize(vec, "push int");
			
			vec = new Vector.<int>(3, true);
			showSize(vec, "new vec fixed");
			vec[0] = 10;
			showSize(vec, "push int");
			//} endregion
			
			//{ region Date
			text("-------------Date-------------");
			var date:Date;
			showSize(date);
			date = new Date();
			showSize(date, "new");
			date.fullYear = 1000;
			showSize(date, "set date");
			//} endregion
			
			text("-------------Event-------------");
			var event:Event = new Event("aa");
			showSize(event);
			event = new MouseEvent("aa");
			showSize(event, "mouseEvent");
			
			text("-------------ByteArray-------------");
			var bytes:ByteArray = new ByteArray();
			showSize(bytes);
			bytes.writeBoolean(true);
			showSize(bytes, "writeboolean");
			bytes.writeShort(12);
			showSize(bytes, "writeshort");
			bytes.writeInt(10);
			showSize(bytes, "writeint");
			
			text("");
			arr = [
				Object,
				EventDispatcher,
				//DisplayObject,
				Video,
				Bitmap,
				Shape,
				//InteractiveObject,
				TextField,
				SimpleButton,
				//DisplayObjectContainer,
				Loader,
				Sprite,
				MovieClip
			];
			
			var C:Class;
			
			for (var ti:int, tLen:int = arr.length; ti < tLen; ti++) {
				C = arr[ti];
				text("-------------" + String(C) + "-------------");
				temp = new C();
				showSize(temp);
			}
			
			
		}
		
		private var _txt:TextField = null;
		
		private function init():void
		{
			_txt = new TextField();
			_txt.width = stage.stageWidth - 10;
			_txt.height = stage.stageHeight - 10;
			_txt.border = true;
			_txt.wordWrap = true;
			addChild(_txt);
		}
		
		public function showSize(obj:*, msg:String = ""):void
		{
			var str:String = "type:" + getQualifiedClassName(obj) + ";value:" + obj + ";size:" + getSize(obj) + "." + msg;
			//trace("type:", getQualifiedClassName(obj), "value:", obj, "size:", getSize(obj), ".", msg);
			text(str);
		}
		
		public function text(str:String):void
		{
			_txt.appendText(str + "\n");
		}
	
	}

}