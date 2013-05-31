package com.qing.utils 
{
	import flash.utils.describeType;
	/**
	 * 普通的xml转换，还不支持namespace. 可能还有一些bug，下面有例子
	 * 
	 * <br/>
	 * <example>
	 * var obj : Object = { "id":1, "name":"gk" };
	 * simple1: 对象套对象
			var temp : Object = { "file":"1.json", "size":1222 };
			obj.file = temp;
			//<root name="gk" id="1">
  //<file size="1222" file="1.json"/>
//</root>
	 * simple2: 对象套数组
			obj.likes = [{"id":"1", "name":"ball"}, {"id":"2", "name":"sing"}  ];
			//<root name="gk" id="1">
  //<likes name="ball" id="1"/>
  //<likes name="sing" id="2"/>
  //<file size="1222" file="1.json"/>
//</root>
	 * simple3: 对象套对象套数组
			obj.trees = { "id":1, "name":"trees", tree:[ {"id":"1", "name":"tree1"}, {"id":"2", "name":"tree2"} ] };
			var x : XML = Obj2XML.parse(obj);
			trace(x.toXMLString());
			
			
			//<root name="gk" id="1">
  //<trees name="trees" id="1">
    //<tree name="tree1" id="1"/>
    //<tree name="tree2" id="2"/>
  //</trees>
  //<likes name="ball" id="1"/>
  //<likes name="sing" id="2"/>
  //<file size="1222" file="1.json"/>
//</root>

	 * simple4: 对象套简单类型数组
		 var obj : Object = { "id":"test", "arr":[0, 1, 2, 3, 4, 5, 6] };
			var myXML : XML = Obj2XML.parse(obj);
			//trace( myXML.toXMLString());
			//<root id="test">
  //<arr>0,1,2,3,4,5,6</arr>
//</root>
		反解为 {"name":"test", "arr":"0,1,2,3,4,5,6"}
	 * simple5: 
		 * var obj : Object = { "id":"test", "arr":[0, {"name":"the obj in the simple type arr"}, 1, 2, 3, 4, 5, 6] };
			var myXML : XML = Obj2XML.parse(obj);
			trace( myXML.toXMLString());
		  //<root id="test">
  //<arr name="the obj in the simple type arr">0,1,2,3,4,5,6</arr>
//</root> 
		这个在用XML2Obj进行反解的时候 为,{"id":"test", "arr":{"_content":"0,1,2,3,4,5,6", "name":"the obj in the simple type arr"}}
		值在arr._content中

	 * </example>
	 * @author gengkun123@gmail.com
	 */
	public class Obj2XML 
	{
		private static const STR_VAR : String = "variable";
		
		/**
		 * object to xml ， 
		 * @param	obj, give a obj, don't give a Array,String...
		 * @param	name the element name
		 * @return
		 */
		public static function parse(obj:Object, name:String = "root"):XML {
			if (!name) name = "root";
			var result : XML = new XML("<" + name + "/>");
			var type : String = null;// ObjectUtil.getObjType(obj);			
			obj = ObjectUtil.getDynamicObj(obj);			
			var child : * = null;
			for (var prop : * in obj) {
				child = obj[prop];
				type = ObjectUtil.getObjType(child);
				if (type == ObjectUtil.TYPE_OBJECT) {
					result.appendChild(parse(child, prop) );
				}else if (type == ObjectUtil.TYPE_ARRAY) { 
					//result.prop = new XMLList();
					var tempArr : Array = [];
					for each(var tObj : * in child) {
						type = ObjectUtil.getObjType(tObj);
						if (type == ObjectUtil.TYPE_OBJECT || type == ObjectUtil.TYPE_ARRAY) {
							result.appendChild(parse(tObj, prop) );
						}else {
							tempArr.push(tObj.toString());
						}
					}
					if (tempArr.length > 0) {
						result[prop] = tempArr.join(",");
					}
					tempArr = null;
				}
				else {
					result.@[prop] = child;
				}
			}
			return result;
		}
		
	}

}