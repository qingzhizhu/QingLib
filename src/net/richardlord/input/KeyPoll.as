/*
 * Author: Richard Lord
 * Copyright (c) Richard Lord 2007
 * http://www.richardlord.net/blog/polling-the-keyboard-in-actionscript-3
 * 
 * Licence Agreement (The MIT License)
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package net.richardlord.input
{
	//import flash.events.KeyboardEvent;
	import flash.events.Event;
	//import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	
	/**
	 * <p> 仿照AS2Key.isDown. <b> 为了适配starling，将dispObj,event 的类型都改为 无类型 。</b> </p>
	 * <p>Games often need to get the current state of various keys in order to respond to user input. 
	 * This is not the same as responding to key down and key up events, but is rather a case of discovering 
	 * if a particular key is currently pressed.</p>
	 * 
	 * <p>In Actionscript 2 this was a simple matter of calling Key.isDown() with the appropriate key code. 
	 * But in Actionscript 3 Key.isDown no longer exists and the only intrinsic way to react to the keyboard 
	 * is via the keyUp and keyDown events.</p>
	 * 
	 * <p>The KeyPoll class rectifies this. It has isDown and isUp methods, each taking a key code as a 
	 * parameter and returning a Boolean.</p>
	 */
	public class KeyPoll
	{
		private var states:ByteArray;
		private var dispObj:*; //DisplayObject;
		
		private static const _E_KEY_DOWN : String = "keyDown";
		private static const _E_KEY_UP : String = "keyUp";
		
		/**
		 * Constructor
		 * 
		 * @param displayObj a display object on which to test listen for keyboard events. To catch all key events use the stage.
		 */
		public function KeyPoll( displayObj:*/*DisplayObject*/ )
		{
			states = new ByteArray();
			states.writeUnsignedInt( 0 );
			states.writeUnsignedInt( 0 );
			states.writeUnsignedInt( 0 );
			states.writeUnsignedInt( 0 );
			states.writeUnsignedInt( 0 );
			states.writeUnsignedInt( 0 );
			states.writeUnsignedInt( 0 );
			states.writeUnsignedInt( 0 );
			dispObj = displayObj;
			dispObj.addEventListener( _E_KEY_DOWN/*KeyboardEvent.KEY_DOWN*/, keyDownListener, false, 0, true );
			dispObj.addEventListener( _E_KEY_UP/*KeyboardEvent.KEY_UP*/, keyUpListener, false, 0, true );
			dispObj.addEventListener( Event.ACTIVATE, activateListener, false, 0, true );
			dispObj.addEventListener( Event.DEACTIVATE, deactivateListener, false, 0, true );
		}
		
		private function keyDownListener( ev:*/*KeyboardEvent*/ ):void
		{
			//var n1 : int = states[ ev.keyCode >>> 3 ];// ev.keyCode >>> 3;
			//var n2 : int = (ev.keyCode & 7);
			//var n3 : int = 1 << (ev.keyCode & 7);
			//var n4 : int = n1 | n3;
			//trace("keydown", ev.keyCode, "num", n1, n2, n3, n4);
			states[ ev.keyCode >>> 3 ] |= 1 << (ev.keyCode & 7);
		}
		
		private function keyUpListener( ev:*/*KeyboardEvent*/ ):void
		{
			//var n1 : int = ev.keyCode >>> 3;
			//var n2 : int = (ev.keyCode & 7);
			//var n3 : int = ~(1 << (ev.keyCode & 7));
			//var n4 : int = n1 & n3;
			//trace("keyUP", ev.keyCode, "num", n1, n2, n3, n4);			
			states[ ev.keyCode >>> 3 ] &= ~(1 << (ev.keyCode & 7));
		}
		
		private function activateListener( ev:Event ):void
		{
			for( var i:int = 0; i < 8; ++i )
			{
				states[ i ] = 0;
			}
		}

		private function deactivateListener( ev:Event ):void
		{
			for( var i:int = 0; i < 8; ++i )
			{
				states[ i ] = 0;
			}
		}
		
		/**
		 * To test whether a key is down.
		 *
		 * @param keyCode code for the key to test.
		 *
		 * @return true if the key is down, false otherwise.
		 *
		 * @see isUp
		 */
		public function isDown( keyCode:uint ):Boolean
		{
			return ( states[ keyCode >>> 3 ] & (1 << (keyCode & 7)) ) != 0;
		}
		
		/**
		 * To test whether a key is up.
		 *
		 * @param keyCode code for the key to test.
		 *
		 * @return true if the key is up, false otherwise.
		 *
		 * @see isDown
		 */
		public function isUp( keyCode:uint ):Boolean
		{
			return ( states[ keyCode >>> 3 ] & (1 << (keyCode & 7)) ) == 0;
		}
		
		
		public function dispose():void {			
			dispObj.removeEventListener( _E_KEY_DOWN, keyDownListener);
			dispObj.removeEventListener( _E_KEY_UP, keyUpListener);
			dispObj.removeEventListener( Event.ACTIVATE, activateListener);
			dispObj.removeEventListener( Event.DEACTIVATE, deactivateListener);
			
			states = null;
			dispObj = null;
		}
	}
}