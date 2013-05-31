package com.qing.utils 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	/**
	 * 操作file的帮助类
	 * @author gengkun123@gmail.com
	 */
	public class FileUtil 
	{
		/**
		 * 将\换为/, use on the windows
		 * @param	path
		 * @return
		 */
		public static function pathFormat(path:String):String {
			return path.replace(/\\/g, "\/");
		}
		/**
		 * 替换文件路径
		 * @param	path
		 * @param	pattern
		 * @param	repl
		 * @return
		 */
		public static function pathReplace(path:String, pattern:*, repl:Object):String {
			if (pattern is String) {
				pattern = pathFormat(pattern);
			}
			return pathFormat(path).replace(pattern, repl);
		}
		
		/**
		 * 获得文件的上级目录
		 * "D:\My Documents\DFGameEditor\assets\building\tower\场景.jpg" -> D:\My Documents\DFGameEditor\assets\building\tower\
		 * @param	path
		 * @return
		 */
		public static function getFileDirPath(path:String):String {
			var temp : String = pathFormat(path);
			var index : int = temp.lastIndexOf("\/");
			return temp.substring(0, index + 1);
		}
		
		/**
		 * write something in the file
		 * @param	data
		 * @param	fileName 绝对文件路径
		 * @param	charSet="utf-8"
		 */
		public static function writeFile(data:String, fileName:String, charSet:String="utf-8"):void {
			var file : File = new File(fileName);
			var stream : FileStream = new FileStream();
			stream.openAsync(file, FileMode.WRITE);
			stream.writeMultiByte(data, charSet);
			stream.close();
			data = null;
			stream = null;
			file = null;
		}
		
		/**
		 * getDirectoryListing 返回当前目录的列表
		 * @param	path
		 * @return
		 */
		public static function getDirectoryListing(path:String):Array {
			var file : File =  new File(path);
			if (file.exists && file.isDirectory) {
				return file.getDirectoryListing();
			}
			return null;
		}
		
		/**
		 * 根据path返回系统列表。TreeList data格式如下:<br/>
		 * {
		 * 	"label":File.name,
		 * 	"path":File.nativePath,
		 * 	"items":[
		 * 		{"label":File.name, "path":File.nativePath, "isFile":true/false, items[...]}
		 * 	]
		 * }
		 * @param	path
		 * @param	extension 扩展名 过滤，if null, return all the file.
		 * @return
		 */
		public static function getFileList(path:String, extension:Array=null):* {
			var file : File = new File(path);
			var obj : Object = { "label":file.name, "path":path, "items":null };
			if (!file.exists) {
				return obj;
			}
			var items : Array = [];
			
			var arr : Array = file.getDirectoryListing();
			getFileListHandler(arr, items, extension);
			arr = null;
			obj.items = items;
			return obj;
		}
		/**
		 * getFileList 调用
		 * @param	arr
		 * @param	items
		 * @param	extension 扩展名
		 */
		private static function getFileListHandler(arr:Array, items:Array, extension:Array=null):void {
			var tempObj : Object = null;
			for each(var f : File in arr) {
				tempObj = { "label":f.name, "path":f.nativePath };
				if (f.isDirectory) {
					tempObj.items = [];
					getFileListHandler( getDirectoryListing(f.nativePath), tempObj.items );
				}else {
					if (extension && extension.indexOf(f.extension) < 0) {
						continue;
					}
					tempObj["isFile"] = true;
				}
				items.push(tempObj);
			}
		}
		
		
		//public static function test():void {
			//var file : File = new File();
			//file.browseForOpenMultiple("添加多个图片", [new FileFilter("image(*.jpg;*.png)", "*.jpg;*.jpeg;*.png" )]);
			//file.addEventListener(FileListEvent.SELECT_MULTIPLE, onSelectAddImgs);
		//}
		
		
		
		
	}

}