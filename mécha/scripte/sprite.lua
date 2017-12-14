
function load_sprite(lieux,nom)
	if love.filesystem.exists(lieux) then
		if love.filesystem.exists(""..lieux.."/"..nom.."/1.png") then
			local new = {}
			local w = 1
			while love.filesystem.exists(""..lieux.."/"..nom.."/"..w..".png") do
				table.insert( new , love.graphics.newImage(""..lieux.."/"..nom.."/"..w..".png"))
				w = w+1
			end
			new.Width = new[1]:getWidth()
			new.Height = new[1]:getHeight()
			return( new )
		elseif love.filesystem.exists(""..lieux.."/"..nom.."/1.gif") then
			local new = {}
			local w = 1
			while love.filesystem.exists(""..lieux.."/"..nom.."/"..w..".gif") do
				table.insert( new , love.graphics.newImage(""..lieux.."/"..nom.."/"..w..".gif"))
				w = w+1
			end
			new.Width = new[1]:getWidth()
			new.Height = new[1]:getHeight()
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

function search_sprite(lieux)
	if love.filesystem.exists(lieux) then
		local list = love.filesystem.getDirectoryItems(lieux)
		for i,S in ipairs(list) do
			return load_sprite(""..lieux.."/"..S.."")
		end
	end
end
rien_spr = load_sprite( "Data/Erreur","rien spr" )
rien_spr_bl = load_sprite( "Data/Erreur","rien spr bad load" )
function create_sprite(sprite)
	return({frame = 1,speed = 0,data = sprite})
end

function selector4(sprU,sprD,sprL,sprR,dir)
	local sp = {sprR,sprU,sprL,sprD}
	dir = angle(0,dir)
	if math.abs(dir) < math.pi/4 then
		return (sprR)
	elseif math.abs(dir) > math.pi*3/4 then
		return (sprL)
	elseif dir > 0 then
		return (sprU)
	else
		return (sprD)
	end
end
function update_sprite(sprite,dot)
	sprite.frame = sprite.frame+sprite.speed*dot
	if sprite.speed > 0 then
		if sprite.frame >= table.maxn(sprite.data)+1 then
			sprite.frame = 1
		end
	else
		if sprite.frame < 1 then
			sprite.frame = table.maxn(sprite.data)
		end
	end


end
function draw_sprite(sprite,X,Y,A,sx,sy,cx,cy)
	love.graphics.draw( sprite.data[math.floor(sprite.frame)] , X , Y , A , sx , sy , cx , cy )
end
