package com.qing.ane.billing 
{
	
	/**
	 * 支付接口
	 * @author gengkun123@gmail.com
	 */
	public interface IPayment 
	{
		/**
		 * only use on the android
		 * @param	key
		 */
		function setPublicKey(key:String):void;
		/**
		 * 
		 * @param	procuctId	google play or ios item id
		 * @param	onSuccess	onSuccess(productId)
		 * @param	onFail		onFail(productId, errorTxt)
		 */
		function buyItem(productId:String, onSuccess:Function, onFail:Function = null):void;
	}
	
}