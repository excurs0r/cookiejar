using GLib;
using Sqlite;

namespace Cookiejar.Firefox {

	class FirefoxProfile : Object, Profile {

		public string name;
		public string path;

		protected List<Cookie> cookies;

		public FirefoxProfile(string name, string path) {
			this.name = name;
			this.path = path;
			this.cookies = new List<Cookie>();
		}

		protected List<Cookie> sqlite_query(string query) {
			string file_path = Environment.get_home_dir()+"/.mozilla/firefox/"+path+"/cookies.sqlite";

			Database db;
			int ec = Database.open(file_path, out db);
			
			if(ec != Sqlite.OK) {
				print("Cannot open database\n");
				return new List<Cookie>();
			}
			
			string errmsg;
			string[] res;
			int nrows, ncols;

			ec = db.get_table(query, out res, out nrows, out ncols, out errmsg);

			if(ec != Sqlite.OK) {
				print("Error: "+errmsg+"\n");
				return new List<Cookie>();
			}

			if(nrows == 0) {
				print("No cookies found in database\n");
				return new List<Cookie>();
			}
			
			List<Cookie> result = new List<Cookie>();
			for(int i=ncols;i<res.length;i+=ncols) {
				Cookie cookie = new Cookie();
				cookie.id = long.parse(res[i]);
				cookie.baseDomain = res[i+1];
				cookie.originAttributes = res[i+2];
				cookie.name = res[i+3];
				cookie.value = res[i+4];
				cookie.host = res[i+5];
				cookie.expiry = long.parse(res[i+6]);
				cookie.lastAccessed = long.parse(res[i+7]);
				cookie.creationTime =  long.parse(res[i+8]);
				cookie.isSecure = long.parse(res[i+9]);
				cookie.isHttpOnly = long.parse(res[i+10]);
				cookie.inBrowserElement = long.parse(res[i+11]);
				cookie.sameSite = long.parse(res[i+12]);
				result.append(cookie);
			}
			return result;

		}

		public List<Cookie> get_cookies() {
			return this.sqlite_query("select * from moz_cookies");
		}
		
		public List<Cookie> search(string search) {
			string query = "select * from moz_cookies where ";
			query += "baseDomain LIKE \"%"+search+"%\" OR ";
			query += "name LIKE \"%"+search+"%\" OR ";
			query += "value LIKE \"%"+search+"%\" OR ";
			query += "host LIKE \"%"+search+"%\"";
			return this.sqlite_query(query);
		}
	
		public string get_info() {
			return this.name+"\t"+this.path;
		}

		public void delete_cookie(string search) {
			string file_path = Environment.get_home_dir()+"/.mozilla/firefox/"+path+"/cookies.sqlite";

			Database db;
			int ec = Database.open(file_path, out db);
			
			if(ec != Sqlite.OK) {
				print("Cannot open database\n");
			}
			
			List<Cookie> cookies = this.search(search);
			int deletes = 0;
			foreach(Cookie c in cookies) {
				ec = db.exec("delete from moz_cookies where id = "+c.id.to_string());
				if(ec != Sqlite.OK) {
					print("Could not delete cookie\n");
				} else {
					deletes++;
				}
			}
			print("Deleted %d cookies\n", deletes);
			return;
		}
	}
}
