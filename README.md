# cookiejar

Cookiejar is build to import and export cookies from your browser.
Usefull if you want to get netflix from one computer to another.

If you are cool, you write some code for chrome.
Code is written in Vala. See https://wiki.gnome.org/Projects/Vala and
https://valadoc.org.
This software is for everybody. Fell free to do whatever you want.

## compilation

Dependencies:
- gio-2.0
- sqlite3
- glib-2.0
- gobject-2.0

```
git clone git@github.com:excurs0r/cookiejar.git
cd cookiejar
mkdir build
meson build
cd build
ninja
```

## run tests
`ninja test`

## usage
`./cookiejar` will tell you this:
```
cookiejar list profiles
cookiejar list cookies
cookiejar search <someWhat>
cookiejar export <someWhat> (search and return sql insert query)
```

## how to copy netflix
Exporting into sql file: `./cookiejar export netflix > netflix.sql`

And import it: `sqlite3 ~/.mozilla/firefox/[profile]/cookies.sqlite < netflix.sql`

MAGIC \o/
















