rien_image = love.graphics.newImage("ressource/Erreur/rien.gif")
function load_image(nom)
	local img = 0
	if love.filesystem.exists(""..nom.."") then
		img = love.graphics.newImage(""..nom.."")
	elseif love.filesystem.exists(""..nom..".png") then
		img = love.graphics.newImage(""..nom..".png")
	elseif love.filesystem.exists(""..nom..".gif") then
		img = love.graphics.newImage(""..nom..".gif")
	elseif love.filesystem.exists(""..nom..".tga") then
		img = love.graphics.newImage(""..nom..".tga")
	elseif love.filesystem.exists(""..nom..".jpg") then
		img = love.graphics.newImage(""..nom..".jpg")
	elseif love.filesystem.exists("ressource/"..nom.."") then
		img = love.graphics.newImage("ressource/"..nom.."")
	elseif love.filesystem.exists("ressource/"..nom..".png") then
		img = love.graphics.newImage("ressource/"..nom..".png")
	elseif love.filesystem.exists("ressource/"..nom..".gif") then
		img = love.graphics.newImage("ressource/"..nom..".gif")
	elseif love.filesystem.exists("ressource/"..nom..".tga") then
		img = love.graphics.newImage("ressource/"..nom..".tga")
	elseif love.filesystem.exists("ressource/"..nom..".jpg") then
		img = love.graphics.newImage("ressource/"..nom..".jpg")
	else
		img = rien_image
	end
	return (img)
end
