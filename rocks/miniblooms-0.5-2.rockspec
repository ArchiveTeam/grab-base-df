package = "miniblooms"
version = "0.5-2"
source = {
	url = "git+https://github.com/bitdivine/miniblooms"
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

