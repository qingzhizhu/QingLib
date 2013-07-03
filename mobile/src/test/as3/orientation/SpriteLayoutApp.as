package test.as3.orientation
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.StageOrientationEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class SpriteLayoutApp extends Sprite
	{
		private static const BLUE:int = 0x3399FF;
		private static const GREEN:int = 0x99CC00;
		private static const RED:int = 0xFF3333;
		private static const YELLOW:int = 0xFFCC00;
		
		private var a:Sprite;
		private var b:Sprite;
		private var c:Sprite;
		private var d:Sprite;
		
		private var stageOrientation:TextField;
		
		public function SpriteLayoutApp()
		{
			super();
			
			//
			//NativeApplication.nativeApplication.executeInBackground
			stage.autoOrients = true;
			trace(stage.nativeWindow == NativeApplication.nativeApplication.activeWindow);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(Event.RESIZE, onResize);
			stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE, onOrientationChange);
		
			drawSprites();
			addTxt();
		}
		
		public function onOrientationChange(e:StageOrientationEvent):void      
		{       
			stageOrientation.text = e.target.deviceOrientation;
		}

		private function onResize(e:Event):void
		{
			var stageObj:Stage = e.target as Stage;
			var w:int = stageObj.stageWidth;
			var h:int = stageObj.stageHeight;
			
			sizeComponents(w, h);
			layoutComponents(w, h);
		}

		public function getSprite(id:String):Sprite
		{
			return this.getChildByName(id) as Sprite
		}
		
		protected function sizeComponents(stageWidth:int, stageHeight:int):void
		{      
			if(stageWidth < stageHeight)
			{
				a = this.getSprite("a");       
				a.width = stageWidth/2;      
				a.height = 1/3 * stageHeight;      
				
				b = this.getSprite("b");       
				b.width = stageWidth/2;      
				b.height = 1/3 * stageHeight; 
				
				c = this.getSprite("c");       
				c.width = stageWidth;      
				c.height = stageHeight - (1/3 * stageHeight) - (1/6 * stageHeight);      
				
				d = this.getSprite("d");       
				d.width = stageWidth;      
				d.height = 1/6 * stageHeight; 
				
			} else if(stageWidth > stageHeight) {
				a = this.getSprite("a");       
				a.width = stageWidth/2;      
				a.height = stageHeight/2 - (1/6 * stageHeight)/2;      
				
				b = this.getSprite("b");       
				b.width = stageWidth/2;      
				b.height = stageHeight/2 - (1/6 * stageHeight)/2;
				
				c = this.getSprite("c");       
				c.width = stageWidth/2;      
				c.height = stageHeight - (1/6 * stageHeight);      
				
				d = this.getSprite("d");       
				d.width = stageWidth;      
				d.height = 1/6 * stageHeight; 

			}
			
		}

		protected function layoutComponents(stageWidth:int, stageHeight:int):void
		{    
			if(stageWidth < stageHeight)
			{
				a = this.getSprite("a") ; 
				a.x = 0;
				a.y = 0;
				
				b = this.getSprite("b") ; 
				b.x = a.x + a.width;
				b.y = 0;
				
				c = this.getSprite("c") ; 
				c.x = 0;
				c.y = b.y + b.height;
				
				d = this.getSprite("d") ; 
				d.x = 0;
				d.y = stageHeight - d.height;
			
			} else if(stageWidth > stageHeight) {
			
				a = this.getSprite("a") ; 
				a.x = 0;
				a.y = 0;
				
				b = this.getSprite("b") ; 
				b.x = 0
				b.y = a.y + a.height;
				
				c = this.getSprite("c") ; 
				c.x = a.x + a.width;
				c.y = 0;
				
				d = this.getSprite("d") ; 
				d.x = 0;
				d.y = stageHeight - d.height;
			}
			
			stageOrientation.x = a.x;
			stageOrientation.y = a.y;
			
		}  
		
		protected function drawSprites():void
		{
			drawRectangle("a", 1, 1, BLUE);
			drawRectangle("b", 1, 1, GREEN);
			drawRectangle("c", 1, 1, YELLOW);
			drawRectangle("d", 1, 1, RED);
		}
		
		protected function addTxt():void 
		{     
			var tF:TextFormat = new TextFormat();
			tF.size = 18;
			
			stageOrientation = new TextField();
			stageOrientation.defaultTextFormat = tF;
			stageOrientation.text = "";
			
			addChild(stageOrientation);
		}     
		
		protected function drawRectangle(id:String, width:int, height:int, color:int):void
		{      
			var sprite:Sprite = new Sprite();
			sprite.name = id;
			sprite.graphics.beginFill(color);
			sprite.graphics.drawRect(0, 0, width, height);
			sprite.graphics.endFill();
			
			addChild(sprite);
		}

	}
}