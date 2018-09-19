using GLib;

namespace Cookiejar.Firefox {
	
	interface Browser : Object {
		
		public abstract List<Profile> get_profiles();
		public abstract void read_profiles();
	}
}
