package test.demo 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * 落叶效果，可以换成雪花。
	 * 
	 * 
	 * http://www.ilike2flash.com/2012/03/falling-leaf-animation-in-actionscript.html
	 * @author gengkun123@gmail.com
	 */
	public class FallLeafAnimation extends Sprite 
	{
		private var leaves:Array  = new Array(),
					numLeaves:uint = 10,
					angle:Number = 0;
		public function FallLeafAnimation() 
		{
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
	

		private function enterFrameHandler(e:Event):void{

			if(leaves.length < numLeaves){
				var leaf:Leaf = new Leaf();
				 leaf.x = getRandom(0, 300);
				 leaf.y = getRandom(-100, -10);
				 leaf.scaleX = leaf.scaleY = getRandom(0.1, 0.2);
				 leaf.rotY = getRandom(2, 6);
				 leaf.xVelocity = Math.cos(angle) * getRandom(-3, 3);
				 leaf.yVelocity = getRandom(1,3);
				 leaf.spin = getRandom(0.3,1.5);
				 addChild(leaf);
				 leaves.push(leaf);
			}

			for(var i:uint = 0; i< leaves.length; i++){
				 var l:Leaf = leaves[i];
				 l.x += l.xVelocity;
				 l.y += l.yVelocity;
				 l.rotation += l.spin;
				 /*l.rotationX =*/ l.rotationY += l.rotY;

				if(l.y > stage.stageHeight + l.height || 
				  l.x > stage.stageWidth + l.width ||
				  l.x < 0 - l.width){
				   l.x = getRandom(0, 300);
				   l.y = getRandom(-200, -10);
				   l.rotation = 0;
				   l.rotationY = 0;
				   l.scaleX = l.scaleY = getRandom(0.1, 0.2);
				   l.xVelocity = Math.cos(angle) * getRandom(-3, 3);
				   l.yVelocity = getRandom(1,3);
				}
			}


			(angle < 360) ? angle += 0.2 : 0;

		}

		private function getRandom(min:Number, max:Number):Number {
		 return min + (Math.random() * (max - min));
		}

	}



}
import flash.display.MovieClip;


dynamic class Leaf extends MovieClip {
	public function Leaf() {
		addChild(new Assets.BIRD());
	}
}