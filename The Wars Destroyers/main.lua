function creation(px,py,grou,typ,direc)
	--unit={1={x,y,z},2={m,n,direc,direcjam,angz,réelang},3=phase,4=typ,5={timer,phasetime,supression},6={torce{sprite,frame},jam{sprite,frame}},7=iaphase,8={obj x,y,step},9=point{ed,id},10=id,11=morale,12=santer,13=balle}
	table.insert( groupe[grou][2],{{px,py,200},{0,0,direc,direc,0,direc},1,typ,{0,0,0},{{1,1,1},{1,1,1}},1,{px,py,1},{0,0,1},groupe[grou][8],3,unitlist[typ][4],unitlist[typ][10]})
	groupe[grou][8] = groupe[grou][8]+1
	groupe[grou][10] = groupe[grou][10]+1
end
function creatgroup(px,py,equ)
	--groupe[0] = {1={x,y},2={unit},3=team,4=obj{},5=objadv{},6=eta,7=id,8=idlist,9=morale,10=nombre}
	table.insert( groupe,{{px,py},{},equ,{},{},1,ident,1,6,0})
	ident = ident+1
end
function tire(ed,id) --missi={1={x,y,z},2={m,n,o,direc},3=phase,4=type,5=equip,6=frame,7=lastframe,8=timer,9=sonplay}
	decalh = math.random(-unitlist[groupe[ed][2][id][4]][3]*100,unitlist[groupe[ed][2][id][4]][3]*100)/100
	decalv = math.random(-unitlist[groupe[ed][2][id][4]][3]*100-100,unitlist[groupe[ed][2][id][4]][3]*10)/210+groupe[ed][2][id][2][5]
	table.insert( missi ,{{groupe[ed][2][id][1][1],groupe[ed][2][id][1][2],groupe[ed][2][id][1][3]-30},{missilist[unitlist[groupe[ed][2][id][4]][2]][1]*math.cos(groupe[ed][2][id][2][3]+decalh),missilist[unitlist[groupe[ed][2][id][4]][2]][1]*math.sin(groupe[ed][2][id][2][3]+decalh),missilist[unitlist[groupe[ed][2][id][4]][2]][1]*math.sin(decalv),groupe[ed][2][id][2][3]},1,unitlist[groupe[ed][2][id][4]][2],groupe[ed][3],1,1,crono+missilist[unitlist[groupe[ed][2][id][4]][2]][3],1})
	groupe[ed][2][id][13] = groupe[ed][2][id][13]-1
end
function love.load()
	fps = 0
	select = love.graphics.newCanvas( )
	ident = 1
	soundlist = {}
	--soundlist = {1=son}
	cart = 2
	point = love.graphics.newImage("soleil.png")
	pointe = love.graphics.newImage("pointe1.png")
	pointe2 = love.graphics.newImage("pointe2.png")
	vue = love.graphics.newImage("vue.png")
	unitlist = {}
	unitlist[1] = {"soldier",1,.07,25,600,.5,.5,.2,.08,30,2,.3,2}
	unitlist[2] = {"soldier",1,.1 ,20,600,.4,2 ,1.5,.06,60,3,.8,4}
	--unitlist[0] = {1=app,2=projectile,3=preci,4=hp,5=range,6=speed,7=reflex,8=rafale,9=cooldown,10=balle,11=temprecharge,12=pause,13=supression}
	groupe = {}
	missi = {}
	missilist = {}
	missilist[1] = {40,"balle",2,.5,10}
	--missilist[0] = {1=spee,2=app{},3=timer,4=demoralisation,5=domage}
	sang = {}
	num = 1
	while love.filesystem.exists( "app/sang/1/"..num..".png" ) == true do
		table.insert( sang ,{love.graphics.newImage("app/sang/1/"..num..".png")})
		if love.filesystem.exists( "app/sang/1/"..num..".ogg") == true then
			sang[table.maxn(sang)][2] = love.sound.newSoundData( "app/sang/1/"..num..".ogg" )
			sang[table.maxn(sang)][3] = 0
		end
		num = num+1
	end
	for i,h in ipairs(missilist) do
		if love.filesystem.exists( "app/missi/"..h[2].."" ) == true then
			nom = h[2]
			h[2] = {{},{}}
			num = 1
			while love.filesystem.exists( "app/missi/"..nom.."/go/"..num..".png" ) == true do
				table.insert( h[2][1] ,{love.graphics.newImage("app/missi//"..nom.."/go/"..num..".png")})
				if love.filesystem.exists( "app/missi/"..nom.."/go/"..num..".ogg") == true then
					h[2][1][table.maxn(h[2][1])][2] = love.sound.newSoundData( "app/missi//"..nom.."/go/"..num..".ogg" )
					h[2][1][table.maxn(h[2][1])][3] = 0
				end
				num = num+1
			end
			num = 1
			while love.filesystem.exists( "app/missi/"..nom.."/boom/"..num..".png" ) == true do
				table.insert( h[2][2] ,{love.graphics.newImage("app/missi//"..nom.."/boom/"..num..".png")})
				if love.filesystem.exists( "app/missi/"..nom.."/boom/"..num..".ogg") == true then
					h[2][2][table.maxn(h[2][2])][2] = love.sound.newSoundData( "app/missi//"..nom.."/boom/"..num..".ogg" )
					h[2][2][table.maxn(h[2][1])][3] = 0
				end
				num = num+1
			end
			if love.filesystem.exists( "app/missi//"..nom.."/passe.ogg") == true then
				h[2][3] = {love.sound.newSoundData( "app/missi//"..nom.."/passe.ogg" ),0}
			end
		else
			h[1] = 0
		end
	end
	for i,h in ipairs(unitlist) do
		if love.filesystem.exists( "app/unit/"..h[1].."" ) == true then
			nom = h[1]
			h[1] = {{{{},0,0},{{},0,0,0},{{},0,0},{{},0,0},{{},0,0}},{{{},0,0}},{{},0,0}}
			if love.filesystem.exists( "app/unit/"..nom.."/torce/stand/prop.lua" ) == true then
				love.filesystem.load("app/unit/"..nom.."/torce/stand/prop.lua")()
				h[1][1][1][2] = x
				h[1][1][1][3] = y
			end
			num = 1
			while love.filesystem.exists( "app/unit/"..nom.."/torce/stand/"..num..".png" ) == true do
				table.insert( h[1][1][1][1] ,{love.graphics.newImage("app/unit/"..nom.."/torce/stand/"..num..".png")})
				if love.filesystem.exists( "app/unit/"..nom.."/torce/stand/"..num..".ogg") == true then
					h[1][1][1][1][table.maxn(h[1][1][1][1])][2] = love.sound.newSoundData( "app/unit/"..nom.."/torce/stand/"..num..".ogg" )
					h[1][1][1][1][table.maxn(h[1][1][1][1])][3] = 0
				end
				num = num+1
			end
			if love.filesystem.exists( "app/unit/"..nom.."/torce/fire/prop.lua" ) == true then
				love.filesystem.load("app/unit/"..nom.."/torce/fire/prop.lua")()
				h[1][1][2][2] = x
				h[1][1][2][3] = y
				h[1][1][2][4] = frametire
			end
			num = 1
			while love.filesystem.exists( "app/unit/"..nom.."/torce/fire/"..num..".png" ) == true do
				table.insert( h[1][1][2][1] ,{love.graphics.newImage("app/unit/"..nom.."/torce/fire/"..num..".png")})
				if love.filesystem.exists( "app/unit/"..nom.."/torce/fire/"..num..".ogg") == true then
					h[1][1][2][1][table.maxn(h[1][1][2][1])][2] = love.sound.newSoundData( "app/unit/"..nom.."/torce/fire/"..num..".ogg" )
					h[1][1][2][1][table.maxn(h[1][1][2][1])][3] = 0
				end
				num = num+1
			end
			if love.filesystem.exists( "app/unit/"..nom.."/torce/recharge/prop.lua" ) == true then
				love.filesystem.load("app/unit/"..nom.."/torce/recharge/prop.lua")()
				h[1][1][3][2] = x
				h[1][1][3][3] = y
			end
			num = 1
			while love.filesystem.exists( "app/unit/"..nom.."/torce/recharge/"..num..".png" ) == true do
				table.insert( h[1][1][3][1] ,{love.graphics.newImage("app/unit/"..nom.."/torce/recharge/"..num..".png")})
				if love.filesystem.exists( "app/unit/"..nom.."/torce/recharge/"..num..".ogg") == true then
					h[1][1][3][1][table.maxn(h[1][1][3][1])][2] = love.sound.newSoundData( "app/unit/"..nom.."/torce/recharge/"..num..".ogg" )
					h[1][1][3][1][table.maxn(h[1][1][3][1])][3] = 0
				end
				num = num+1
			end
			if love.filesystem.exists( "app/unit/"..nom.."/torce/penche/prop.lua" ) == true then
				love.filesystem.load("app/unit/"..nom.."/torce/penche/prop.lua")()
				h[1][1][4][2] = x
				h[1][1][4][3] = y
			end
			num = 1
			while love.filesystem.exists( "app/unit/"..nom.."/torce/penche/"..num..".png" ) == true do
				table.insert( h[1][1][4][1] ,{love.graphics.newImage("app/unit/"..nom.."/torce/penche/"..num..".png")})
				if love.filesystem.exists( "app/unit/"..nom.."/torce/penche/"..num..".ogg") == true then
					h[1][1][4][1][table.maxn(h[1][1][4][1])][2] = love.sound.newSoundData( "app/unit/"..nom.."/torce/penche/"..num..".ogg" )
					h[1][1][4][1][table.maxn(h[1][1][4][1])][3] = 0
				end
				num = num+1
			end
			if love.filesystem.exists( "app/unit/"..nom.."/torce/pencher/prop.lua" ) == true then
				love.filesystem.load("app/unit/"..nom.."/torce/pencher/prop.lua")()
				h[1][1][5][2] = x
				h[1][1][5][3] = y
			end
			num = 1
			while love.filesystem.exists( "app/unit/"..nom.."/torce/pencher/"..num..".png" ) == true do
				table.insert( h[1][1][5][1] ,{love.graphics.newImage("app/unit/"..nom.."/torce/pencher/"..num..".png")})
				if love.filesystem.exists( "app/unit/"..nom.."/torce/pencher/"..num..".ogg") == true then
					h[1][1][5][1][table.maxn(h[1][1][5][1])][2] = love.sound.newSoundData( "app/unit/"..nom.."/torce/pencher/"..num..".ogg" )
					h[1][1][5][1][table.maxn(h[1][1][5][1])][3] = 0
				end
				num = num+1
			end
			if love.filesystem.exists( "app/unit/"..nom.."/jambe/run/prop.lua" ) == true then
				love.filesystem.load("app/unit/"..nom.."/jambe/run/prop.lua")()
				h[1][2][1][2] = x
				h[1][2][1][3] = y
				h[1][2][1][4] = speed
			end
			num = 1
			while love.filesystem.exists( "app/unit/"..nom.."/jambe/run/"..num..".png" ) == true do
				table.insert( h[1][2][1][1] ,{love.graphics.newImage("app/unit/"..nom.."/jambe/run/"..num..".png")})
				if love.filesystem.exists( "app/unit/"..nom.."/torce/run/"..num..".ogg") == true then
					h[1][1][2][1][table.maxn(h[1][1][2][1])][2] = love.sound.newSoundData( "app/unit/"..nom.."/torce/run/"..num..".ogg" )
					h[1][1][2][1][table.maxn(h[1][1][2][1])][3] = 0
				end
				num = num+1
			end
			if love.filesystem.exists( "app/unit/"..nom.."/mort/prop.lua" ) == true then
				love.filesystem.load("app/unit/"..nom.."/mort/prop.lua")()
				h[1][3][2] = x
				h[1][3][3] = y
			end
			num = 1
			while love.filesystem.exists( "app/unit/"..nom.."/mort/"..num..".png" ) == true do
				table.insert( h[1][3][1] ,{love.graphics.newImage("app/unit/"..nom.."/mort/"..num..".png")})
				if love.filesystem.exists( "app/unit/"..nom.."/torce/mort/"..num..".ogg") == true then
					h[1][1][3][1][table.maxn(h[1][1][3][1])][2] = love.sound.newSoundData( "app/unit/"..nom.."/torce/mort/"..num..".ogg" )
					h[1][1][3][1][table.maxn(h[1][1][3][1])][3] = 0
				end
				num = num+1
			end
		else
			h[1] = 0
		end
	end
	mape = love.image.newImageData( "carte/"..cart.."/carte.png" )
	map = {}
	map[1] = love.graphics.newImage( "carte/"..cart.."/carte1.png" )
	map[2] = love.graphics.newImage( "carte/"..cart.."/carte2.png" )
	map[3] = love.graphics.newImage( "carte/"..cart.."/carte3.png" )
	love.filesystem.load("carte/"..cart.."/coverlist.lua")()
	--rouge = altitude
	--vert =
	--bleu =
	----------------------------------
 	carto = {}
	local wx = 1
	while wx < mape:getWidth()/5+1 do
		local wy = 1
		carto[wx] = {}
		while wy < mape:getHeight()/5+1 do
			carto[wx][wy] = {}
			wy = wy+1
		end
		wx = wx+1
	end
	moux = 0
	mouy = 0
	elu = {1,1}
	grouelu = 1
	zoom = 1
	rien = love.graphics.newImage( "rien.png" )
	cam_x = love.graphics.getHeight()/2*zoom
	cam_y = love.graphics.getHeight()/2*zoom
	crono = 0
	creatgroup(400,400,1)
	creation(100,20,1,1,math.pi)
	creation(100,20,1,1,math.pi)
	creation(100,20,1,1,math.pi)
	creation(100,20,1,2,math.pi)
