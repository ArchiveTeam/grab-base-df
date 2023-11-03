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
   "html-entities",
   "idn2",
   "luasocket",
   "luafilesystem",
   "luasec",
   "luazip",
   "crc32",
   "md5",
   "base64",
   "lua-cjson",
   "utf8"
}
build = {
    type = "builtin",
}
