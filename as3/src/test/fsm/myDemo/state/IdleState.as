package test.fsm.myDemo.state 
{
	import com.qing.fsm.IState;
	import test.fsm.myDemo.Agent;
	public class IdleState implements IState
	{
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(time:Number, ...params):void
		{
			var a : Agent = params[0];
			if (a.numCycles > 30) {
				//a.setState(Agent.WANDER);
				a.setState(WanderState);
			}
		}
		
		public function enter(...params):void
		{
			var a : Agent = params[0];
			a.say("Idling...");
			a.speed = 0;
		}
		
		public function exit(...params):void
		{
			var a : Agent = params[0];
			a.randomDirection();
		}
		
	}

}