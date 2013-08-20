package test.as3 {
    import flash.display.Sprite;

    public class ProxyExample extends Sprite {
        public function ProxyExample() {
            var arr:ProxyArray = new ProxyArray();
            arr.push(1);
            arr.push(-2);
            arr.push(3);
            arr.push(4);
            arr.push("five");
            
            trace(arr.length); // 5
            trace(arr[0]);     // 1
            trace(arr[1]);     // -2
            trace(arr[2]);     // 3
            trace(arr[3]);     // 4

            trace(arr.sum());  // 6
			
			arr.sum();

            arr.clear();
            trace(arr); // (empty string)
            
            arr[0] = "zero";
            trace(arr); // zero
        }
    }
}

import flash.utils.Proxy;
import flash.utils.flash_proxy;

dynamic class ProxyArray extends Proxy {
    private var _item:Array;

    public function ProxyArray() {
        _item = new Array();
    }

    override flash_proxy function callProperty(methodName:*, ... args):* {
        var res:*;
        switch (methodName.toString()) {
            case 'clear':
                _item = new Array();
                break;
            case 'sum':
                var sum:Number = 0;
                for each (var i:* in _item) {
                    // ignore non-numeric values
                    if (!isNaN(i)) {
                        sum += i;
                    }
                }
                res = sum;
                break;
            default:
                res = _item[methodName].apply(_item, args);
                break;
        }
        return res;
    }

    override flash_proxy function getProperty(name:*):* {
        return _item[name];
    }

    override flash_proxy function setProperty(name:*, value:*):void {
        _item[name] = value;
    }
}
