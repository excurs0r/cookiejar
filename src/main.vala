using GLib;

namespace Slurp.Firefox {

	public int main(string[] args) {
		Firefox firefox = new Firefox();
		var profiles = firefox.get_profiles();
		print("Found %d profiles.\n", (int)profiles.length());
		foreach(Profile profile in profiles) {
			print("Listing profile: "+profile.name+"\n\n");
			var cookies = profile.search(args[1]);
			print("Host\t\tBaseDomain\tName\n\n");
			foreach(Cookie cookie in cookies) {
				print(cookie.export_row()+"\n");
			}

			if(args[2] == "export") {
				foreach(Cookie cookie in cookies) {
					print(cookie.export_sql());
				}
			} 
		}
		
		return 0;
	}
}			
