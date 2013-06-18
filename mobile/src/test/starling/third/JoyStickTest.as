package  test.starling.third
{
	import starling.display.Sprite;
	import starling.extensions.advancedjoystick.JoyStick;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.display.Quad;
	
	
	public class JoyStickTest extends Sprite
	{
		
		private var joystick:JoyStick;
		private var player:Quad;
		private var playerXVel:Number = 0;
		private var playerYVel:Number = 0;
		private var playerMaxVel:Number = 10;
		
		public function JoyStickTest() 
		{
			// Adding the Square to the screen.
			player = new Quad(50,50,0x000000);
			player.pivotX = 25;
			player.pivotY = 25;
			player.x = 400;
			player.y = 300;
			addChild( player );
			
			// Initializing and adding Joystick with DEFAULT skin. 不适用默认皮肤，需要将embed的资源注释
			joystick = new JoyStick();
			joystick.setPosition( joystick.minOffsetX, 500 - joystick.minOffsetY );
			addChild( joystick );
			
			addEventListener( Event.ENTER_FRAME, onUpdate );
		}
		
		private function onUpdate( evt:Event ):void
		{
			/* 
			 * If the joystick is being moved, the velocity of the player will update, else the velocity will
			 * decrease due to friction. Feel free to find your own methods of movement smoothing. :)
			 */
			 
			if( joystick.touched )
			{
				playerXVel = joystick.velocityX * playerMaxVel;
				playerYVel = joystick.velocityY * playerMaxVel;				
			}
			else{
				playerXVel *= 0.9;
				playerYVel *= 0.9;
			}
			
			player.x += playerXVel;
			player.y += playerYVel;
			
			// Very simple bounds checking.
			if( player.x >= 775 ) player.x = 775; else if( player.x < 25 ) player.x = 25;
			if( player.y >= 575 ) player.y = 575; else if( player.y < 25 ) player.y = 25;
		}

	}
	
}
