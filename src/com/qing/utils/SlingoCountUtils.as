package com.qing.utils 
{
	/**
	 * var arr : Array = [
			0, 0, 0, 0, 0,
			0, 0, 0, 0, 0,
			0, 0, 0, 0, 0,
			14, 0, 0, 0, 64,
			0, 0, 0, 60, 0];
			
			var list : Array = SlingoCountUtils.getBingoMatch(arr, 12);
			trace(list.length, list);
			list = SlingoCountUtils.getBingoMatch(arr, 0);
			trace(list.length, list);
	 * @author eric
	 */
	public class SlingoCountUtils 
	{
		
		/**
		 * Bingo结果计算器
		 * @param	numlist			所有网格内的数字集合，用一维数组表示，默认的网格尺寸是5X5
		 * @param	hitpoint		目前点击的网格下表号
		 * @return
		 */
		public static function getBingoMatch(numlist:Array, hitpoint:uint):Array
		{
			var bingoList:Array = [];	//结果数组
			var w:int = 5;		//网格宽
			var h:int = 5;		//网格高		
			var i:int;
			var id:int;
			var tmp:Array;
			var midId:int = Math.ceil((numlist.length - 1) * 0.5);
			
			var x:int = hitpoint % w ;		//点击点的二维横坐标
			var y:int = int(hitpoint / h);	//点击点的二维纵坐标
			var ckLeft:Boolean = false;
			var ckRight:Boolean = false;
			
			//先检查水平连线
			i = 0;
			tmp = [];
			tmp[0] = [];
			tmp[1] = [];
			tmp[2] = [];
			tmp[3] = [];
			while (i < w) {
				//水平id
				id = y * w + i;
				if (numlist[id] == 0) {
					tmp[0].push(id);
				}
				//垂直id
				id = x + i*w;
				if (numlist[id] == 0) {
					tmp[1].push(id);
				}
				//左斜id
				id = i * (w + 1);
				if (numlist[id] == 0) {
					tmp[2].push(id);
				}			
				if (hitpoint == id) ckLeft = true;
				//右斜id
				id = (i+1) * (w - 1);
				if (numlist[id] == 0) {
					tmp[3].push(id);
				}			
				if (hitpoint == id) ckRight = true;
			
				i++;
			}
			//制作结果
			var ln:int = tmp.length;
			for (i = 0; i < ln; i++) {
				var list:Array = tmp[i];
				if (list.length == w) {
					if ((i == 2 && !ckLeft) || (i == 3 && !ckRight)) continue;
					bingoList.push(list);
				}
			}		
			return bingoList;
		}
		
		
	}

}