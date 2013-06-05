
package com.qing.utils
{	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageQuality;
	import flash.geom.Matrix;
	import flash.system.Capabilities;
	import flash.utils.getTimer;

	/**
	 * 系统属性，开启缓存等等
	 * @author kevin geng
	 */
	public class MySystem
	{
		private static var _stage : Stage = null;
		private static var _openCacheAsBt : Boolean = true;
		
		private static var _first_desktop : int = -1;
		private static var _first_ios : int = -1;
		private static var _first_android : int = -1;
		
		/**
		 * 
		 * @param stage 舞台
		 * @param openCacheAsBt 是否使用位图缓存功能
		 */
		public static function init(stage:Stage, openCacheAsBt:Boolean = true):void{
			_stage = stage;
			_openCacheAsBt = openCacheAsBt;
		}
		/**
		 * 系统运行时间
		 * 
		 */
		public static function currentTimeMillis():int
		{
			return getTimer();
		}
		/**
		 * 计算位图的内存， 传入Bitmap 或 BitmapData. wid x hei x 4 / 1024.
		 * @param 返回单位 KB
		 */
		public static function countBitmapMem(bitmap : *):uint{
			if(bitmap is Bitmap || bitmap is BitmapData){
				return (bitmap.width * bitmap.height >> 8 );
			}
			return 0;
		}
		
		/**
		 * 是否桌面系统中 
		 * @return 
		 * 
		 */        
		public static function get isDesktop():Boolean
		{
			if(!~_first_desktop){
				_first_desktop = (Capabilities.playerType=="Desktop" || Capabilities.playerType=="ActiveX" || Capabilities.playerType=="PlugIn") ? 1 : 0;
			}
			return _first_desktop;
		}
		
		/**
		 * 是否ios
		 * @return
		 */
		public static function get isIOS():Boolean 
		{
			if(!~_first_ios){
				_first_ios = (~Capabilities.manufacturer.toLowerCase().indexOf("ios")) ? 1 : 0;
			}
			return _first_ios;
		}
		
		
		/**
		 * 是否android
		 * @return
		 */
		public static function get isAndroid():Boolean 
		{
			if(!~_first_android){
				_first_android = (~Capabilities.manufacturer.toLowerCase().indexOf("android")) ? 1 : 0;
			}
			return _first_android;
		}
		
		/**
		 * 设置舞台质量
		 */
		public static function set stageQuality(qua : String):void{
			if(_stage)
			_stage.quality = qua;
		}
		/**
		 * 最低的舞台品质
		 */
		public static function lowStageQuality():void{
			stageQuality = StageQuality.LOW;
		}
		/**
		 * high 舞台品质
		 */
		public static function highStageQuality():void{
			stageQuality = StageQuality.HIGH;
		}
		/**
		 * 当init（）方法的_openCacheAsBt 开时，
		 * 启用位图缓存；当在桌面平台开启位图矩阵，bitmap不要使用此方法。
		 * @param opaqueColor 背景颜色。 -1 不使用此属性
		 */
		public static function openCacheAsBt(dis:DisplayObject, opaqueColor:int=-1):void{
			if(dis is Bitmap){
				trace("bitmap don't open cacheAsBitmap");
				return;
			}
			if(_openCacheAsBt){
				dis.cacheAsBitmap = true;
				if(isDesktop) dis.cacheAsBitmapMatrix = new Matrix();
			}
			if(~opaqueColor){
				dis.opaqueBackground = opaqueColor;
			}
		}
		
	}
}