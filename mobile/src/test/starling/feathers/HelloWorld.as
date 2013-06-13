package test.starling.feathers 
{
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	import feathers.themes.MetalWorksMobileTheme;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class HelloWorld extends Sprite 
	{
		protected var theme:MetalWorksMobileTheme;
		protected var button:Button;
	
		public function HelloWorld() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			this.theme = new MetalWorksMobileTheme(stage);
			
			this.button = new Button();
			button.label = "click me";
			button.addEventListener(Event.TRIGGERED, ontriggered);
			addChild(button);
			
			button.validate();
			this.button.x = (this.stage.stageWidth - this.button.width) / 2;
			this.button.y = (this.stage.stageHeight - this.button.height) / 2;
			
			var label : Label = new Label();
			label.text = "label!";
			this.addChild(label);
			
			
			var input : TextInput = new TextInput();
			input.text = "write your name";
			input.y = 50;
			addChild(input);
		}
		
		private function ontriggered(e:Event):void 
		{
			const label:Label = new Label();
			label.text = "Hi, I'm Feathers!\nHave a nice day.";
			Callout.show(label, this.button);
		}
		
	}

}