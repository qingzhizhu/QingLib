package test.as3 
{
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	import flash.display.Shape;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.InterpolationMethod;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	public class Scale9GridExample extends Sprite
	{
		   private var square:Shape;
		   public function Scale9GridExample()
		   {
				  initSquare();
		   }
		   private function initSquare():void {
			   
			   square = new Shape();
				  square.graphics.lineStyle(3, 0);
				  square.graphics.lineGradientStyle(GradientType.LINEAR, [0xFF0000, 0xFF], [100, 100], [0, 0xFF], gradientMatrix, SpreadMethod.REPEAT);
				  //square.graphics.drawRect(0, 0, 200, 4);
				  square.graphics.moveTo(50, 50);
				  square.graphics.lineTo(200, 50);
				  //square.x = square.y = 50;
				  addChild(square);
				  
				  
				  
				  square = new Shape();
				  square.graphics.lineStyle(20, 0xFFCC00);
				  var gradientMatrix:Matrix = new Matrix();
				  gradientMatrix.createGradientBox(15, 15, Math.PI, 0, 0);
				  square.graphics.beginGradientFill(GradientType.RADIAL,
						[0xffff00, 0x0000ff],
						[100, 100],
						[0, 0xFF],
						gradientMatrix,
						SpreadMethod.REFLECT,
						InterpolationMethod.RGB,
							0.9);
				  square.graphics.drawRect(0, 0, 100, 100);
				  var grid:Rectangle = new Rectangle(20, 10, 60, 80);	//20*2+60=100
				  //var grid:Rectangle = new Rectangle(30, 30, 10, 10);
				  square.scale9Grid = grid ;
				  addChild(square);
				  square.x = square.y = 100;
				  var tim:Timer = new Timer(100);
				  tim.start();
				  tim.addEventListener(TimerEvent.TIMER, scale);
				  
				  
				  
				  
				 
		   }
		   var scaleFactor:Number = 1.01;
		   private function scale(event:TimerEvent):void {
				  
				square.scaleX *= scaleFactor;
				square.scaleY *= scaleFactor;
				if (square.scaleX > 5.0) {
						   scaleFactor = 0.99;
					  }
				if (square.scaleX < 1.0) {
						   scaleFactor = 1.01;
					  }
		   }
	}

}