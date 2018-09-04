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
			int inserts = 0;
			foreach(Cookie c in this.cookies) {
				bool success;
				
				success = this.insert_cookie(c);
				if(success) {
					inserts++;
					continue;
				}
				this.set_next_valid_id(ref c);
				success = this.insert_cookie(c);
				if(success) {
					inserts++;
					continue;
				}
				
			}
			print("Inserts: %d\n", inserts);
		}

		public bool insert_cookie(Cookie c) {
			int ec = this.db.exec(c.export_sql());
			if(ec != Sqlite.OK) {
				print("Could not insert cookie\n");
				return false;
			}
			return true;
		}

		public bool delete_cookie(Cookie c) {
			int ec = this.db.exec("delete from moz_cookies where id = "+c.id.to_string());
			if(ec != Sqlite.OK) {
				print("Could not delete cookie\n");
				return false;
			}
			return true;
		}
		
		public void set_next_valid_id(ref Cookie c) {
			if(c == null) {
				return;
			}
			string[] res;
			string errmsg;
			int nrows, ncols;
			int ec = this.db.get_table("select * from moz_cookies order by id desc limit 1", out res, out nrows, out ncols, out errmsg);
			if(ec != Sqlite.OK) {
				print(errmsg+"\n");
				return;
			}
			string tmp = res[0];
			long id = long.parse(tmp); 
			id++;
			c.id = id; // next valid unique id
			return;
		}
	}
}
