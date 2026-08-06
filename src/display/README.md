Deutsch
-------
Hier befinden sich alle Funktionen zum Zeichnen.
Diese Dateien erzeugen den Textbuffer und stellen ihn über
den aktiven Displaytreiber dar.
Es werden hier keine Routerdaten abgefragt.

Hinweis: Es gibt zwei parallele Bausteine fuer Screens:
- theme_* (in themes/<theme>/<theme>.sh) - aktuell von den
  meisten Screens genutzt (z.B. hosts.sh, internet.sh)
- display_title/display_row/display_nav (in display_widgets.sh)
  - fuer Screens gedacht, die kein Theme benutzen wollen
Neue Screens sollten sich an einem der beiden Muster
orientieren, nicht beide mischen.
-------------------------------
English
-------
Display rendering subsystem.
Creates the screen buffer and forwards it to the selected
display driver.
No router communication happens here.

Note: there are two parallel building blocks for screens:
- theme_* (in themes/<theme>/<theme>.sh) - currently used by
  most screens (e.g. hosts.sh, internet.sh)
- display_title/display_row/display_nav (in
  display_widgets.sh) - meant for screens that don't use a
  theme
New screens should follow one pattern consistently, not mix
both.
