package com.qing.ane
{
	
	import com.juankpro.ane.localnotif.Notification;
	import com.juankpro.ane.localnotif.NotificationAlertPolicy;
	import com.juankpro.ane.localnotif.NotificationEvent;
	import com.juankpro.ane.localnotif.NotificationIconType;
	import com.juankpro.ane.localnotif.NotificationManager;
	import com.qing.utils.Logger;

	/**
	 * ...
	 * @author Nicolas
	 */
	public class NotificationHelper 
	{
		private static const NOTIFICATION_CODE:String = "MY_CUSTOM_NOTIFICATION";

		private static var _notificationManager:NotificationManager;
		
		public function NotificationHelper() 
		{
			
		}
		
		private static function init():Boolean
		{
			if (!NotificationManager.isSupported)
				return false;
				
			if (_notificationManager == null)
			{
				try 
				{
					_notificationManager = new NotificationManager();
					_notificationManager.addEventListener(NotificationEvent.NOTIFICATION_ACTION, onNotificationActionEvent);	
				}
				catch (ae:ArgumentError)
				{
					Logger.debug("The notification native extension has\n no support for this platform.");
					return false;
				}
			}
			return true;
		}
		
		public static function notify(title:String, body:String, tickerText:String, delay:Number = 0, repeatInterval:uint = 0):void
		{		
			if (!init())
				return;
				
			var n:Notification = new Notification();
			
			n.tickerText = tickerText;
			n.title = title;
			n.body = body;

			// This action label appears in two places on iOS: on the action button of the notification dialog, and on the unlock slider when the device is locked.
			// If unset, the iOS default will be used. 
			n.actionLabel = "Open";
			
			// Allows you to contorl whether an alert is dispathed with each notification, or just the first notification.
			n.alertPolicy = NotificationAlertPolicy.EACH_NOTIFICATION;
			
			// On Android, specifies whether the notification persists when the user taps it in the notification area
			n.cancelOnSelect = true;
			
			// On Android and iOS "...the app will be brought to the foreground if it was in the background or launched if it had been shutdown.
			// On iOS, the way to perform the action of a notification manifests itself as a button 
			// on the notification dialog that appears when a notification is fired and different
			// text on the unlock slider when the device is locked. 
			// On Android, the way to perform an action is not visible, it is performed by selecting 
			// the notification from the notification list (window shade)."
			n.hasAction = true;
			n.actionData = "customAction";
			
			// Allows you to set the Android notification icon
			n.iconType = "drawable.icon";
				//NotificationIconType.FLAG;
			
			// On both Android and iOS, lets you set a number on the icon or application badge
			n.numberAnnotation = 0;
							
			// On Android, "ongoing" notifications aren't cleared with the clear button
			n.ongoing = false;
							
			// Android and iOS
			n.playSound = true;
			
			n.fireDate = new Date();
			n.fireDate.time += delay;
			n.repeatInterval = repeatInterval;
			// On Android, alerts (sound and vibration) until acknowledged 
			n.repeatAlertUntilAcknowledged = false;
			
			// Only configurable on Android
			n.vibrate = true;
			
			_notificationManager.notifyUser(NOTIFICATION_CODE, n);
		}
		
		public static function cancelAll():void
		{
			if (!init())
				return;
			
			_notificationManager.cancelAll();
		}
		
		private static function onNotificationActionEvent(e:NotificationEvent):void 
		{
			Logger.debug("return game from notification.");
		}
	}

}