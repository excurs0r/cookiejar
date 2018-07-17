using GLib;

namespace Slurp.Firefox {

	public int main(string[] args) {
		
		if(args.length < 2) {
			print("usage: ./chillingo_the_thief <option1> <option2>");
			return 1;
		}

		if(args[1] == "list") {
			if(args[2] == "profiles") {
				var firefox = new Firefox();
				var profiles = firefox.get_profiles();
				foreach(Profile p in profiles) {
					print("Name\tPath\n----------------------------\n");
					print(p.get_info()+"\n");
				}
				return 0;
			}
			if(args[2] == "cookies") {
				var firefox = new Firefox();
				var profiles = firefox.get_profiles();
				foreach(Profile p in profiles) {
					print("Host\tBaseDomain\tPath\tValue\n----------------------------------------------\n");
					var cookies = p.get_cookies();
					foreach(Cookie c in cookies) {
						print(c.get_info()+"\n");
					}
				}
			}
		}
		
		return 0;
	}
}			
