package test.fsm.demo.agent.states 
{
	import test.fsm.demo.agent.Agent;
	
	public interface IAgentState 
	{
		function update(a:Agent):void;
		function enter(a:Agent):void;
		function exit(a:Agent):void;
	}
	
}