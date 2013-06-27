/*
 * Author: Richard Lord
 * Copyright (c) Richard Lord 2007
 * http://www.richardlord.net/blog/finite-state-machines-for-ai-in-actionscript
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
 
package com.qing.fsm
{
	import com.qing.utils.construct;
	import com.qing.utils.FunctionUtils;
	import flash.utils.Dictionary;

	public class StateMachine
	{
		private var _statesDic : Dictionary;
		private static var _STATESDIC : Dictionary = null;
		private var _useStaticState : Boolean = false;
		
		private var _currentState : IState;
		private var _previousState : IState;
		private var _nextState : IState;

		public function StateMachine(useStaticState:Boolean=true)
		{
			_useStaticState = useStaticState;
			if (_useStaticState) {
				if (!_STATESDIC) _STATESDIC = new Dictionary();
			}else {
				_statesDic = new Dictionary();
			}
			_currentState = null;
			_previousState = null;
			_nextState = null;
		}
		/**
		 * 初始化states
		 * @param	...instances
		 */
		public function primeStates( ...instances ) : void
		{
			for each( var state : IState in instances )
			{
				var type : Class = Object( state ).constructor as Class;
				if( type )
				{
					states[type] = state;
				}
			}
		}
		
		public function removeStates( ...instances ) : void
		{
			if(instances){
				for each( var state : IState in instances )
				{
					var type : Class = Object( state ).constructor as Class;
					if( type && states[type] == state )
					{
						delete states[type];
					}
				}
			}else {//remove all
				for( var p : * in states )
				{
					states[p] = null;
					delete states[p];
				}
			}
		}
		
		private function getStateForClass( type : Class, ...params ) : IState
		{
			return type in states ? states[type] : states[type] = construct(type, params);
		}
		
		public function get previousState() : IState
		{
			return _previousState;
		}
		public function get currentState() : IState
		{
			return _currentState;
		}
		public function get nextState() : IState
		{
			return _nextState;
		}
		
		public function setNextState( type : Class ) : void
		{
			_nextState = getStateForClass( type );
		}

		public function update( time : Number, ...params ) : void
		{
			if ( _currentState )
			{
				FunctionUtils.sendParams(_currentState.update, time, params);
			}
		}
		
		public function changeState( type : Class, ...params ) : void
		{
			_changeState( getStateForClass( type, params ) );
		}

		public function changeStateInstance( state : IState ) : void 
		{
			primeStates( state );
			_changeState( state );
		}

		private function _changeState( state : IState, ...params ) : void
		{
			if( _currentState )
			{
				FunctionUtils.sendParams(_currentState.exit, params);
			}
			_previousState = _currentState;
			_currentState = state;
			if( _currentState )
			{
				FunctionUtils.sendParams(_currentState.enter, params);
			}
		}
		
		public function goToPreviousState() : void
		{
			if( _previousState )
			{
				_changeState( _previousState );
			}
		}

		public function goToNextState() : void
		{
			if( _nextState )
			{
				_changeState( _nextState );
			}
		}
		
		private function get states():Dictionary {
			return _useStaticState ? _STATESDIC : _statesDic;
		}
		
	}
}
