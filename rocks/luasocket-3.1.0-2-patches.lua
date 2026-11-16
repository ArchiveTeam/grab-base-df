version = "3.1.0-2"
build.patches = {
  ["url-performance.patch"] = [[
--- a/src/url.lua
+++ b/src/url.lua
@@ -86,17 +86,19 @@
     local marker = string.char(1)
     repeat
         local was = path
-        path = path:gsub('//', '/'..marker..'/', 1)
+        path = path:gsub('//', '/'..marker..'/')
     until path == was
     repeat
         local was = path
-        path = path:gsub('/%./', '/', 1)
+        path = path:gsub('/%./', '/')
     until path == was
+    path = '/' .. path
     repeat
         local was = path
-        path = path:gsub('[^/]+/%.%./([^/]+)', '%1', 1)
+        path = path:gsub('/[^/]+/%.%./([^/]+)', '/%1', 1)
     until path == was
-    path = path:gsub('[^/]+/%.%./*$', '')
+    path = path:gsub('/[^/]+/%.%./*$', '/')
+    path = path:sub(2)
     path = path:gsub('/%.%.$', '/')
     path = path:gsub('/%.$', '/')
     path = path:gsub('^/%.%./', '/')
@@ -115,9 +117,8 @@
 local function absolute_path(base_path, relative_path)
     if string.sub(relative_path, 1, 1) == "/" then
       return remove_dot_components(relative_path) end
-    base_path = base_path:gsub("[^/]*$", "")
-    if not base_path:find'/$' then base_path = base_path .. '/' end
+    base_path = base_path:match("^(.*/)") or "/"
     local path = base_path .. relative_path
     path = remove_dot_components(path)
     return path
 end
]]
}
