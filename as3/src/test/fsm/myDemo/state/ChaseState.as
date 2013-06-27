package test.fsm.myDemo.state 
{
	import com.qing.fsm.IState;
	import test.fsm.myDemo.Agent;
	public class ChaseState implements IState
	{
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(time:Number, ...params):void
		{
			var a : Agent = params[0];
			var dx:Number = a.stage.mouseX - a.x;
			var dy:Number = a.stage.mouseY - a.y;
			var rad:Number = Math.atan2(dy, dx);
			a.velocity.x = Math.cos(rad);
			a.velocity.y = Math.sin(rad);
			if (a.numCycles < 40) return;
			a.say("Chasing!");
			a.speed = 2;
			if (a.distanceToMouse > a.chaseRadius) {
				//a.setState(Agent.CONFUSED);
				a.setState(ConfusionState);
			}
			if (a.distanceToMouse < a.fleeRadius) {
				//a.setState(Agent.FLEE);
				a.setState(FleeState);
			}
		}
		
		public function enter(...params):void
		{
			var a : Agent = params[0];
			var dx:Number = a.stage.mouseX - a.x;
			var dy:Number = a.stage.mouseY - a.y;
			var rad:Number = Math.atan2(dy, dx);
			a.velocity.x = Math.cos(rad);
			a.velocity.y = Math.sin(rad);
			a.say("Oh wow! Something to chase!");
			a.speed = 0;
		}
		
		public function exit(...params):void
		{
			
		}
		
	}

}