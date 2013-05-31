package com.qing.utils
{
	import flash.net.SharedObject;

	/**
	 * Cookie implementation
	 * The cookie in XP shoud be in  '...\Application Data\Macromedia\Flash Player\#SharedObjects\etc'
	 * Air: C:\Users\kevin\AppData\Roaming\game\Local Store\#SharedObjects\game.swf\#.chocobots
	 * @author cpardon
	 *
	 */
	public class Cookie
	{
        private var mCookie:SharedObject;

        /**
         * Create the cookie
         * @param name Name of the cookie
         *
         */
        public function Cookie( name:String, localPath:String = null )
        {
			try {
				mCookie = SharedObject.getLocal( name, localPath );
			}
			catch (e:Error) {
				Logger.debug("Couldn't create cookie: " + name, e.message);
			}
        }

		/**
		 * Get the underlying data object.
		 */
		public function get data():Object {
			return mCookie.data;
		}

		/**
		 * Gets the size of the cookie on disc.
		 */
		public function get size():uint {
			return mCookie.size;
		}

        /**
         * Read a value in the cookie
         * @param variable Name of the variable you wanna read
         * @return Its value
         *
         */
        public function read( variable:String ):*
		{
		    if( mCookie.data[ variable ] != null )
		    {
		    	return mCookie.data[ variable ];
		    }

		    return null;
		}

        /**
         * Write a value in the cookie
         * @param variable Name of the variable to write the value in
         * @param value New value of this variable
         *
         */
        public function write( variable:String , value:* ):void
		{
		    mCookie.data[ variable ] = value;
		    mCookie.flush();
		}

		/**
		 * Create (or open) a cookie and save a variable
		 * @param cookieName Name of the cookie
		 * @param variable Name of the variable
		 * @param value Value to write
		 *
		 */
		public static function saveCookieVariable( cookieName:String, variable:String , value:* ):void
		{			
			try {
				var cookie:Cookie = new Cookie( cookieName );
				cookie.write( variable, value );
			}
			catch (e:Error) {
				Logger.debug("Couldn't write cookie: " + cookieName, e.message);
			}
		}

		/**
		 * Create (or open) a cookie and save a variable
		 * @param cookieName Name of the cookie
		 * @param variable Name of the variable
		 * @return the read value
		 *
		 */
		public static function readCookieVariable( cookieName:String, variable:String ):*
		{
			try 
			{
				var cookie:Cookie = new Cookie( cookieName );
				return cookie.read( variable );
			}
			catch (e:Error) 
			{
				Logger.debug("Couldn't read cookie: " + cookieName, e.message);
				return "";
			}
		}
	}
}