--creation(px,py,grou,typ,direc)
	creatgroup(650,650,2)
	creation(160,700,2,1,math.pi)
	creation(160,700,2,1,math.pi)
	creation(160,700,2,1,math.pi)
	creation(160,700,2,2,math.pi)
	--creation(600,500,2,1,math.pi)
	selected = {1}
	canbeselected = 1
	shift = false
end
function love.mousepressed( mx, my, bu )
	if bu == "wd" then
		if zoom > 0.2 then
			zoom = math.max(.9*zoom,love.graphics.getWidth()/map[1]:getWidth(),love.graphics.getHeight()/map[1]:getHeight())
			cam_x = math.min(math.max(cam_x+.1*(-love.mouse.getX()+love.graphics.getWidth()/2)/zoom,love.graphics.getWidth()/2/zoom),map[1]:getWidth()-love.graphics.getWidth()/2/zoom)
			cam_y = math.min(math.max(cam_y+.1*(-love.mouse.getY()+love.graphics.getHeight()/2)/zoom,love.graphics.getHeight()/2/zoom),map[1]:getHeight()-love.graphics.getHeight()/2/zoom)
		end
	elseif bu == "m" then
	elseif bu == "l" then
		selected[1] = canbeselected
	elseif bu == "r" then
		if selected[1] ~= 0 then
			for i,h in ipairs(selected) do
				ordre(h,moux,mouy,1,false)
			end
		end
	elseif bu == "wu" then
		if zoom < 5 then
			zoom = math.max(1.1*zoom,math.min(map[1]:getWidth()/love.graphics.getWidth(),map[1]:getHeight()/love.graphics.getHeight()))
			cam_x = math.min(math.max(cam_x-.1*(-love.mouse.getX()+love.graphics.getWidth()/2)/zoom,love.graphics.getWidth()/2/zoom),map[1]:getWidth()-love.graphics.getWidth()/2/zoom)
			cam_y =math.min(math.max( cam_y-.1*(-love.mouse.getY()+love.graphics.getHeight()/2)/zoom,love.graphics.getHeight()/2/zoom),map[1]:getHeight()-love.graphics.getHeight()/2/zoom)
		end
	end
end
function love.mousereleased( mx, my, bu )
end
function love.keypressed( k )
	if k == "m" then
		creatgroup(400,400,1)
		creation(100,20,table.maxn(groupe),1,math.pi)
		creation(100,20,table.maxn(groupe),1,math.pi)
		creation(100,20,table.maxn(groupe),1,math.pi)
		creation(100,20,table.maxn(groupe),1,math.pi)
		creation(100,20,table.maxn(groupe),1,math.pi)
		creation(100,20,table.maxn(groupe),2,math.pi)
	elseif k == "n" then
		creatgroup(400,400,2)
		creation(800,820,table.maxn(groupe),1,math.pi)
		creation(800,820,table.maxn(groupe),1,math.pi)
		creation(800,820,table.maxn(groupe),1,math.pi)
		creation(800,820,table.maxn(groupe),1,math.pi)
		creation(800,820,table.maxn(groupe),1,math.pi)
		creation(800,820,table.maxn(groupe),2,math.pi)
	end
end
function love.keyreleased( k )
end
function ordre(ed,ex,ey,typ)
	if groupe[ed] ~= nil then
		if shift == true then
			table.insert( groupe[ed][5] , {ex,ey,typ} )
		else
			groupe[ed][5] = {{ex,ey,typ}}
			groupe[ed][4] = {}
		end
	end
