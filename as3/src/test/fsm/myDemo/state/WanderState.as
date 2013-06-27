package test.fsm.myDemo.state 
{
	import com.qing.fsm.IState;
	import test.fsm.myDemo.Agent;
	public class WanderState implements IState
	{
		
		public function update(time:Number, ...params):void
		{
			var a : Agent = params[0];
			a.say("Wandering...");
			a.velocity.x += Math.random() * 0.2 - 0.1;
			a.velocity.y += Math.random() * 0.2 - 0.1;
			if (a.numCycles > 120) {
				//a.setState(Agent.IDLE);
				a.setState(IdleState);
			}
			if (!a.canSeeMouse) return;
			if (a.distanceToMouse < a.fleeRadius) {
				//a.setState(Agent.FLEE);
				a.setState(FleeState);
			}else if (a.distanceToMouse < a.chaseRadius) {
				//a.setState(Agent.CHASE);
				a.setState(ChaseState);
			}
		}
		
		public function enter(...params):void
		{
			var a : Agent = params[0];
			a.speed = 1;
		}
		
		public function exit(...params):void
		{
			
		}
	}
}