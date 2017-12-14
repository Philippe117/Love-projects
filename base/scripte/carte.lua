local new = new_function(fonction,"load",10)
function new.F()
	carte = {}
	carte.verso = love.graphics.newImage("ressource/verso.png")
	carte.sqr = math.floor(math.sqrt((carte.verso:getWidth()/2)^2+(carte.verso:getHeight())^2))
	carte.canva = love.graphics.newCanvas( carte.sqr , carte.sqr )
	carte.verso2 = render_card(carte.verso)
	for i = 1,1 do
		local list = love.filesystem.enumerate("Data/Carte")
		

		for i,h in ipairs(list) do
			search_for_objet("Data/Carte/"..h.."")
		end
	end




end
function render_card(card,A)
	local new = {}
	for i = 1,6 do
		carte.canva:renderTo(function()
			love.graphics.draw(card,carte.sqr/2,carte.sqr/2,math.pi/6*(i-3),.5,.5,card:getWidth()/2,card:getHeight()/2)
		end)
		new[i] = love.graphics.newImage(carte.canva:getImageData())
		carte.canva:clear()
	end
	return (new)
end

function find_angle(PA)
	PA = PA-math.pi*math.floor(PA/math.pi+.5)
	if PA < -math.pi/12*5 then
		PA = PA+math.pi/2
	end
	PA = math.floor(PA/math.pi*6+.5)
	return (PA)
end
function find_card(card,PA)
	PA2 = find_angle(PA)
	PA = PA2*math.pi/6
	return (card[PA2+3]),(PA)
end
function draw_card(card,X,Y,A,sx,sy,PA)
	local img,PA = find_card(card,PA)
	love.graphics.draw(	img ,
				X ,
				Y ,
				A-sx*PA/sy ,
				sx*2 ,
				sy*2 ,
				img:getWidth()/2 ,
				img:getHeight()/2	)
end
