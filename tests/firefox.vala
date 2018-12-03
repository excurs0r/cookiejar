using GLib;

namespace Cookiejar.Firefox {

	int main(string[] args) {
		var firefox = new Firefox();
		firefox.set_profiles_ini_path(args[1]);
		firefox.read_profiles();
		var profiles = firefox.get_profiles();
		
			assert(profiles.length() == 2);
	
		List<FirefoxProfile> asserted_profiles = new List<FirefoxProfile>();
		
		FirefoxProfile default_profile = new FirefoxProfile("default", "l9s1dnjq.default");
		asserted_profiles.append(default_profile);

		FirefoxProfile another_profile = new FirefoxProfile("another_profile", "somepath.default");
		asserted_profiles.append(another_profile);

		foreach(Profile p in profiles) {
			FirefoxProfile fp = (FirefoxProfile)p;
			bool found = false;
			foreach(FirefoxProfile ap in asserted_profiles) {
				if(fp.name == ap.name && fp.path == ap.path) {
					found = true;
				}
			}
			assert(found);
		}

		return 0;
	}
}
