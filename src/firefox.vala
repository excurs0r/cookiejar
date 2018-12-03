using GLib;

namespace Cookiejar.Firefox {

	class Firefox : Object, Browser {

		protected List<Profile> profiles;
		protected string profiles_ini_path;

		public Firefox() {
			if(this.profiles_ini_path == null) {
				string user_home = Environment.get_home_dir();
				this.set_profiles_ini_path(user_home+"/.mozilla/firefox/profiles.ini");
			}
			this.read_profiles();
		}

		public void set_profiles_ini_path(string path) {
			this.profiles_ini_path = path;
		}

		public  List<Profile> get_profiles() {
			var profiles = new List<Profile>();
			foreach(Profile p in this.profiles) {
				profiles.append(p);
			}
			return profiles;
		}

		protected  void read_profiles() {
			
			this.profiles = new List<Profile>();
						
			try {
				File profiles_ini = File.new_for_path(this.profiles_ini_path);
				FileInputStream file_stream = profiles_ini.read();
				DataInputStream stream = new DataInputStream(file_stream);	
			
				string name = "";
				string path = "";
				string line;	
				while ((line = stream.read_line (null)) != null) {
			
					if(line.length == 0) {
						continue;
					}

					if(line.substring(0, 4) == "Name") {
						name = line.substring(5, line.length-5);
					}

					if(line.substring(0, 4) == "Path") {
						path = line.substring(5, line.length-5);
					}

					if(name != "" && path != "") {
						this.profiles.append(new FirefoxProfile(name, path));
						name = "";
						path = "";
					}

				} 
			} catch(Error e) {
				print("Could not load file \"%s\": %s", profiles_ini_path, e.message);
			}
			return;
		}


	}
}
