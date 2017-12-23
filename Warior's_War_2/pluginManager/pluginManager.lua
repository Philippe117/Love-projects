--
-- Created by Philippe La Madeleine.
-- User: philippe
-- Date: 21/12/17
-- Time: 10:48 PM
-- To change this template use File | Settings | File Templates.
--

plugins = {}
pluginManager = {}
plugin = {}

function pluginManager.load()
    local pluginsNames = love.filesystem.getDirectoryItems("pluginManager/plugins")
    for i, pluginName in pairs(pluginsNames) do
        local filePath = "pluginManager/plugins/"..pluginName.."/"..pluginName..".lua"
        if love.filesystem.exists(filePath) then
            local p = {name=pluginName }
            plugin = p
            love.filesystem.load(filePath)()
            table.insert(plugins, plugin)
        end
    end
    for i, plugin in pairs(plugins) do
        if plugin.load ~= nil then
            plugin.load()
        end
    end
end

function pluginManager.mousepressed( mouseX, mouseY, button )
    for i, plugin in pairs(plugins) do
        if plugin.mousepressed ~= nil then
            plugin.mousepressed( mouseX, mouseY, button )
        end
    end
end

function pluginManager.mousereleased( mouseX, mouseY, button )
    for i, plugin in pairs(plugins) do
        if plugin.mousereleased ~= nil then
            plugin.mousereleased( mouseX, mouseY, button )
        end
    end
end

function pluginManager.keypressed( key )
    for i, plugin in pairs(plugins) do
        if plugin.keypressed ~= nil then
            plugin.keypressed( key )
        end
    end
end

function pluginManager.keyreleased( key )
    for i, plugin in pairs(plugins) do
        if plugin.keyreleased ~= nil then
            plugin.keyreleased( key )
        end
    end
end

function pluginManager.update(dt)
    for i, plugin in pairs(plugins) do
        if plugin.update ~= nil then
            plugin.update( dt )
        end
    end
end

function pluginManager.draw()
    for i, plugin in pairs(plugins) do
        if plugin.draw ~= nil then
            plugin.draw()
        end
        love.graphics.print( plugin.name , 10 , 10*i )
    end
end
