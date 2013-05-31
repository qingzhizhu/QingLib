package com.qing.ane.billing 
{
	
	
	import com.qing.utils.Logger;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	/**
	 * 支付类
	 * @author gengkun123@gmail.com
	 */
	
	//===========================================================================================android================================================================
	CONFIG::ANDROID
		import com.milkmangames.nativeextensions.android.AndroidIAB;
	CONFIG::ANDROID
		import com.milkmangames.nativeextensions.android.events.AndroidBillingEvent;
	CONFIG::ANDROID
		import com.milkmangames.nativeextensions.android.events.AndroidBillingErrorEvent;
		
	CONFIG::ANDROID
	public class Payment implements IPayment 
	{
		private var _publicKey:String;
		private var _iab:AndroidIAB;
		private var _itemId:String;
		private var _onSuccess:Function;
		private var _onFail:Function;
		
		public function Payment() 
		{
			Logger.debug("android payment!");
		}
		
		public function setPublicKey(key:String):void {
			_publicKey = key;
		}
		
		/* INTERFACE com.kun.billing.IPayment */
		
		public function buyItem(productId:String, onSuccess:Function, onFail:Function = null):void 
		{
			_itemId = productId;
			_onSuccess = onSuccess;
			_onFail = onFail;
			
			if (_iab == null)
				init();
			else
				doPurchase();
		}
		
		private function doPurchase():void 
		{
			Logger.debug("google play sell the item?", _itemId);
			_iab.purchaseItem(_itemId);
			//_iab.testPurchaseItemSuccess();
		}
		
		private function init():void 
		{
			if (!AndroidIAB.isSupported()) {
				Logger.debug("Don't support android payemnt!");
				return;
			}
			_iab = AndroidIAB.create();
			_iab.addEventListener(AndroidBillingEvent.SERVICE_READY, handleEvent);
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
		
		private function handleEvent(e:Event):void 
		{
			switch (e.type)
			{
				case AndroidBillingEvent.SERVICE_READY:
					if (this._itemId) {
						doPurchase();
					}
					break;
				case AndroidBillingEvent.PURCHASE_SUCCEEDED:
					if (_onSuccess != null){
						_onSuccess((e as AndroidBillingEvent).itemId);
						_onSuccess = null;
					}
					_itemId = null;
					break;
				case AndroidBillingEvent.SERVICE_NOT_SUPPORTED:
				case AndroidBillingEvent.PURCHASE_CANCELLED:
				case AndroidBillingErrorEvent.PURCHASE_FAILED:
					if (_onFail != null){
						_onFail(e["itemId"], e);
						_onFail = null;
					}
					_itemId = null;
					break;
				default:
					Logger.debug("payment:", e);
					break;
			}
		}
		
	}
	
	
	//===========================================================================================ios  没有测试================================================================
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
		
	CONFIG::IOS
	public class Payment implements IPayment 
	{
		private var _itemId:String;
		private var _onSuccess:Function;
		private var _onFail:Function;
		/**?*/
		private var _count:Number = 0;
		
		public function Payment() 
		{
			Logger.debug("IOS payment!");
			init();
		}
		
		public function setPublicKey(key:String):void {
			
		}
		
		/* INTERFACE com.kun.billing.IPayment */
		
		public function buyItem(productId:String, onSuccess:Function, onFail:Function = null):void 
		{
			_itemId = productId;
			_onSuccess = onSuccess;
			_onFail = onFail;
			
			AppPurchase.manager.startPayment(productId, 1);
		}
		
		
		///=============
		private function init():void
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
						//confirmbyFE(t);
						
						trace("调用成功事件");
						this._onSuccess && this._onSuccess(this._itemId);
					});
					trace("Called Finish on " + t.transactionIdentifier);
				}else if(t.state == Transaction.TRANSACTION_STATE_RESTORED){
					if(t.originalTransaction.state == Transaction.TRANSACTION_STATE_FAILED || t.originalTransaction.state == Transaction.TRANSACTION_STATE_PUCHASED){
						AppPurchase.manager.finishTransaction(t.originalTransaction.transactionIdentifier);
						trace("Restored Transaction Finish on " + t.transactionIdentifier); 
					}
				}else{
					trace("Finish Not Called");
					_count++;
					if (_count == 2)
					{
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