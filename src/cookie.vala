using GLib;

namespace Slurp.Firefox {
	
	class Cookie : Object {
		public int id;
		public string baseDomain;
		public string originAttributes;
		public string name;
		public string value;
		public string host;
		public string path;
		public int expiry;
		public int lastAccessed;
		public int creationTime;
		public int isSecure;
		public int isHttpOnly;
		public int inBrowserElement;
		public int sameSite;

		public string export_sql() {
			string query = "insert into moz_cookies \n";
			query += "(id, baseDomain, originAttributes, name, value, host,";
			query += "path, expiry, lastAccessed, creationTime, isSecure, isHttpOnly, inBrowserElement, sameSite)\n";
			query += "values ("+this.id.to_string()+", \""+this.baseDomain+"\", \""+this.originAttributes+"\", \""+this.name+"\", ";
			query +=  "\""+this.value+"\", \""+this.host+"\", \""+this.path+"\", "+this.expiry.to_string()+", ";
			query += this.lastAccessed.to_string()+", "+this.creationTime.to_string()+", ";
			query += this.isSecure.to_string()+", "+this.isHttpOnly.to_string()+", "+this.inBrowserElement.to_string()+", ";
			query += this.sameSite.to_string()+")\n\n";
			return query;
		}
	}
}
