package test.starling.quadtree
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

    import starling.core.Starling;

	/**
	 * 当需要包含显示很多对象，同一时间内显示部分对象<br/>
	 * 很适合 <b>大型2d世界地图</b>
	 * 
	 * 
	 */
    public class QuadtreeSpriteExample extends Sprite
    {
        private var _starling:Starling;

        public function QuadtreeSpriteExample()
        {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;

            _starling = new Starling(QuadtreeSpriteScene, stage);
            _starling.start();
        }
    }
}
