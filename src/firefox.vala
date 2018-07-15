using GLib;

namespace Slurp.Firefox {

	class Firefox : Object {

		protected List<Profile> profiles;

		public Firefox() {
			this.read_profiles();
			foreach(Profile profile in this.profiles) {
				profile.get_netflix();
			}
		}

		protected void read_profiles() {
			
			this.profiles = new List<Profile>();
			string user_home = Environment.get_home_dir();
			string profiles_ini_path = user_home+"/.mozilla/firefox/profiles.ini";
			
			try {
				File profiles_ini = File.new_for_path(profiles_ini_path);
				DataInputStream stream = new DataInputStream(profiles_ini.read());	
			
				Profile profile = new Profile();
	
				string line;
				while ((line = stream.read_line (null)) != null) {
						
					if(!line.valid_char(5) || line.length < 5) {
						continue;
					}

					if(line.substring(0, 4) == "Name") {
						profile.name = line.substring(5, line.length-5);
					}

					if(line.substring(0, 4) == "Path") {
						profile.path = line.substring(5, line.length-5);
						profile.load_cookies();
						this.profiles.append(profile);
						profile = new Profile();
					}

				} 
			} catch(Error e) {
				print("Could not load file \"%s\": %s", profiles_ini_path, e.message);
			}
			return;
		}


	}
}