end
function order(ed,ex,ey,typ)
	if shift == true
	and groupe[ed][4][1] ~= nil then
		bx = groupe[ed][4][table.maxn(groupe[ed][4])][1]
		by = groupe[ed][4][table.maxn(groupe[ed][4])][2]
		for t,p in ipairs(groupe[ed][2]) do
			if p[9] ~= 0
			and p[9][1] ~= 0 then
				zone[p[9][1]][p[9][2]][4] = 0
			end
			p[9] = {0,0}
		end
	else
		bx = math.floor(groupe[ed][1][1]/20)*20
		by = math.floor(groupe[ed][1][2]/20)*20
		for t,p in ipairs(groupe[ed][2]) do
			p[8][3] = 1
			if p[9] ~= 0
			and p[9][1] ~= 0 then
				zone[p[9][1]][p[9][2]][4] = 0
			end
			p[9] = {0,0}
		end
	end
	bm = 0
	bn = 0
	dost = math.sqrt((bx-ex)^2+(by-ey)^2)
	list = {}
	lim = 0
	while dost > 30 do
		possi = true
		for t,p in ipairs(list) do
			if math.sqrt((bx+20-p[1])^2+(by-p[2])^2) < 18 then
				possi = false
			end
		end
		if possi == true then
			if altitude(bx+25,by) == 0
			and altitude(bx+15,by+9) == 0
			and altitude(bx+10,by) == 0
			and altitude(bx+20,by) == 0
			and altitude(bx+15,by-9) == 0 then
				di1 = math.sqrt((bx+20-ex)^2+(by-ey)^2)
			else
				di1 = math.huge
			end
		end
		possi = true
		for t,p in ipairs(list) do
			if math.sqrt((bx-p[1])^2+(by-p[2]+20)^2) < 18 then
				possi = false
			end
		end
		if possi  == true then
			if altitude(bx,by+25) == 0
			and altitude(bx,by+10) == 0
			and altitude(bx+9,by+15) == 0
			and altitude(bx,by+20) == 0
			and altitude(bx-9,by+15) == 0 then
				di2 = math.sqrt((bx-ex)^2+(by+20-ey)^2)
			else
				di2 = math.huge
			end
		end
		possi = true
		for t,p in ipairs(list) do
			if math.sqrt((bx-p[1])^2+(by-p[2]-20)^2) < 18 then
				possi = false
			end
		end
		if  possi == true then
			if altitude(bx,by-25) == 0
			and altitude(bx,by-10) == 0
			and altitude(bx+9,by-15) == 0
			and altitude(bx,by-20) == 0
			and altitude(bx-9,by-15) == 0 then
				di3 = math.sqrt((bx-ex)^2+(by-20-ey)^2)
			else
				di3 = math.huge
			end
		end
		possi = true
		for t,p in ipairs(list) do
			if math.sqrt((bx-20-p[1])^2+(by-p[2])^2) < 18 then
				possi = false
			end
		end
		if  possi == true then
			if altitude(bx-25,by) == 0
			and altitude(bx-10,by) == 0
			and altitude(bx-20,by) == 0
			and altitude(bx-15,by+9) == 0
			and altitude(bx-15,by-9) == 0 then
				di4 = math.sqrt((bx-20-ex)^2+(by-ey)^2)
			else
				di4 = math.huge
			end
		end
		if math.min(di2,di3,di4) > di1 then
			bx = bx+20
			bm = 20
			bn = 0
			table.insert( list , {bx,by,typ})
		elseif math.min(di1,di3,di4) > di2 then
			by = by+20
			bm = 0
			bn = 20
			table.insert( list , {bx,by,typ})
		elseif math.min(di1,di2,di4) > di3 then
			by = by-20
			bm = 0
			bn = -20
			table.insert( list , {bx,by,typ})
		elseif math.min(di1,di2,di3) > di4 then
			bx = bx-20
			bm = -20
			bn = 0
			table.insert( list , {bx,by,typ})
		end
		lim = lim+1
		if lim > 100 then
			dost = 0
		else
			dost = math.sqrt((bx-ex)^2+(by-ey)^2)
		end
	end
	dost = math.sqrt((bx-ex)^2+(by-ey)^2)
	if dost < 50 then
		table.insert( list , {ex,ey,typ})
	end
		for t,p in ipairs(list) do
			for u,q in ipairs(list) do
				if math.abs(t-u) > 1 then
					if math.sqrt((p[1]-q[1])^2+(p[2]-q[2])^2) < 25 then
						eqw = math.min(t,u)
						while eqw < math.max(t,u) do
							table.remove(list,math.min(t,u))
							eqw = eqw+1
						end
					end
				end
			end
		end
		if shift == true then
			for t,p in ipairs(list) do
				table.insert(groupe[ed][4],p)
			end
		else

			groupe[ed][4] = list
		end
	--groupe[ed][4] = {{moux,mouy,1}}
end
function killing(ed,id)
	if groupe[ed][2][id][9] ~= 0
	and groupe[ed][2][id][9][1] ~= 0 then
		zone[groupe[ed][2][id][9][1]][groupe[ed][2][id][9][2]][4] = 0
	end
	groupe[ed][2][id][7] = 0
	groupe[ed][2][id][6][1][2] = 1
	groupe[ed][2][id][3] = 0
	groupe[ed][2][id][5][1] = crono+6
	groupe[ed][2][id][1][3] = 100
	groupe[ed][10] = groupe[ed][10]-1
end
function altitude(dx,dy)
	local dx = math.max(2,math.min(mape:getWidth()-2,math.floor(dx/10)))
	local dy = math.max(2,math.min(mape:getHeight()-2,math.floor(dy/10)))
	r, g, b, a = mape:getPixel(dx,dy)
	return(r)
end
function bleu(dx,dy)
	local dx = math.max(2,math.min(mape:getWidth()-2,math.floor(dx/10)))
	local dy = math.max(2,math.min(mape:getHeight()-2,math.floor(dy/10)))
	r, g, b, a = mape:getPixel(dx,dy)
	return(b)
