using GLib;

namespace Cookiejar.Firefox {

		int main(string[] args) {
		
		if(args.length < 2) {
			print("Commands:\n---------------\ncookiejar list profiles\ncookiejar list cookies\ncookiejar search <someWhat>\n");
			print("cookiejar export <someWhat> (search and return sql insert query)\n");
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
					print("ID\t\tHost\t\tBaseDomain\tPath\tValue\n----------------------------------------------\n");
					var cookies = p.get_cookies();
					foreach(Cookie c in cookies) {
						print(c.get_info()+"\n");
					}
				}
				return 0;
			}
			print("Commands:\n---------------\ncookiejar list profiles\ncookiejar list cookies\ncookiejar search <someWhat>\n");
			print("cookiejar export <someWhat> (search and return sql insert query)\n");
			return 0;
		}
		if(args[1] == "search" || args[1] == "export") {
			var search = args[2];
			var firefox = new Firefox();
			var profiles = firefox.get_profiles();
			if(args[1] == "search") {
				print("ID\t\tHost\t\tBaseDomain\tPath\tValue\n----------------------------------------------\n");
			}	
			foreach(Profile p in profiles) {
				var cookies = p.search(search);
				foreach(Cookie c in cookies) {
					if(args[1] == "search") {
						print(c.get_info()+"\n");
					} else {
						print(c.export_sql()+"\n");
					}
				}
			}
			return 0;
		}

		if(args[1] == "import") {
			if(args.length < 4) {
				print("usage: cookiejar import target_db searchstring (-d → delete flag)\n");
				return 0;
			}
			string target_db = args[2];
			string search = args[3];

			var firefox = new Firefox();
			var profiles = firefox.get_profiles();
			List<Cookie> cookies_to_import = new List<Cookie>();
			foreach(Profile p in profiles) {
				var cookies = p.search(search);
				foreach(Cookie c in cookies) {
					cookies_to_import.append(c);
				}
			}

			var importer = new Importer(target_db, cookies_to_import);
			if(args.length > 4 && args[4] == "-d") {
				importer.delete_flag = true;
			}
			importer.run();
			return 0;
		}
	

		if(args[1] == "delete") {


			if(args.length < 2) {
				print("usage: cookiejar delete searchword\n");
				return 1;
			}

			var firefox = new Firefox();
			var profiles = firefox.get_profiles();
			foreach(Profile p in profiles) {
				p.delete_cookie(args[2]);
			}
			return 0;
		}

		print("Commands:\n---------------\ncookiejar list profiles\ncookiejar list cookies\ncookiejar search <someWhat>\n");
        print("cookiejar export <someWhat> (search and return sql insert query)\n");
		
		return 0;
	}	
}			
