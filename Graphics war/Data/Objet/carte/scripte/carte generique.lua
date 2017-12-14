function S.load(D)
	carte = D
	D.verso = love.graphics.newImage(""..D.lieux.."/ressource/verso.png")
	D.sqr = math.floor(math.sqrt((D.verso:getWidth()/2)^2+(D.verso:getHeight())^2))
	D.canva = love.graphics.newCanvas( D.sqr , D.sqr )
	D.verso2 = render_card(D.verso)
	D.liste = {}
	local liste = love.filesystem.getDirectoryItems("Data/Carte")
	for i,h in ipairs(liste) do
		D.liste[h] = add_card("Data/Carte",h)
	end
	D.liste.vide = add_card(""..D.lieux.."/ressource","carte_vide")
end
function add_card(lieux,nom)
	local new = {}
	new.recto = love.graphics.newImage(""..lieux.."/"..nom.."/recto.png")
	new.recto2 = render_card(new.recto)
	S = new
	search_script(""..lieux.."/"..nom.."/scripte")
	return (new)
end
function S.creation(O)
	O.carte_data = O.data.liste.vide
	selectable = false

	O.A = 0		--réel
	O.AX = 0
	O.AY = 0
	O.PA = 0

	O.vX = O.X	--voulut
	O.vY = O.Y
	O.vZ = O.Z
	O.vA = O.A
	O.vAX = O.AX
	O.vAY = O.AY
	O.vPA = O.PA

	O.sX = .7	--speed
	O.sY = .7
	O.sZ = .7
	O.sA = .7
	O.sAX = .7
	O.sAY = .7
	O.sPA = 20

	O.timer = 2

	O.deck = { X = 3500 , Y = 100 , Z = -100 }
	O.mode = "stand"
end
local new = new_function( fonction , "MP" , 12 )
function new.F(mx,my,bu)
	if bu == "l" then
		for i,O in ipairs(carte.objet) do
			O.vZ = math.random(-1000,500)

			O.vX , O.vY = get_screen_to_world(O.vZ,love.mouse.getX(),love.mouse.getY())
			O.vA = math.random(0,360)/180*math.pi
			O.vAX = math.random(0,1)*math.pi
			O.vPA = math.random(0,360)/180*math.pi
		end
	end
end
local new = new_function( 0, "objet_update" , 12 )
new.obj = S
function new.F(D,dot)
	for i,O in ipairs(D.objet) do


		O.X = O.X+(O.vX-O.X)*dot*O.sX
		O.Y = O.Y+(O.vY-O.Y)*dot*O.sY
		O.Z = O.Z+(O.vZ-O.Z)*dot*O.sZ
		O.A = O.A+angle(O.A,O.vA)*dot*O.sA
		O.AX = O.AX+angle(O.AX,O.vAX)*dot*O.sAX
		O.AY = O.AY+angle(O.AY,O.vAY)*dot*O.sAY
		O.PA = O.PA+angle(O.PA,O.vPA)*dot*O.sPA



		if O.eta.camera then
			if inview( O.X , O.Y , O.Z , carte.sqr/2 ,carte.sqr/2 ) then

			else
				O.eta.camera = false
			end

		else
			if inview( O.X , O.Y , O.Z , 400 , 100 ) then
				add_to_camera(O)
			end
		end
	end
end
function S.draw_cam(O)
	love.graphics.setColor(255,255,255)
	if math.cos(O.AY)*math.cos(O.AX) > 0 then
		draw_in_world( draw_card , O.carte_data.recto2 , O.X , O.Y , O.Z , O.A , .5*math.cos(O.AX),.5*math.cos(O.AY),O.PA)
		txt = txt+1
	else
		draw_in_world( draw_card , carte.verso2 , O.X , O.Y , O.Z , O.A , .5*math.cos(O.AX),.5*math.cos(O.AY),O.PA)
	end
--	draw_in_world( draw_card , O.carte_data.recto , O.X , O.Y , O.Z , 0 , 1,1,90,0)
	--draw_card(card,X,Y,A,sx,sy,PA)
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
