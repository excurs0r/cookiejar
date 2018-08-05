project('cookiejar', 'vala', 'c')

gio_dep 	= dependency('gio-2.0')
sqlite3_dep = dependency('sqlite3')
glib_dep 	= dependency('glib-2.0')
gobject_dep = dependency('gobject-2.0')


executable('cookiejar', ['src/main.vala', 'src/firefox.vala', 'src/profile.vala', 'src/cookie.vala'],
			dependencies : [gio_dep, sqlite3_dep, glib_dep, gobject_dep])

executable('import', ['src/import.vala', 'src/firefox.vala', 'src/profile.vala', 'src/cookie.vala'],
			dependencies : [gio_dep, sqlite3_dep, glib_dep, gobject_dep])
