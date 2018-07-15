using GLib;
using Sqlite;

namespace Slurp.Firefox {

	class Profile : Object {

		public string name;
		public string path;

		protected List<Cookie> cookies;

		public void load_cookies() {

			print("Loading: "+Environment.get_home_dir()+"/.mozilla/firefox/"+path+"/cookies.sqlite\n");

			if(this.name == null || this.path == null || this.name == "" || this.path == "") {
				return;
			}
			
			Database db;
			int ec = Database.open(Environment.get_home_dir()+"/.mozilla/firefox/"+path+"/cookies.sqlite", out db);
			
			if(ec != Sqlite.OK) {
				return;
			}
			
			string errmsg;
			string[] res;
			int nrows, ncols;

			string query = "select * from moz_cookies";
			ec = db.get_table(query, out res, out nrows, out ncols, out errmsg);

			if(ec != Sqlite.OK) {
				print("Error: "+errmsg+"\n");
			}

			for(int i=0;i<res.length;i+=ncols) {
				Cookie cookie = new Cookie();
				cookie.id = (int)res[i+0];
				cookie.baseDomain = res[i+1];
				cookie.originAttributes = res[i+2];
				cookie.name = res[i+3];
				cookie.value = res[i+4];
				cookie.host = res[i+5];
				cookie.expiry = (int)res[i+6];
				cookie.lastAccessed = (int)res[i+7];
				cookie.creationTime = (int)res[i+8];
				cookie.isSecure = (int)res[i+9];
				cookie.isHttpOnly = (int)res[i+10];
				cookie.inBrowserElement = (int)res[i+11];
				cookie.sameSite = (int)res[i+12];
				this.cookies.append(cookie);
			}
			return;
		}
		
		public void get_netflix() {
			foreach(Cookie cookie in this.cookies) {
				if(cookie.baseDomain.index_of("netflix") != -1) {
					print(cookie.export_sql()+"\n");
				}
			}
		} 
	}
}
