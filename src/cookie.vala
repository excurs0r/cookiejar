using GLib;

namespace Cookiejar.Firefox {
	
	class Cookie : Object {

		public long id;
		public string baseDomain;
		public string originAttributes;
		public string name;
		public string value;
		public string host;
		public string path;
		public long expiry;
		public long lastAccessed;
		public long creationTime;
		public long isSecure;
		public long isHttpOnly;
		public long inBrowserElement;
		public long sameSite;

		public string export_sql() {
			string query = "insert into moz_cookies ";
			query += "(id, baseDomain, originAttributes, name, value, host, ";
			query += "path, expiry, lastAccessed, creationTime, isSecure, isHttpOnly, inBrowserElement, sameSite) ";
			query += "values ("+this.id.to_string()+", \""+this.baseDomain+"\", \""+this.originAttributes+"\", \""+this.name+"\", ";
			query +=  "\""+this.value+"\", \""+this.host+"\", \""+this.path+"\", "+this.expiry.to_string()+", ";
			query += this.lastAccessed.to_string()+", "+this.creationTime.to_string()+", ";
			query += this.isSecure.to_string()+", "+this.isHttpOnly.to_string()+", "+this.inBrowserElement.to_string()+", ";
			query += this.sameSite.to_string()+");\n";
			return query;
		}

		public string get_info() {
			string row = this.id.to_string()+"\t"+this.trim_col(this.host)+"\t"+this.trim_col(this.baseDomain)+"\t"+this.trim_col(this.path)+"\t";
			row += this.trim_col(this.value, 10);
			return row;
		}

		protected string trim_col(string? content, int length = 12) {
			if(content == null) {
				return "";
			}
			if(content.length > length) {
				return content.substring(0,length);
			}
			return content;
		}
	}
}
