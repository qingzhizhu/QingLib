package com.qing.utils 
{
	/**
	 * xml helper
	 * @author gengkun123@gmail.com
	 */
	public class XMLUtil 
	{
		
		/**
		 * insert child in the fisrt position.
		 * @param	xml
		 * @param	child
		 * @return
		 */
		public static function insetFirst(xml:XML, child:Object):*{
			return xml.prependChild(child);	//i think this will call insertChildAfter(null, child);
		}
		
		/**
		 * insert child in the last position.
		 * @param	xml
		 * @param	child
		 * @return
		 */
		public static function insetLast(xml:XML, child:Object):*{
			return xml.appendChild(child);
		}
		/**
		 * insert child in the fisrt position. use the insertChildAfter
		 * @param	xml
		 * @param	child
		 * @return
		 */
		public static function insetFirst2(xml:XML, child:Object):*{
			return xml.insertChildAfter(null, child);
		}
		
		/**
		 * insert child in the last position. use the insertChildBefore
		 * @param	xml
		 * @param	child
		 * @return
		 */
		public static function insetLast2(xml:XML, child:Object):*{
			return xml.insertChildBefore(null, child);
		}
		
	}

}