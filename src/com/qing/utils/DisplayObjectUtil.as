package com.qing.utils 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;
	/**
	 * 操作显示对象的一些方法
	 * @author gengkun123@gmail.com
	 */
	public class DisplayObjectUtil 
	{
		/**
		 * 将 source 的child放在其他容器中,层级不改变 
		 * @param	source
		 * @param	container
		 * @param	setChild 将child.name 相同的设置在container中
		 */
		public static function childToAnthorContainer(source:Sprite, container:Sprite, setChild:Boolean=true):void {
			var child : DisplayObject = null;
			while(source.numChildren){
				child = source.removeChildAt(0);
				if(setChild && container.hasOwnProperty(child.name)){
					container[child.name] = child;
				}
				container.addChild(child);
			}
		}
		
		/**
		 * 删除所有子试图
		 * @param	source
		 */
		public static function removeAllChildren(source:DisplayObjectContainer):void {
			var i:int = 0, len:int = source.numChildren;
			while (i < len) {
				source.removeChildAt(0);
				i++;
			}
		}
		
		/**
		 * 相对于父居中
		 * @param	source
		 */
		public static function center(source:DisplayObject):void {
			if (source && source.parent) {
				source.x = int(int(source.parent.width - source.width) >> 1);
				source.y = int(int(source.parent.height - source.height) >> 1);
				//centerBySize(source.parent.width
			}
		}
		
		/**
		 * 相对于size居中
		 * @param	source
		 */
		public static function centerBySize(source:DisplayObject, wid:Number, hei:Number):void {
			source.x = int(int(wid - source.width) >> 1);
			source.y = int(int(hei - source.height) >> 1);
		}
		/**
		 * 画一个sprite的边框
		 * @param	source
		 */
		public static function drawBorder(source:Sprite, thinkness:int=1, color:uint=0, alpha:Number=1):void {
			var g : Graphics = source.graphics;
			g.lineStyle(thinkness, color, alpha);
			g.drawRect(0, 0, source.width, source.height);
		}
		/**
		 * 在sprite 画个灰层
		 * @param	source
		 * @param	isAdd 默认是画，false是clear
		 * @param	color
		 * @param	alpha
		 */
		public static function drawGrayLayer(source:Sprite, isAdd:Boolean=true, color:uint = 0, alpha:Number = 0.6):void {
			var g : Graphics = source.graphics;
			if(isAdd){
				g.beginFill(color, alpha);
				g.drawRect(0, 0, source.width, source.height);
				g.endFill();
			}else {
				g.clear();
			}
		}
		
		/**
		 * 用graphics画个矩形
		 * @param	g
		 * @param	isAdd 默认是画，false是clear
		 * @param	color
		 * @param	alpha
		 */
		public static function drawLayerByGraphics(g:Graphics, wid:int, hei:int, isAdd:Boolean=true, color:uint = 0, alpha:Number = 0.6):void {
			if (isAdd) {
				g.clear();
				g.beginFill(color, alpha);
				g.drawRect(0, 0, wid, hei);
				g.endFill();
			}else {
				g.clear();
			}
		}
		
		public static function drawGrayLayerBySize(source:Sprite, wid:int, hei:int, isAdd:Boolean=true, color:uint = 0, alpha:Number = 0.6):void {
			var g : Graphics = source.graphics;
			if(isAdd){
				g.beginFill(color, alpha);
				g.drawRect(0, 0, wid, hei);
				g.endFill();
			}else {
				g.clear();
			}
		}
		
		public static function drawGrayLayerBySizePos(source:Sprite, posX:int, posY:int, wid:int, hei:int, isAdd:Boolean=true, color:uint = 0, alpha:Number = 0.6):void {
			var g : Graphics = source.graphics;
			if (isAdd) {
				g.clear();
				g.beginFill(color, alpha);
				g.drawRect(posX, posY, wid, hei);
				g.endFill();
			}else {
				g.clear();
			}
		}
		
	}

}