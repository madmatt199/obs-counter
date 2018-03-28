+--------------------+
| GlazedHam's Logger |
+--------------------+
This is a simple console logger written for Lua 5.1. This is intended to be used
as a singleton "class" that allows one application to write log message. Not
intended for multiple instantiations or used from multiple sources at the same
time.

Current features are...
- Console logging
- Configurable log levels
- Low resolution timer

Planned features are...
- High resolution timer
- File based logging in addition to console
- Additional output information (function names, line numbers)