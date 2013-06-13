package test.starling.third 
{
	import flash.ui.Keyboard;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.ParticleSystem;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	
	/**
	 * 粒子系统demo.<br/>
	 * 在线编辑器 http://onebyonedesign.com/flash/particleeditor/ <br/>
	 * src code: https://github.com/PrimaryFeather/Starling-Extension-Particle-System
	 * @author gengkun123@gmail.com
	 */
	public class ParticleTest extends Sprite 
	{
		[Embed(source="../../../../../assets/texture/particle/pe_particle.pex", mimeType="application/octet-stream")]
		private static const PeParticle:Class;
		
		[Embed(source="../../../../../assets/texture/particle/pe_texture.png")]
		private static const PeParticleTexture:Class;
		
		
		[Embed(source="../../../../../assets/texture/particle/jellyfish.pex", mimeType="application/octet-stream")]
        private static const JellyfishConfig:Class;
		
		[Embed(source="../../../../../assets/texture/particle/jellyfish_particle.png")]
        private static const JellyfishParticle:Class;
		
		private var mParticleSystems:Vector.<ParticleSystem>;
        private var mParticleSystem:ParticleSystem;
		
		public function ParticleTest() 
		{
			var jellyConfig:XML = XML(new JellyfishConfig());
            var jellyTexture:Texture = Texture.fromBitmap(new JellyfishParticle());
			
			var peParticle:XML = XML(new PeParticle());
			var peParticleTexture:Texture = Texture.fromBitmap(new PeParticleTexture());
            
            mParticleSystems = new <ParticleSystem>[
                //new PDParticleSystem(drugsConfig, drugsTexture),
                //new PDParticleSystem(fireConfig, fireTexture),
                //new PDParticleSystem(sunConfig, sunTexture),
                new PDParticleSystem(jellyConfig, jellyTexture),
				new PDParticleSystem(peParticle, peParticleTexture)
            ];
			
			
			 // add event handlers for touch and keyboard
            
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
		}
		
		private function onAddedToStage(event:Event):void
        {
            stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
            stage.addEventListener(TouchEvent.TOUCH, onTouch);
            
            startNextParticleSystem();
        }
        
        private function onRemovedFromStage(event:Event):void
        {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKey);
            stage.removeEventListener(TouchEvent.TOUCH, onTouch);
        }
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch : Touch = e.getTouch(stage);
			if (touch && touch.phase != TouchPhase.HOVER) {
				mParticleSystem.emitterX = touch.globalX;
				mParticleSystem.emitterY = touch.globalY;
				//mParticleSystem.x = touch.globalX;
				//mParticleSystem.y = touch.globalY;
			}
		}
		
		private function onKey(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.SPACE) {
				startNextParticleSystem();
			}
		}
		
		private function startNextParticleSystem():void 
		{
			if (mParticleSystem) {
				mParticleSystem.stop(false);
				mParticleSystem.removeFromParent(false);
				Starling.current.juggler.remove(mParticleSystem);
			}
			
			mParticleSystem = mParticleSystems.shift();
			mParticleSystems.push(mParticleSystem);
			
			mParticleSystem.emitterX = 320;
            mParticleSystem.emitterY = 240;			
			addChild(mParticleSystem);
			mParticleSystem.start();
			Starling.current.juggler.add(mParticleSystem);
		}
		
	}

}