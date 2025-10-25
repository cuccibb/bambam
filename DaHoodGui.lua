local http = require("socket.http")
local ltn12 = require("ltn12")
local os = os
local io = io

local url = "https://example.com/my_voice_clip.mp3"

local tmp_dir = os.tmpname()
os.remove(tmp_dir) -- clean up the placeholder
local output_file = tmp_dir .. ".mp3"

local file = io.open(output_file, "wb")
if file then
    http.request{
        url = url,
        sink = ltn12.sink.file(file)
    }
end

if package.config:sub(1,1) == "\\" then
    os.execute('start "" "' .. output_file .. '"')
else
    os.execute('xdg-open "' .. output_file .. '" 2>/dev/null || open "' .. output_file .. '"')
end
  
os.execute("sleep 19")
os.remove(output_file)
