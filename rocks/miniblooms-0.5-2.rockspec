package = "miniblooms"
version = "0.5-2"
source = {
	url = "https://web.archive.org/web/20260720090735id_/https://codeload.github.com/bitdivine/miniblooms/tar.gz/6b5f98e7e22348b00a0e71a122a79ebe35899727",
	file = "miniblooms-6b5f98e7e22348b00a0e71a122a79ebe35899727.tar.gz",
	dir = "miniblooms-6b5f98e7e22348b00a0e71a122a79ebe35899727",
	md5 = "07f09739a3e36d4d4a3508ef3bdb1e2d"
}
description = {
	summary = "Small, fast bloom filters",
	detailed = [[
		This is a small, fast implementation of bloom
		filters that takes cache performance into account.
	]],
	homepage = "https://github.com/bitdivine/miniblooms",
	license = "MIT"
}
dependencies = {
	"lua >= 5.1, < 5.2"
}
build = {
	type = "builtin",
	modules = {
		minibloom = {
			sources = {
				"src/minibloom.c",
				"src/minibloomfile.c",
				"src/murmur.c",
				"minibloom.c"
			},
			incdirs={
				"src/"
			}
		}
	},
	copy_directories = {
		"examples"
	}
}
