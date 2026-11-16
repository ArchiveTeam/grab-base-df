package = "requirements"
version = "0-0"
source = {
   url = "https://archiveteam.org/"
}
description = {
   summary = "This rockspec is made just to keep track of packages to be installed. It should only be installed with option `--deps-only`, as in `luarocks install --only-deps requirements-1.0-1.rockspec`.",
   homepage = "https://archiveteam.org/"
}
dependencies = {
   "lua >= 5.1, < 5.2",
   "html-entities == 1.3.1-0",
   "idn2 == 0.1-0",
   "luasocket == 3.1.0-2", -- 3.1.0-1 with rocks/luasocket-3.1.0-2-patches.lua
   "luafilesystem == 1.9.0-1",
   "luasec == 1.3.2-1",
   "luazip == 1.2.7-1",
   "crc32 == 1.1-1",
   "md5 == 1.3-1",
   "base64 == 1.5-3",
   "lua-cjson == 2.1.0.10-1",
   "utf8 == 1.3-0",
   "miniblooms", -- should already be installed
   "luabitop == 1.0.3-1",
   "bit32 == 5.3.5.1-1",
   "luaossl == 20250929-0",
   "lua-zlib == 1.4-0",
   "lua-basex == 0.2.0-2",
   "date == 2.2.1-2",
   "uuid == 1.0.0-1",
   "lua-iconv == 7.1.0-1",
   "basexx == 0.4.1-1",
   "lua-protobuf == 0.6.0-1",
   "org.conman.dns == 2.1.3-1"
}
build = {
    type = "builtin",
}
