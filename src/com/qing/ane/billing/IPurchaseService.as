package com.qing.ane.billing 
{
	
	/**
	 * ...
	 * @author ....
	 */
	public interface IPurchaseService
	{
		/**
		 * 支付购买宝石的第一步
		 * @param	gems 购买的
		 * @param	price 价格
		 * @param	platformType 平台类型 0：ios，1：android
		 * @param	itemId 物品id
		 * @param	callback 回调
		 */
		function buyGemReportANDROID(gems:uint, price:Number, platformType:Number, itemId:String, callback:Function = null):void
		
		/**
		 * 支付的第二步
		 * @param	tid 后台在第一步告诉前台的交易id
		 * @param	callback 回调
		 */
		function getConfirmedbyFEANDROID(tid:String, callback:Function):void
		
		function buyCoinReportANDROID(gems:uint, price:Number, platformType:Number, itemId:String, callback:Function = null):void
		
		function coinConfirmedbyFEANDROID(tid:String, callback:Function):void
		
		/**
		 * 支付购买宝石的第一步
		 * @param	gems 购买的
		 * @param	price 价格
		 * @param	platformType 平台类型 0：ios，1：android
		 * @param	itemId 物品id
		 * @param	callback 回调
		 */
		function buyGemReport(gems:uint, price:Number, platformType:Number, itemId:String, callback:Function = null):void
		
		/**
		 * 支付的第二步
		 * @param	tid 后台在第一步告诉前台的交易id
		 * @param	callback 回调
		 */
		function getConfirmedbyFE(tid:Number, receiptdata:Object , platformType:Number , itemId:String , callback:Function):void
		
		function buyCoinReport(gems:uint, price:Number, platformType:Number, itemId:String, callback:Function = null):void
		
		function coinConfirmedbyFE(tid:Number, receiptdata:Object , platformType:Number , itemId:String , callback:Function):void
	}
	
}