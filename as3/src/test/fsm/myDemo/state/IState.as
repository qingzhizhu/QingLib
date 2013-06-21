package test.fsm.myDemo.state 
{
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class IState 
	{
		function enter():void; // called on entering the state
	    function exit():void; // called on leaving the state
	    function update( time:Number ):void; // called every frame while in the state
	}

}