using GLib;
using Sqlite;
using Cookiejar.Firefox;

/**
 * usage: ./import target_db searchString
 *
 */
int main(string[] args) {
	if(args.length > 2) {
		string search = args[2];
		var firefox = new Firefox();
		var profiles = firefox.get_profiles();
		List<Cookie> exported_cookies = new List<Cookie>();
		foreach(Profile p in profiles) {
			var cookies = p.search(search);
			foreach(Cookie c in cookies) {
				exported_cookies.append(c);
			}
		}
		
		string target_db = args[1];
		Database db;

		int ec = Database.open_v2(target_db, out db, Sqlite.OPEN_READWRITE);
	
		print("Target Database: %s\n", target_db);
		if(ec != Sqlite.OK) {
			print("Could not open target database.\nERROR: %s\n", db.errmsg());
			return 1;
		}

		int inserted = 0;
		foreach(Cookie c in exported_cookies) {
			
			ec = db.exec(c.export_sql());
			
			if(ec != Sqlite.OK) {
				// TODO: Resolve id conflicts?
				print("Could not execute insert query.\n");
				print("ERROR: %s\n", db.errmsg());
				continue;
			}
			inserted++;
		}
		print("Inserted %d cookies.\n", inserted);
		return 0;


	}
	return 1;
}