end
function love.update(dot)
	moux = (love.mouse.getX()-love.graphics.getWidth()/2)/zoom+cam_x
	mouy = (love.mouse.getY()-love.graphics.getHeight()/2)/zoom+cam_y
	canbeselected = 0
	if groupe[elu[1]] ~= nil then
		if groupe[elu[1]][2][elu[2]] ~= nil
		and groupe[elu[1]][2][elu[2]][3] ~= 0 then
			if groupe[elu[1]][6] == 1 then--------------stand-------------
				---------------colision(------------
				--groupe[elu[1]][2][elu[2]][2][3] = math.atan2(mouy-groupe[elu[1]][2][elu[2]][1][2],moux-groupe[elu[1]][2][elu[2]][1][1])
				for i,h in ipairs(groupe[elu[1]][2]) do
					if h[3] ~= 0 then
						dist = math.sqrt((groupe[elu[1]][2][elu[2]][1][1]-h[1][1])^2+(groupe[elu[1]][2][elu[2]][1][2]-h[1][2])^2)
						if dist < 12 then
							groupe[elu[1]][2][elu[2]][2][1] = groupe[elu[1]][2][elu[2]][2][1]+.05*(groupe[elu[1]][2][elu[2]][1][1]-h[1][1])
							groupe[elu[1]][2][elu[2]][2][2] = groupe[elu[1]][2][elu[2]][2][2]+.05*(groupe[elu[1]][2][elu[2]][1][2]-h[1][2])
						elseif dist > 180 then
							groupe[elu[1]][2][elu[2]][2][1] = groupe[elu[1]][2][elu[2]][2][1]-.01*(groupe[elu[1]][2][elu[2]][1][1]-h[1][1])
							groupe[elu[1]][2][elu[2]][2][2] = groupe[elu[1]][2][elu[2]][2][2]-.01*(groupe[elu[1]][2][elu[2]][1][2]-h[1][2])
						end
					end
				end
				---------------)colision------------
			elseif groupe[elu[1]][6] == 2 then-----------move-----------
				---------------colision(------------
			--	groupe[elu[1]][2][elu[2]][2][3] = math.atan2(mouy-groupe[elu[1]][2][elu[2]][1][2],moux-groupe[elu[1]][2][elu[2]][1][1])
				for i,h in ipairs(groupe[elu[1]][2]) do
					if h[3] ~= 0 then
						dist = math.sqrt((groupe[elu[1]][2][elu[2]][1][1]-h[1][1])^2+(groupe[elu[1]][2][elu[2]][1][2]-h[1][2])^2)
						if dist ~= 0 then
							if dist < 12 then
								groupe[elu[1]][2][elu[2]][2][1] = groupe[elu[1]][2][elu[2]][2][1]+.05*(groupe[elu[1]][2][elu[2]][1][1]-h[1][1])
								groupe[elu[1]][2][elu[2]][2][2] = groupe[elu[1]][2][elu[2]][2][2]+.05*(groupe[elu[1]][2][elu[2]][1][2]-h[1][2])
							--elseif dist > 150 then
							--	groupe[elu[1]][2][elu[2]][2][1] = groupe[elu[1]][2][elu[2]][2][1]-.02*(groupe[elu[1]][2][elu[2]][1][1]-h[1][1])/dist*(dist-150)
							--	groupe[elu[1]][2][elu[2]][2][2] = groupe[elu[1]][2][elu[2]][2][2]-.02*(groupe[elu[1]][2][elu[2]][1][2]-h[1][2])/dist*(dist-150)
							end
						else
							groupe[elu[1]][2][elu[2]][1][1] = groupe[elu[1]][2][elu[2]][1][1]-1
						end
					end
				end
				---------------)colision------------
			elseif groupe[elu[1]][6] == 3 then----------------recherche de position----------

				best = 0
				bes = math.huge
				ang = 0
				bl = bleu(groupe[elu[1]][1][1],groupe[elu[1]][1][2])
				if bl ~= 0 then
					for i,h in ipairs(zone[bl]) do
						if h[4] == 0 then
							if -h[3]-groupe[elu[1]][2][elu[2]][2][3] > math.pi then
								ang = math.abs(h[3]-groupe[elu[1]][2][elu[2]][2][3]-2*math.pi)
							elseif -h[3]-groupe[elu[1]][2][elu[2]][2][3] < -math.pi then
								ang = math.abs(-h[3]-groupe[elu[1]][2][elu[2]][2][3]+2*math.pi)
							else
								ang = math.abs(-h[3]-groupe[elu[1]][2][elu[2]][2][3])
							end
							ang = ang+.0001*math.sqrt((groupe[elu[1]][2][elu[2]][1][1]+1000*math.cos(groupe[elu[1]][2][elu[2]][2][3])-h[1])^2+(groupe[elu[1]][2][elu[2]][1][2]+100*math.sin(groupe[elu[1]][2][elu[2]][2][3])-h[2])^2)
							if ang < bes then
								best = i
								bes = ang
							end
						end
						if groupe[elu[1]][2][elu[2]][9] ~= 0
						and groupe[elu[1]][2][elu[2]][9][1] ~= 0
						and i == groupe[elu[1]][2][elu[2]][9][2] then
							if -h[3]-groupe[elu[1]][2][elu[2]][2][3] > math.pi then
								ang = math.abs(h[3]-groupe[elu[1]][2][elu[2]][2][3]-2*math.pi)
							elseif -h[3]-groupe[elu[1]][2][elu[2]][2][3] < -math.pi then
								ang = math.abs(-h[3]-groupe[elu[1]][2][elu[2]][2][3]+2*math.pi)
							else
								ang = math.abs(-h[3]-groupe[elu[1]][2][elu[2]][2][3])
							end
							ang = ang+.0001*math.sqrt((groupe[elu[1]][2][elu[2]][1][1]+1000*math.cos(groupe[elu[1]][2][elu[2]][2][3])-h[1])^2+(groupe[elu[1]][2][elu[2]][1][2]+100*math.sin(groupe[elu[1]][2][elu[2]][2][3])-h[2])^2)
							if ang < bes then
								best = i
								bes = ang
							end
						end
					end
				end
				if bes < 2 then
					if groupe[elu[1]][2][elu[2]][9] ~= 0
					and groupe[elu[1]][2][elu[2]][9][1] ~= 0 then
						zone[groupe[elu[1]][2][elu[2]][9][1]][groupe[elu[1]][2][elu[2]][9][2]][4] = 0
					end
					zone[bl][best][4] = 1
					groupe[elu[1]][2][elu[2]][8] = {zone[bl][best][1],zone[bl][best][2],1}
					groupe[elu[1]][2][elu[2]][9] = {bl,best}
				else
					groupe[elu[1]][2][elu[2]][9] = 0
				end
			end

			groupe[elu[1]][9] = (groupe[elu[1]][9]+groupe[elu[1]][2][elu[2]][11])/2+.08*(2.8-groupe[elu[1]][9])
			groupe[elu[1]][2][elu[2]][11] = math.max(0,groupe[elu[1]][2][elu[2]][11]+.2*(groupe[elu[1]][9]-groupe[elu[1]][2][elu[2]][11]))
			if groupe[elu[1]][2][elu[2]][9] ~= 0
			and groupe[elu[1]][2][elu[2]][9][1] ~= 0 then
				groupe[elu[1]][2][elu[2]][11] = groupe[elu[1]][2][elu[2]][11]+math.max(0,.04*(3-groupe[elu[1]][2][elu[2]][11]))
				if groupe[elu[1]][2][elu[2]][1][3] == 100 then
				groupe[elu[1]][2][elu[2]][11] = groupe[elu[1]][2][elu[2]][11]+math.max(0,.06*(4-groupe[elu[1]][2][elu[2]][11]))
				end
			end
			if groupe[elu[1]][2][elu[2]][7] == 1 then
				if groupe[elu[1]][2][elu[2]][3] == 1
				or groupe[elu[1]][2][elu[2]][3] == 2 then
					plusprochegr = {unitlist[groupe[elu[1]][2][elu[2]][4]][5]+100,0}--dist,id
					plusprochegre = {unitlist[groupe[elu[1]][2][elu[2]][4]][5]+100,0}--dist,id
					for e,g in ipairs(groupe) do
						if g[3] ~= groupe[elu[1]][3] then
							dist = math.sqrt((groupe[elu[1]][2][elu[2]][1][1]-g[1][1])^2+(groupe[elu[1]][2][elu[2]][1][2]-g[1][2])^2)
							possi = true
							adv = 36
							em = 9*(g[1][1]-groupe[elu[1]][2][elu[2]][1][1])/dist
							en = 9*(g[1][2]-groupe[elu[1]][2][elu[2]][1][2])/dist
							ex = groupe[elu[1]][2][elu[2]][1][1]+em*4
							ey = groupe[elu[1]][2][elu[2]][1][2]+en*4
							while adv < dist do
								if altitude(ex,ey) < 150 then
									adv = adv+9
									ex = ex+em
									ey = ey+en
								else
									possi = false
									adv = math.huge
								end
							end
							if possi == true then
								if dist < plusprochegr[1] then
									plusprochegr = {dist,e}
								end
							else
								if dist < plusprochegre[1] then
									plusprochegre = {dist,e}
								end
							end
						end
					end
					if plusprochegr[2] == 0 then
						plusprochegr = plusprochegre
					end
					if plusprochegr[2] ~= 0 then
						plusproche = {math.huge,0}--dist,id
						for i,h in ipairs(groupe[plusprochegr[2]][2]) do
							if h[3] ~= 0 then
								dist = math.sqrt((groupe[elu[1]][2][elu[2]][1][1]-h[1][1])^2+(groupe[elu[1]][2][elu[2]][1][2]-h[1][2])^2+(groupe[elu[1]][2][elu[2]][1][3]-h[1][3])^2)
								if dist < plusproche[1] then
									em = 9*(h[1][1]-groupe[elu[1]][2][elu[2]][1][1])/dist
									en = 9*(h[1][2]-groupe[elu[1]][2][elu[2]][1][2])/dist
									eo = 9*(h[1][3]-groupe[elu[1]][2][elu[2]][1][3])/dist
									ex = groupe[elu[1]][2][elu[2]][1][1]+em*4
									ey = groupe[elu[1]][2][elu[2]][1][2]+en*4
									ez = groupe[elu[1]][2][elu[2]][1][3]-5+eo*4
									adv = 36
									while adv < dist do
										if altitude(ex,ey) < ez then
											adv = adv+9
											ex = ex+em
											ey = ey+en
											ez = ez+eo
										else
											adv = math.huge
										end
									end
									if adv < dist+100 then
										plusproche = {dist,i}
									end
								end
							end
						end
					end
					if plusprochegr[2] ~= 0
					and plusproche[2] ~= 0 then
						groupe[elu[1]][2][elu[2]][7] = 2
						groupe[elu[1]][2][elu[2]][5][1] = crono+unitlist[groupe[elu[1]][2][elu[2]][4]][7]
						groupe[elu[1]][2][elu[2]][5][2] = crono+unitlist[groupe[elu[1]][2][elu[2]][4]][8]
						groupe[elu[1]][2][elu[2]][5][3] = crono+unitlist[groupe[elu[1]][2][elu[2]][4]][13]
						groupe[elu[1]][2][elu[2]][2][3] = math.atan2(groupe[plusprochegr[2]][2][plusproche[2]][1][2]-groupe[elu[1]][2][elu[2]][1][2],groupe[plusprochegr[2]][2][plusproche[2]][1][1]-groupe[elu[1]][2][elu[2]][1][1])
						groupe[elu[1]][2][elu[2]][2][5] = (groupe[plusprochegr[2]][2][plusproche[2]][1][3]-groupe[elu[1]][2][elu[2]][1][3])/plusproche[1]

					end
				end
				if groupe[elu[1]][2][elu[2]][11] > 2.5 then
					if groupe[elu[1]][2][elu[2]][1][3] == 100 then
						if groupe[elu[1]][2][elu[2]][3] == 1
						or groupe[elu[1]][2][elu[2]][3] == 2 then
							plusprochegr = {unitlist[groupe[elu[1]][2][elu[2]][4]][5]+100,0}--dist,id
							plusprochegre = {unitlist[groupe[elu[1]][2][elu[2]][4]][5]+100,0}--dist,id
							for e,g in ipairs(groupe) do
								if g[3] ~= groupe[elu[1]][3] then
									dist = math.sqrt((groupe[elu[1]][2][elu[2]][1][1]-g[1][1])^2+(groupe[elu[1]][2][elu[2]][1][2]-g[1][2])^2)
									possi = true
									adv = 36
									em = 9*(g[1][1]-groupe[elu[1]][2][elu[2]][1][1])/dist
									en = 9*(g[1][2]-groupe[elu[1]][2][elu[2]][1][2])/dist
									ex = groupe[elu[1]][2][elu[2]][1][1]+em*4
									ey = groupe[elu[1]][2][elu[2]][1][2]+en*4
									while adv < dist do
										if altitude(ex,ey) < 150 then
											adv = adv+9
											ex = ex+em
											ey = ey+en
										else
											possi = false
											adv = math.huge
										end
									end
									if possi == true then
										if dist < plusprochegr[1] then
											plusprochegr = {dist,e}
										end
									else
										if dist < plusprochegre[1] then
											plusprochegre = {dist,e}
										end
									end
								end
							end
							if plusprochegr[2] == 0 then
								plusprochegr = plusprochegre
							end
							if plusprochegr[2] ~= 0 then
								plusproche = {math.huge,0}--dist,id
								for i,h in ipairs(groupe[plusprochegr[2]][2]) do
									if h[3] ~= 0 then
										dist = math.sqrt((groupe[elu[1]][2][elu[2]][1][1]-h[1][1])^2+(groupe[elu[1]][2][elu[2]][1][2]-h[1][2])^2+(groupe[elu[1]][2][elu[2]][1][3]-h[1][3])^2)
										if dist < plusproche[1] then
											em = 5*(h[1][1]-groupe[elu[1]][2][elu[2]][1][1])/dist
											en = 5*(h[1][2]-groupe[elu[1]][2][elu[2]][1][2])/dist
											eo = 5*(h[1][3]-150)/dist
											ex = groupe[elu[1]][2][elu[2]][1][1]+em*4
											ey = groupe[elu[1]][2][elu[2]][1][2]+en*4
											ez = 150-5+eo*4
											adv = 20
											while adv < dist do
												if altitude(ex,ey) < ez then
													adv = adv+5
													ex = ex+em
													ey = ey+en
													ez = ez+eo
												else
													adv = math.huge
												end
											end
											if adv < dist+100 then
												plusproche = {dist,i}
											end
										end
									end
								end
							end
							if plusprochegr[2] ~= 0
							and plusproche[2] ~= 0 then
								groupe[elu[1]][2][elu[2]][7] = 2
								groupe[elu[1]][2][elu[2]][5][1] = 0
								groupe[elu[1]][2][elu[2]][5][2] = crono+.8
								groupe[elu[1]][2][elu[2]][2][3] = math.atan2(groupe[plusprochegr[2]][2][plusproche[2]][1][2]-groupe[elu[1]][2][elu[2]][1][2],groupe[plusprochegr[2]][2][plusproche[2]][1][1]-groupe[elu[1]][2][elu[2]][1][1])


								groupe[elu[1]][2][elu[2]][2][5] = (groupe[plusprochegr[2]][2][plusproche[2]][1][3]-groupe[elu[1]][2][elu[2]][1][3])/plusproche[1]
							else
								groupe[elu[1]][2][elu[2]][3] = 4
								groupe[elu[1]][2][elu[2]][6][1][1] = 5
								groupe[elu[1]][2][elu[2]][6][1][2] = table.maxn(unitlist[groupe[elu[1]][2][elu[2]][4]][1][1][groupe[elu[1]][2][elu[2]][6][2][1]][1])+.99999999
							end
						else
							groupe[elu[1]][2][elu[2]][3] = 4
							groupe[elu[1]][2][elu[2]][6][1][1] = 5
							groupe[elu[1]][2][elu[2]][6][1][2] = table.maxn(unitlist[groupe[elu[1]][2][elu[2]][4]][1][1][groupe[elu[1]][2][elu[2]][6][2][1]][1])+.99999999
						end
					end
				end
			elseif groupe[elu[1]][2][elu[2]][7] == 2 then
				if groupe[elu[1]][2][elu[2]][3] ~= 4
				and groupe[elu[1]][2][elu[2]][3] ~= 5
				and groupe[elu[1]][2][elu[2]][3] ~= 6 then
					if groupe[elu[1]][2][elu[2]][5][3] < crono then

						groupe[elu[1]][2][elu[2]][7] = 1
						groupe[elu[1]][2][elu[2]][3] = 1
						groupe[elu[1]][2][elu[2]][6][1][2] = 1
						groupe[elu[1]][2][elu[2]][6][1][1] = 1
					end
				end


				if groupe[elu[1]][2][elu[2]][3] == 1 then-----------stand---------
					if groupe[elu[1]][2][elu[2]][5][1] < crono then
						if groupe[elu[1]][2][elu[2]][1][3] == 100 then
							groupe[elu[1]][2][elu[2]][3] = 5
							groupe[elu[1]][2][elu[2]][6][1][1] = 5
							groupe[elu[1]][2][elu[2]][6][1][2] = table.maxn(unitlist[groupe[elu[1]][2][elu[2]][4]][1][1][groupe[elu[1]][2][elu[2]][6][2][1]][1])+.99999999
						else
							groupe[elu[1]][2][elu[2]][5][2] = crono+unitlist[groupe[elu[1]][2][elu[2]][4]][8]
							groupe[elu[1]][2][elu[2]][3] = 2
							groupe[elu[1]][2][elu[2]][6][1][2] = 1
							groupe[elu[1]][2][elu[2]][6][1][1] = 2
						end
					end

				elseif groupe[elu[1]][2][elu[2]][3] == 2 then-----------tire---------
					if groupe[elu[1]][2][elu[2]][5][2] > crono then

					else
						if groupe[elu[1]][2][elu[2]][11] < 2.5 then
							if groupe[elu[1]][2][elu[2]][1][3] == 200 then
								groupe[elu[1]][2][elu[2]][7] = 1
								groupe[elu[1]][2][elu[2]][3] = 3
								groupe[elu[1]][2][elu[2]][6][1][2] = 1
								groupe[elu[1]][2][elu[2]][6][1][1] = 5
							end
						else
							groupe[elu[1]][2][elu[2]][3] = 1
							groupe[elu[1]][2][elu[2]][5][1] = crono+unitlist[groupe[elu[1]][2][elu[2]][4]][12]*math.random(80,120)/100
							groupe[elu[1]][2][elu[2]][5][2] = crono+unitlist[groupe[elu[1]][2][elu[2]][4]][8]*math.random(50,150)/100
							groupe[elu[1]][2][elu[2]][6][1][2] = 1
							groupe[elu[1]][2][elu[2]][6][1][1] = 1
						end
					end
					if groupe[elu[1]][2][elu[2]][3] ~= 4
					and groupe[elu[1]][2][elu[2]][3] ~= 5 then
						plusprochegr = {unitlist[groupe[elu[1]][2][elu[2]][4]][5]+100,0}--dist,id
						plusprochegre = {unitlist[groupe[elu[1]][2][elu[2]][4]][5]+100,0}--dist,id
						for e,g in ipairs(groupe) do
							if g[3] ~= groupe[elu[1]][3] then
								dist = math.sqrt((groupe[elu[1]][2][elu[2]][1][1]-g[1][1])^2+(groupe[elu[1]][2][elu[2]][1][2]-g[1][2])^2)
								possi = true
								adv = 36
								em = 9*(g[1][1]-groupe[elu[1]][2][elu[2]][1][1])/dist
								en = 9*(g[1][2]-groupe[elu[1]][2][elu[2]][1][2])/dist
								ex = groupe[elu[1]][2][elu[2]][1][1]+em*4
								ey = groupe[elu[1]][2][elu[2]][1][2]+en*4
								while adv < dist do
									if altitude(ex,ey) < 150 then
										adv = adv+9
										ex = ex+em
										ey = ey+en
									else
										possi = false
										adv = math.huge
									end
								end
								if possi == true then
									if dist < plusprochegr[1] then
										plusprochegr = {dist,e}
									end
								else
									if dist < plusprochegre[1] then
										plusprochegre = {dist,e}
									end
								end
							end
						end
						if plusprochegr[2] == 0 then
							plusprochegr = plusprochegre
						end
						if plusprochegr[2] ~= 0 then
							plusproche = {math.huge,0}--dist,id
							for i,h in ipairs(groupe[plusprochegr[2]][2]) do
								if h[3] ~= 0 then
									dist = math.sqrt((groupe[elu[1]][2][elu[2]][1][1]-h[1][1])^2+(groupe[elu[1]][2][elu[2]][1][2]-h[1][2])^2+(groupe[elu[1]][2][elu[2]][1][3]-h[1][3])^2)
									if dist < plusproche[1] then
										em = 5*(h[1][1]-groupe[elu[1]][2][elu[2]][1][1])/dist
										en = 5*(h[1][2]-groupe[elu[1]][2][elu[2]][1][2])/dist
										eo = 5*(h[1][3]-groupe[elu[1]][2][elu[2]][1][3])/dist
										ex = groupe[elu[1]][2][elu[2]][1][1]+em*4
										ey = groupe[elu[1]][2][elu[2]][1][2]+en*4
										ez = groupe[elu[1]][2][elu[2]][1][3]-5+eo*4
										adv = 20
										while adv < dist do
											if altitude(ex,ey) < ez then
												adv = adv+5
												ex = ex+em
												ey = ey+en
												ez = ez+eo
											else
												adv = math.huge
											end
										end
										if adv < dist+100 then
											plusproche = {dist,i}
										end
									end
								end
							end
						end
						if plusprochegr[2] ~= 0
						and plusproche[2] ~= 0 then
							groupe[elu[1]][2][elu[2]][5][3] = crono+unitlist[groupe[elu[1]][2][elu[2]][4]][13]
							groupe[elu[1]][2][elu[2]][2][3] = math.atan2(groupe[plusprochegr[2]][2][plusproche[2]][1][2]-groupe[elu[1]][2][elu[2]][1][2],groupe[plusprochegr[2]][2][plusproche[2]][1][1]-groupe[elu[1]][2][elu[2]][1][1])
						end
					end
				end
				if groupe[elu[1]][6] == 1 then
					best = 0
					bes = math.huge
					ang = 0
					bl = bleu(groupe[elu[1]][1][1],groupe[elu[1]][1][2])
					if bl ~= 0 then
						for i,h in ipairs(zone[bl]) do
							if h[4] == 0 then
								if -h[3]-groupe[elu[1]][2][elu[2]][2][3] > math.pi then
									ang = math.abs(h[3]-groupe[elu[1]][2][elu[2]][2][3]-2*math.pi)
								elseif -h[3]-groupe[elu[1]][2][elu[2]][2][3] < -math.pi then
									ang = math.abs(-h[3]-groupe[elu[1]][2][elu[2]][2][3]+2*math.pi)
								else
									ang = math.abs(-h[3]-groupe[elu[1]][2][elu[2]][2][3])
								end
								ang = ang+.0001*math.sqrt((groupe[elu[1]][2][elu[2]][1][1]+1000*math.cos(groupe[elu[1]][2][elu[2]][2][3])-h[1])^2+(groupe[elu[1]][2][elu[2]][1][2]+100*math.sin(groupe[elu[1]][2][elu[2]][2][3])-h[2])^2)
								if ang < bes then
									best = i
									bes = ang
								end
							end
							if groupe[elu[1]][2][elu[2]][9] ~= 0
							and groupe[elu[1]][2][elu[2]][9][1] ~= 0
							and i == groupe[elu[1]][2][elu[2]][9][2] then
								if -h[3]-groupe[elu[1]][2][elu[2]][2][3] > math.pi then
									ang = math.abs(h[3]-groupe[elu[1]][2][elu[2]][2][3]-2*math.pi)
								elseif -h[3]-groupe[elu[1]][2][elu[2]][2][3] < -math.pi then
									ang = math.abs(-h[3]-groupe[elu[1]][2][elu[2]][2][3]+2*math.pi)
								else
									ang = math.abs(-h[3]-groupe[elu[1]][2][elu[2]][2][3])
								end
								ang = ang+.0001*math.sqrt((groupe[elu[1]][2][elu[2]][1][1]+1000*math.cos(groupe[elu[1]][2][elu[2]][2][3])-h[1])^2+(groupe[elu[1]][2][elu[2]][1][2]+100*math.sin(groupe[elu[1]][2][elu[2]][2][3])-h[2])^2)
								if ang < bes then
									best = i
									bes = ang
								end
							end
						end
					end
					if bes < 2 then
						if groupe[elu[1]][2][elu[2]][9] ~= 0
						and groupe[elu[1]][2][elu[2]][9][1] ~= 0 then
							zone[groupe[elu[1]][2][elu[2]][9][1]][groupe[elu[1]][2][elu[2]][9][2]][4] = 0
						end
						zone[bl][best][4] = 1
						groupe[elu[1]][2][elu[2]][8] = {zone[bl][best][1],zone[bl][best][2],1}
						groupe[elu[1]][2][elu[2]][9] = {bl,best}
					else
						groupe[elu[1]][2][elu[2]][9] = 0
					end
				end

			end
		end
		elu = {elu[1],elu[2]+1}
		if elu[2] > table.maxn(groupe[elu[1]][2]) then
			elu = {elu[1]+1,1}
		end
	else
		elu = {1,1}
	end
	for e,g in ipairs(groupe) do
		-------------rendu(------------
		if g[6] == 2 then
			possi = table.maxn(groupe[e][2])
			if g[4] ~= {} then
				for i,h in ipairs(groupe[e][2]) do
					if h[8][3] == table.maxn(g[4]) then
						dist = math.sqrt((g[1][1]-g[4][table.maxn(g[4])][1])^2+(g[1][2]-g[4][table.maxn(g[4])][2])^2)
						if dist < 20 then
							possi = possi-1
						end
					elseif h[3] == 0 then
						possi = possi-1
					end
				end
			end
			if possi <= 0 then
				g[6] = 3
				g[5] = {}
				g[4] = {}
			end
		end
		-------------)rendu------------
		possi = table.maxn(groupe[e][2])
		if g[6] == 3 then
			for i,h in ipairs(groupe[e][2]) do
				if h[9] == 0
				or h[9][1] ~= 0
				or h[3] == 0 then
					possi = possi-1
				end
			end
		end
		if possi <= 0 then
			g[6] = 1
		end
		for i,h in ipairs(groupe[e][2]) do
			if h[3] ~= 0 then
				if g[4] ~= {}
				and g[4][h[8][3]] ~= nil then
					if g[4][h[8][3]][3] == 1 then
						if h[3] ~= 2 then
							dist = math.sqrt((h[1][1]-h[8][1])^2+(h[1][2]-h[8][2])^2)
							if dist > 20 then
								h[2][1] = .8*h[2][1]+(-h[1][1]+h[8][1])*unitlist[h[4]][6]/dist
								h[2][2] = .8*h[2][2]+(-h[1][2]+h[8][2])*unitlist[h[4]][6]/dist
							else
								h[2][1] = .9*h[2][1]+.002*(-h[1][1]+h[8][1])
								h[2][2] = .9*h[2][2]+.002*(-h[1][2]+h[8][2])
							end
						end
					elseif g[4][h[8][3]][3] == 2 then
						dist = math.sqrt((h[1][1]-h[8][1])^2+(h[1][2]-h[8][2])^2)
						if dist > 20 then
							h[2][1] = .8*h[2][1]+(-h[1][1]+h[8][1])*unitlist[h[4]][6]/dist
							h[2][2] = .8*h[2][2]+(-h[1][2]+h[8][2])*unitlist[h[4]][6]/dist
						else
							h[2][1] = .9*h[2][1]+.002*(-h[1][1]+h[8][1])
							h[2][2] = .9*h[2][2]+.002*(-h[1][2]+h[8][2])
						end
					end
				else
					if h[3] ~= 2 then
						dist = math.sqrt((h[1][1]-h[8][1])^2+(h[1][2]-h[8][2])^2)
						if dist > 20 then
							h[2][1] = .8*h[2][1]+(-h[1][1]+h[8][1])*unitlist[h[4]][6]/dist
							h[2][2] = .8*h[2][2]+(-h[1][2]+h[8][2])*unitlist[h[4]][6]/dist
						else
							h[2][1] = .9*h[2][1]+.002*(-h[1][1]+h[8][1])
							h[2][2] = .9*h[2][2]+.002*(-h[1][2]+h[8][2])
						end
					end
				end
			end
		end
		for i,h in ipairs(groupe[e][2]) do
			h[6][1][3] = h[6][1][2]
			h[6][2][3] = h[6][2][2]


				if math.atan2(h[2][2],h[2][1])-h[2][4] > math.pi then------------epaule---------
					h[2][4] = h[2][4]+.06*(math.atan2(h[2][2],h[2][1])-h[2][4]-2*math.pi)
				elseif math.atan2(h[2][2],h[2][1])-h[2][4] < -math.pi then------------epaule---------
					h[2][4] = h[2][4]+.06*(math.atan2(h[2][2],h[2][1])-h[2][4]+2*math.pi)
				else
					h[2][4] = h[2][4]+.06*(math.atan2(h[2][2],h[2][1])-h[2][4])
				end










			carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)))] = {}
			if math.floor(h[1][1]/50)-h[1][1] < 25 then
				carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)+1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)))] = {}
				if math.floor(h[1][1]/50)-h[1][1] < 25 then
					carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)+1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)+1))] = {}
				else
					carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)+1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)-1))] = {}
				end
			else
				carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)-1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)))] = {}
				if math.floor(h[1][1]/50)-h[1][1] < 25 then
					carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)-1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)+1))] = {}
				else
					carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)-1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)-1))] = {}
				end
			end
			if math.floor(h[1][1]/50)-h[1][1] < 25 then
				carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)+1))] = {}
			else
				carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)-1))] = {}
			end
			if h[3] ~= 0 then --pas mort
				if altitude(h[1][1]+15*math.cos(h[2][4]-1),h[1][2]+15*math.sin(h[2][4]-1)) > 50 then
					h[2][1] = .9*h[2][1]-.5*math.cos(h[2][4]-1)
					h[2][2] = .9*h[2][2]-.5*math.sin(h[2][4]-1)
				end
				if altitude(h[1][1]+15*math.cos(h[2][4]+1),h[1][2]+15*math.sin(h[2][4]+1)) > 50 then
					h[2][1] = .9*h[2][1]-.5*math.cos(h[2][4]+1)
					h[2][2] = .9*h[2][2]-.5*math.sin(h[2][4]+1)
				end
				dist = math.sqrt((h[1][1]-moux)^2+(h[1][2]-mouy)^2)
				if dist < 30 then
					canbeselected = e
				end
				g[1][1] = (g[1][1]+h[1][1])/2
				g[1][2] = (g[1][2]+h[1][2])/2
				--h[2][1] = .9*h[2][1]+.1*math.cos(h[2][4])
				--h[2][2] = .9*h[2][2]+.1*math.sin(h[2][4])
				h[6][2][2] = h[6][2][2]+.05*unitlist[h[4]][1][2][h[6][2][1]][4]*math.sqrt(h[2][1]^2+h[2][2]^2)
				if h[6][2][2] >= table.maxn(unitlist[h[4]][1][2][h[6][2][1]][1])+1 then
					h[6][2][2] = 1
				end
				if g[4] ~= {} then
					if g[4][h[8][3]] ~= nil then
						dist = math.sqrt((h[1][1]-g[4][h[8][3]][1])^2+(h[1][2]-g[4][h[8][3]][2])^2)
						if dist > 20 then
							h[8][1] = g[4][h[8][3]][1]
							h[8][2] = g[4][h[8][3]][2]
						elseif g[4][h[8][3]+1] ~= nil then
							h[8][3] = h[8][3]+1
						end
					end
				end
			end
			if h[3] == 1 then --stand
				h[6][1][2] = h[6][1][2]+.2
				if h[6][1][2] >= table.maxn(unitlist[h[4]][1][1][h[6][1][1]][1])+1 then
					h[6][1][2] = 1
				end
				if h[2][4]-h[2][6] > math.pi then
					h[2][6] = h[2][6]+.06*(h[2][4]-h[2][6]-2*math.pi)
				elseif h[2][4]-h[2][6] < -math.pi then
					h[2][6] = h[2][6]+.06*(h[2][4]-h[2][6]+2*math.pi)
				else
					h[2][6] = h[2][6]+.06*(h[2][4]-h[2][6])
				end
			elseif h[3] == 2 then --tire
				if h[2][3]-h[2][4] > math.pi then------------epaule---------
					h[2][4] = h[2][4]+.16*(h[2][3]-h[2][4]-2*math.pi)
				elseif h[2][3]-h[2][4] < -math.pi then------------epaule---------
					h[2][4] = h[2][4]+.16*(h[2][3]-h[2][4]+2*math.pi)
				else
					h[2][4] = h[2][4]+.16*(h[2][3]-h[2][4])
				end


				h[6][1][2] = h[6][1][2]+table.maxn(unitlist[h[4]][1][1][h[6][1][1]][1])/unitlist[h[4]][9]*dot*math.random(50,100)/100
				if h[6][1][2] >= table.maxn(unitlist[h[4]][1][1][h[6][1][1]][1])+1 then
					h[6][1][2] = 1
				end
				if math.floor(h[6][1][2]) == unitlist[h[4]][1][1][h[6][1][1]][4] then
					if math.floor(h[6][1][2]) ~= math.floor(h[6][1][3]) then
						tire(e,i)
					end
				end
				if h[13] <= 0 then
					h[3] = 6
					h[6][1][1] = 3
					h[6][1][2] = 1
				end
				if h[2][3]-h[2][6] > math.pi then------------epaule---------
					h[2][6] = h[2][6]+.16*(h[2][3]-h[2][6]-2*math.pi)
				elseif h[2][3]-h[2][6] < -math.pi then------------epaule---------
					h[2][6] = h[2][6]+.16*(h[2][3]-h[2][6]+2*math.pi)
				else
					h[2][6] = h[2][6]+.16*(h[2][3]-h[2][6])
				end
			elseif h[3] == 3 then --penche
				h[6][1][2] = h[6][1][2]+.3
				h[1][3] = h[1][3]-1
				if h[6][1][2] >= table.maxn(unitlist[h[4]][1][1][h[6][2][1]][1])+1 then
					h[1][3] = 100
					h[3] = 1
					h[6][1][1] = 4
					h[6][1][2] = 1
				end
			elseif h[3] == 4 then --releve
				h[6][1][2] = h[6][1][2]-.3
				h[1][3] = h[1][3]+1
				if h[6][1][2] < 1 then
					h[1][3] = 200
					h[3] = 1
					h[6][1][1] = 1
					h[6][1][2] = 1
				end
			elseif h[3] == 5 then --releve de combat
				h[6][1][2] = h[6][1][2]-.4
				h[1][3] = h[1][3]+1.1
				if h[6][1][2] < 1 then
					h[1][3] = 200
					h[3] = 2
					h[6][1][1] = 2
					h[6][1][2] = 1
					h[5][2] = crono+unitlist[h[4]][8]
				end
			elseif h[3] == 6 then --recharge
				h[6][1][2] = h[6][1][2]+table.maxn(unitlist[h[4]][1][1][h[6][1][1]][1])/unitlist[h[4]][11]*dot
				if h[6][1][2] >= table.maxn(unitlist[h[4]][1][1][h[6][1][1]][1])+1 then
					h[3] = 1
					h[6][1][1] = 1
					h[6][1][2] = 1
					h[1][1] = h[1][1]+10
					h[13] = unitlist[h[4]][10]
				end
			end
			h[1][1] = h[1][1]+h[2][1]
			h[1][2] = h[1][2]+h[2][2]
			if math.floor(h[6][1][2]) ~= math.floor(h[6][1][3]) then
				if unitlist[h[4]][1][1][h[6][1][1]][1][math.floor(h[6][1][2])][2] ~= nil
				and unitlist[h[4]][1][1][h[6][1][1]][1][math.floor(h[6][1][2])][3] < crono then
					table.insert(soundlist,{love.audio.newSource(unitlist[h[4]][1][1][h[6][1][1]][1][math.floor(h[6][1][2])][2]),crono+1})
					soundlist[table.maxn(soundlist)][1]:setVolume(math.min(1,300/math.sqrt((h[1][1]-cam_x)^2+(h[1][2]-cam_y)^2+(1000/zoom)^2)^1.3))
					love.audio.play(soundlist[table.maxn(soundlist)][1])
					unitlist[h[4]][1][1][h[6][1][1]][1][math.floor(h[6][1][2])][3] = crono+.05
				end
			end
			if math.floor(h[6][2][2]) ~= math.floor(h[6][2][3]) then
				if unitlist[h[4]][1][2][h[6][2][1]][1][math.floor(h[6][2][2])][2] ~= nil
				and unitlist[h[4]][1][2][h[6][2][1]][1][math.floor(h[6][2][2])][3] < crono then
					table.insert(soundlist,{love.audio.newSource(unitlist[h[4]][1][2][h[6][2][1]][1][math.floor(h[6][2][2])][2]),crono+1})
					soundlist[table.maxn(soundlist)][1]:setVolume(math.min(1,300/math.sqrt((h[1][1]-cam_x)^2+(h[1][2]-cam_y)^2+(1000/zoom)^2)^1.3))
					love.audio.play(soundlist[table.maxn(soundlist)][1])
					unitlist[h[4]][1][2][h[6][2][1]][1][math.floor(h[6][2][2])][3] = crono+.05
				end
			end
		end
	end
	for e,g in ipairs(groupe) do
		if g[5][1] ~= nil then
			dist = math.sqrt((g[1][1]-g[5][1][1])^2+(g[1][2]-g[5][1][2])^2)
			if dist > 50 then
				if g[4][table.maxn(g[4])] ~= nil then
					dist = math.sqrt((g[1][1]-g[4][table.maxn(g[4])][1])^2+(g[1][2]-g[4][table.maxn(g[4])][2])^2)
					if dist < 50 then
						order(e,g[5][1][1],g[5][1][2],g[5][1][3])
					end
				else
					order(e,g[5][1][1],g[5][1][2],g[5][1][3])
				end
				g[6] = 2
			end
		end
		for i,h in ipairs(groupe[e][2]) do
			if h[3] == 0 then -- mort
				h[6][1][2] = math.min(h[6][1][2]+.2,table.maxn(unitlist[h[4]][1][3][1]))
				h[2][1] = .8*h[2][1]
				h[2][2] = .8*h[2][2]
				if h[5][1] < crono then
					table.remove(groupe[e][2],i)
					if table.maxn(groupe[e][2]) == 0 then
						for q,w in ipairs(selected) do
							if w > e then
								w = w-1
							elseif w == e then
								w = 0
							end
						end
						table.remove(groupe,e)
					end
				end
			else
				h[2][1] = .9*h[2][1]
				h[2][2] = .9*h[2][2]
				table.insert(carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)))],{e,i})
				if math.floor(h[1][1]/50)-h[1][1] < 25 then
					table.insert(carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)+1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)))],{e,i})
					if math.floor(h[1][1]/50)-h[1][1] < 25 then
						table.insert(carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)+1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)+1))],{e,i})
					else
						table.insert(carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)+1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)-1))],{e,i})
					end
				else
					table.insert(carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)-1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)))],{e,i})
					if math.floor(h[1][1]/50)-h[1][1] < 25 then
						table.insert(carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)-1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)+1))],{e,i})
					else
						table.insert(carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)-1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)-1))],{e,i})
					end
				end
				if math.floor(h[1][1]/50)-h[1][1] < 25 then
					table.insert(carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)+1))],{e,i})
				else
					table.insert(carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)-1))],{e,i})
				end
			end
		end
	end
	for i,h in ipairs(missi) do
		h[7] = h[6]
		if h[3] == 1 then
			spee = math.sqrt(h[2][1]^2+h[2][2]^2+h[2][3]^2)
			se = 0
			while se < spee do
				h[1][1] = h[1][1]+h[2][1]/spee*3
				h[1][2] = h[1][2]+h[2][2]/spee*3
				h[1][3] = h[1][3]+h[2][3]/spee*3
				se = se+3
				if altitude(h[1][1],h[1][2]) > h[1][3] then
					h[3] = 2
					h[1][1] = h[1][1]-h[2][1]/spee*3
					h[1][2] = h[1][2]-h[2][2]/spee*3
					h[1][3] = h[1][3]+10

					h[6] = 1
					se = 10000
					h[8] = crono+5
				end
			end
			if h[3] == 1 then
				for e,g in ipairs(carto[math.max(1,math.min(table.maxn(carto),math.floor(h[1][1]/50)))][math.max(1,math.min(table.maxn(carto[1]),math.floor(h[1][2]/50)))]) do
					if groupe[g[1]] ~= nil then
						if h[3] == 1 then
							if groupe[g[1]][3] ~= h[5] then
								if groupe[g[1]][2][g[2]] ~= nil then
									if groupe[g[1]][2][g[2]][1][3] > h[1][3] then
										dist = math.sqrt((groupe[g[1]][2][g[2]][1][1]-h[1][1])^2+(groupe[g[1]][2][g[2]][1][2]-h[1][2])^2)
										if dist < 10 then
											h[3] = 3
											h[1][1] = h[1][1]-h[2][1]/spee*5
											h[1][2] = h[1][2]-h[2][2]/spee*5
											h[1][3] = 120
											h[6] = 1
											groupe[g[1]][2][g[2]][11] = groupe[g[1]][2][g[2]][11]-2*missilist[h[4]][4]
											groupe[g[1]][2][g[2]][12] = groupe[g[1]][2][g[2]][12]-missilist[h[4]][5]



											if groupe[g[1]][2][g[2]][12] <= 0 then
												killing(g[1],g[2])
											end
										end
									end
										groupe[g[1]][2][g[2]][11] = groupe[g[1]][2][g[2]][11]-missilist[h[4]][4]*math.random(50,100)/100
								end
							end
						end
					end
				end
			end
			h[6] = h[6]+.2
			if h[6] >= table.maxn(missilist[h[4]][2][1])+1 then
				h[6] = 1
			end
			if h[8] < crono then
				table.remove(missi,i)
			end
			if missilist[h[4]][2][3][1] ~= nil then
				if missilist[h[4]][2][3][2] < crono then
					dist = math.sqrt((cam_x-h[1][1])^2+(cam_y-h[1][2])^2)
					if h[9] == 0 then
						if dist < 400 then
							h[9] = 1
							dist = math.sqrt((cam_x-h[1][1])^2+(cam_y-h[1][2])^2+(1000/zoom)^2)
							table.insert(soundlist,{love.audio.newSource(missilist[h[4]][2][3][1]),crono+1})
							soundlist[table.maxn(soundlist)][1]:setVolume(math.min(1,50/dist^1.1))
							love.audio.play(soundlist[table.maxn(soundlist)][1])
							missilist[h[4]][2][3][2] = crono+.1
						end
					else
						if dist > 200 then
							h[9] = 0
						end
					end
				end
			end
		elseif h[3] == 2 then
			h[6] = h[6]+.2
			if h[6] >= table.maxn(missilist[h[4]][2][2])+1 then
				h[6] = table.maxn(missilist[h[4]][2][2])
				table.remove(missi,i)
			end
			if h[8] < crono then
				table.remove(missi,i)
			end
		elseif h[3] == 3 then
			h[6] = h[6]+.2
			if h[6] >= table.maxn(sang)+1 then
				h[6] = table.maxn(sang)
				table.remove(missi,i)
			end
		end
		if h[3] ~= 3 then
			if math.floor(h[6]) ~= math.floor(h[7]) then
				if missilist[h[4]][2][h[3]][math.floor(h[6])][2] ~= nil
				and missilist[h[4]][2][h[3]][math.floor(h[6])][3] < crono then
					table.insert(soundlist,{love.audio.newSource(missilist[h[4]][2][h[3]][math.floor(h[6])][1]),crono+1})
					soundlist[table.maxn(soundlist)][1]:setVolume(math.min(1,300/math.sqrt((h[1][1]-cam_x)^2+(h[1][2]-cam_y)^2+(1000/zoom)^2)^1.3))
					love.audio.play(soundlist[table.maxn(soundlist)][1])
					missilist[h[4]][2][h[3]][math.floor(h[6])][3] = crono+.05
				end
			end
		end







	end
	for i,h in ipairs(soundlist) do
		if h[2] < crono then
			table.remove(soundlist,i)
		end
	end
	crono = crono+dot
	fps = fps+.01*(1/dot-fps)
