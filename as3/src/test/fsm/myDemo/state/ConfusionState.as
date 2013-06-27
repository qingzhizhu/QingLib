package test.fsm.myDemo.state 
{
	import com.qing.fsm.IState;
	import test.fsm.myDemo.Agent;
	public class ConfusionState implements IState
	{
		public function ConfusionState() 
		{
			
		}
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(time:Number, ...params):void
		{
			var a : Agent = params[0];
			if (++a.numCycles % 10 == 0) {
				a.randomDirection();
				if (a.canSeeMouse && a.distanceToMouse < a.chaseRadius) {
					if (a.stateMachine.previousState is FleeState) a.setState(FleeState);
					else if (a.stateMachine.previousState is ChaseState) a.setState(ChaseState);
					//if(a.previousState==Agent.FLEE) a.setState(Agent.FLEE);
					//if(a.previousState==Agent.CHASE) a.setState(Agent.CHASE);
				}
			}
			if (a.numCycles > 60) a.setState(IdleState);// a.setState(Agent.IDLE);
		}
		
		public function enter(...params):void
		{
			var a : Agent = params[0];
			a.say("???");
			a.speed = 0;
		}
		
		public function exit(...params):void
		{
			
		}
		
	}

}