using GLib;
using Cookiejar.Firefox;
using Sqlite;

namespace Cookiejar {

	class Importer : Object {
		
		protected Database db;		
		protected List<Cookie> cookies;
		bool database_available = false;

		public Importer(string target_db, List<Cookie> cookies) {
			int ec = Database.open_v2(target_db, out this.db, Sqlite.OPEN_READWRITE);
			if(ec != Sqlite.OK) {
				print("Could not open target database\n");
				return;
			}
			this.cookies = new List<Cookie>();
			foreach(Cookie c in cookies) {
				this.cookies.append(c);
			}
			this.database_available = true;
		}

		public void run() {
			if(!this.database_available) {
				return;
			}
			foreach(Cookie c in this.cookies) {
				// Try insert
				int ec = db.exec(c.export_sql());
				// Try with new id
				if(ec != Sqlite.OK) {
					int nrows, ncols;
					string[] res;
					string errmsg;
					ec = db.get_table("select id from moz_cookies order by id desc limit 1", out res, out nrows, out ncols, out errmsg);
					if(ec != Sqlite.OK) {
						print("Could not get new id\n");
						continue;
					}
					long id = long.parse(res[1])+1;
					c.id = id;
					ec = db.exec(c.export_sql(), null, out errmsg);
					// Delete old cookie insert new
					if(ec != Sqlite.OK) {
						var firefox = new Firefox.Firefox();
						var profiles = firefox.get_profiles();
						List<Cookie> hits = new List<Cookie>();
						foreach(Profile p in profiles) {
							var tmp = p.find(c);
							foreach(Cookie x in tmp) {
								hits.append(x);
							}
						}
						// FIXME: Delete is not working so unique constraints
						// still fill on insert
						// check if we only found 1 match
						if(1 == hits.length()) {
							long cookieId = hits.nth_data(0).id;
							message(cookieId.to_string());
							ec = this.db.exec("delete from moz_cookies where id = "+cookieId.to_string(), null, out errmsg);
							
							if(ec != Sqlite.OK) {
								message(errmsg);
							}
							ec = this.db.exec(c.export_sql(), null, out errmsg);
							if(ec != Sqlite.OK) {
								message(errmsg);
							}
						}
					}
				}
			}			
		}
	}
}
