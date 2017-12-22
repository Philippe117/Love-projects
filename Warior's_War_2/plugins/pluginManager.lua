--
-- Created by Philippe La Madeleine.
-- User: philippe
-- Date: 21/12/17
-- Time: 10:48 PM
-- To change this template use File | Settings | File Templates.
--

plugins = {}
pluginManager = {}

function pluginManager.load()
    local pluginsNames = love.filesystem.getDirectoryItems("plugins")
    for pluginName in pairs(pluginsNames) do
        local filePath = "plugins/"..pluginName.."/"..pluginName..".lua"
        if love.filesystem.exists(filePath) then
            local plugin = {}
            love.filesystem.load(filePath)()
            table.insert( plugins , plugin )
        end
    end
    for plugin in pairs(plugins) do
        if plugin.load then
            plugin.load()
        end
    end
end

function pluginManager.mousepressed( mouseX, mouseY, button )
    for plugin in pairs(plugins) do
        if plugin.mousepressed then
            plugin.mousepressed( mouseX, mouseY, button )
        end
    end
end

function pluginManager.mousereleased( mouseX, mouseY, button )
    for plugin in pairs(plugins) do
        if plugin.mousereleased then
            plugin.mousereleased( mouseX, mouseY, button )
        end
    end
end

function pluginManager.keypressed( key )
    for plugin in pairs(plugins) do
        if plugin.keypressed then
            plugin.keypressed( key )
        end
    end
end

function pluginManager.keyreleased( key )
    for plugin in pairs(plugins) do
        if plugin.keyreleased then
            plugin.keyreleased( key )
        end
    end
end

function pluginManager.update(dt)
    for plugin in pairs(plugins) do
        if plugin.update then
            plugin.update( dt )
        end
    end
end

function pluginManager.draw()
    for plugin in pairs(plugins) do
        if plugin.draw then
            plugin.draw()
        end
    end
end
