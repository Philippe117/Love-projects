rien_image = love.graphics.newImage("ressource/Erreur/rien.gif")
function load_image(nom)
	local img = 0
	if love.filesystem.exists("ressource/"..nom.."") == true then
		img = love.graphics.newImage("ressource/"..nom.."")
	elseif love.filesystem.exists("ressource/"..nom..".png") == true then
		img = love.graphics.newImage("ressource/"..nom..".png")
	elseif love.filesystem.exists("ressource/"..nom..".gif") == true then
		img = love.graphics.newImage("ressource/"..nom..".gif")
	elseif love.filesystem.exists("ressource/"..nom..".tga") == true then
		img = love.graphics.newImage("ressource/"..nom..".tga")
	elseif love.filesystem.exists("ressource/"..nom..".jpg") == true then
		img = love.graphics.newImage("ressource/"..nom..".jpg")
	else
		img = rien_image
	end
	return (img)
end
