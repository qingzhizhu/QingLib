package test.as3.multitouch
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.GesturePhase;
	import flash.events.TimerEvent;
	import flash.events.TouchEvent;
	import flash.events.TransformGestureEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.Timer;
	
	[ SWF( backgroundColor="0xFFFFFF",
             frameRate="25", 
             width="320", 
             height="480" ) ]
	
	public class MultitouchAndGestures extends Sprite
	{	
		private var offsetX:Number;
		private var offsetY:Number;
		private var coordinates:TextField; 
		private var resetTouchTimer:Timer;
		private var currentTarget:String;
		
		public function MultitouchAndGestures()
		{
			
			var textField:TextField = new TextField();
			textField.width = stage.stageWidth;
			textField.wordWrap = true;
			textField.multiline = true;
			textField.autoSize = TextFieldAutoSize.LEFT;
			
			trace("maxtouchPoints:", Multitouch.maxTouchPoints);
			var touchEnabled:Boolean = Multitouch.supportsTouchEvents;
			
			resetTouchTimer = new Timer(1000, 0);
			resetTouchTimer.addEventListener(TimerEvent.TIMER, onTimer); 
			
			switch(touchEnabled)
			{ 
				case true:
				{
					Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
					
					textField.text = Multitouch.supportedGestures + Multitouch.maxTouchPoints;
					
					// registering the events
					stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouch);
					stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouch);
					stage.addEventListener(TouchEvent.TOUCH_END, onTouch);
				}
					break;
				case false:
				{
					textField.text = "Touch events - Not supported.";
				}
					break;
			} 
			var gestures:Vector
			
			stage.addChild(textField);
		}    
		
		private function onTouch(touchEvent:TouchEvent):void
		{
			var id:Number = touchEvent.touchPointID;
			var x:Number = touchEvent.stageX;
			var y:Number = touchEvent.stageY;
			
			switch(touchEvent.type)
			{ 
				case TouchEvent.TOUCH_BEGIN:
				{
					if(touchEvent.target is Stage)
					{	
						trace("e.touchPointID :: " + touchEvent.touchPointID); 
						drawLines(id, x, y);
						drawShape(id, x, y);
						
					} else {
						
						currentTarget = touchEvent.target.name;    
						initializeGestures();
						
					}                              
				}
					break;
				case TouchEvent.TOUCH_MOVE:
				{
					moveLines(id, x, y);
					drawShape(id, x, y); 
				}
					break;
				case TouchEvent.TOUCH_END:
				{
					removeLines(id);
				}                  
					break;
				default:
					break;
			} 
		}
		
		private function drawLines(id:Number, x:Number, y:Number):void
		{
			offsetX = x;
			offsetY = y;
			
			var vertical:Sprite = new Sprite();
			vertical.name = "v" + id;
			vertical.graphics.lineStyle(2, 0x000000);
			vertical.graphics.moveTo(x, 0);
			vertical.graphics.lineTo(x, stage.stageHeight);
			stage.addChild(vertical); 
			
			var horizontal:Sprite = new Sprite();
			horizontal.name = "h" + id; 
			horizontal.graphics.lineStyle(2, 0x000000);
			horizontal.graphics.moveTo(0, y);
			horizontal.graphics.lineTo(stage.stageWidth, y);
			stage.addChild(horizontal); 
			
			setCoordinates(x, y); 
		}
		
		private function moveLines(id:Number, x:Number, y:Number):void
		{
			
			var vertical:Sprite = stage.getChildByName(("v" + id)) as Sprite;
			vertical.x = x - offsetX;
			
			var horizontal:Sprite = stage.getChildByName(("h" + id)) as Sprite;                    
			horizontal.y = y - offsetY;
			
			setCoordinates(x, y); 
		}
		
		private function removeLines(id:Number):void
		{   
			stage.removeChild(stage.getChildByName(("v" + id)));
			stage.removeChild(stage.getChildByName(("h" + id)));
			stage.removeChild(coordinates);
			
			coordinates = null;
		}
		
		private function setCoordinates(x:Number, y:Number):void
		{
			if(!coordinates)
			{
				coordinates = new TextField();
				stage.addChild(coordinates);
			}
			
			coordinates.text = "(" + x + ", " + y + ")"; 
			coordinates.x = x + 2;
			coordinates.y = y - 15; 
		}
		
		private function drawShape(id:Number, x:Number, y:Number):void
		{
			
			var shape:Sprite;
			var name:String = id.toString(); 
			
			if(!stage.getChildByName(name))
			{
				shape = new Sprite(); 
				shape.name = id.toString();
				shape.addEventListener(TransformGestureEvent.GESTURE_PAN, onPan);
				
				stage.addChild(shape);
				
			} else {
				
				shape = stage.getChildByName(name) as Sprite; 
				
			} 
			
			shape.graphics.clear(); 
			shape.graphics.lineStyle(2, 0x00F000, 1.0); 
			shape.graphics.beginFill(0x000000, 1.0); 
			shape.graphics.drawRect(offsetX, offsetY, x-offsetX, y-offsetY); 
			shape.graphics.endFill(); 
		}
		
		private function onPan(event:TransformGestureEvent):void
		{
			switch(event.phase)
			{
				case GesturePhase.UPDATE:
				{
					
					initializeReset();
					
					stage.getChildByName(currentTarget).x = stage.getChildByName(currentTarget).x + event.offsetX;
					stage.getChildByName(currentTarget).y = stage.getChildByName(currentTarget).y + event.offsetY;
					
				}		
					break;
			}
		}
		
		private function onTimer(e:TimerEvent):void
		{
			
			resetTouchTimer.stop();
			
			initializeTouches(); 
		}
		
		private function initializeGestures():void
		{
			if(Multitouch.supportsGestureEvents)
			{
				Multitouch.inputMode = MultitouchInputMode.GESTURE; 
				initializeReset(); 
				trace("inputMode", Multitouch.inputMode);
			}
		}
		
		private function initializeReset():void
		{
			resetTouchTimer.delay = 1000;
			
			if(!resetTouchTimer.running)
				resetTouchTimer.start();
		}
		
		private function initializeTouches():void
		{
			if(Multitouch.supportsTouchEvents)
			{
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT; 
				trace("inputMode", Multitouch.inputMode);
			}
		}
	}
}
