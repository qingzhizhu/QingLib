package test.demo {
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLLoader;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
	/**
	 * http://www.emanueleferonato.com/2013/06/13/how-to-create-a-leaderboard-in-your-flash-game-with-scoreoid/
	 */
	public class ScoreoidMain extends Sprite {
		private var shipFilter:GlowFilter=new GlowFilter(0x00ff00,0.8,4,4,2,3,false,false);
		private var smokeFilter:GlowFilter=new GlowFilter(0xff0000,0.8,4,4,2,3,false,false);
		private var fuelFilter:GlowFilter=new GlowFilter(0x00ffff,0.8,4,4,2,3,false,false);
		private var rockFilter:GlowFilter=new GlowFilter(0xffffff,0.8,4,4,2,3,false,false);
		private var scoreFilter:GlowFilter=new GlowFilter(0xff00ff,0.8,2,4,2,3,false,false);
		private var gravity:Number=0.1;
		private var thrust:Number=0.25;
		private var yspeed:Number=0;
		private var xspeed:Number=5;
		private var distance:Number=0;
		private var smokeInterval:Number=10;
		private var framesPassed:Number=0;
		private var fuelFrequency:Number=10;
		private var gasoline:Number=500;
		private var rockFrequency:Number=50;
		private var engines:Boolean=false;
		private var ship:Ship=new Ship();
		private var score:Score=new Score();
		private var rockCanvas:Sprite=new Sprite();
		private var fuelCanvas:Sprite=new Sprite();
		private var smokeCanvas:Sprite=new Sprite();
		private var fuelVector:Vector.<Fuel>=new Vector.<Fuel>();
		private var rockVector:Vector.<Rock>=new Vector.<Rock>();
		private var smokeVector:Vector.<Smoke>=new Vector.<Smoke>();
		private var topScore:Number=0;
		public function ScoreoidMain() {
			getBest();
			addChild(ship);
			ship.x=120;
			ship.y=240;
			ship.filters=new Array(shipFilter);
			addChild(score);
			addChild(rockCanvas);
			addChild(fuelCanvas);
			addChild(smokeCanvas);
			score.filters=new Array(scoreFilter);
			addEventListener(Event.ENTER_FRAME,update);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,engineOn);
			stage.addEventListener(MouseEvent.MOUSE_UP,engineOff);
		}
		private function engineOn(e:MouseEvent):void {
			engines=true;
			framesPassed=smokeInterval;
		}
		private function engineOff(e:MouseEvent):void {
			engines=false;
			smokeInterval=10;
		}
		private function update(e:Event):void {
			if (Math.random()*1000<fuelFrequency) {
				var fuel:Fuel=new Fuel();
				fuel.y=Math.random()*400+40;
				fuel.x=650;
				fuel.filters=new Array(fuelFilter);
				fuelCanvas.addChild(fuel);
				fuelVector.push(fuel);
			}
			if (Math.random()*1000<rockFrequency) {
				var rock:Rock=new Rock();
				rock.y=Math.random()*400+40;
				rock.x=670;
				rock.rotation=Math.random()*360;
				rock.filters=new Array(rockFilter);
				rockCanvas.addChild(rock);
				rockVector.push(rock);
			}
			distance+=xspeed;
			score.scoreText.text="Distance: "+distance+" - Fuel: "+gasoline+" - Best distance: "+topScore;
			if ((gasoline>0)&&(engines)) {
				yspeed-=thrust;
				smokeInterval-=0.25;
				gasoline-=1;
				framesPassed++;
				if (smokeInterval<framesPassed) {
					var smoke:Smoke=new Smoke();
					smoke.x=ship.x;
					smoke.y=ship.y;
					smoke.filters=new Array(smokeFilter);
					smokeCanvas.addChild(smoke);
					smokeVector.push(smoke);
					framesPassed=0;
					smokeInterval-=0.01;
				}
			}
			yspeed+=gravity;
			ship.y+=yspeed;
			angle=Math.atan2(yspeed,xspeed);
			ship.rotation=angle*180/Math.PI;
			for (var i:int=fuelVector.length-1; i>=0; i--) {
				fuelVector[i].x-=xspeed*1.2;
				var dist_x:Number=ship.x+28*Math.cos(angle)-fuelVector[i].x;
				var dist_y:Number=ship.y+28*Math.sin(angle)-fuelVector[i].y;
				var dist:Number = Math.sqrt(dist_x*dist_x+dist_y*dist_y);
				if (dist<10) {
					gasoline+=100;
					fuelCanvas.removeChild(fuelVector[i]);
					fuelVector.splice(i,1);
				}
				else {
					if (fuelVector[i].x<-10) {
						fuelCanvas.removeChild(fuelVector[i]);
						fuelVector.splice(i,1);
					}
				}
			}
			for (i=rockVector.length-1; i>=0; i--) {
				rockVector[i].x-=xspeed;
				if (rockVector[i].x<-20) {
					rockCanvas.removeChild(rockVector[i]);
					rockVector.splice(i,1);
				}
			}
			for (i=smokeVector.length-1; i>=0; i--) {
				smokeVector[i].x-=xspeed;
				smokeVector[i].width+=0.2;
				smokeVector[i].height+=0.2;
				smokeVector[i].alpha-=0.04;
				if (smokeVector[i].alpha<0) {
					smokeCanvas.removeChild(smokeVector[i]);
					smokeVector.splice(i,1);
				}
			}
			if (ship.y>480 || ship.y<0 || rockCanvas.hitTestPoint(ship.x+28*Math.cos(angle), ship.y+28*Math.sin(angle), true) || rockCanvas.hitTestPoint(ship.x+8*Math.cos(angle+Math.PI/2), ship.y+8*Math.sin(angle+Math.PI/2), true) || rockCanvas.hitTestPoint(ship.x+8*Math.cos(angle-Math.PI/2), ship.y+8*Math.sin(angle-Math.PI/2), true)) {
				postScore();
				yspeed=0;
				ship.y=200;
				gasoline=500;
				distance=0;
				rockVector=new Vector.<Rock>();
				removeChild(rockCanvas);
				rockCanvas=new Sprite();
				addChild(rockCanvas);
				fuelVector=new Vector.<Fuel>();
				removeChild(fuelCanvas);
				fuelCanvas=new Sprite();
				addChild(fuelCanvas);
				smokeVector=new Vector.<Smoke>();
				removeChild(smokeCanvas);
				smokeCanvas=new Sprite();
				addChild(smokeCanvas);
			}
		}
		private function postScore():void {
			var url:String="https://www.scoreoid.com/api/createScore";
			var request:URLRequest=new URLRequest(url);
			var requestVars:URLVariables = new URLVariables();
			request.data=requestVars;
			requestVars.api_key="xxx";
			requestVars.game_id="yyy";
			requestVars.response="XML";
			requestVars.username="Demo Name";
			requestVars.score=distance;
			request.method=URLRequestMethod.POST;
			var urlLoader:URLLoader = new URLLoader();
			urlLoader = new URLLoader();
			urlLoader.dataFormat=URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, scorePosted);
			urlLoader.load(request);
		}
		private function scorePosted(event:Event):void {
			getBest();
		}
		private function loaderCompleteHandler(event:Event):void {
			var score:XML=new XML(event.target.data);
			if (score>topScore) {
				topScore=score;
			}
		}
		function getBest():void {
			var url:String="https://www.scoreoid.com/api/getGameTop";
			var request:URLRequest=new URLRequest(url);
			var requestVars:URLVariables = new URLVariables();
			request.data=requestVars;
			requestVars.api_key="xxx";
			requestVars.game_id="yyy";
			requestVars.response="XML";
			requestVars.field="best_score";
			request.method=URLRequestMethod.POST;
			var urlLoader:URLLoader = new URLLoader();
			urlLoader = new URLLoader();
			urlLoader.dataFormat=URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			urlLoader.load(request);
		}
	}
}