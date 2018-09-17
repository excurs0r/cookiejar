project('cookiejar', 'vala', 'c')

# Installation destination directory
#DESTDIR=/usr/local

# Dependencies for cookiejar
cookiejar_deps = [
	dependency('gio-2.0'),
	dependency('sqlite3'),
	dependency('glib-2.0'),
	dependency('gobject-2.0')
]

# Source files
cookiejar_src = [ 
	'src/main.vala',
	'src/firefox.vala',
	'src/cookie.vala',
	'src/importer.vala', 
	'src/firefox.vala',
	'src/profile.vala'
]

#subdir('tests')

cookiejar = executable('cookiejar', cookiejar_src, dependencies: cookiejar_deps)