end
function love.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw( map[1] , (-cam_x)*zoom+love.graphics.getWidth()/2,(-cam_y)*zoom+love.graphics.getHeight()/2 ,0,zoom,zoom)
  select:clear()
	love.graphics.setCanvas(select)
	if groupe[canbeselected] ~= nil then
		love.graphics.setColor(0,255,0)
		for i,h in ipairs(groupe[canbeselected][2]) do
			if h[3] ~= 0 then
				love.graphics.draw( pointe , (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2 ,0,zoom*.7,zoom*.7,25,25)
			end
		end
	end
	if groupe[selected[1]] ~= nil then
		love.graphics.setColor(255,255,255,200)
		for e,g in ipairs(selected) do
			for i,h in ipairs(groupe[g][2]) do
				if h[3] ~= 0 then
					love.graphics.draw( pointe , (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2 ,0,zoom,zoom,25,25)
				end
			end
		end
	end
	love.graphics.setBlendMode( "subtractive" )
	love.graphics.setColor(255,255,255)
	if groupe[canbeselected] ~= nil then
		for i,h in ipairs(groupe[canbeselected][2]) do
			if h[3] ~= 0 then
				love.graphics.draw( pointe2 , (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2 ,0,zoom*.7,zoom*.7,25,25)
			end
		end
	end
	if groupe[selected[1]] ~= nil then
		for e,g in ipairs(selected) do
			for i,h in ipairs(groupe[g][2]) do
				if h[3] ~= 0 then
					love.graphics.draw( pointe2 , (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2 ,0,zoom,zoom,25,25)
				end
			end
		end
	end
	love.graphics.setBlendMode( "alpha" )
	love.graphics.setCanvas()
	love.graphics.setColor(255,255,255)
	love.graphics.draw( select , 0 , 0 )
	love.graphics.setColor(255,255,255)
	for e,g in ipairs(groupe) do
		for i,h in ipairs(groupe[e][2]) do
			if h[3] == 0 then
				if h[5][1]-crono > 0 then
					love.graphics.setColor(math.min(255,100*(h[5][1]-crono)),math.min(255,54*(h[5][1]-crono)),math.min(255,50*(h[5][1]-crono)),math.min(255,100*(h[5][1]-crono)))
					love.graphics.draw( unitlist[h[4]][1][3][1][math.floor(h[6][1][2])][1] , (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2 ,h[2][4],-zoom*.3,zoom*.3,unitlist[h[4]][1][3][2],unitlist[h[4]][1][3][3])
					love.graphics.setColor(255,255,255)
				end
			end
		end
		for i,h in ipairs(groupe[e][2]) do
			if h[3] ~= 0 then
				love.graphics.draw( unitlist[h[4]][1][2][h[6][2][1]][1][math.floor(h[6][2][2])][1] , (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2 ,h[2][4],-zoom*.3,zoom*.3,unitlist[h[4]][1][2][h[6][2][1]][2],unitlist[h[4]][1][2][h[6][2][1]][3])
			end
		end
		for i,h in ipairs(groupe[e][2]) do
			if h[3] ~= 0 then
				if h[1][3] < 150 then
					love.graphics.draw( unitlist[h[4]][1][1][h[6][1][1]][1][math.floor(h[6][1][2])][1] , (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2 ,h[2][6],-zoom*.3,zoom*.3,unitlist[h[4]][1][1][h[6][2][1]][2],unitlist[h[4]][1][1][h[6][2][1]][3])
				end
			end
		end
	end
	for i,h in ipairs(missi) do
		if h[1][3] < 100 then
			if h[3] == 3 then
				love.graphics.draw( sang[math.floor(h[6])][1] , (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2 ,h[2][4],.8*zoom,.8*zoom,sang[math.floor(h[6])][1]:getWidth()/2,sang[math.floor(h[6])][1]:getHeight()/2)
			else
				if h[8] > crono then
					love.graphics.setColor(255,255,255,math.min(255,100*(h[8]-crono)))
					love.graphics.draw( missilist[h[4]][2][h[3]][math.floor(h[6])][1] , (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2 ,h[2][4],.8*zoom,.8*zoom,missilist[h[4]][2][h[3]][math.floor(h[6])][1]:getWidth()/2,missilist[h[4]][2][h[3]][math.floor(h[6])][1]:getHeight()/2)
					love.graphics.setColor(255,255,255)
				end
			end
		end
	end
	love.graphics.draw( map[2] , (-cam_x)*zoom+love.graphics.getWidth()/2,(-cam_y)*zoom+love.graphics.getHeight()/2 ,0,zoom,zoom)
	for e,g in ipairs(groupe) do
		for i,h in ipairs(groupe[e][2]) do
			if h[1][3] > 150 then
				if h[3] ~= 0 then
					love.graphics.draw( unitlist[h[4]][1][1][h[6][1][1]][1][math.floor(h[6][1][2])][1] , (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2 ,h[2][6],-zoom*.3,zoom*.3,unitlist[h[4]][1][1][h[6][2][1]][2],unitlist[h[4]][1][1][h[6][2][1]][3])
				end
			end
			--love.graphics.draw( point , (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2 ,0,zoom*.4,zoom*.4,25,25)
			love.graphics.setColor(255,0,0)
			--love.graphics.print( math.floor(h[3]),  (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2)
			--love.graphics.print( h[7],  (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,10+(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2)
			--love.graphics.print( table.maxn(unitlist[h[4]][1][1][h[6][1][1]][1])+1,  (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,20+(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2)
			love.graphics.setColor(255,255,255)
		end
		love.graphics.setColor(255,0,255)
		--love.graphics.print( g[6],  (g[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(g[1][2]-cam_y)*zoom+love.graphics.getHeight()/2)
		love.graphics.setColor(255,255,255)
		--love.graphics.setColor(0,0,0)
		--love.graphics.print( e,  (g[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(g[1][2]-cam_y)*zoom+love.graphics.getHeight()/2)
		--love.graphics.draw( point , (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2 ,0,zoom*.4,zoom*.4,25,25)
	end
	for i,h in ipairs(missi) do
		if h[1][3] > 100
		and h[1][3] < 200 then
			if h[3] == 3 then
				love.graphics.draw( sang[math.floor(h[6])][1] , (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2 ,h[2][4],.8*zoom,.8*zoom,sang[math.floor(h[6])][1]:getWidth()/2,sang[math.floor(h[6])][1]:getHeight()/2)
			else
				if h[8] > crono then
					love.graphics.setColor(255,255,255,math.min(255,100*(h[8]-crono)))
					love.graphics.draw( missilist[h[4]][2][h[3]][math.floor(h[6])][1] , (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2 ,h[2][4],.8*zoom,.8*zoom,missilist[h[4]][2][h[3]][math.floor(h[6])][1]:getWidth()/2,missilist[h[4]][2][h[3]][math.floor(h[6])][1]:getHeight()/2)
					love.graphics.setColor(255,255,255)
				end
			end
		end
	end
	love.graphics.draw( map[3] , (-cam_x)*zoom+love.graphics.getWidth()/2,(-cam_y)*zoom+love.graphics.getHeight()/2 ,0,zoom,zoom)
	for i,h in ipairs(missi) do
		if h[1][3] > 200 then
			if h[3] == 3 then
				love.graphics.draw( sang[math.floor(h[6])][1] , (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2 ,h[2][4],.8*zoom,.8*zoom,sang[math.floor(h[6])][1]:getWidth()/2,sang[math.floor(h[6])][1]:getHeight()/2)
			else
				if h[8] > crono then
					love.graphics.setColor(255,255,255,math.min(255,100*(h[8]-crono)))
					love.graphics.draw( missilist[h[4]][2][h[3]][math.floor(h[6])][1] , (h[1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom+love.graphics.getHeight()/2 ,h[2][4],.8*zoom,.8*zoom,missilist[h[4]][2][h[3]][math.floor(h[6])][1]:getWidth()/2,missilist[h[4]][2][h[3]][math.floor(h[6])][1]:getHeight()/2)
					love.graphics.setColor(255,255,255)
				end
			end
		end
	end
	--for e,g in ipairs(zone) do
	--	if colomou == e then
	--		sdf = 1.3
	--		love.graphics.setColor(255,255,255)
	--	else
	--		sdf = 1
	--		love.graphics.setColor(180,180,180)
	--	end
	--	for i,h in ipairs(zone[e]) do
	--		if h[4] ~= 0 then
	--			love.graphics.draw( pointe , (h[1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[2]-cam_y)*zoom+love.graphics.getHeight()/2 ,-h[3],.35*zoom*sdf,.35*zoom*sdf,30,40)
	--				love.graphics.print( i  , (h[1]-cam_x-25)*zoom+love.graphics.getWidth()/2,(h[2]-cam_y-25)*zoom+love.graphics.getHeight()/2 )
	--		end
	--	end
	--end
	--for e,g in ipairs(carto) do
	--	for i,h in ipairs(carto[e]) do
	--		if h[1] ~= nil then
	--			for f,j in ipairs(carto[e][i]) do
	--				love.graphics.print( "("..j[1]..","..j[2]..")"  , (e*50-cam_x-25)*zoom+love.graphics.getWidth()/2,(i*50-cam_y-25)*zoom+love.graphics.getHeight()/2 )
	--			end
	--		end
	--	end
	--end
	--for i,h in ipairs(groupe[1][4]) do
	--	love.graphics.draw( pointe , (h[1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[2]-cam_y)*zoom+love.graphics.getHeight()/2 ,0,.3*zoom,.3*zoom,40,40)
	--	love.graphics.print( h[3]  , (h[1]-cam_x-25)*zoom+love.graphics.getWidth()/2,(h[2]-cam_y-25)*zoom+love.graphics.getHeight()/2 )
	--end
	love.graphics.print( table.maxn(soundlist), 100  , 50  )
	love.graphics.print( "("..elu[1].."," ..elu[2]..")", 100  , 150  )
	love.graphics.print( math.floor(fps*10)/10, 100  , 200  )
end
