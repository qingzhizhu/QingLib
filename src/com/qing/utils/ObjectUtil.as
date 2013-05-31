package com.qing.utils 
{
	import flash.system.System;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author gengkun123@gmail.com
	 */
	public class ObjectUtil 
	{
		/**CLASS type*/
		public static const TYPE_ARRAY : String = "Array";
		public static const TYPE_OBJECT : String = "Object";
		public static const TYPE_INT : String = "int";
		public static const TYPE_NUMBER : String = "Number";
		public static const TYPE_STRING : String = "String";
		public static const TYPE_DATE : String = "Date";
		public static const TYPE_XML : String = "XML";
		public static const TYPE_BOOLEAN : String = "Boolean";
		
		/**PROPERTY type*/
		public static const PROP_VAR : String = "variable";
		public static const PROP_ACCESSOR : String = "accessor";
		
		public function ObjectUtil() 
		{
			
		}
		
		/**
		 * 获得顶级基本类型
		 * trace( ObjectUtil.getObjType(new Object()) );
			trace( ObjectUtil.getObjType([]));
			trace( ObjectUtil.getObjType("trasdasdf"));
			trace( ObjectUtil.getObjType( -1));
			trace( ObjectUtil.getObjType(1.2));
			trace( ObjectUtil.getObjType(true));
			trace( ObjectUtil.getObjType(new TestVO()) );
			trace( ObjectUtil.getObjType(new Dictionary() ));
			trace( ObjectUtil.getObjType(new Date()) );
			trace( ObjectUtil.getObjType( <tree></tree> ) );
			trace( ObjectUtil.getObjType(new Vector.<String>()));
			
		 * @param	obj
		 * @return Array | String | int | Number | Boolean | Date | Object | XML
		 */
		public static function getObjType(obj:*):String {
			var type : String = getQualifiedClassName(obj);
			if (type.indexOf("Vector") > -1) {
				type = TYPE_ARRAY;
			}
			else if (type.indexOf("::") > -1) {
				type = TYPE_OBJECT;
			}
			return type;
		}
		
		/**
		 * convert customer obj to dynamic obj. know from the clone(), becase the registerClassAlias.
		 * @param	obj
		 * @param	deep is deep dynamic? child... groundson...
		 * @return
		 */
		public static function getDynamicObj(obj:Object, deep:Boolean = false):Object {
			var type : String = getObjType(obj);
			if (type != TYPE_OBJECT && type != TYPE_ARRAY) {
				return obj;
			}
			var desc : XML = describeType(obj);
			if (desc.@isDynamic == false) {
				var list : XML = <root/>;
				list.appendChild(desc.elements(PROP_VAR));
				list.appendChild(desc.elements(PROP_ACCESSOR));
				var result : Object = { };
				var name : String = null;
				var child : * = null;
				for each(var temp:* in list.children() ) {
					name = temp.@name;
					child = obj[name];
					if (deep) {
						switch (getObjType(child)) 
						{
							case TYPE_OBJECT:
								result[name] = getDynamicObj(child, deep);
							break;
							case TYPE_ARRAY:
								result[name] = [];
								for each( var temp2:* in child) {
									result[name].push(getDynamicObj(temp2, deep));
								}
							break;
							
							default:
								result[name] = child;
							break;
						} 
					}else{
						result[name] = child;
					}
				}
				System.disposeXML(list);
				list = null;
				return result;
			}
			return obj;
		}
		
		/**
		 * deep copy
		 * @param	source
		 * @return
		 */
		public static function clone(source:Object):Object {
			var bytes : ByteArray = new ByteArray();
			bytes.writeObject(source);
			bytes.position = 0;
			return bytes.readObject();
		}
	}

}