
function load_sprite(lieux)
	if love.filesystem.exists(lieux) then
		if love.filesystem.exists(""..lieux.."/1.png") then
			local new = {}
			local w = 1
			while love.filesystem.exists(""..lieux.."/"..w..".png") do
				table.insert( new , love.graphics.newImage(""..lieux.."/"..w..".png"))
				w = w+1
			end
			new.Width = new[1]:getWidth()
			new.Height = new[1]:getHeight()
			--rapporter_erreur("sprite: \""..lieux.."\" chargé")
			return( new )
		elseif love.filesystem.exists(""..lieux.."/1.gif") then
			local new = {}
			local w = 1
			while love.filesystem.exists(""..lieux.."/"..w..".gif") do
				table.insert( new , love.graphics.newImage(""..lieux.."/"..w..".gif"))
				w = w+1
			end
			new.Width = new[1]:getWidth()
			new.Height = new[1]:getHeight()
			--rapporter_erreur("sprite: \""..lieux.."\" chargé")
			return( new )
		else
			rapporter_erreur("le sprite: \""..lieux.."\" ne contien aucunes images ou elles ne sont pas suporté")
			return(rien_spr_bl)
		end
	else
		rapporter_erreur("le sprite: \""..lieux.."\" est absent du registre")
		return(rien_spr_bl)
	end
end
rien_spr = load_sprite( "ressource/Erreur/rien spr" )
rien_spr_bl = load_sprite( "ressource/Erreur/rien spr bad load" )

function create_sprite(data,speed,frame)
	return( { frame = frame or 1 , speed = speed or 1 , data = data } )
end
function update_sprite(sprite,dot)
	sprite.frame = sprite.frame+sprite.speed*dot*world.speed
	if sprite.frame >= table.maxn(sprite.data)+1 then
		sprite.frame = 1
	end
end
function draw_sprite(sprite,X,Y,A,sx,sy,cx,cy)
	love.graphics.draw(sprite.data[math.floor(sprite.frame)],X,Y,A,sx,sy,cx,cy)
end


