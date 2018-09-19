project('cookiejar', 'vala', 'c')

# Dependencies for cookiejar
cookiejar_deps = [
	dependency('gio-2.0'),
	dependency('sqlite3'),
	dependency('glib-2.0'),
	dependency('gobject-2.0')
]

# cookie.vala test
cookie_test_src = [
	'src/cookie.vala',
	'tests/cookie.vala'
]

cookie_test = executable('cookie', cookie_test_src, dependencies: cookiejar_deps)
test('cookie', cookie_test)






# Source files
cookiejar_src = [ 
	'src/main.vala',
	'src/firefox.vala',
	'src/cookie.vala',
	'src/importer.vala',
	'src/browser.vala',
	'src/firefox.vala',
	'src/profile.vala'
]

executable('cookiejar', cookiejar_src, dependencies: cookiejar_deps)

