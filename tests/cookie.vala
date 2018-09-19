using GLib;

namespace Cookiejar.Firefox {

	int main() {
		Cookie cookie = new Cookie();
		cookie.id = 1234;
		cookie.baseDomain = "testBaseDomain";
		cookie.originAttributes = "testAttributes";
		cookie.name = "someName";
		cookie.value = "lala";
		cookie.host = "localhost";
		cookie.path = "somePath";
		cookie.expiry = 567;
		cookie.lastAccessed = 789;
		cookie.creationTime = 985;
		cookie.isSecure = 567364;
		cookie.isHttpOnly = 462;
		cookie.inBrowserElement = 124512654;
		cookie.sameSite = 332;

		assert(cookie.id == 1234);
		assert(cookie.baseDomain == "testBaseDomain");
		assert(cookie.originAttributes == "testAttributes");
		assert(cookie.name == "someName");
		assert(cookie.value == "lala");
		assert(cookie.host == "localhost");
		assert(cookie.path == "somePath");
		assert(cookie.expiry == 567);
		assert(cookie.lastAccessed == 789);
		assert(cookie.creationTime == 985);
		assert(cookie.isSecure == 567364);
		assert(cookie.isHttpOnly == 462);
		assert(cookie.inBrowserElement == 124512654);
		assert(cookie.sameSite == 332);

		return 0;

	}
}
