function I.load(I)
	santer = 3
	ava = love.graphics.newCanvas( )
	arri = love.graphics.newCanvas( )
	bloom = love.graphics.newCanvas( )
	arriere = love.graphics.newCanvas( )
	avant = love.graphics.newCanvas( )
	echel = love.graphics.newCanvas( )
	echelle = love.graphics.newCanvas( )
	interface = love.graphics.newCanvas( )


	sourmode = 0
	sprite = {}
	sprite[1] = "Robot guy/Running"
	sprite[2] = "Robot guy/Stand"
	sprite[3] = "Robot guy/Jump"
	sprite[4] = "Projectile/Plasma"
	sprite[5] = "Projectile/Faseur"
	sprite[6] = "Projectile/Maseur"
	sprite[7] = "Projectile/Protoplasma"
	sprite[8] = "Projectile/Missile"
	sprite[9] = "Robot guy/Grimpe"
	sprite[10] = "Robot guy/Mort"
	sprite[11] = "Robot guy/Status"
	missi = {}
	--missi[0] {1={x,y},2={m,n,ang},3=alier t/f ,4=type,5frame,6,lastframe,7=timer,8=kill

	vie = math.max(vie,3)
	M = {}
	M.rouge = 255
	M.vert = 255
	M.bleu = 255
	visi = true
	love.filesystem.load("carte/"..niv.."/scripte.lua")()
	M.init()
	carter = love.image.newImageData("carte/"..niv.."/map.gif")
	if love.filesystem.exists( "carte/"..niv.."/mus.mp3" , "stream" ) == true then
		musi = love.audio.newSource( "carte/"..niv.."/mus.mp3" , "stream" )
		musi:setLooping( true )
		love.audio.play(musi)
	end
	how = love.audio.newSource( "how.ogg"  )
	--sprite[0] = {{image,son,delaison}}
	for i,h in ipairs(sprite) do
		nom = h
		sprite[i] = {}
		num = 1
		while love.filesystem.exists( "App/"..nom.."/"..num..".gif" ) == true do
			table.insert(sprite[i],{love.graphics.newImage("App/"..nom.."/"..num..".gif" ),0,0})
			num = num+1
		end
		for e,g in ipairs(sprite[i]) do
			g[1]:setFilter( "nearest","nearest" )
			if love.filesystem.exists( "App/"..nom.."/"..e..".ogg" ) == true then
				g[2] = love.audio.newSource( "App/"..nom.."/"..e..".ogg" )
				g[3] = 0
			end
		end
	end







	effet = {}
	--X , Y , m , n , frix , A , S , rot , Splus , T


	local list = love.filesystem.getDirectoryItems("App/Effet/")
	for i,h in ipairs(list) do
		_G["effet_"..h..""] = {image = table.maxn(sprite)+1}
		E = _G["effet_"..h..""]

		love.filesystem.load("App/Effet/"..h.."/proprieter.lua")()

		table.insert( sprite , {} )
		num = 1
		while love.filesystem.exists("App/Effet/"..h.."/app/"..num..".png") == true do
			table.insert(sprite[table.maxn(sprite)],{love.graphics.newImage( "App/Effet/"..h.."/app/"..num..".png"),0,0})
			num = num+1
		end
		for u,c in ipairs(sprite[table.maxn(sprite)]) do

			if love.filesystem.exists( "App/Effet/"..h.."/app/"..u..".ogg" ) == true then
				c[2] = love.audio.newSource( "App/Effet/"..h.."/app/"..u..".ogg" )
				c[3] = 0
			end
		end
	end








	missilist = {}
	--missilist[0] = {1=speed,2=domage,3=sprite,4=cadence,5=time,6=auto,7=taille,8=rotation,9=kill permi}
	missilist[1] = {.3,1,4,.4,2,false,1,.3,1,nom = "Plasma",munition = "infini"}
	missilist[2] = {.4,1,5,.2,2,true,1,0,1,nom = "Phaseur",munition = 0}
	missilist[3] = {.8,1,6,.2,2,false,1,0,2,nom = "Maseur",munition = 0}
	missilist[4] = {.1,1,7,1,2,true,2,-.5,5,nom = "Protoplasma",munition = 0,partic1 = effet_Proton}
	missilist[5] = {.3,3,8,.75,2,false,1,0,1,nom = "Missile",munition = 0,partic1 = effet_Boucane,partic2 = effet_Boucane_boom}
	for i,h in ipairs(missilist) do
		_G["proj_"..h.nom..""] = i
	end












	love.filesystem.load("carte/"..niv.."/mobs en rouge.lua")()




	obj = {}
	objlist = {}
	--objlist[0] = {1=ro,2=type,nom
	checpoint = {}
	chec = 0
	tempohit = 0
	start_x = 4
	start_y = 4
	timemor = 0
	checlist = {}
	objlist = {}
	carto = {}
	cartog = {}
	if love.filesystem.exists( "carte/"..niv.."/fon.gif") == true then
		fon = love.graphics.newImage("carte/"..niv.."/fon.gif")
		fon:setFilter( "nearest","nearest" )

	end
	wx = 0
	while wx < carter:getWidth() do
		wy = 0
		carto[wx] = {}
		cartog[wx] = {}
		while wy < carter:getHeight() do
			ro, ve, bl, al = carter:getPixel( math.min(math.max(0,math.floor(wx)),carter:getWidth()-1), math.min(math.max(0,math.floor(wy)),carter:getHeight()-1) )
			if ro == 255 then
				start_x = wx
				start_y = wy
			elseif ro == 254 then
				table.insert(checpoint,{wx,wy})
			end
			if ro ~= 0 then
				if love.filesystem.exists( "carte/"..niv.."/mobs en rouge.lua") == true then



					mobenrouge()



					if love.filesystem.exists( "App/Mobs/"..nomina.."/Proprieter.lua") == true then
						love.filesystem.load("App/Mobs/"..nomina.."/Proprieter.lua")()
						tyu = table.maxn(objlist)+1
						possi = true
						for i,h in ipairs(objlist) do
							if h[1] == ro then
								possi = false
								tyu = i
							end
						end
						if possi == true then
							_G["unit_"..nomina..""] = table.maxn(objlist)+1
							if tipe == 1 then		--screencrosser
								table.insert( objlist , {ro,tipe,nomina,0,true,vitt,domage = domage} )
							elseif tipe == 2 then		--mine
								table.insert( objlist , {ro,tipe,nomina,0,true,domage = domage} )
							elseif tipe == 3 then		--ia
								table.insert( objlist , {ro,tipe,nomina,0,true,jumph,patrouille = patrouille,vue_limiter = vue_limiter,genre = genre,domage = domage} )
							elseif tipe == 4 then		--tourelle
								table.insert( objlist , {ro,tipe,nomina,0,true,cool} )
							elseif tipe == 5 then		--seecknbash
								table.insert( objlist , {ro,tipe,nomina,0,true,domage = domage,rot_tipe = rot_tipe} )
							elseif tipe == 6 then		--point
								table.insert( objlist , {ro,tipe,nomina,0,true,quant,genre = genre} )
							elseif tipe == 7 then		--up
								table.insert( objlist , {ro,tipe,nomina,0,true,nbdevie} )
							elseif tipe == 8 then		--around turner
								table.insert( objlist , {ro,tipe,nomina,0,true,vitt,domage = domage} )
							elseif tipe == 9 then		--plateforme
								table.insert( objlist , {ro,tipe,nomina,0,true,vitt} )
							elseif tipe == 10 then		--jumper
								table.insert( objlist , {ro,tipe,nomina,0,true,direction,force} )
							elseif tipe == "custom" then	--custom
								table.insert( objlist , {ro,tipe,nomina,0,true} )
								T = objlist[table.maxn(objlist)]
								love.filesystem.load("App/Mobs/"..nomina.."/scripte.lua")()
								T.init(T)
							end
						end
						creation (wx+.5,wy+.5,tyu)
					end
				end
			end
			if bl ~= 0 then
				if love.filesystem.exists( "carte/"..niv.."/terrain en bleu/"..bl.."") == true then
					tyu = table.maxn(checlist)+1
					possi = true
					til = table.maxn(sprite)+1
					for i,h in ipairs(checlist) do
						if h[1] == bl then
							possi = false
							til = h[2]
							tyu = i
						end
					end
					if possi == true then
						num = 1
						table.insert( sprite , {} )
						if love.filesystem.exists( "carte/"..niv.."/terrain en bleu/"..bl.."/"..num..".gif") == true then
							while love.filesystem.exists( "carte/"..niv.."/terrain en bleu/"..bl.."/"..num..".gif") == true do
								table.insert(sprite[til],{love.graphics.newImage( "carte/"..niv.."/terrain en bleu/"..bl.."/"..num..".gif"),0,0})
								num = num+1
							end
							for e,g in ipairs(sprite[til]) do
								g[1]:setFilter( "nearest","nearest" )
							end
						end
						table.insert( checlist , {bl,til,1} )
					end
					carto[wx][wy] = {til,tyu,0,bl}
				else
					carto[wx][wy] = 0
				end
			end
			cartog[wx][wy] = 0
			wy = wy+1
		end
		wx = wx+1
	end
	--table.insert(sprite[table.maxn(sprite)],{love.graphics.newImage("App/Mobs/"..nomina.."/"..h.."/"..numb..".gif")})
	for i,h in ipairs(objlist) do
		if h[2] == 1 then
			h[4] = {"Avance","Mort"}
		elseif h[2] == 2 then
			h[4] = {"Stand","Explose"}
		elseif h[2] == 3 then
			h[4] = {"Stand","Hostile","Mort","Walk"}
		elseif h[2] == 4 then
			h[4] = {"Stand","Hostile","Mort"}
		elseif h[2] == 5 then
			h[4] = {"Stand","Saute","Hostile","Mort"}
		elseif h[2] == 6 then
			h[4] = {"Stand","Recup"}
		elseif h[2] == 7 then
			h[4] = {"Stand","Recup"}
		elseif h[2] == 8 then
			h[4] = {"Walk","Mort"}
		elseif h[2] == 9 then
			h[4] = {"Stand"}
		elseif h[2] == 10 then
			h[4] = {"Stand","projection"}
		elseif h[2] == "custom" then
			h.sprite(h)
		end
		for e,g in ipairs(h[4]) do
			table.insert( sprite , {} )
			numb = 1
			while love.filesystem.exists("App/Mobs/"..h[3].."/"..g.."/"..numb..".gif") == true do
				table.insert(sprite[table.maxn(sprite)],{love.graphics.newImage( "App/Mobs/"..h[3].."/"..g.."/"..numb..".gif"),0,0})
				numb = numb+1
			end
			for u,c in ipairs(sprite[table.maxn(sprite)]) do
				c[1]:setFilter( "nearest","nearest" )
				if love.filesystem.exists( "App/Mobs/"..h[3].."/"..g.."/"..u..".ogg" ) == true then
					c[2] = love.audio.newSource( "App/Mobs/"..h[3].."/"..g.."/"..u..".ogg" )
					c[3] = 0
				end
			end
			h[4][e] = table.maxn(sprite)
		end
	end
	if love.filesystem.exists( "App/Robot guy/Jump/Jump.ogg" ) == true then
		sonsaute = love.audio.newSource( "App/Robot guy/Jump/Jump.ogg" )
	end
	for i,h in ipairs(obj) do
		if objlist[h[3]][2] == 1 then--screencrosser
		elseif objlist[h[3]][2] == 2 then--mine
		elseif objlist[h[3]][2] == 3 then--ia
		elseif objlist[h[3]][2] == 4 then--tourelle
		elseif objlist[h[3]][2] == 5 then--seecknbash
		elseif objlist[h[3]][2] == 6 then--point
			h[1][2] = h[1][2]-.5
		elseif objlist[h[3]][2] == 7 then--up
		elseif objlist[h[3]][2] == 8 then--around turner
			if coli(h[1][1],h[1][2]+1) >= 150 then
				h[2][3] = 0
			elseif coli(h[1][1]+1,h[1][2]) >= 150 then
				h[2][3] = 1.5*math.pi
			elseif coli(h[1][1],h[1][2]-1) >= 150 then
				h[2][3] = math.pi
			elseif coli(h[1][1]-1,h[1][2]) >= 150 then
				h[2][3] = .5*math.pi
			end
		elseif objlist[h[3]][2] == 9 then--plateforme
		elseif objlist[h[3]][2] == 10 then--jumper
		end
	end
	tirer = false
	retire = 0
	cam_x = 0.0001
	cam_y = 9.7
	zoom = 1
	x = start_x
	y = start_y
	m = 0
	n = 0
	grimpe = 0
	distosol = 0
	numspr = 1
	saut_n = .25
	vitesse = .04
	depl_m = 0
	depl_n = 0
	sens = 1
	ang = 0
	frame = 1
	app = 1
	crono = 0
	gravity_m = 0
	gravity_n = .01
	fps = 60
	lastframe = 0
	M.start()
end
function I.deload(I)
	love.audio.stop()
	obj = nil
	--objlist = nil
	checpoint = nil
	checlist = nil
	carto = nil
	cartog = nil
	fon = nil
	musi = nil
	missi = nil
	missilist = nil
	bloom = nil
	arriere = nil
	avant = nil
	echel = nil
	echelle = nil
	interface = nil
	sprite = nil
	ava = nil
	arri = nil
	carter = nil
	sonsaute = nil
	collectgarbage ("collect")
end
function creation (sx,sy,tiper)
	if objlist[tiper][2] == 1 then--screencrosser
		table.insert( obj , {{sx,sy},{0,0,0,1},tiper,1,1,1,1})
		--1={x,y},2={m,n,o},3=type,4=app{Stand,Explose},5=anim,6=frame,7=lastframe,
	elseif objlist[tiper][2] == 2 then--mine
		table.insert( obj , {{sx,sy},{0,0,0,1},tiper,1,1,1,1})
		--1={x,y},2={m,n,o},3=type,4=app{Stand,Explose},5=anim,6=frame,7=lastframe,
	elseif objlist[tiper][2] == 3 then--ia
		table.insert( obj , {{sx,sy},{0,0,0,-1},tiper,1,1,1,1})
		--1={x,y},2={m,n,o},3=type,4=app{Stand,Explose},5=anim,6=frame,7=lastframe
		if objlist[tiper].patrouille ~= false then
			obj[table.maxn(obj)][5] = 4
		end
		obj[table.maxn(obj)].timer = 0
	elseif objlist[tiper][2] == 4 then--tourelle
		table.insert( obj , {{sx,sy},{0,0,0,1},tiper,1,1,1,1,0})
		--1={x,y},2={m,n,o},3=type,4=app{Stand,Explose},5=anim,6=frame,7=lastframe,
	elseif objlist[tiper][2] == 5 then--seecknbash
		table.insert( obj , {{sx,sy},{0,0,0,1},tiper,1,1,1,1,0})
		--1={x,y},2={m,n,o},3=type,4=app{Stand,Explose},5=anim,6=frame,7=lastframe,8=ondul
	elseif objlist[tiper][2] == 6 then--point
		table.insert( obj , {{sx,sy},{0,0,0,1},tiper,1,1,1,1})
		--1={x,y},2={m,n,o},3=type,4=app{Stand,Explose},5=anim,6=frame,7=lastframe,
	elseif objlist[tiper][2] == 7 then--up
		table.insert( obj , {{sx,sy},{0,0,0,1},tiper,1,1,1,1})
		--1={x,y},2={m,n,o},3=type,4=app{Stand,Explose},5=anim,6=frame,7=lastframe,
	elseif objlist[tiper][2] == 8 then--around turner
		table.insert( obj , {{sx,sy},{0,0,0,1},tiper,1,1,1,1})
		obj[table.maxn(obj)].timer = 0
		--1={x,y},2={m,n,o},3=type,4=app{Stand,Explose},5=anim,6=frame,7=lastframe,8direction
	elseif objlist[tiper][2] == 9 then--plateforme
		mo = -1
		no = 0
		if coliv(sx+1,sy) == objlist[tiper][1] then
			mo = 1
			no = 0
		end
		if coliv(sx,sy+1) == objlist[tiper][1] then
			mo = 0
			no = 1
		end
		if coliv(sx,sy-1) == objlist[tiper][1] then
			mo = 0
			no = -1
		end
		table.insert( obj , {{sx,sy+1},{mo*objlist[tiper][6],no*objlist[tiper][6],0,1},tiper,1,1,1,1})
		--1={x,y},2={m,n,o},3=type,4=app{Stand,Explose},5=anim,6=frame,7=lastframe
	elseif objlist[tiper][2] == 10 then--jumper
		table.insert( obj , {{sx,sy},{0,0,0,1},tiper,1,1,1,1})
		--1={x,y},2={m,n,o},3=type,4=app{Stand,Explose},5=anim,6=frame,7=lastframe,
	elseif objlist[tiper][2] == "custom" then--custom
		objlist[tiper].creation(tiper,sx,sy)
	end
end
function particule(tipe,ex,ey,em,en,ang)
	table.insert( effet , {	tipe = tipe,
				X = ex,
				Y = ey,
				A = ang,
				m = tipe.facteur_vitt*em+math.random(-50*tipe.random,50*tipe.random)/50,
				n = tipe.facteur_vitt*en+math.random(-50*tipe.random,50*tipe.random)/50,
				S = tipe.S,
				T = crono+tipe.T,
				alpha = tipe.alpha,
				frame =  1,
				lastframe = 0
						} )

end
function mort ()
	if vivant ~= 0 then
		if vie == 0 then
			vie = vie-1
			love.audio.pause(musi)
			point = math.max(point-1000,0)
			tempohit = 0
			m = 0
			n = 0
			vivant = 0
			timemor = crono+3
			numspr = 10
			frame = 1
			depl_m = 0
			depl_n = 0
			grimpe = 0
			tirer = false
		else
			vie = vie-1
			point = math.max(point-1000,0)
			tempohit = 0
			m = 0
			n = 0
			vivant = 0
			timemor = crono+1.5
			numspr = 10
			frame = 1
			depl_m = 0
			depl_n = 0
			grimpe = 0
			tirer = false
		end
	end
end
function tire(xu,yu,du,su,equ,typ)
	table.insert(missi,{{xu,yu},{su*missilist[typ][1]*math.cos(du),missilist[typ][1]*math.sin(du),du},equ,typ,1,0,crono+missilist[typ][5],missilist[typ][9],Tpartic = 0})
	if equ == true then
		if numspr == 2 then
			frame = 1
		end
		for i,h in ipairs(obj) do
			if objlist[h[3]][2] == 3 then
				if (x-h[1][1])/math.abs(x-h[1][1]) == -sens
				and y-h[1][2] < 3
				and y-h[1][2] > -1
				and coli(h[1][1],h[1][2]+1) > 150 then
					h[2][2] = -objlist[h[3]][6]
				end
			end
		end
	end
end
function coli(ex,ey)
	ro, gr, bl, al = carter:getPixel( math.min(math.max(0,math.floor(ex)),carter:getWidth()-1), math.min(math.max(0,math.floor(ey)),carter:getHeight()-1) )
	return (bl)
end
function colir(ex,ey)
	ro, gr, bl, al = carter:getPixel( math.min(math.max(0,math.floor(ex)),carter:getWidth()-1), math.min(math.max(0,math.floor(ey)),carter:getHeight()-1) )
	return (ro)
end
function coliv(ex,ey)
	ro, gr, bl, al = carter:getPixel( math.min(math.max(0,math.floor(ex)),carter:getWidth()-1), math.min(math.max(0,math.floor(ey)),carter:getHeight()-1) )
	return (gr)
end
function rotation_fluide(A1,A2,P)
	A1 = A1-math.floor(A1/math.pi/2)*2*math.pi
	A2 = A2-math.floor(A2/math.pi/2)*2*math.pi
	if A2-A1 > math.pi then
		return(P*(A2-A1-2*math.pi))
	elseif A2-A1 < -math.pi then
		return(P*(A2-A1+2*math.pi))
	else
		return(P*(A2-A1))
	end
end
function I.MP(I,mx,my,bu)
	if vivant ~= 0 then
		if bu == saute then
			depl_n = -saut_n
			if coli(x,y+1) >= 150
			or coli(x-.4,y+1) >= 150
			or coli(x+.4,y+1) >= 150 then
				if y >= math.floor(y)+.5 then
					n = depl_n
					if depl_n ~= 0 then
						love.audio.stop(sonsaute)
						love.audio.play(sonsaute)
						numspr = 3
					end
				end
			end
		elseif bu == "l" then
			tirer = true
		elseif bu == "wd" then
			arme = arme+1
			if arme > 5 then
				arme = 1
			else
				while missilist[arme].munition == 0 do
					arme = arme+1
					if arme > 5 then
						arme = 1
					end
				end
			end
		elseif bu == "wu" then
			arme = arme-1
			if arme < 1 then
				arme = 5
			end
			while missilist[arme].munition == 0 do
				arme = arme-1
				if arme < 1 then
					arme = 5
				end
			end
		end
		for i,h in ipairs(obj) do
			if objlist[h[3]][2] == "custom" then
				objlist[h[3]].MP(objlist[h[3]],h,mx,my,bu)
			end
		end
	end
end
function I.MR(I,mx,my,bu)
	if vivant ~= 0 then
		if bu == saute then
			depl_n = 0
		elseif bu == "l" then
			tirer = false
		end
		for i,h in ipairs(obj) do
			if objlist[h[3]][2] == "custom" then
				objlist[h[3]].MR(objlist[h[3]],h,mx,my,bu)
			end
		end
	end
end
function I.KP(I,k)
	if vivant ~= 0 then
		if k == "escape" then
			set_menu(menu_pause)
			menu.load(menu)
			love.audio.pause(musi)
		elseif k == gauche then
			if love.keyboard.isDown(droite) then
				depl_m = 0
			else
				depl_m = -vitesse
				sens = -1
			end
		elseif k == droite then
			if love.keyboard.isDown(gauche) then
				depl_m = 0
			else
				depl_m = vitesse
				sens = 1
			end
		elseif k == haut then
			if love.keyboard.isDown(bas) then
				grimpe = 0
			else
				grimpe = -.1
			end
		elseif k == bas then
			if love.keyboard.isDown(haut) then
				grimpe = 0
			else
				grimpe = .1
			end
		elseif k == saute then
			depl_n = -saut_n
		end
		for i,h in ipairs(obj) do
			if objlist[h[3]][2] == "custom" then
				objlist[h[3]].KP(objlist[h[3]],h,k)
			end
		end
	end
end
function I.KR(I,k)
	if vivant ~= 0 then
		if k == gauche then
			if love.keyboard.isDown(droite) then
				depl_m = vitesse
				sens = 1
			else
				depl_m = 0
			end
		elseif k == droite then
			if love.keyboard.isDown(gauche) then
				depl_m = -vitesse
				sens = -1
			else
				depl_m = 0
			end
		elseif k == haut then
			if love.keyboard.isDown(bas) then
				grimpe = .1
			else
				grimpe = 0
			end
		elseif k == bas then
			if love.keyboard.isDown(haut) then
				grimpe = -.1
			else
				grimpe = 0
			end
		elseif k == saute then
			depl_n = 0
		end
		for i,h in ipairs(obj) do
			if objlist[h[3]][2] == "custom" then
				objlist[h[3]].KR(objlist[h[3]],h,k)
			end
		end
	end
end
function I.update(I,dot)
	if vivant ~= 0 then
		if y > carter:getHeight() then
			mort()
			santer = 0
		end
		if tirer == true then
			if retire < crono then
				tire(x+.4*sens,y+.2,0,sens,true,arme)
				if missilist[arme][6] == false then
					tirer = false
				end
				retire = crono+missilist[arme][4]
				if missilist[arme].munition ~= "infini" then
					missilist[arme].munition = math.max(missilist[arme].munition-1,0)
					if missilist[arme].munition == 0 then
						arme = 1
					end
				end
			end
		end
	else
		if timemor < crono then
			if vie ~= -1 then
				vivant = 1
				santer = 3
				tempohit = crono+.5
				if chec == 0 then
					x = start_x
					y = start_y
				else
					x = checpoint[chec][1]
					y = checpoint[chec][2]
				end
			else
				set_menu(menu_principal)
				menu.load(menu)
			end
		end
	end
	if vivant ~= 0 then
		cam_x = math.min(math.max(cam_x+.1*(x-cam_x+.00001),love.graphics.getWidth()/100),carter:getWidth()-love.graphics.getWidth()/100)
		cam_y = math.max(math.min(cam_y+.01*(y-cam_y+.00001),carter:getHeight()-9/900*love.graphics.getHeight()),9/900*love.graphics.getHeight())
	end
	num = 0
	while num < 10 do
		if num >= 9 then
			distosol = num
		end
		if coli(x,y+num) >= 100 then
			distosol = num
			num = 15
		end
		for i,h in ipairs(obj) do
			if objlist[h[3]][2] == 9 then
				if math.abs(h[1][1]-(x)) < 1
				and math.abs(h[1][2]-(y+num)) < .5 then
					distosol = num
					num = 15
				end
			end
		end
		num = num+1
	end
	x = x+m
	y = y+n
	if checpoint[chec+1] ~= nil
	and x > checpoint[chec+1][1] then
		chec = chec+1
	end
	if coli(x,y+1) >= 150 then
		if y >= math.floor(y)+.5 then
			y = math.floor(y)+.5
			m = .75*m+depl_m
			n = 0
		else
			m = .85*m+gravity_m+.5*depl_m
			n = n+gravity_n
		end
	else
		m = .88*m+gravity_m+.4*depl_m
		n = n+gravity_n
	end
	if coli(x,y) >= 100
	and coli(x,y) < 150 then
		if n >= -.1 then
		--or love.keyboard.isDown(haut) then
			if depl_n ~= 0 then
				n = depl_n
				if depl_n ~= 0 then
					love.audio.stop(sonsaute)
					love.audio.play(sonsaute)
				end
			end
		end
	end
	if coli(x,y+1) >= 150
	or coli(x-.3,y+1) >= 150
	or coli(x+.3,y+1) >= 150 then
		if y >= math.floor(y)+.5 then
			if depl_n ~= 0 then
				n = depl_n
				if depl_n ~= 0 then
					love.audio.stop(sonsaute)
					love.audio.play(sonsaute)
				end
			end
		end
	end
	if coli(x,y-2) >= 150 then
		if y < math.floor(y)+.25 then
			y = math.floor(y)+.25
			m = .75*m+depl_m
			n = math.max(0,n)
		end
	end
	if coli(x+1,y) >= 150 then
		if x >= math.floor(x)+.5 then
			x = math.floor(x)+.5
			m = math.min(m,0)
			--n = .9*n
		end
	end
	if coli(x-1,y) >= 150 then
		if x < math.floor(x)+.5 then
			x = math.floor(x)+.5
			m = math.max(m,0)
			--n = .9*n
		end
	end
	if coli(x+1,y-1) >= 150 then
		if x >= math.floor(x)+.5 then
			x = math.floor(x)+.5
			m = math.min(m,0)
			--n = .9*n
		end
	end
	if coli(x-1,y-1) >= 150 then
		if x < math.floor(x)+.5 then
			x = math.floor(x)+.5
			m = math.max(m,0)
			--n = .9*n
		end
	end
	if coli(x,y) >= 150
	or coli(x,y-1) >= 150 then
		x = x-m
		y = y-n
		n = -.01*n
		m = -.01*m
	end
	if vivant == 0 then
		frame = math.min(frame+.15,table.maxn(sprite[10]))
	else
		if coli(x,y) >= 100
		and coli(x,y) < 150 then
			if grimpe ~= 0 then
				x = x+.1*(math.floor(x)+.5-x)
				m = .9*m
			end
			if n >= -.1 then
				n = grimpe
			end
				frame = frame+grimpe*4
				if frame < 1 then
					frame = table.maxn(sprite[9])
				elseif frame >= table.maxn(sprite[9])+1 then
					frame = 1
				end
				numspr = 9
		else
			if distosol > 1 then
				if n < 0 then
					frame = math.max(math.min((distosol-1)/4*table.maxn(sprite[3])/2,table.maxn(sprite[3])/2),1)+.9
				else
					frame = table.maxn(sprite[3])-math.min((distosol-1)/4*table.maxn(sprite[3])/2,table.maxn(sprite[3])/2)+.9
				end
				numspr = 3
			else
				if depl_m == 0 then
					frame = frame+.15
					if frame < 1 then
						frame = table.maxn(sprite[2])
					elseif frame >= table.maxn(sprite[2])+1 then
						frame = 1
					end
					numspr = 2
				else
					frame = frame+depl_m*-m*40
					if frame < 1 then
						frame = table.maxn(sprite[1])
					elseif frame >= table.maxn(sprite[1])+1 then
						frame = 1
					end
					numspr = 1
				end
			end
		end
	end
	for i,h in ipairs(checlist) do
		h[3] = h[3]+.1
		if h[3] >= table.maxn(sprite[h[2]])+1 then
			h[3] = 1
		end
	end
	for i,h in ipairs(obj) do
		if menu == menu_play then
			if math.abs(h[1][1]-cam_x) < 20 then
				h[1][1] = h[1][1]+h[2][1]
				h[1][2] = h[1][2]+h[2][2]
				cartog[math.max(1,math.min(table.maxn(cartog),math.floor(h[1][1])))][math.max(1,math.min(table.maxn(cartog[1]),math.floor(h[1][2])))] = 0
				if h[1][1] < cam_x+18
				and h[1][1] > cam_x-18
				and sprite[objlist[h[3]][4][h[5]]][math.floor(h[6])][2] ~= 0
				and h[6] ~= h[7]
				and crono > sprite[objlist[h[3]][4][h[5]]][math.floor(h[6])][3] then
					love.audio.stop(sprite[objlist[h[3]][4][h[5]]][math.floor(h[6])][2])
					love.audio.play(sprite[objlist[h[3]][4][h[5]]][math.floor(h[6])][2])
					sprite[objlist[h[3]][4][h[5]]][math.floor(h[6])][3] = crono+.1
				end
				h[7] = h[6]
				if objlist[h[3]][2] == 1 then--screencrosser
					if h[5] == 1 then
						dist = math.sqrt((x-h[1][1])^2+(y-h[1][2]-.5)^2)
						if dist < 1 then
							santer = math.max(0,santer-objlist[h[3]].domage)
							if santer == 0 then
								mort()
							else
								tempohit = crono+.5
								love.audio.stop(how)
								love.audio.play(how)
								n = -.18
								m = .24*(x-h[1][1])/math.abs(x-h[1][1])
							end

							h[5] = 2
							h[6] = 1
							h[7] = 0
							h[2][1] = 0
						end
						if h[1][1] < cam_x+16 then
							h[2][1] = -objlist[h[3]][6]
							h[6] = h[6]+.2
							if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
								h[6] = 2
							end
							if h[1][1] < cam_x-16 then
								table.remove(obj,i)
							end
						end
						if coli(h[1][1],h[1][2]) >= 150 then
							h[5] = 2
							h[6] = 1
							h[7] = 0
							h[2][1] = 0
						end
						cartog[math.max(1,math.min(table.maxn(cartog),math.floor(h[1][1])))][math.max(1,math.min(table.maxn(cartog[1]),math.floor(h[1][2])))] = i
					elseif h[5] == 2 then
						h[6] = h[6]+.1
						if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
							table.remove(obj,i)
						end
					end
				elseif objlist[h[3]][2] == 2 then--mine
						if h[5] == 1 then
							dist = math.sqrt((x-h[1][1])^2+10*(y-h[1][2]-.25)^2)
							if dist < 1 then
								santer = math.max(0,santer-objlist[h[3]].domage)
								if santer == 0 then
									mort()
								else
									tempohit = crono+.5
									love.audio.stop(how)
									love.audio.play(how)
									n = -.18
									m = .24*(x-h[1][1])/math.abs(x-h[1][1])
								end
								h[5] = 2
								h[6] = 1
								h[7] = 0
								h[2][1] = 0
							end
							if coli(h[1][1],h[1][2]+1) >= 150 then
								h[2][2] = 0
								h[1][2] = math.floor(h[1][2])
							else
								h[2][2] = h[2][2]+.01
							end
						elseif h[5] == 2 then
							h[6] = h[6]+.1
							if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
								table.remove(obj,i)
							end
						end

				elseif objlist[h[3]][2] == 3 then--ia
					if coli(h[1][1],h[1][2]+1) >= 150 then
						h[2][2] = 0
						h[1][2] = math.floor(h[1][2])
					else
						h[2][2] = h[2][2]+.01
					end
					if h[5] == 1 then
						h[6] = h[6]+.1
						if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
							h[6] = 1
							h[7] = 0
						end
						if objlist[h[3]].genre == "tire" then
							if math.abs(x-h[1][1]) < 10
							and math.abs(y-h[1][2]) < 2 then
								if objlist[h[3]].vue_limiter == false
								or (x-h[1][1])*h[2][4] < 0 then
									h[5] = 2
									h[6] = 1
									h[7] = 0
								end
							end
						elseif objlist[h[3]].genre == "toucher" then
							if h.timer < crono then
								dist = math.sqrt((x-h[1][1])^2+10*(y-h[1][2]-.25)^2)
								if dist < 1 then
									santer = math.max(0,santer-objlist[h[3]].domage)
									if santer == 0 then
										mort()
									else
										tempohit = crono+.5
										love.audio.stop(how)
										love.audio.play(how)
										n = -.18
										m = .24*(x-h[1][1])/math.abs(x-h[1][1])
									end
									h.timer = crono+1
								end
							end
						end
						cartog[math.max(1,math.min(table.maxn(cartog),math.floor(h[1][1])))][math.max(1,math.min(table.maxn(cartog[1]),math.floor(h[1][2])))] = i
					elseif h[5] == 2 then
						h[6] = h[6]+.1
						if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
							tire(h[1][1]-.8*h[2][4],h[1][2]+.5,math.atan(.2*(y-h[1][2])/math.abs(x-h[1][1])),-h[2][4],false,1)
							h[6] = 1
							h[7] = 0
						end
						if math.abs(x-h[1][1]) > 10
						or math.abs(y-h[1][2]) > 2 then
							if objlist[h[3]].patrouille ~= false then
								h[5] = 4
	 						else
								h[5] = 1
							end
							h[6] = 1
							h[7] = 0
						end
						cartog[math.max(1,math.min(table.maxn(cartog),math.floor(h[1][1])))][math.max(1,math.min(table.maxn(cartog[1]),math.floor(h[1][2])))] = i
					elseif h[5] == 3 then
						h[6] = h[6]+.3
						if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
							table.remove(obj,i)
						end
					elseif h[5] == 4 then
						if coli(h[1][1],h[1][2]+1) >= 150 then
							h[1][1] = h[1][1]-h[2][4]*objlist[h[3]].patrouille.speed
							if coli(h[1][1]-h[2][4],h[1][2]+1) < 150
							or coli(h[1][1]-h[2][4],h[1][2]) >= 150 then
								if coli(h[1][1]+h[2][4],h[1][2]+1) < 150
								or coli(h[1][1]+h[2][4],h[1][2]) >= 150 then
									h[5] = 1
									h[6] = 1
									h[7] = 0
								else
									h[2][4] = -h[2][4]
								end
							end
						end
						h[6] = h[6]+.1
						if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
							h[6] = 1
							h[7] = 0
						end
						if objlist[h[3]].genre == "tire" then
							if math.abs(x-h[1][1]) < 10
							and math.abs(y-h[1][2]) < 2 then
								if objlist[h[3]].vue_limiter == false
								or (x-h[1][1])*h[2][4] < 0 then
									h[5] = 2
									h[6] = 1
									h[7] = 0
								end
							end
						elseif objlist[h[3]].genre == "toucher" then
							if h.timer < crono then
								dist = math.sqrt((x-h[1][1])^2+10*(y-h[1][2]-.25)^2)
								if dist < 1 then
									santer = math.max(0,santer-objlist[h[3]].domage)
									if santer == 0 then
										mort()
									else
										tempohit = crono+.5
										love.audio.stop(how)
										love.audio.play(how)
										n = -.18
										m = .24*(x-h[1][1])/math.abs(x-h[1][1])
									end
									h.timer = crono+1
								end
							end
						end
						cartog[math.max(1,math.min(table.maxn(cartog),math.floor(h[1][1])))][math.max(1,math.min(table.maxn(cartog[1]),math.floor(h[1][2])))] = i
					end
					if h[5] ~= 3
					and h[5] ~= 4 then
						h[2][4] = -(x-h[1][1]+.001)/math.abs(x-h[1][1]+.001)
					end
					if coli(h[1][1],h[1][2]-1) > 150 then
						h[2][2] = math.max(0,h[2][2])
					end
				elseif objlist[h[3]][2] == 4 then--tourelle
					if h[5] == 3 then
						h[6] = h[6]+.1
						if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
							table.remove(obj,i)
						end
					else
						if coli(h[1][1],h[1][2]+1) >= 150 then
							h[2][2] = 0
							h[1][2] = math.floor(h[1][2])
						else
							h[2][2] = h[2][2]+.01
						end
						h[2][4] = -(x-h[1][1]+.001)/math.abs(x-h[1][1]+.001)
						if h[1][1] < x+14
						and h[1][1] > x-14 then
							if math.abs(y-h[1][2]) < 2 then
								if h[5] == 1 then
									if h[6] <= table.maxn(sprite[objlist[h[3]][4][h[5]]])/2 then
										cartog[math.max(1,math.min(table.maxn(cartog),math.floor(h[1][1])))][math.max(1,math.min(table.maxn(cartog[1]),math.floor(h[1][2])))] = i
									end
									h[6] = math.min(h[6]+.2,table.maxn(sprite[objlist[h[3]][4][h[5]]])+.5)
									if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]]) then
										if crono > h[8] then
											h[5] = 2
											h[6] = 1
											h[7] = 0
											h[8] = crono+objlist[h[3]][6]
										end
									end
								elseif h[5] == 2 then
									if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])/2 then
										cartog[math.max(1,math.min(table.maxn(cartog),math.floor(h[1][1])))][math.max(1,math.min(table.maxn(cartog[1]),math.floor(h[1][2])))] = i
									end
									h[6] = h[6]+.2
									if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
										tire(h[1][1],h[1][2]+1,math.atan(.2*(y-h[1][2])/math.abs(x-h[1][1])),-h[2][4],false,1)
										h[5] = 1
										h[6] = 1
										h[7] = 0
									end
								end
							else
								h[5] = 1
								h[6] = math.min(h[6]+.2,table.maxn(sprite[objlist[h[3]][4][h[5]]])+.5)
							end
						end
					end
				elseif objlist[h[3]][2] == 5 then--seecknbash
					if h[5] == 1 then
						if coli(h[1][1],h[1][2]+1) >= 150 then
							h[2][2] = 0
							h[1][2] = math.floor(h[1][2])
						else
							h[2][2] = h[2][2]+.01
						end
						if math.abs(x-h[1][1]) < 10 then
							h[5] = 2
							h[6] = 1
							h[7] = 0
							h[2][2] = -.18
							h[2][1] = .05
						end
						cartog[math.max(1,math.min(table.maxn(cartog),math.floor(h[1][1])))][math.max(1,math.min(table.maxn(cartog[1]),math.floor(h[1][2])))] = i
					elseif h[5] == 2 then

						h[2][2] = h[2][2]+.005
						if h[2][2] > 0 then
							h[5] = 3
							h[6] = 1
							h[7] = 0
						end
						h[8] = h[8]+.02
						h[2][3] = .25*math.sin(h[8])
						if coli(h[1][1],h[1][2]+.5) >= 150 then
							h[5] = 4
							h[6] = 1
							h[7] = 0
							h[2][1] = 0
							h[2][2] = 0
						end
						h[6] = math.min(h[6]+.2,table.maxn(sprite[objlist[h[3]][4][h[5]]]))
						cartog[math.max(1,math.min(table.maxn(cartog),math.floor(h[1][1])))][math.max(1,math.min(table.maxn(cartog[1]),math.floor(h[1][2])))] = i
					elseif h[5] == 3 then
						dist = math.sqrt((x-h[1][1])^2+(y-h[1][2])^2)
						h[2][1] = .9*h[2][1]+.02*(x-h[1][1])/dist
						h[2][2] = .9*h[2][2]+.02*(y-h[1][2])/dist-.003
						h[8] = h[8]+.07
						if objlist[h[3]].rot_tipe == "sin" then
							h[2][3] = .3*math.sin(h[8])
						elseif objlist[h[3]].rot_tipe == "pointe" then
							h[2][3] = h[2][3]+rotation_fluide(h[2][3],math.atan((y-h[1][2])/(x-h[1][1])),.1)
							h[2][4] = -(x-h[1][1]+.001)/math.abs(x-h[1][1]+.001)
						end
						if dist < 1 then
							santer = math.max(0,santer-objlist[h[3]].domage)
							if santer == 0 then
								mort()
							else
								tempohit = crono+.5
								love.audio.stop(how)
								love.audio.play(how)
								n = -.18
								m = .24*(x-h[1][1])/math.abs(x-h[1][1])
							end
							h[5] = 4
							h[6] = 1
							h[7] = 0
							h[2][1] = 0
							h[2][2] = 0
						end
						if coli(h[1][1],h[1][2]+.5) >= 150 then
							h[5] = 4
							h[6] = 1
							h[7] = 0
							h[2][1] = 0
							h[2][2] = 0
						end
						h[6] = 	h[6]+.2
						if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
							h[6] = 1
							h[7] = 0
						end
						cartog[math.max(1,math.min(table.maxn(cartog),math.floor(h[1][1])))][math.max(1,math.min(table.maxn(cartog[1]),math.floor(h[1][2])))] = i
					elseif h[5] == 4 then
						h[6] = h[6]+.1
						if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
							table.remove(obj,i)
						end
					end
				elseif objlist[h[3]][2] == 6 then--point
					if h[5] == 1 then
						dist = math.sqrt((x-h[1][1])^2+(y-h[1][2])^2)
						if dist < 1 then
							h[5] = 2
							if objlist[h[3]].genre == "point" then
								point = point+objlist[h[3]][6]
							else
								missilist[objlist[h[3]].genre].munition = missilist[objlist[h[3]].genre].munition+objlist[h[3]][6]
							end
						end
						h[6] = 	h[6]+.2
						if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
							h[6] = 1
							h[7] = 0
						end
					elseif h[5] == 2 then
						h[6] = h[6]+.2
						if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
							table.remove(obj,i)
						end
					end
				elseif objlist[h[3]][2] == 7 then--up
					if h[5] == 1 then
						dist = math.sqrt((x-h[1][1])^2+(y-h[1][2])^2)
						if dist < 1 then
							h[5] = 2
							vie = vie+objlist[h[3]][6]
							santer = 3
						end
						h[6] = 	h[6]+.2
						if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
							h[6] = 1
							h[7] = 0
						end
					elseif h[5] == 2 then
						h[6] = h[6]+.2
						if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
							table.remove(obj,i)
						end
					end
				elseif objlist[h[3]][2] == 8 then--around turner
					h[6] = h[6]+.1
					if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
						h[6] = 1
						h[7] = 0
					end
					if h.timer < crono then
						dist = math.sqrt((x-h[1][1])^2+(y-h[1][2])^2)
						if dist < 1 then
							santer = math.max(0,santer-objlist[h[3]].domage)
							if santer == 0 then
								mort()
							else
								tempohit = crono+.5
								love.audio.stop(how)
								love.audio.play(how)
								n = -.18
								m = .24*(x-h[1][1])/math.abs(x-h[1][1])
							end
							h.timer = crono+1
						end
					end
					h[2][1] = -math.cos(h[2][3])*objlist[h[3]][6]
					h[2][2] = -math.sin(h[2][3])*objlist[h[3]][6]
					if  coli(h[1][1]+math.cos(h[2][3]+.5*math.pi)+.5*math.cos(h[2][3]),h[1][2]+math.sin(h[2][3]+.5*math.pi)+.5*math.sin(h[2][3])) < 150
					and coli(h[1][1]+math.cos(h[2][3]+.5*math.pi),h[1][2]+math.sin(h[2][3]+.5*math.pi)) < 150 then
						h[1][1] = math.floor(h[1][1]-2*h[2][1]-.5*math.cos(h[2][3]))+.5
						h[1][2] = math.floor(h[1][2]-2*h[2][2]-.5*math.sin(h[2][3]))+.5
						h[2][3] = h[2][3]-.5*math.pi
						h[1][1] = h[1][1]-math.cos(h[2][3])+.30*math.cos(h[2][3]-math.pi/2)
						h[1][2] = h[1][2]-math.sin(h[2][3])+.3*math.sin(h[2][3]-math.pi/2)
					end
					if coli(h[1][1],h[1][2]) >= 150 then
						h[2][3] = h[2][3]-.5*math.pi
					end
				elseif objlist[h[3]][2] == 9 then--plateforme
					if math.abs(h[1][1]-(x+1)) < 1
					and math.abs(h[1][2]-(y)) < .5 then
						--x = x+h[2][1]
						m = math.min(h[2][1],m)
					end
					if math.abs(h[1][1]-(x-1)) < 1
					and math.abs(h[1][2]-(y)) < .5 then
						--x = x+h[2][1]
						m = math.max(h[2][1],m)
					end
					if math.abs(h[1][1]-(x)) < 1
					and math.abs(h[1][2]-(y+1)) < .5 then
						x = x+h[2][1]
						m = .75*m+depl_m
						y = h[1][2]-1.499
						n = math.max(h[2][2],0)
						if depl_n ~= 0 then
							n = depl_n
							if depl_n ~= 0 then
								love.audio.stop(sonsaute)
								love.audio.play(sonsaute)
							end
						end
					end
					if math.abs(h[1][1]-(x)) < 1
					and math.abs(h[1][2]-(y-1)) < .5 then
						n = math.max(h[2][2],n)
					end
					h[6] = h[6]+.1
					if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
						h[6] = 1
						h[7] = 0
					end
				elseif objlist[h[3]][2] == 10 then--jumper
					if h[5] == 1 then
						h[6] = h[6]+.1
						if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
							h[6] = 1
							h[7] = 0
						end
						if math.abs(h[1][1]-(x)) < .5
						and math.abs(h[1][2]-(y)) < .5 then
							h[5] = 2
							h[6] = 1
							h[7] = 0
							n = -objlist[h[3]][7]*math.sin(objlist[h[3]][6]/180*math.pi)
							m = objlist[h[3]][7]*math.cos(objlist[h[3]][6]/180*math.pi)
						end
					elseif h[5] == 2 then
						h[6] = h[6]+.1
						if h[6] >= table.maxn(sprite[objlist[h[3]][4][h[5]]])+1 then
							h[5] = 1
							h[6] = 1
							h[7] = 0
						end
					end
				end
				if h[1][2] > carter:getHeight() then
					table.remove(obj,i)
				end
			else
				if objlist[h[3]][2] == 8 then--around turner
					h[1][1] = h[1][1]+h[2][1]
					h[1][2] = h[1][2]+h[2][2]
					h[2][1] = -math.cos(h[2][3])*objlist[h[3]][6]
					h[2][2] = -math.sin(h[2][3])*objlist[h[3]][6]
					if  coli(h[1][1]+math.cos(h[2][3]+.5*math.pi)+.5*math.cos(h[2][3]),h[1][2]+math.sin(h[2][3]+.5*math.pi)+.5*math.sin(h[2][3])) < 150
					and coli(h[1][1]+math.cos(h[2][3]+.5*math.pi),h[1][2]+math.sin(h[2][3]+.5*math.pi)) < 150 then
						h[1][1] = math.floor(h[1][1]-2*h[2][1]-.5*math.cos(h[2][3]))+.5
						h[1][2] = math.floor(h[1][2]-2*h[2][2]-.5*math.sin(h[2][3]))+.5
						h[2][3] = h[2][3]-.5*math.pi
						h[1][1] = h[1][1]-math.cos(h[2][3])+.30*math.cos(h[2][3]-math.pi/2)
						h[1][2] = h[1][2]-math.sin(h[2][3])+.3*math.sin(h[2][3]-math.pi/2)
					end
					if coli(h[1][1],h[1][2]) >= 150 then
						h[2][3] = h[2][3]-.5*math.pi
					end
				elseif objlist[h[3]][2] == 3 then--ia











					if coli(h[1][1],h[1][2]+1) >= 150 then
						h[2][2] = 0
						h[1][2] = math.floor(h[1][2])
					else
						h[2][2] = h[2][2]+.01
					end
					if h[5] == 4 then
						if coli(h[1][1],h[1][2]+1) >= 150 then
							h[1][1] = h[1][1]-h[2][4]*objlist[h[3]].patrouille.speed
							if coli(h[1][1]-h[2][4],h[1][2]+1) < 150
							or coli(h[1][1]-h[2][4],h[1][2]) >= 150 then
								if coli(h[1][1]+h[2][4],h[1][2]+1) < 150
								or coli(h[1][1]+h[2][4],h[1][2]) >= 150 then
									h[5] = 1
									h[6] = 1
									h[7] = 0
								else
									h[2][4] = -h[2][4]
								end
							end
						end
					end
					if h[5] ~= 3
					and h[5] ~= 4 then
						h[2][4] = -(x-h[1][1]+.001)/math.abs(x-h[1][1]+.001)
					end
					if coli(h[1][1],h[1][2]-1) > 150 then
						h[2][2] = math.max(0,h[2][2])
					end








				elseif objlist[h[3]][2] == 9 then--plateforme
					h[1][1] = h[1][1]+h[2][1]
					h[1][2] = h[1][2]+h[2][2]
				end
			end
			if objlist[h[3]][2] == 9 then--plateforme
				if coliv(h[1][1]+h[2][1]/math.max(1.000000,math.abs(h[2][1])),h[1][2]-1) ~= objlist[h[3]][1] then
					h[2][1] = -h[2][1]
					if coliv(h[1][1],h[1][2]) == objlist[h[3]][1] then
						h[2][2] = objlist[h[3]][6]
						h[2][1] = 0
					elseif coliv(h[1][1],h[1][2]-2) == objlist[h[3]][1] then
						h[2][2] = -objlist[h[3]][6]
						h[2][1] = 0
					end
				end
				if coliv(h[1][1],h[1][2]+h[2][2]-1/math.max(1.000000,math.abs(h[2][2]))) ~= objlist[h[3]][1] then
					h[2][2] = -h[2][2]
					if coliv(h[1][1]+1,h[1][2]-1) == objlist[h[3]][1] then
						h[2][1] = objlist[h[3]][6]
						h[2][2] = 0
					elseif coliv(h[1][1]-1,h[1][2]-1) == objlist[h[3]][1] then
						h[2][1] = -objlist[h[3]][6]
						h[2][2] = 0
					end
				end

			elseif objlist[h[3]][2] == "custom" then
				objlist[h[3]].update(objlist[h[3]],h,i,dot)
			end
		end
	end
	if menu == menu_play then
		for i,h in ipairs(missi) do
			if h[1][1] < x+20
			and h[1][1] > x-20 then


				if math.floor(h[5]) ~= h[6] then
					if sprite[missilist[h[4]][3]][math.floor(h[5])][2] ~= 0
					and sprite[missilist[h[4]][3]][math.floor(h[5])][3] < crono then
						love.audio.stop(sprite[missilist[h[4]][3]][math.floor(h[5])][2])
						love.audio.play(sprite[missilist[h[4]][3]][math.floor(h[5])][2])
						sprite[missilist[h[4]][3]][math.floor(h[5])][3] = crono+.1
					end
				end
				h[6] = math.floor(h[5])
				if h[5] <= table.maxn(sprite[missilist[h[4]][3]])/2 then



					if missilist[h[4]].partic1 ~= nil then
						if h.Tpartic < crono then
							num = 1
							while num <= missilist[h[4]].partic1.number do
								particule(missilist[h[4]].partic1,h[1][1],h[1][2]-.5,h[2][1],h[2][2],h[2][3])
								h.Tpartic = crono+missilist[h[4]].partic1.delais
								num = num+1
							end

						end
					end

					h[1][1] = h[1][1]+h[2][1]
					h[1][2] = h[1][2]+h[2][2]
					h[2][3] = h[2][3]+missilist[h[4]][8]*h[2][1]/math.abs(h[2][1])
					h[5] = h[5]+.1
					if h[5] >= table.maxn(sprite[missilist[h[4]][3]])/2 then
						h[5] = 1
					end
					if crono > h[7] then
						h[5] = table.maxn(sprite[missilist[h[4]][3]])/2+1
					end
					if coli(h[1][1],h[1][2]-.5) >= 150 then
						h[5] = table.maxn(sprite[missilist[h[4]][3]])/2+1
					end
					if h[3] == true then

						wx = -math.max(1.6*missilist[h[4]][7])
						while wx <= math.max(1.6*missilist[h[4]][7]) do
							wy = -math.max(1,1.6*missilist[h[4]][7])
							while wy <= math.max(1.6*missilist[h[4]][7]) do
								local qex = math.max(1,math.min(table.maxn(cartog),math.floor(h[1][1]+wx)))
								local qey = math.max(1,math.min(table.maxn(cartog[1]),math.floor(h[1][2]+wy)))
								if cartog[qex][qey] ~= 0
								and obj[cartog[qex][qey]] ~= nil then
									dist = math.sqrt((obj[cartog[qex][qey]][1][1]-h[1][1])^2+(obj[cartog[qex][qey]][1][2]-h[1][2]+.5)^2)
									if dist < missilist[h[4]][7] then

										wx = 10000
										wy = 10000
										h[8] = h[8]-1
										if h[8] == 0 then
											h[5] = 2
											h[6] = 1
											h[7] = 0
										end
										if objlist[obj[cartog[qex][qey]][3]][2] == 1 then
											obj[cartog[qex][qey]][5] = 2
											obj[cartog[qex][qey]][6] = 1
											obj[cartog[qex][qey]][7] = 0
										elseif objlist[obj[cartog[qex][qey]][3]][2] == 3 then
											obj[cartog[qex][qey]][5] = 3
											obj[cartog[qex][qey]][6] = 1
											obj[cartog[qex][qey]][7] = 0
										elseif objlist[obj[cartog[qex][qey]][3]][2] == 4 then
											obj[cartog[qex][qey]][5] = 3
											obj[cartog[qex][qey]][6] = 1
											obj[cartog[qex][qey]][7] = 0
										elseif objlist[obj[cartog[qex][qey]][3]][2] == 5 then
											obj[cartog[qex][qey]][5] = 4
											obj[cartog[qex][qey]][6] = 1
											obj[cartog[qex][qey]][7] = 0
										elseif objlist[obj[cartog[qex][qey]][3]][2] == "custom" then
											objlist[obj[cartog[qex][qey]][3]].toucher(h,obj[cartog[qex][qey]])
										end
										cartog[qex][qey] = 0
									end
								end
								wy = wy+1
							end
							wx = wx+1
						end
					elseif tempohit < crono then




						dist = math.sqrt((x-h[1][1])^2+(y-h[1][2])^2)
						if dist < missilist[h[4]][7] then
							h[5] = 2
							h[6] = 1
							h[7] = 0
							santer = math.max(0,santer-missilist[h[4]][2])
							if santer == 0 then
								mort()
							else
								tempohit = crono+.5
								love.audio.stop(how)
								love.audio.play(how)
								n = -.18
								m = .24*(x-h[1][1])/math.abs(x-h[1][1])
							end
						end
					end
				else
					if missilist[h[4]].partic2 ~= nil then
						if h.Tpartic < crono then
							num = 1
							while num <= missilist[h[4]].partic2.number do
								particule(missilist[h[4]].partic2,h[1][1],h[1][2]-.5,h[2][1],h[2][2],h[2][3])
								h.Tpartic = crono+missilist[h[4]].partic2.delais
								num = num+1
							end

						end
					end





					h[5] = h[5]+.1
					if h[5] >= table.maxn(sprite[missilist[h[4]][3]])+1 then
						table.remove(missi,i)
					end
				end
			else
				table.remove(missi,i)
			end
		end

		if sprite[numspr] ~= nil
		and sprite[numspr][math.floor(frame)] ~= nil then
			if math.floor(lastframe) ~= math.floor(frame) then

				if sprite[numspr][math.floor(frame)][2] ~= 0
				and sprite[numspr][math.floor(frame)][3] < crono then
					love.audio.stop(sprite[numspr][math.floor(frame)][2])
					love.audio.play(sprite[numspr][math.floor(frame)][2])
					sprite[numspr][math.floor(frame)][3] = crono+.1
				end
			end
		end
		for i,h in ipairs(effet) do
			if h.T > crono
			and h.alpha > 0 then
				h.alpha = h.alpha+h.tipe.alphaplus
				h.A = h.A+h.tipe.rot
				h.S = h.S+h.tipe.Splus
				h.m = h.tipe.frix*h.m
				h.n = h.tipe.frix*h.n
				h.X = h.X+h.m
				h.Y = h.Y+h.n
				h.frame = math.min(h.frame+.2,table.maxn(sprite[h.tipe.image]))



				h.lastframe = math.floor(h.frame)
			else
				table.remove(effet,i)
			end
		end

		M.update(dot)
		fps = fps+.01*(1/dot-fps)
		lastframe = frame
		crono = crono+dot
	end
