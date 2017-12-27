--
-- Created by Philippe La Madeleine.
-- User: philippe
-- Date: 20/12/17
-- Time: 7:07 PM
-- To change this template use File | Settings | File Templates.
--

print("loading scripts...")
local scriptsNames = love.filesystem.getDirectoryItems("scripts")
for i, scriptName in pairs(scriptsNames) do
    print("loading "..scriptName.."")
    local filePath = "scripts/"..scriptName..""
    if love.filesystem.exists(filePath) then
        love.filesystem.load(filePath)()
    end
end
