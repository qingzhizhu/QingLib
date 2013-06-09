// =================================================================================================
//
//  ctp2nd's constants / iOS device detect-o-matic
//	This is probably far from optimal, but, as I tell my wife, 'It was good for me.'
//  <a href="http://www.ctpstudios.com" rel="nofollow">http://www.ctpstudios.com</a> | ctp2nd @ gmail / gtalk / twitter
//
// =================================================================================================
 
package
{
	//
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
 
	public class Constants
	{
 
		// first check to see if we're on the device or in the debugger //
		public static const isDebugger:Boolean = Capabilities.isDebugger;
		// set a few variables that'll help us deal with the debugger//
		public static const isLandscape:Boolean = true;  // most of my games are in landscape
		public static const debuggerDevice:String = "iPhone4"; // iPhone3 = iPhone4,4s, etc.
 
		// we create an object here that'll keep a detailed abount of the current environment.
		public static const DeviceDetails:Object = getDeviceDetails();
 
		public static const GameWidth:int  = DeviceDetails.width;  // set an Easy reference for Height & Width
		public static const GameHeight:int = DeviceDetails.height; 
 
		public static const CenterX:int = DeviceDetails.x;  // Calculate the CenterX & Y for the screen
		public static const CenterY:int = DeviceDetails.y;
 
		// I find that having a rect that accurately represents the screen size is useful, so I make one here for both main orientations.
		public static const GameScreenLandscape:Rectangle = new Rectangle(CenterX, CenterY, GameWidth, GameHeight);
		public static const GameScreenPortrait:Rectangle = new Rectangle(CenterY, CenterX, GameHeight, GameWidth); 
 
		private static function getDeviceDetails():Object {
			var retObj:Object = {};
			var devStr:String = Capabilities.os;
			var devStrArr:Array = devStr.split(" ");
			devStr = devStrArr.pop();
			devStr = (devStr.indexOf(",") > -1)?devStr.split(",").shift():debuggerDevice;
			if ((devStr == "iPhone1") || (devStr == "iPhone2")){
				// lowdef iphone, 3, 3g, 3gs
				retObj.width = 480;
				retObj.height = 320;
				retObj.x = 240;
				retObj.y = 160;
				retObj.device = "iphone";
				retObj.scale = 1;
			} else if ((devStr == "iPhone3") || (devStr == "iPhone4") || (devStr == "iPhone5")){
				// highdef iphone 4, 4s, 5?
				retObj.width = 960;
				retObj.height = 640;
				retObj.x = 480;
				retObj.y = 320;
				retObj.device = "iphone4";
				retObj.scale = 2;
			} else if ((devStr == "iPad1") || (devStr == "iPad2")){
				// ipad 1,2
				retObj.width = 1024;
				retObj.height = 768;
				retObj.x = 512;
				retObj.y = 384;
				retObj.device = "ipad";
				retObj.scale = 1;
			} else if ((devStr == "iPad3")){
				//what ipad 3... i mean 'The new iPad', sorry
				retObj.width = 2048;
				retObj.height = 1536;
				retObj.x = 1024;
				retObj.y = 768;
				retObj.device = "ipad";
				retObj.scale = 2; // oops!  thanks for pointing that out
			} else {
				//Wait, it wasn't ANY of those devices?  Oh well, lets make an ASS of yoU and ME
				//I'm assuming the OS reported something stupid, so we'll default to the high def iPhone graphics
				retObj.width = 960;
				retObj.height = 640;
				retObj.x = 480;
				retObj.y = 320;
				retObj.device = "iphone4";
				retObj.scale = 2;
			}
			return retObj;
		}
 
	}
}