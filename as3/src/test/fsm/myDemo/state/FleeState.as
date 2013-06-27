package test.fsm.myDemo.state 
{
	import com.qing.fsm.IState;
	import test.fsm.myDemo.Agent;
	/**
	 * ...
	 * @author Andreas Rønning
	 */
	public class FleeState implements IState
	{
		
		public function FleeState() 
		{
			
		}
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(time:Number, ...params):void
		{
			var a : Agent = params[0];
			if (a.numCycles < 10) return;
			a.say("Fleeing!");
			a.speed = 2;
			a.faceMouse( -1);
			if(a.numCycles>80){
				if (a.distanceToMouse > a.fleeRadius) {
					//a.setState(Agent.CONFUSED);
					a.setState(ConfusionState);
				}
			}
		}
		
		public function enter(...params):void
		{
			var a : Agent = params[0];
			a.say("Eek!");
			a.faceMouse(1);
			a.speed = 0;
		}
		
		public function exit(...params):void
		{
			
		}
		
	}

}