using GLib;

namespace Cookiejar.Firefox {

	interface Profile : Object {
		
		public abstract void delete_cookie(string search);
		public abstract List<Cookie> find(Cookie c);
		public abstract List<Cookie> get_cookies();
		public abstract string get_info();
		public abstract List<Cookie> search(string search);
	}
	
}
