package com.qing.ane.billing 
{
	import com.greensock.TimelineMax;
	//import com.qing.common.billing.IPurchaseService;
	//import com.qing.common.HTTPServiceEvent;
	//import com.qing.common.logging.Log;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	//import com.qing.slotmachine.Game;
	
	CONFIG::IOS
		import com.adobe.nativeExtensions.Transaction;
	CONFIG::IOS
		import com.adobe.nativeExtensions.AppPurchase;
	CONFIG::IOS
		import com.adobe.nativeExtensions.AppPurchaseEvent;
	CONFIG::IOS
		import com.adobe.nativeExtensions.Product;
	CONFIG::IOS
		import com.adobe.nativeExtensions.Transaction;	
	
	CONFIG::ANDROID
		import com.milkmangames.nativeextensions.android.AndroidIAB;
	CONFIG::ANDROID
		import com.milkmangames.nativeextensions.android.events.AndroidBillingErrorEvent;
	CONFIG::ANDROID
		import com.milkmangames.nativeextensions.android.events.AndroidBillingEvent;
	CONFIG::ANDROID
		import com.milkmangames.nativeextensions.android.events.AndroidBillingEvent;
	/**
	 * ...
	 * @author Nicolas Tian
	 */
	public class IAPHelper extends EventDispatcher
	{
		public static var EVENT_HIDE_MASK:String = "event_hide_mask";
		public static var EVENT_SHOW_MASK:String = "event_show_mask";
		
		public static var TRAN_TYPE_GEM:Number = 0;
		public static var TRAN_TYPE_COIN:Number = 1;
		
		private var version:String = "";
		
		private static var OS_TYPE_IOS:Number = 0;
		private static var OS_TYPE_ANDROID:Number = 1;
		
		private var _inited:Boolean = false;
		
		private var _publicKey:String;
		CONFIG::ANDROID
		private var _iab:AndroidIAB;
		private var _item:Object;//购买的物品对象
		private var _dataId:Number = 0;//后台在第一步告诉前台的交易id
		private var _dataIdAndroid:String = "";
		private var _onSuccess:Function;//交易成功的回调
		private var _onFail:Function;//交易失败的回调
		private var _transactionType:Number = 0;//交易类型：0，gem；1，coin
		private var _count:Number = 0;
		
		public function IAPHelper(publicKey:String) 
		{
			_publicKey = publicKey;
			
		}
		
		
		//---------------------------------------------------public API------------------------------------------------
		/**
		 * 支付的API
		 * @param	item		购买的物品对象里面必须包含的属性
		 * {
				Count: 数量
				Price: 价格
				iTunesID: 在applestore里的id
				AndroidStoreID: 在google里的id
				LogID: 数量跟等级挂钩，需要用这个id匹配
			}
		 * @param   type 		购买类型，0：购买宝石，1：购买coin
		 * @param	onSuccess 	function(itemId:String):void
		 * @param	onFail		function(itemId:String, msg:String):void
		 */
		public function purchase(item:Object, type:Number, onSuccess:Function = null, onFail:Function = null):void
		{
			_item = item;
			_transactionType = type;
			_onSuccess = onSuccess;
			_onFail = onFail;
			
			if (!_inited)
			{
				init();
			}else {
				buyReport();
			}
			
			CONFIG::IOS
			{
				buyReport();
			}
		}
		
		
		//------------------------------------------------private API------------------------------------------------------
		
		//第一次通讯的回调
		private function reportCB(evt:*):void
		{
			if (evt.response.code == 0)
			{
				CONFIG::IOS
				{
					_dataId = parseInt(evt.response.data);//记录这个id，这是前后端之间记录的id，与后来真正的交易数据有对应
					AppPurchase.manager.startPayment(_item.iTunesID,1);
				}
				CONFIG::ANDROID
				{
					_dataIdAndroid = evt.response.data;
					_iab.purchaseItem("slotgirls_coin_tier1.flash");
				}
			}
			else {
				if(this._onFail != null) this._onFail();
			}
		}
		
		//第二次通讯的回调
		private function confirmCB(evt:*):void
		{
			if (evt.response.code == 0)
			{
				if(this._onSuccess != null) this._onSuccess();
			}else {
				if(this._onFail != null) this._onFail();
			}
			
			//Game.service.canRemove = true;
			//Game.service.removeLoad();
			dispatchEvent(new Event(IAPHelper.EVENT_HIDE_MASK));
		}
		
		//同后台的第一次通讯
		private function buyReport():void 
		{
			var itemId:String = "";
			CONFIG::ANDROID
			{
				itemId = _item.AndroidStoreID;
			}
			CONFIG::IOS
			{
				itemId = _item.iTunesID;
			}
			
			//判断交易类型然后判断平台类型
			if (_transactionType == IAPHelper.TRAN_TYPE_GEM)
			{
				CONFIG::IOS
				{
					//Game.service.buyGemReport(_item.Count, _item.Price, IAPHelper.OS_TYPE_IOS, itemId, reportCB);
					;
				}
				CONFIG::ANDROID
				{
					//Game.service.buyGemReportANDROID(_item.Count, _item.Price, IAPHelper.OS_TYPE_ANDROID, itemId, reportCB);
					;
				}
			} else {
				var coins:uint = 0;// Game.ui.levelData[_item.LogID];
				CONFIG::IOS
				{
					//Game.service.buyCoinReport(_item.Count, _item.Price, IAPHelper.OS_TYPE_IOS, itemId, reportCB);
					;
				}
				CONFIG::ANDROID
				{
					//Game.service.buyCoinReportANDROID(_item.Count, _item.Price, IAPHelper.OS_TYPE_ANDROID, itemId, reportCB);
					;
				}
			}
		}
		
		//同后台的第二次通讯
		private function confirmbyFE(t:Object = null):void
		{
			CONFIG::IOS
			{
				if (_transactionType == IAPHelper.TRAN_TYPE_GEM)
				{
					//Game.service.getConfirmedbyFE(_dataId, t.receipt, IAPHelper.OS_TYPE_IOS, _item.iTunesID, confirmCB);
					;
				}else {
					//Game.service.coinConfirmedbyFE(_dataId, t.receipt, IAPHelper.OS_TYPE_IOS, _item.iTunesID, confirmCB);
					;
				}
			}
			CONFIG::ANDROID
			{
				if (_transactionType == IAPHelper.TRAN_TYPE_GEM)
				{
					//Game.service.getConfirmedbyFEANDROID(_dataIdAndroid, confirmCB);
					;
				} else {
					//Game.service.coinConfirmedbyFEANDROID(_dataIdAndroid, confirmCB);
					;
				}
			}
		}
		
		private function init():void 
		{
			_inited = true;
			CONFIG::ANDROID
			{
				initAndroidPurchase();
			}
			CONFIG::IOS
			{
				initIOSPurchase();
			}
		}
		
		CONFIG::ANDROID
		{
			private function initAndroidPurchase():void
			{
				_iab = AndroidIAB.create();
				_iab.addEventListener(AndroidBillingEvent.SERVICE_READY, onServiceReady);
				_iab.addEventListener(AndroidBillingEvent.SERVICE_NOT_SUPPORTED, handleEvent);
				_iab.addEventListener(AndroidBillingEvent.PURCHASE_SUCCEEDED, handleEvent);
				_iab.addEventListener(AndroidBillingEvent.PURCHASE_REFUNDED, handleEvent);
				_iab.addEventListener(AndroidBillingEvent.PURCHASE_CANCELLED, handleEvent);
				_iab.addEventListener(AndroidBillingEvent.PURCHASE_USER_CANCELLED, handleEvent);
				_iab.addEventListener(AndroidBillingErrorEvent.PURCHASE_FAILED, handleEvent);
				_iab.addEventListener(AndroidBillingEvent.TRANSACTIONS_RESTORED,handleEvent);
				_iab.addEventListener(AndroidBillingErrorEvent.TRANSACTION_RESTORE_FAILED, handleEvent);
				_iab.startBillingService(_publicKey);
			}
			
			private function onServiceReady(e:AndroidBillingEvent):void 
			{
				if (_item != null)
					buyReport();
			}
			
			private function handleEvent(e:Event):void 
			{
				switch (e.type)
				{
					case AndroidBillingEvent.PURCHASE_SUCCEEDED:
						if (_onSuccess != null)
							_onSuccess();
						_item = null;
						confirmbyFE();
						break;
					case AndroidBillingEvent.SERVICE_NOT_SUPPORTED:
					case AndroidBillingEvent.PURCHASE_CANCELLED:
					case AndroidBillingErrorEvent.PURCHASE_FAILED:
						if (_onFail != null)
							_onFail();
						_item = null;
						break;
				}
			}
		}
		
		CONFIG::IOS
		{
			private function initIOSPurchase():void
			{
				AppPurchase.manager.addEventListener(AppPurchaseEvent.UPDATED_TRANSACTIONS,onUpdate);
				AppPurchase.manager.addEventListener(AppPurchaseEvent.RESTORE_FAILED,function(e:AppPurchaseEvent):void{trace("FFFFFFFFFFFAILD",e.error);});
				AppPurchase.manager.addEventListener(AppPurchaseEvent.RESTORE_COMPLETE, function(e:AppPurchaseEvent):void { trace("complete!");} );
				AppPurchase.manager.addEventListener(AppPurchaseEvent.REMOVED_TRANSACTIONS,function(e:AppPurchaseEvent):void{
					trace("Removed Transaction...");
					for each(var t:Transaction in e.transactions){
						trace ("Removed: " + t.transactionIdentifier);
					}
				});
				AppPurchase.manager.restoreTransactions();
			}
			
			protected function onUpdate(e:AppPurchaseEvent):void
			{
				for (var i:Number = 0; i < e.transactions.length; i++)
				{
					var t:Transaction = e.transactions[i];
					trace("APP - Printing Transaction", "Date: " + t.date, "Error: " + t.error, "Product Id: " + t.productIdentifier, "Product Quantity: " + t.productQuantity
						,"Receipt: " + t.receipt,"State: " + t.state,"transaction Identifier: " + t.transactionIdentifier);
					if (t.state == Transaction.TRANSACTION_STATE_PUCHASED) {
						AppPurchase.manager.finishTransaction(t.transactionIdentifier);
						var req:URLRequest = new URLRequest("https://sandbox.itunes.apple.com/verifyReceipt");
						req.method = URLRequestMethod.POST;
						req.data = "{\"receipt-data\" : \""+ t.receipt +"\"}";
						var ldr:URLLoader = new URLLoader(req);
						ldr.load(req);
						ldr.addEventListener(Event.COMPLETE, function(e:Event):void {
							confirmbyFE(t);
						});
						trace("Called Finish on " + t.transactionIdentifier);
					}else if(t.state == Transaction.TRANSACTION_STATE_RESTORED){
						if(t.originalTransaction.state == Transaction.TRANSACTION_STATE_FAILED || t.originalTransaction.state == Transaction.TRANSACTION_STATE_PUCHASED){
							AppPurchase.manager.finishTransaction(t.originalTransaction.transactionIdentifier);
							trace("Restored Transaction Finish on " + t.transactionIdentifier); 
						}
						//Game.service.canRemove = true;
						//Game.service.removeLoad();
					}else{
						trace("Finish Not Called");
						_count++;
						if (_count == 2)
						{
							//Game.service.canRemove = true;
							//Game.service.removeLoad();
							_count = 0;
						}
						if (t.transactionIdentifier)
						{
							AppPurchase.manager.finishTransaction(t.transactionIdentifier);
						}
					}
				}
			}
		}
	}

}