end
function I.draw(I)
	love.graphics.setColor(255,255,255)
		arri:clear( )
	love.graphics.setCanvas( arri)

		wx = -love.graphics.getWidth()/(50*zoom)/2
		while wx <= love.graphics.getWidth()/(50*zoom)/2+1 do
			wy = -love.graphics.getHeight()/(50*zoom)/2
			while wy < love.graphics.getHeight()/(50*zoom)/2+1 do

				if carto[math.floor(wx+cam_x)] ~= nil
				and carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)] ~= nil
				and carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)] ~= 0 then
					if carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][4] < 100 then
						love.graphics.draw( sprite[carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][1]][math.floor(checlist[carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][2]][3])][1] , (math.floor(cam_x+wx)-cam_x+.5)*zoom*50+love.graphics.getWidth()/2,(math.floor(cam_y+wy)-cam_y+.5)*zoom*50+love.graphics.getHeight()/2,0,-5*zoom,5*zoom,5,5)
					end
				end
				wy = wy+1
			end
			wx = wx+1
		end
		echel:clear( )
	love.graphics.setCanvas( echel)

		wx = -love.graphics.getWidth()/(50*zoom)/2
		while wx <= love.graphics.getWidth()/(50*zoom)/2+1 do
			wy = -love.graphics.getHeight()/(50*zoom)/2
			while wy < love.graphics.getHeight()/(50*zoom)/2+1 do

				if carto[math.floor(wx+cam_x)] ~= nil
				and carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)] ~= nil
				and carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)] ~= 0 then
					if carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][4] >= 100
					and carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][4] < 150 then
						love.graphics.draw( sprite[carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][1]][math.floor(checlist[carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][2]][3])][1] , (math.floor(cam_x+wx)-cam_x+.5)*zoom*50+love.graphics.getWidth()/2,(math.floor(cam_y+wy)-cam_y+.5)*zoom*50+love.graphics.getHeight()/2,0,-5*zoom,5*zoom,5,5)
					end
				end
				wy = wy+1
			end
			wx = wx+1
		end




		ava:clear( )
	love.graphics.setCanvas( ava)

		love.graphics.setColor(M.rouge,M.vert,M.bleu)
		wx = -love.graphics.getWidth()/(50*zoom)/2
		while wx <= love.graphics.getWidth()/(50*zoom)/2+1 do
			wy = -love.graphics.getHeight()/(50*zoom)/2
			while wy < love.graphics.getHeight()/(50*zoom)/2+1 do

				if carto[math.floor(wx+cam_x)] ~= nil
				and carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)] ~= nil
				and carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)] ~= 0 then
					if carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][4] >= 150 then
						love.graphics.draw( sprite[carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][1]][math.floor(checlist[carto[math.floor(wx+cam_x)][math.floor(wy+cam_y)][2]][3])][1] , (math.floor(cam_x+wx)-cam_x+.5)*zoom*50+love.graphics.getWidth()/2,(math.floor(cam_y+wy)-cam_y+.5)*zoom*50+love.graphics.getHeight()/2,0,-5*zoom,5*zoom,5,5)
					end
				end
				wy = wy+1
			end
			wx = wx+1
		end
		love.graphics.setColor(255,255,255,255-255*math.max(2*(tempohit-crono),0))
		--if tempohit < crono
		if visi == true then
			if math.sin(crono*50)-math.min(2*(tempohit-crono),1) > 0 then
				love.graphics.draw( sprite[numspr][math.floor(frame)][1] , (x-cam_x)*zoom*50+love.graphics.getWidth()/2,(y-cam_y-.5)*zoom*50+love.graphics.getHeight()/2,ang,-5*zoom*sens,5*zoom,sprite[numspr][math.floor(frame)][1]:getWidth()/2,sprite[numspr][math.floor(frame)][1]:getHeight()/2)
			end
		end
		love.graphics.setColor(255,255,255)
		for i,h in ipairs(obj) do
			if math.abs(h[1][1]-cam_x) < 18 then
				love.graphics.draw( sprite[objlist[h[3]][4][h[5]]][math.floor(h[6])][1] , (h[1][1]-cam_x)*zoom*50+love.graphics.getWidth()/2,(h[1][2]-cam_y)*zoom*50+love.graphics.getHeight()/2,h[2][3],5*zoom*h[2][4],5*zoom,10,10)
			end
			if objlist[h[3]][2] == "custom" then
				objlist[h[3]].draw(objlist[h[3]],h)
			end
		end


		for i,h in ipairs(missi) do
			if math.abs(h[1][1]-cam_x) < 18 then
				love.graphics.draw( sprite[missilist[h[4]][3]][math.floor(h[5])][1] , (h[1][1]-cam_x)*zoom*50+love.graphics.getWidth()/2,(h[1][2]-cam_y-.5)*zoom*50+love.graphics.getHeight()/2,h[2][3],5*zoom*h[2][1]/math.abs(h[2][1]),5*zoom,sprite[missilist[h[4]][3]][math.floor(h[5])][1]:getWidth()/2,sprite[missilist[h[4]][3]][math.floor(h[5])][1]:getHeight()/2)
			end
		end
		for i,h in ipairs(checpoint) do
			love.graphics.print( i ,(h[1]-cam_x)*zoom*50+love.graphics.getWidth()/2,(h[2]-cam_y-.5)*zoom*50+love.graphics.getHeight()/2)
		end
		arriere:clear( )
	love.graphics.setCanvas( arriere)

		love.graphics.setColor(255,255,255)
		love.graphics.draw( arri , 0 , 0 )
		love.graphics.setBlendMode( "multiplicative" )
		love.graphics.setColor(0,0,0,30)
		love.graphics.draw( ava , 0 , 0 )
		--love.graphics.setColor(255,255,255)
		if option.effect > 50 then
			love.graphics.draw( ava , 20+3 , 15+0 )
			love.graphics.draw( ava , 20+2 , 15+2 )
			love.graphics.draw( ava , 20+0 , 15+3 )
			love.graphics.draw( ava , 20-2 , 15+2 )
			love.graphics.draw( ava , 20-3 , 15+0 )
			love.graphics.draw( ava , 20-2 , 15-2 )
			love.graphics.draw( ava , 20+0 , 15-3 )
			love.graphics.draw( ava , 20+2 , 15-2 )

			love.graphics.draw( echel , 10+3 , 7+0 )
			love.graphics.draw( echel , 10+2 , 7+2 )
			love.graphics.draw( echel , 10+0 , 7+3 )
			love.graphics.draw( echel , 10-2 , 7+2 )
			love.graphics.draw( echel , 10-3 , 7+0 )
			love.graphics.draw( echel , 10-2 , 7-2 )
			love.graphics.draw( echel , 10+0 , 7-3 )
			love.graphics.draw( echel , 10+2 , 7-2 )
		end
		love.graphics.setBlendMode( "alpha" )

	echelle:clear( )
	love.graphics.setCanvas( echelle)


		love.graphics.setColor(255,255,255)
		love.graphics.draw( echel , 0 , 0 )
		love.graphics.setBlendMode( "multiplicative" )
		love.graphics.setColor(0,0,0,30)
		love.graphics.draw( ava , 0 , 0 )
		if option.effect > 50 then
			--love.graphics.setColor(255,255,255)
			love.graphics.draw( ava , 10+3 , 7+0 )
			love.graphics.draw( ava , 10+2 , 7+2 )
			love.graphics.draw( ava , 10+0 , 7+3 )
			love.graphics.draw( ava , 10-2 , 7+2 )
			love.graphics.draw( ava , 10-3 , 7+0 )
			love.graphics.draw( ava , 10-2 , 7-2 )
			love.graphics.draw( ava , 10+0 , 7-3 )
			love.graphics.draw( ava , 10+2 , 7-2 )

		end

	love.graphics.setBlendMode( "alpha" )avant:clear( )
	love.graphics.setCanvas( avant)

		love.graphics.setColor(255,255,255)
		love.graphics.draw( ava , 0 , 0 )


		interface:clear( )
	love.graphics.setCanvas( interface)



		love.graphics.setColor(255,255,255)
		M.draw()

		love.graphics.draw( sprite[11][math.max(1,math.min(4,4-santer))][1] , 0 ,0,0,5)
		love.graphics.setFont( chifre_X )
		love.graphics.print( "x"..vie.."", 100 , 35 )
		love.graphics.setFont( letre_X )
		love.graphics.print( "score" , 20 , 80 )
		love.graphics.print( ""..missilist[arme].nom.."" , 20 , 130 )
		love.graphics.setFont( chifre_X )
		love.graphics.print( ""..point.."" , 200 , 80 )
		love.graphics.print( "x "..missilist[arme].munition.."" , 300 , 130 )
		love.graphics.setFont( chifre )
		love.graphics.print( math.floor(fps*100)/100 , love.graphics.getWidth()-100 , 30 )

	love.graphics.setCanvas( )

		if fon ~= nil then
			love.graphics.draw( fon , 0,0,0,love.graphics.getWidth()/fon:getWidth(),love.graphics.getHeight()/fon:getHeight())
		end
		love.graphics.setColor(0,0,0,200)

		if option.effect > 50 then
			love.graphics.draw( arriere , 2 , 0 )

			love.graphics.draw( arriere , 1 , 1 )
			love.graphics.draw( arriere , 0 , 2 )
			love.graphics.draw( arriere , -1 , 1 )
			love.graphics.draw( arriere , -2 , 0 )
			love.graphics.draw( arriere , -1 , -1 )
			love.graphics.draw( arriere , 0 , -2 )
			love.graphics.draw( arriere , 1 , -1 )
		end
		love.graphics.setColor(255,255,255)
		love.graphics.draw( arriere , 0 , 0 )




		love.graphics.setColor(0,0,0,200)
		if option.effect > 50 then
			love.graphics.draw( echelle , 2 , 0 )
			love.graphics.draw( echelle , 1 , 1 )
			love.graphics.draw( echelle , 0 , 2 )
			love.graphics.draw( echelle , -1 , 1 )
			love.graphics.draw( echelle , -2 , 0 )
			love.graphics.draw( echelle , -1 , -1 )
			love.graphics.draw( echelle , 0 , -2 )
			love.graphics.draw( echelle , 1 , -1 )
		end
		love.graphics.setColor(255,255,255)
		love.graphics.draw( echelle , 0 , 0 )



		love.graphics.setColor(0,0,0,200)
		if option.effect > 50 then
			love.graphics.draw( avant , 2 , 0 )
			love.graphics.draw( avant , 1 , 1 )
			love.graphics.draw( avant , 0 , 2 )
			love.graphics.draw( avant , -1 , 1 )
			love.graphics.draw( avant , -2 , 0 )
			love.graphics.draw( avant , -1 , -1 )
			love.graphics.draw( avant , 0 , -2 )
			love.graphics.draw( avant , 1 , -1 )
		end
		love.graphics.setColor(255,255,255)
		love.graphics.draw( avant , 0 , 0 )
		for i,h in ipairs(effet) do
			love.graphics.setColor(255,255,255,h.alpha)
			love.graphics.draw( sprite[h.tipe.image][math.floor(h.frame)][1] , (h.X-cam_x)*zoom*50+love.graphics.getWidth()/2,(h.Y-cam_y)*zoom*50+love.graphics.getHeight()/2,h.A,5*zoom*h.S,5*zoom*h.S,sprite[h.tipe.image][math.floor(h.frame)][1]:getWidth()/2,sprite[h.tipe.image][math.floor(h.frame)][1]:getHeight()/2)
		end

		love.graphics.setColor(255,255,255)

		love.graphics.draw( grille , 0,0,0,love.graphics.getWidth()/grille:getWidth(),love.graphics.getHeight()/grille:getHeight())
		love.graphics.setColor(0,0,0,200)
		if option.effect > 50 then
			love.graphics.draw( interface , 2 , 0 )
			love.graphics.draw( interface , 1 , 1 )
			love.graphics.draw( interface , 0 , 2 )
			love.graphics.draw( interface , -1 , 1 )
			love.graphics.draw( interface , -2 , 0 )
			love.graphics.draw( interface , -1 , -1 )
			love.graphics.draw( interface , 0 , -2 )
			love.graphics.draw( interface , 1 , -1 )
		end
		love.graphics.setColor(255,255,255)
		love.graphics.draw( interface , 0 , 0 )


	--love.graphics.setBlendMode( "additive" )

	--love.graphics.setBlendMode( "alpha" )

end
