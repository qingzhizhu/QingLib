package com.qing.fsm 
{
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public interface IState 
	{
		function enter(...params):void; // called on entering the state
	    function exit(...params):void; // called on leaving the state
	    function update( time:Number, ...params):void; // called every frame while in the state
	}

}