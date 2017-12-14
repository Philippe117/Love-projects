
rien_img = love.graphics.newImage( "Data/Erreur/rien.gif" )
rien_img_bl = love.graphics.newImage( "Data/Erreur/rien bad load.gif" )

function load_image(lieux)
	if love.filesystem.exists(""..lieux..".png") then
		return(love.graphics.newImage(""..lieux..".png"))
	elseif love.filesystem.exists(""..lieux..".gif") then
		local new = love.graphics.newImage(""..lieux..".gif")
		new:setFilter( "nearest","nearest" )
		return(new)
	else
		rapporter_erreur("l'image: \""..lieux.."\" est absente du registre")
		return(rien_img_bl)
	end
end
