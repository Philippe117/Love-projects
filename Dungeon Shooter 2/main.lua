function love.load()
	---------------carte--------------
	mape = love.image.newImageData( "app/carte/1/carte.tga" )
	maper = {}
	maper[1] = love.graphics.newImage( "app/carte/1/carti.png" )
	maper[2] = love.graphics.newImage( "app/carte/1/carti2.png" )
	maper[3] = love.graphics.newImage( "app/carte/1/carti3.png" )
	maper[4] = love.graphics.newImage( "app/carte/1/carti4.png" )
	maper[5] = love.graphics.newImage( "app/carte/1/carti5.png" )
	maper[6] = love.graphics.newImage( "app/carte/1/carti6.png" )
	noirceur = 0
	--rouge = altitude
	--vert = 
	--bleu = 
	----------------------------------
 
	moux = 0
	mouy = 0
	mouz = 0
	feu = {}
	feu[1] = love.graphics.newImage( "app/effect/flame1/1.tga" )
	feu[2] = love.graphics.newImage( "app/effect/flame1/2.tga" )
	feu[3] = love.graphics.newImage( "app/effect/flame1/3.tga" )
	feu[4] = love.graphics.newImage( "app/effect/flame1/4.tga" )
	idjoueur = 1
	mapr = {}
	mapr[1] = 1
	mapr[2] = 1
	mapr[3] = 1
	mapr[4] = 1
	mapr[5] = 1
	mapr[6] = 1
	eludraw = 1
	drawlist = {}
	drawlist[1] = {{},{},{},{},{}}
	drawlist[2] = {{},{},{},{},{}}
	drawlist[3] = {{},{},{},{},{}}
	drawlist[4] = {{},{},{},{},{}}
	drawlist[5] = {{},{},{},{},{}}
	drawlist[6] = {{},{},{},{},{}}
	--drawlist[x] = { 1 unit ,2 projectile ,3 effets ,4 effetl}
ligth = love.graphics.newCanvas( )
	DSW = math.atan2(0,1)
	hau = "w"
	bas = "s"
	gau = "a"
	dro = "d"
	rec = "r"
	penc = "lctrl"
	sprint = "lshift"
	saut = " "
	lamp = "f"
	changep = "wd"
	changem = "wu"
	ombhaut = love.graphics.newImage( "app/set/ombre/torce.tga" )
	obscur = love.graphics.newImage( "obscur1.tga" )
	casquelist = {}
	casquelist[1] = {1,{31,28},1,1,1}
	--casquelist[0] = {1 armure ,2 centre{x,y} ,3 poid ,4 app ,5 furtivite}
	epaulelist = {}
	epaulelist[1] = {1,{38,49},1,1,1}
	--epaulelist[0] = {1 armure ,2 centre{x,y} ,3 poid ,4 app ,5 furtivite}
	torcelist = {}
	torcelist[1] = {1,0,1,1,1}
	--torcelist[0] = {1 armure ,2  ,3 poid ,4 app ,5 furtivite}
	jambelist = {}
	jambelist[1] = {1,{86,60},1,1,1,1}
	--jambelist[0] = {1 armure ,2 centre{x,y} ,3 poid ,4 {app} ,5 furtivite}
	lampelist = {}
	lampelist[1] = {400,love.graphics.newImage( "obscur1.tga" ),1,1,1,1}
	--lampelist[0] = {1 railon de visi ,2 app ,3  ,4  ,5 }
	for i,h in ipairs(casquelist) do
		h[4] = love.graphics.newImage( "app/set/set "..h[4].."/casque.tga" )
	end
	for i,h in ipairs(epaulelist) do
		h[4] = love.graphics.newImage( "app/set/set "..h[4].."/epaule.tga" )
	end
	for i,h in ipairs(torcelist) do
		h[4] = {love.graphics.newImage( "app/set/set "..h[4].."/torce.tga" ),love.graphics.newImage( "app/set/set "..h[4].."/bras.tga" )}
	end
	for i,h in ipairs(jambelist) do
		h[4] = {love.graphics.newImage( "app/set/set "..h[4].."/pied.tga" ),love.graphics.newImage( "app/set/set "..h[4].."/jam1.tga" ),love.graphics.newImage( "app/set/set "..h[4].."/jam2.tga" )}
	end
	for i,h in ipairs(lampelist) do
		h[4] = {love.graphics.newImage( "app/set/set "..h[4].."/pied.tga" ),love.graphics.newImage( "app/set/set "..h[4].."/jam1.tga" ),love.graphics.newImage( "app/set/set "..h[4].."/jam2.tga" )}
	end
	preset = {}
	preset[1] = {normal,1,1,1,1,{1,2},"normal",1}
	--preset[0] = {1 nom ,2 casque ,3 epaule ,4 torce ,5 jambe ,6 {armes} ,7 nom,8 lampe}
	unitlist = {}
	unitlist[1] = { 100 ,1 ,8 ,1 ,"normal" }
	--unitlist[0] { 1 hp ,2 app ,3 speed ,4 regen/s ,5 nom }
	weplist = {}
	weplist[1] = {.1,2,.25,150,30,1,"mitraille",{".ogg",".ogg"},400,1,1,20,1,2,1,2,.5,{{30,0,-.2},{18,-1.2,-.5},{0,-.2,1.2}},.1,1}
	weplist[2] = {.8,16,.15,150,8,1,"mitraille",{".ogg",".ogg"},400,1,2,20,1,2,2,.5,.5,{{30,0,-.2},{18,-.8,-.2},{0,-.2,1.2}},4,5}
	--weplist[0] = {1 cadence,2 recul,3 stab,4 bruit,5 cap cargeur ,6 projectile ,7 nom ,8 {bruit1 , bruit2} ,9 range ,10 depratio ,11 app ,12 deportation,13,flash,14 chargeur depar,15 typ de recharge ,16 temp de recharge ,17 temp de changement ,18 pos{normal{di,ang,ang2},rech{di,ang,ang2},chang{di,ang,ang2}},19 précision,20 nb de proj}
	--typ de recharge 1=chargeur , 2=balle a balle
	for i,h in ipairs(weplist) do
		h[11] = love.graphics.newImage( "app/arme/arme"..h[11].."/app.tga" )
		h[13] = love.graphics.newImage( "app/arme/arme"..h[13].."/app.tga" )
	end
	missilist = {}
	missilist[1] = {{5,8},60,0,1,2,1}
	--missilist[1] {1 {damax,damin},2 speed ,3 poid ,4 app ,5 timer , 6 {appboomsang , appboompierre , appboommetal , appboombois , appboomelectric  }
	for i,h in ipairs(missilist) do
		h[4] = love.graphics.newImage( "app/projectile/missi"..h[4].."/app.tga" )
		h[6] = love.graphics.newImage( "app/projectile/missi"..h[6].."/boom.tga" )
	end
	wep = {}
	--wep[0] = { 1 {x,y,z} ,2 {m,n,direc,direcz} ,3 balle ,4 cargeur ,5 phase ,6 id du porteur ,7 typ ,8 retire }
	--phase  0=vide mort , 1=en main ,2 en inventaire
	missi = {}
	--missi = {1 {x,y,x2,y2,z} ,2 {m,n,direc,o} ,3 phase ,4 timer ,5 type ,6 team ,7 rebon ,8 distparcourue ,9 nextseek }
	--phase  0=explose  1=en vol  2=au sol ,
	unit = {}
	--unit = {1 {x,y,x2,y2,z,ex,ey,bx,by} ,2 {m,n,direct,o} ,3 {phaseglob , phasetete , phasejamb , etat jambe ,eta arme } ,4  ,5 type ,6 equip ,7 { hp , vhp } ,8 stamina ,9 id ,10 { directvise ,directvisejam ,direcarme,direcepaule,directorce, direcjambe,directete,visefusi ,visefusiz ,decalfusil} ,11 timertire , 12 timerecharge , 13 timereprend ,14 timerab ,15 {casque,epaule,torce,jambe,{armes,,,},armechoisi,lampe} ,16 frame{arme,pied gauche{x,y,x2,y2},pied droit{x,y,x2,y2},pas,pied} ,17 depratio,18 altsolaupied ,19 lampealu ,20 main{{x,y,x2,y2},{x,y,x2,y2}},21 fusil{dist,ang} }
	--phaseglob  0=mort  1=vivant  2=hord d'état 
	--phasetete  0=stand  1=tire  2=recharge  3=utilise obj
	--phasejamb  0=stand  1=cour  2=saute  3=
	--eta arme  0=normal  1=change arme 
	idmaker = 0
	ia = {}
	--ia[0] = { 1 slave i ,2 phase ,3 {target_i , lastsee_x , lastsee_y , lastsee_z } }
	--phase   1=stand  2=wander 3=follow 4=attack 5=search 6=surprisesed 7=supress 8=hide
	elu = 1
	imagu = love.graphics.newImage( "soleil.tga" )
	imago = love.graphics.newImage( "pointe2.tga" )
	effetlist = {}
	effetlist[1] = {0,0,0,0,0,0,0,0,love.graphics.newImage( "emprunte.tga" ),{0,0,0,-1}}
	--effetlist[0] = {1rm,2rn,3ro,4+m,5+n,6+o,7+sca,8+rot,9app,10{+r,+v,+b,+a},}
	effet = {}
	--effets = {1x,2y,3z,4m,5n,6o,7sca,8rot,9{r,v,b,a},10type}
	effetlists = {}
	effetlists[1] = {0,0,0,0,0,0,0,0,love.graphics.newImage( "emprunte.tga" ),{0,0,0,-1}}
	--effetlists[0] = {1rm,2rn,3ro,4+m,5+n,6+o,7+sca,8+rot,9app,10{+r,+v,+b,+a},}
	effets = {}
	--effets = {1x,2y,3z,4m,5n,6o,7sca,8rot,9{r,v,b,a},10type}
	effetlistl = {}
	effetlistl[1] = {0,0,0,0,0,0,0,0,love.graphics.newImage( "app/effect/flash1.tga" ),-.5}
	effetlistl[2] = {0,0,0,0,0,0,0,0,love.graphics.newImage( "app/effect/bloom.tga" ),-.8}
	--effetlistl[0] = {1rm,2rn,3ro,4+m,5+n,6+o,7+sca,8+rot,9app,10+a,}
	effetl = {}
	--effets = {1x,2y,3z,4m,5n,6o,7sca,8rot,9a,10type}
	crono = 0
	dot = 0
	fps = 60
	carto = {}
	local wx = 1
	while wx < mape:getWidth()/10+1 do
		local wy = 1
			carto[wx] = {}
		while wy < mape:getHeight()/10+1 do
			carto[wx][wy] = {}
			wy = wy+1
		end
		wx = wx+1
	end
	zoom = 1
	cam_x = love.graphics.getHeight()/2*zoom
	cam_y = love.graphics.getHeight()/2*zoom
	cam_z = 1000
	creation(400,600,0,1,1,1,0)
	creation(600,600,0,1,1,1,1)
	creation(400,700,0,1,1,1,3)
	creation(600,700,0,1,1,1,4)
	creation(1400,600,0,1,1,1,0)
	creation(1600,600,0,1,1,1,1)
	creation(1400,700,0,1,1,1,3)
	creation(1600,700,0,1,1,1,4)
	creation(2400,600,0,1,1,1,0)
	creation(2600,600,0,1,1,1,1)
	creation(2400,700,0,1,1,1,3)
	creation(2600,700,0,1,1,1,4)
	creation(3400,600,0,1,1,1,0)
	creation(3600,600,0,1,1,1,1)
	creation(3400,700,0,1,1,1,3)
	creation(3600,700,0,1,1,1,4)
	creation(4400,600,0,1,1,1,0)
	creation(4600,600,0,1,1,1,1)
	creation(4400,700,0,1,1,1,3)
	creation(4600,700,0,1,1,1,4)
	creation(400,1600,0,1,1,1,0)
	creation(600,1600,0,1,1,1,1)
	creation(400,1700,0,1,1,1,3)
	creation(600,1700,0,1,1,1,4)
	creation(1400,1600,0,1,1,1,0)
	creation(1600,1600,0,1,1,1,1)
	creation(1400,1700,0,1,1,1,3)
	creation(1600,1700,0,1,1,1,4)
	creation(2400,1600,0,1,1,1,0)
	creation(2600,1600,0,1,1,1,1)
	creation(2400,1700,0,1,1,1,3)
	creation(2600,1700,0,1,1,1,4)
	creation(3400,1600,0,1,1,1,0)
	creation(3600,1600,0,1,1,1,1)
	creation(3400,1700,0,1,1,1,3)
	creation(3600,1700,0,1,1,1,4)
	creation(4400,1600,0,1,1,1,0)
	creation(4600,1600,0,1,1,1,1)
	creation(4400,1700,0,1,1,1,3)
	creation(4600,1700,0,1,1,1,4)
	creation(400,1600,0,1,1,1,0)
	creation(600,1600,0,1,1,1,1)
	creation(400,1700,0,1,1,1,3)
	creation(600,1700,0,1,1,1,4)
	creation(1400,1600,0,1,1,1,0)
	creation(1600,1600,0,1,1,1,1)
	creation(1400,1700,0,1,1,1,3)
	creation(1600,1700,0,1,1,1,4)
	creation(2400,1600,0,1,1,1,0)
	creation(2600,1600,0,1,1,1,1)
	creation(2400,1700,0,1,1,1,3)
	creation(2600,1700,0,1,1,1,4)
	creation(3400,1600,0,1,1,1,0)
	creation(3600,1600,0,1,1,1,1)
	creation(3400,1700,0,1,1,1,3)
	creation(3600,1700,0,1,1,1,4)
	creation(4400,1600,0,1,1,1,0)
	creation(4600,1600,0,1,1,1,1)
	creation(4400,1700,0,1,1,1,3)
	creation(4600,1700,0,1,1,1,4)
	creation(400,2600,0,1,1,1,0)
	creation(600,2600,0,1,1,1,1)
	creation(400,1700,0,1,1,1,3)
	creation(600,1700,0,1,1,1,4)
	creation(1400,2600,0,1,1,1,0)
	creation(1600,2600,0,1,1,1,1)
	creation(1400,1700,0,1,1,1,3)
	creation(1600,1700,0,1,1,1,4)
	creation(2400,2600,0,1,1,1,0)
	creation(2600,2600,0,1,1,1,1)
	creation(2400,1700,0,1,1,1,3)
	creation(2600,1700,0,1,1,1,4)
	creation(3400,2600,0,1,1,1,0)
	creation(3600,2600,0,1,1,1,1)
	creation(3400,1700,0,1,1,1,3)
	creation(3600,1700,0,1,1,1,4)
	creation(4400,2600,0,1,1,1,0)
	creation(4600,2600,0,1,1,1,1)
	creation(4400,1700,0,1,1,1,3)
	creation(4600,1700,0,1,1,1,4)
end
function love.mousepressed( mx, my, bu )
	if bu == "l" then
		--for i,h in ipairs(unit) do
			if weplist[wep[unit[idjoueur][15][5][unit[idjoueur][15][6]]][5]][15] == 2 then
				unit[idjoueur][12] = crono+.1
			end
			unit[idjoueur][3][2] = 1
		--end
	elseif bu == "+" then
			zoom = math.max(.9*zoom,love.graphics.getWidth()/mape:getWidth()/10,love.graphics.getHeight()/mape:getHeight()/10)
			cam_x = math.min(math.max(cam_x+.1*(-love.mouse.getX()+love.graphics.getWidth()/2)/zoom,love.graphics.getWidth()/2/zoom),mape:getWidth()*10-love.graphics.getWidth()/2/zoom)
			cam_y = math.min(math.max(cam_y+.1*(-love.mouse.getY()+love.graphics.getHeight()/2)/zoom,love.graphics.getHeight()/2/zoom),mape:getHeight()*10-love.graphics.getHeight()/2/zoom)
	elseif bu == "-" then
			zoom = math.max(1.1*zoom,math.min(mape:getWidth()/10/love.graphics.getWidth(),mape:getHeight()/10/love.graphics.getHeight()))
			cam_x = math.min(math.max(cam_x-.1*(-love.mouse.getX()+love.graphics.getWidth()/2)/zoom,love.graphics.getWidth()/2/zoom),mape:getWidth()*10-love.graphics.getWidth()/2/zoom)
			cam_y =math.min(math.max( cam_y-.1*(-love.mouse.getY()+love.graphics.getHeight()/2)/zoom,love.graphics.getHeight()/2/zoom),mape:getHeight()*10-love.graphics.getHeight()/2/zoom)
	elseif bu == changep then
		--for i,h in ipairs(unit) do
			if unit[idjoueur][15][6] < table.maxn(unit[idjoueur][15][5]) then
				changearme(idjoueur,unit[idjoueur][15][6]+1)
			else
				changearme(idjoueur,1)
			end
		--end
	elseif bu == changem then
		--for i,h in ipairs(unit) do
			if unit[idjoueur][15][6] > 1 then
				changearme(idjoueur,unit[idjoueur][15][6]-1)
			else
				changearme(idjoueur,table.maxn(unit[idjoueur][15][5]))
			end
		--end
	end
end
function love.mousereleased( mx, my, bu )
	if bu == "l" then
		--for i,h in ipairs(unit) do
			unit[idjoueur][3][2] = 0
		--end
	end
end
function love.keypressed( k )
	if k == hau then
		unit[idjoueur][3][3] = 1
		unit[idjoueur][10][2] = -math.pi/2
	elseif k == bas then
		--for i,h in ipairs(unit) do
			unit[idjoueur][3][3] = 1
			unit[idjoueur][10][2] = math.pi/2
		--end
	elseif k == gau then
		--for i,h in ipairs(unit) do
			unit[idjoueur][3][3] = 1
			unit[idjoueur][10][2] = math.pi
		--end
	elseif k == dro then
		--for i,h in ipairs(unit) do
			unit[idjoueur][3][3] = 1
			unit[idjoueur][10][2] = 0
		--end
	elseif k == saut then
		--for i,h in ipairs(unit) do
			unit[idjoueur][2][4] = 3
		--end
	elseif k == lamp then
		--for i,h in ipairs(unit) do
			if unit[idjoueur][19] == false then
				unit[idjoueur][19] = true
			else
				unit[idjoueur][19] = false
			end
		--end
	elseif k == changep then
		--for i,h in ipairs(unit) do
			if unit[idjoueur][15][6] < table.maxn(unit[idjoueur][15][5]) then
				changearme(idjoueur,unit[idjoueur][15][6]+1)
			else
				changearme(idjoueur,1)
			end
		--end
	elseif k == changem then
		--for i,h in ipairs(unit) do
			if unit[idjoueur][15][6] > 1 then
				changearme(idjoueur,unit[idjoueur][15][6]-1)
			else
				changearme(idjoueur,table.maxn(unit[idjoueur][15][5]))
			end
		--end
	end
end
function love.keyreleased( k )
	if k == hau then
		--for i,h in ipairs(unit) do
			unit[idjoueur][3][3] = 0
		--end
	elseif k == bas then
		--for i,h in ipairs(unit) do
			unit[idjoueur][3][3] = 0
		--end
	elseif k == gau then
		--for i,h in ipairs(unit) do
			unit[idjoueur][3][3] = 0
		--end
	elseif k == dro then
		--for i,h in ipairs(unit) do
			unit[idjoueur][3][3] = 0
		--end
	elseif k == rec then
		--for i,h in ipairs(unit) do
			recharge(idjoueur)
		--end
	end
end
function creation(px,py,pz,typ,pres,equip,direc)
	ex = math.floor(math.min(math.max(px/100,1),table.maxn(carto)))
	ey = math.floor(math.min(math.max(py/100,1),table.maxn(carto[1])))
	bx = math.floor(math.min(math.max(px/50,1),mape:getWidth()))
	by = math.floor(math.min(math.max(py/50,1),mape:getHeight()))
	for i,h in ipairs(preset[pres][6]) do
		if i == table.maxn(preset[pres][6]) then
			table.insert(wep,{{px,py,pz},{0,0,direc,0},weplist[h][5],weplist[h][14],1,table.maxn(unit)+1,h,0})
		else
			table.insert(wep,{{px,py,pz},{0,0,direc,0},weplist[h][5],weplist[h][14],2,table.maxn(unit)+1,h,0})
		end
	end
	table.insert(unit,{{px,py,px,py,pz,ex,ey,bx,by},{0,0,direc,0},{1,0,0,1,0},0,typ,equip,{unitlist[typ][1],unitlist[typ][1]},50,idmaker,{direc,direc,direc,direc,direc,direc,direc,direc,0,0,0,0},crono+1,0,0,0,{preset[pres][2],preset[pres][3],preset[pres][4],preset[pres][5],{},1,preset[pres][8]},{1,{px,py,px+1,py+1},{px,py,px+1,py+1},1,1},1,pz,true,{{0,0},{0,0}},{10,0}})
	for i,h in ipairs(preset[pres][6]) do
		table.insert(unit[table.maxn(unit)][15][5],table.maxn(wep)-i+1)
	end
	idmaker = idmaker+1
end
function killing(id)
	--if unitlist[unit[id][3][5]][18] ~= 0 then
	--	sout = unitlist[unit[id][4]][]
	--	sout:setVolume( math.min(1/(1+math.sqrt((unit[id][1][1]-cam_x)^2+(unit[id][1][2]-cam_y)^2)+(20/zoom)^2)*20,2) )
	--	love.audio.stop( sout )
	--	love.audio.play( sout )
	--end
	wep[unit[id][15][5]][5] = 1
	unit[id][11] = crono+1
	unit[id][3] = 0
end
function tire(who)
	if math.abs((wep[who][1][1]-cam_x)*zoom*cam_z/(cam_z-wep[who][1][3]*zoom)) < love.graphics.getWidth()
	and math.abs((wep[who][1][2]-cam_y)*zoom*cam_z/(cam_z-wep[who][1][3]*zoom)) < love.graphics.getHeight() then
		if wep[who][3] > 0 then
			local m = math.cos(wep[who][2][4])*math.cos(wep[who][2][3])*missilist[weplist[wep[who][7]][6]][2]
			local n = math.cos(wep[who][2][4])*math.sin(wep[who][2][3])*missilist[weplist[wep[who][7]][6]][2]
			local o = math.sin(wep[who][2][4])*missilist[weplist[wep[who][7]][6]][2]
			local prodn = 0
			while prodn < weplist[wep[who][7]][20] do
				table.insert(missi,{{wep[who][1][1],wep[who][1][2],wep[who][1][1],wep[who][1][2],wep[who][1][3]},{m+math.random(100*-weplist[wep[who][7]][19],100*weplist[wep[who][7]][19])/100,n+math.random(100*-weplist[wep[who][7]][19],100*weplist[wep[who][7]][19])/100,0,o+.5*math.random(100*-weplist[wep[who][7]][19],100*weplist[wep[who][7]][19])/100},1,crono+3,1,1,0,0,0})
				prodn = prodn+1
			end
			unit[wep[who][6]][10][11] = .8*unit[wep[who][6]][10][11]-weplist[wep[who][7]][2]*math.cos(wep[who][2][3])
			unit[wep[who][6]][10][12] = .8*unit[wep[who][6]][10][12]-weplist[wep[who][7]][2]*math.sin(wep[who][2][3])
			unit[wep[who][6]][10][5] = unit[wep[who][6]][10][5]+math.random(-100*weplist[wep[who][7]][2],100*weplist[wep[who][7]][2])/4000
			unit[wep[who][6]][10][9] = unit[wep[who][6]][10][9]+math.random(-80*weplist[wep[who][7]][2],100*weplist[wep[who][7]][2])/4000
			table.insert(effetl,{wep[who][1][1],wep[who][1][2],wep[who][1][3],0,0,0,3,wep[who][2][3],1,1})
			wep[who][3] = wep[who][3]-1
		end
	end
	--effets = {1x,2y,3z,4m,5n,6o,7sca,8rot,9a,10type}
	--missi = {1 {x,y,x2,y2} ,2 {m,n,direc} ,3 phase ,4 timer ,5 type ,6 team ,7 rebon }
end
function altisol(dx,dy)
	local dx = math.max(2,math.min(mape:getWidth()-2,math.floor(dx/10)))
	local dy = math.max(2,math.min(mape:getHeight()-2,math.floor(dy/10)))
	r, g, b, a = mape:getPixel(dx,dy)
	return(r)
end
function recharge(id)
	if wep[unit[id][15][5][unit[id][15][6]]][3] < weplist[wep[unit[id][15][5][unit[id][15][6]]][7]][5] then
		unit[id][3][2] = 2
		unit[id][12] = crono+weplist[wep[unit[id][15][5][unit[id][15][6]]][7]][16]
		if weplist[wep[unit[id][15][5][unit[id][15][6]]][7]][15] == 1 then
			wep[unit[id][15][5][unit[id][15][6]]][3] = 0
		elseif weplist[wep[unit[id][15][5][unit[id][15][6]]][7]][15] == 2 then
		end
	end
end
function changearme(id,number)
	unit[id][12] = crono+weplist[wep[unit[id][15][5][number]][7]][17]
	unit[id][3][5] = number
end
function love.update(dot)
	moux = (love.mouse.getX()-love.graphics.getWidth()/2)/zoom/cam_z*(cam_z-mouz*zoom)+cam_x
	mouy = (love.mouse.getY()-love.graphics.getHeight()/2)/zoom/cam_z*(cam_z-mouz*zoom)+cam_y
	mouz = mouz+.1*(altisol(moux,mouy)-mouz)/zoom
	mapr = {}
	mapr[1] = 1
	mapr[2] = cam_z/(cam_z-50*zoom)
	mapr[3] = cam_z/(cam_z-100*zoom)
	mapr[4] = cam_z/(cam_z-150*zoom)
	mapr[5] = cam_z/(cam_z-200*zoom)
	mapr[6] = cam_z/(cam_z-250*zoom)
	cam_x = cam_x+.1*(math.min(math.max((unit[1][1][3]+moux)/2,love.graphics.getWidth()/2/zoom),mape:getWidth()*10-love.graphics.getWidth()/2/zoom)-cam_x)
	cam_y = cam_y+.1*(math.min(math.max((unit[1][1][4]+mouy)/2,love.graphics.getHeight()/2/zoom),mape:getHeight()*10-love.graphics.getHeight()/2/zoom)-cam_y)
	cam_z = cam_z+.1*(2*mouz+400-cam_z)
	crono = crono+dot
	local ws = love.timer.getTime()
	if eludraw < 5 then
		eludraw = eludraw+1
	else
		eludraw = 1
	end
	drawlist[1] = {{},{},{},{},{}}
	drawlist[2] = {{},{},{},{},{}}
	drawlist[3] = {{},{},{},{},{}}
	drawlist[4] = {{},{},{},{},{}}
	drawlist[5] = {{},{},{},{},{}}
	drawlist[6] = {{},{},{},{},{}}
	for i,h in ipairs(unit) do
		if h[3] ~= 0 then
			h[1][6] = math.floor(math.min(math.max(h[1][1]/100,2),table.maxn(carto)-1))
			h[1][7] = math.floor(math.min(math.max(h[1][2]/100,2),table.maxn(carto[1])-1))
			h[1][8] = math.floor(math.min(math.max(h[1][1]/10,1),mape:getWidth()))
			h[1][9] = math.floor(math.min(math.max(h[1][2]/10,1),mape:getHeight()))
			table.insert(carto[h[1][6]][h[1][7]],i)
		end
	end
	if ia[elu+1] ~= nil then
		elu = elu+1
	else
		elu = 1
	end
	if ia[elu] ~= nil then
	end
	for i,h in ipairs(unit) do
		if h[3][1] == 0 then
		elseif h[3][1] == 1
		or h[3][1] == 2 then
			if h[3][5] ~= 0	then
				if h[12] < crono+.2 then
					wep[h[15][5][h[15][6]]][5] = 2
					wep[h[15][5][h[3][5]]][5] = 1
					h[15][6] = h[3][5]
					h[3][5] = 0
				end
			end
			h[10][1] = math.atan2(mouy-h[1][4],moux-h[1][3])
			h[10][8] = math.atan2(mouy-wep[h[15][5][h[15][6]]][1][2],moux-wep[h[15][5][h[15][6]]][1][1])
			h[10][10] = math.atan((mouz-h[1][5]-23)/math.sqrt((moux-wep[h[15][5][h[15][6]]][1][1])^2+(mouy-wep[h[15][5][h[15][6]]][1][2])^2))
			h[10][2] = math.atan2(math.sin(h[10][2]),math.cos(h[10][2]))
			h[10][3] = math.atan2(math.sin(h[10][3]),math.cos(h[10][3]))
			h[10][4] = math.atan2(math.sin(h[10][4]),math.cos(h[10][4]))
			h[10][5] = math.atan2(math.sin(h[10][5]),math.cos(h[10][5]))
			h[10][6] = math.atan2(math.sin(h[10][6]),math.cos(h[10][6]))
			h[10][7] = math.atan2(math.sin(h[10][7]),math.cos(h[10][7]))
			if h[10][1]-h[10][7] > math.pi then-------------tete--------------
				h[10][7] = h[10][7]+.2*(h[10][1]-h[10][7]-2*math.pi)
			elseif h[10][1]-h[10][7] < -math.pi then
				h[10][7] = h[10][7]+.2*(h[10][1]-h[10][7]+2*math.pi)
			else
				h[10][7] = h[10][7]+.2*(h[10][1]-h[10][7])
			end
			h[10][11] = (1-weplist[wep[h[15][5][h[15][6]]][7]][3])*h[10][11]
			h[10][12] = (1-weplist[wep[h[15][5][h[15][6]]][7]][3])*h[10][12]
			if h[10][1]-h[10][4] > math.pi then------------epaule---------
				h[10][4] = h[10][4]+.1*(h[10][1]-h[10][4]-2*math.pi)
			elseif h[10][1]-h[10][4] < -math.pi then------------epaule---------
				h[10][4] = h[10][4]+.1*(h[10][1]-h[10][4]+2*math.pi)
			else
				h[10][4] = h[10][4]+.1*(h[10][1]-h[10][4])
			end
			if h[10][1]-h[10][3] > math.pi then--------------ventre----------------
				h[10][3] = h[10][3]+.07*(h[10][1]-h[10][3]-2*math.pi)
			elseif h[10][1]-h[10][3] < -math.pi then--------------ventre----------------
				h[10][3] = h[10][3]+.07*(h[10][1]-h[10][3]+2*math.pi)
			else
				h[10][3] = h[10][3]+.07*(h[10][1]-h[10][3])
			end
			if h[10][1]-h[10][6] > math.pi then--------------jambe----------------
				h[10][6] = h[10][6]+.05*(h[10][1]-h[10][6]-2*math.pi)
			elseif h[10][1]-h[10][6] < -math.pi then--------------jambe----------------
				h[10][6] = h[10][6]+.05*(h[10][1]-h[10][6]+2*math.pi)
			else
				h[10][6] = h[10][6]+.05*(h[10][1]-h[10][6])
			end
			if h[10][2]-h[10][4] > math.pi then------------epaule---------
				h[10][4] = h[10][4]+.02*(h[10][2]-h[10][4]-2*math.pi)
			elseif h[10][2]-h[10][4] < -math.pi then------------epaule---------
				h[10][4] = h[10][4]+.02*(h[10][2]-h[10][4]+2*math.pi)
			else
				h[10][4] = h[10][4]+.02*(h[10][2]-h[10][4])
			end
			if h[10][2]-h[10][3] > math.pi then--------------ventre----------------
				h[10][3] = h[10][3]+.018*(h[10][2]-h[10][3]-2*math.pi)
			elseif h[10][2]-h[10][3] < -math.pi then--------------ventre----------------
				h[10][3] = h[10][3]+.018*(h[10][2]-h[10][3]+2*math.pi)
			else
				h[10][3] = h[10][3]+.018*(h[10][2]-h[10][3])
			end
			if h[10][2]-h[10][6] > math.pi then--------------jambe----------------
				h[10][6] = h[10][6]+.02*(h[10][2]-h[10][6]-2*math.pi)
			elseif h[10][2]-h[10][6] < -math.pi then--------------jambe----------------
				h[10][6] = h[10][6]+.02*(h[10][2]-h[10][6]+2*math.pi)
			else
				h[10][6] = h[10][6]+.02*(h[10][2]-h[10][6])
			end
			if h[3][2] == 1 then
			end
			if h[3][2] == 0 then  -------------tete--------
				h[20][1][1] = wep[h[15][5][h[15][6]]][1][1]-5*math.cos(h[10][5])*math.cos(h[10][9])-h[1][3]
				h[20][1][2] = wep[h[15][5][h[15][6]]][1][2]-5*math.sin(h[10][5])*math.cos(h[10][9])-h[1][4]
				h[20][2][1] = wep[h[15][5][h[15][6]]][1][1]+15*math.cos(h[10][5])*math.cos(h[10][9])-h[1][3]
				h[20][2][2] = wep[h[15][5][h[15][6]]][1][2]+15*math.sin(h[10][5])*math.cos(h[10][9])-h[1][4]
				h[21][1] = h[21][1]+.1*(weplist[wep[h[15][5][h[15][6]]][7]][18][1][1]-h[21][1])
				h[21][2] = h[21][2]+.1*(weplist[wep[h[15][5][h[15][6]]][7]][18][1][3]-h[21][2])
				if h[10][8]-h[10][5] > math.pi then
					h[10][5] = h[10][5]+weplist[wep[h[15][5][h[15][6]]][7]][3]*(h[10][8]-h[10][5]+weplist[wep[h[15][5][h[15][6]]][7]][18][1][2]-2*math.pi)
				elseif h[10][8]-h[10][5] < -math.pi then
					h[10][5] = h[10][5]+2*weplist[wep[h[15][5][h[15][6]]][7]][3]*(h[10][8]-h[10][5]+weplist[wep[h[15][5][h[15][6]]][7]][18][1][2]+2*math.pi)
				else
					h[10][5] = h[10][5]+2*weplist[wep[h[15][5][h[15][6]]][7]][3]*(h[10][8]-h[10][5]+weplist[wep[h[15][5][h[15][6]]][7]][18][1][2])
				end
				h[10][9] = h[10][9]+2*weplist[wep[h[15][5][h[15][6]]][7]][3]*(h[10][10]-h[10][9])
			elseif h[3][2] == 1 then
				if h[12] < crono then
					if h[3][5] == 0 then
						if wep[h[15][5][h[15][6]]][8] < crono then
							tire(h[15][5][h[15][6]])
							wep[h[15][5][h[15][6]]][8] = crono+weplist[wep[h[15][5][h[15][6]]][7]][1]
						end
					end
				end
				h[20][1][1] = wep[h[15][5][h[15][6]]][1][1]-5*math.cos(h[10][5])*math.cos(h[10][9])-h[1][3]
				h[20][1][2] = wep[h[15][5][h[15][6]]][1][2]-5*math.sin(h[10][5])*math.cos(h[10][9])-h[1][4]
				h[20][2][1] = wep[h[15][5][h[15][6]]][1][1]+15*math.cos(h[10][5])*math.cos(h[10][9])-h[1][3]
				h[20][2][2] = wep[h[15][5][h[15][6]]][1][2]+15*math.sin(h[10][5])*math.cos(h[10][9])-h[1][4]
				h[21][1] = h[21][1]+.1*(weplist[wep[h[15][5][h[15][6]]][7]][18][1][1]-h[21][1])
				h[21][2] = h[21][2]+.1*(weplist[wep[h[15][5][h[15][6]]][7]][18][1][3]-h[21][2])
				if h[10][8]-h[10][5] > math.pi then
					h[10][5] = h[10][5]+weplist[wep[h[15][5][h[15][6]]][7]][3]*(h[10][8]-h[10][5]+weplist[wep[h[15][5][h[15][6]]][7]][18][1][2]-2*math.pi)/2
				elseif h[10][8]-h[10][5] < -math.pi then
					h[10][5] = h[10][5]+weplist[wep[h[15][5][h[15][6]]][7]][3]*(h[10][8]-h[10][5]+weplist[wep[h[15][5][h[15][6]]][7]][18][1][2]+2*math.pi)/2
				else
					h[10][5] = h[10][5]+weplist[wep[h[15][5][h[15][6]]][7]][3]*(h[10][8]-h[10][5]+weplist[wep[h[15][5][h[15][6]]][7]][18][1][2])/2
				end
				h[10][9] = h[10][9]+weplist[wep[h[15][5][h[15][6]]][7]][3]*(h[10][10]-h[10][9])/2
			elseif h[3][2] == 2 then
				if crono > h[12] then
					if weplist[wep[h[15][5][h[15][6]]][7]][15] == 1 then
						wep[h[15][5][h[15][6]]][3] = weplist[wep[h[15][5][h[15][6]]][7]][5]
						h[3][2] = 0
						wep[h[15][5][h[15][6]]][4] = wep[h[15][5][h[15][6]]][4]-1
					elseif weplist[wep[h[15][5][h[15][6]]][7]][15] == 2 then
						wep[h[15][5][h[15][6]]][3] = wep[h[15][5][h[15][6]]][3]+1
						wep[h[15][5][h[15][6]]][4] = wep[h[15][5][h[15][6]]][4]-1
						h[12] = h[12]+weplist[wep[h[15][5][h[15][6]]][7]][16]
						if wep[h[15][5][h[15][6]]][3] == weplist[wep[h[15][5][h[15][6]]][7]][5] then
							h[3][2] = 0
						end
					end
				end
				h[20][1][1] = wep[h[15][5][h[15][6]]][1][1]-5*math.cos(h[10][5])*math.cos(h[10][9])-h[1][3]
				h[20][1][2] = wep[h[15][5][h[15][6]]][1][2]-5*math.sin(h[10][5])*math.cos(h[10][9])-h[1][4]
				h[20][2][1] = wep[h[15][5][h[15][6]]][1][1]+15*math.cos(h[10][5])*math.cos(h[10][9])-h[1][3]
				h[20][2][2] = wep[h[15][5][h[15][6]]][1][2]+15*math.sin(h[10][5])*math.cos(h[10][9])-h[1][4]
				h[21][1] = h[21][1]+.1*(weplist[wep[h[15][5][h[15][6]]][7]][18][2][1]-h[21][1])
				h[21][2] = h[21][2]+.1*(weplist[wep[h[15][5][h[15][6]]][7]][18][2][3]-h[21][2])
				if (h[10][3]+weplist[wep[h[15][5][h[15][6]]][7]][18][2][3])-h[10][5] > math.pi then
					h[10][5] = h[10][5]+.14*((h[10][3]+weplist[wep[h[15][5][h[15][6]]][7]][18][2][2])-h[10][5]-2*math.pi)
				elseif (h[10][3]+weplist[wep[h[15][5][h[15][6]]][7]][18][2][3])-h[10][5] < -math.pi then
					h[10][5] = h[10][5]+.14*((h[10][3]+weplist[wep[h[15][5][h[15][6]]][7]][18][2][2])-h[10][5]+2*math.pi)
				else
					h[10][5] = h[10][5]+.14*((h[10][3]+weplist[wep[h[15][5][h[15][6]]][7]][18][2][2])-h[10][5])
				end
				h[10][9] = h[10][9]+.14*(h[10][10]-h[10][9])
			end
			if h[3][4] == 1 then
				if h[3][3] == 0 then  -------------jambe--------
					h[2][1] = .8*h[2][1]
					h[2][2] = .8*h[2][2]
					local difx = 8*math.cos(h[10][6]+.5*math.pi)
					local dify = 8*math.sin(h[10][6]+.5*math.pi)
					local spee = math.sqrt(h[2][1]^2+h[2][2]^2)
					local disdroite = math.sqrt((h[1][1]+difx-h[16][2][1]+10*h[2][1])^2+(h[1][2]+dify-h[16][2][2]+10*h[2][2])^2)
					local disgauche = math.sqrt((h[1][1]-difx-h[16][3][1]+10*h[2][1])^2+(h[1][2]-dify-h[16][3][2]+10*h[2][2])^2)
					if disgauche > 25*math.max(1,spee) then
						h[16][3][3] = h[1][1]-difx+10*h[2][1]
						h[16][3][4] = h[1][2]-dify+10*h[2][2]
					end
					if disdroite > 25*math.max(1,spee) then
						h[16][2][3] = h[1][1]+difx+10*h[2][1]
						h[16][2][4] = h[1][2]+dify+10*h[2][2]
					end
					h[16][2][1] = h[16][2][1]+.08*(h[16][2][3]-h[16][2][1])
					h[16][2][2] = h[16][2][2]+.08*(h[16][2][4]-h[16][2][2])
					h[16][3][1] = h[16][3][1]+.08*(h[16][3][3]-h[16][3][1])
					h[16][3][2] = h[16][3][2]+.08*(h[16][3][4]-h[16][3][2])
				elseif h[3][3] == 1 then
					local difx = 8*math.cos(h[10][6]+.5*math.pi)
					local dify = 8*math.sin(h[10][6]+.5*math.pi)
					local spee = math.sqrt(h[2][1]^2+h[2][2]^2)
					if h[16][4] < crono then
						if zoom > .3 then
							if h[16][5] == 1 then
								if math.abs((h[1][1]-cam_x)*zoom*cam_z/(cam_z-h[1][5]*zoom)) < love.graphics.getWidth()/1.5
								and math.abs((h[1][2]-cam_y)*zoom*cam_z/(cam_z-h[1][5]*zoom)) < love.graphics.getHeight()/1.5 then
									table.insert(effets,{h[16][3][1],h[16][3][2],h[1][5],0,0,0,1,h[10][6],{255,255,255,255},1})
								end
								h[16][3][3] = h[1][1]-difx+25*h[2][1]
								h[16][3][4] = h[1][2]-dify+25*h[2][2]
							else
								if math.abs((h[1][1]-cam_x)*zoom*cam_z/(cam_z-h[1][5]*zoom)) < love.graphics.getWidth()/1.5
								and math.abs((h[1][2]-cam_y)*zoom*cam_z/(cam_z-h[1][5]*zoom)) < love.graphics.getHeight()/1.5 then
									table.insert(effets,{h[16][2][1],h[16][2][2],h[1][5],0,0,0,1,h[10][6],{255,255,255,255},1})
								end
								h[16][2][3] = h[1][1]+difx+25*h[2][1]
								h[16][2][4] = h[1][2]+dify+25*h[2][2]
							end
							h[16][5] = -h[16][5]
							h[16][4] = crono+.9/math.max(3,spee)
						end
					end
					local disdroite = math.sqrt((h[1][1]+difx-h[16][2][1]+10*h[2][1])^2+(h[1][2]+dify-h[16][2][2]+10*h[2][2])^2)
					local disgauche = math.sqrt((h[1][1]-difx-h[16][3][1]+10*h[2][1])^2+(h[1][2]-dify-h[16][3][2]+10*h[2][2])^2)
					if disgauche > 25*math.max(1,spee) then
						h[16][3][3] = h[1][1]-difx+10*h[2][1]
						h[16][3][4] = h[1][2]-dify+10*h[2][2]
					end
					if disdroite > 25*math.max(1,spee) then
						h[16][2][3] = h[1][1]+difx+10*h[2][1]
						h[16][2][4] = h[1][2]+dify+10*h[2][2]
					end
					h[16][2][1] = h[16][2][1]+.08*(h[16][2][3]-h[16][2][1])
					h[16][2][2] = h[16][2][2]+.08*(h[16][2][4]-h[16][2][2])
					h[16][3][1] = h[16][3][1]+.08*(h[16][3][3]-h[16][3][1])
					h[16][3][2] = h[16][3][2]+.08*(h[16][3][4]-h[16][3][2])
					h[2][1] = .8*h[2][1]
					h[2][2] = .8*h[2][2]
					h[2][1] = h[2][1]+.1*((h[17]*unitlist[h[5]][3]*math.cos(h[10][2]))-h[2][1])
					h[2][2] = h[2][2]+.1*((h[17]*unitlist[h[5]][3]*math.sin(h[10][2]))-h[2][2])
					local d1 = altisol(h[1][1]+20,h[1][2])
					local d2 = altisol(h[1][1]-20,h[1][2])
					local d3 = altisol(h[1][1],h[1][2]+20)
					local d4 = altisol(h[1][1],h[1][2]-20)
					local d5 = altisol(h[1][1]+15,h[1][2]+15)
					local d6 = altisol(h[1][1]-15,h[1][2]+15)
					local d7 = altisol(h[1][1]+15,h[1][2]-15)
					local d8 = altisol(h[1][1]-15,h[1][2]-15)
					if d1 > h[1][5]+10 then
						h[2][1] = -1
					end
					if d2 > h[1][5]+10 then
						h[2][1] = 1
					end
					if d3 > h[1][5]+10 then
						h[2][2] = -1
					end
					if d4 > h[1][5]+10 then
						h[2][2] = 1
					end
					if d5 > h[1][5]+10 then
						h[2][1] = -.7
						h[2][2] = -.7
					end
					if d6 > h[1][5]+10 then
						h[2][1] = .7
						h[2][2] = -.7
					end
					if d7 > h[1][5]+10 then
						h[2][1] = -.7
						h[2][2] = .7
					end
					if d8 > h[1][5]+10 then
						h[2][1] = .7
						h[2][2] = .7
					end
				end
			else
				local difx = 8*math.cos(h[10][6]+.5*math.pi)
				local dify = 8*math.sin(h[10][6]+.5*math.pi)
				h[16][3][3] = h[1][1]-difx
				h[16][3][4] = h[1][2]-dify
				h[16][2][3] = h[1][1]+difx
				h[16][2][4] = h[1][2]+dify
				h[16][2][1] = h[16][2][1]+.12*(h[16][2][3]-h[16][2][1])
				h[16][2][2] = h[16][2][2]+.12*(h[16][2][4]-h[16][2][2])
				h[16][3][1] = h[16][3][1]+.12*(h[16][3][3]-h[16][3][1])
				h[16][3][2] = h[16][3][2]+.12*(h[16][3][4]-h[16][3][2])
			end
		end 
	end
	for i,h in ipairs(unit) do
		h[2][3] = math.atan2(h[2][2],h[2][1])
		h[1][1] = h[1][1]+h[2][1]
		h[1][2] = h[1][2]+h[2][2]
		h[1][5] = h[1][5]+h[2][4]
		h[1][3] = h[1][3]+.15*((h[16][2][1]+h[16][3][1])/2-h[1][3]+8*h[2][1])
		h[1][4] = h[1][4]+.15*((h[16][2][2]+h[16][3][2])/2-h[1][4]+8*h[2][2])
		h[18] = altisol(h[1][1],h[1][2])
		local hsol = math.max(altisol(h[1][1]-10,h[1][2]-10),altisol(h[1][1]+10,h[1][2]-10),altisol(h[1][1]+10,h[1][2]+10),altisol(h[1][1]-10,h[1][2]+10),altisol(h[1][1],h[1][2]))
		if h[1][5] > hsol+4 then
			h[2][4] = h[2][4]-.1
			h[3][4] = 0
		elseif h[1][5] < hsol then
			h[3][4] = 1
			h[1][5] = hsol
			h[2][4] = 0
		end
		carto[h[1][6]][h[1][7]] = {}
		if h[3] == 0
		and h[11] < crono then
			table.remove(unit,i)
		end
		--if math.floor(h[1][5]/60+.5)+1 == eludraw then
		if math.abs((h[1][1]-cam_x)*zoom*cam_z/(cam_z-h[1][5]*zoom)) < love.graphics.getWidth()/1.8
		and math.abs((h[1][2]-cam_y)*zoom*cam_z/(cam_z-h[1][5]*zoom)) < love.graphics.getHeight()/1.8 then
			table.insert(drawlist[math.max(math.min(math.floor(h[1][5]/50+.8)+1,6),1)][1],i)
		end
		--end
	end
	for i,h in ipairs(wep) do
		if h[5] == 0 then
		elseif h[5] == 1 then
			h[1][1] = unit[h[6]][1][3]+unit[h[6]][21][1]*math.cos(unit[h[6]][10][3]-unit[h[6]][21][2])+unit[h[6]][10][11]
			h[1][2] = unit[h[6]][1][4]+unit[h[6]][21][1]*math.sin(unit[h[6]][10][3]-unit[h[6]][21][2])+unit[h[6]][10][12]
			h[1][3] = unit[h[6]][1][5]+23
			h[2][3] = unit[h[6]][10][5]
			h[2][4] = unit[h[6]][10][9]
		elseif h[5] == 2 then
			h[1][1] = unit[h[6]][1][3]-10*math.cos(unit[h[6]][10][3]-unit[h[6]][21][2])
			h[1][2] = unit[h[6]][1][4]-10*math.sin(unit[h[6]][10][3]-unit[h[6]][21][2])
			h[1][3] = unit[h[6]][1][5]+23
			h[2][3] = unit[h[6]][10][3]-.5*math.pi
			h[2][4] = -1
		end
		if math.abs((h[1][1]-cam_x)*zoom*cam_z/(cam_z-h[1][3]*zoom)) < love.graphics.getWidth()/1.8
		and math.abs((h[1][2]-cam_y)*zoom*cam_z/(cam_z-h[1][3]*zoom)) < love.graphics.getHeight()/1.8 then
			table.insert(drawlist[math.max(math.min(math.floor((h[1][3]-23)/50+.8)+1,6),1)][5],i)
		end
	end
	for i,h in ipairs(missi) do
		if h[3] == 0 then
			if h[4] < crono then
				table.remove(missi,i)
			end
		elseif h[3] == 1 then
			local spee = math.sqrt(h[2][1]^2+h[2][2]^2+h[2][4]^2)
			if h[1][1] < 0
			or h[1][2] < 0
			or h[1][1] > mape:getWidth()*10
			or h[1][2] > mape:getHeight()*10
			or h[4] < crono then
				h[1][1] = h[1][1]-2*h[2][1]
				h[1][2] = h[1][2]-2*h[2][2]
				h[3] = 0
				h[2][1] = 0
				h[2][2] = 0
				h[4] = crono+3
			else
				if math.abs((h[1][1]-cam_x)*zoom*cam_z/(cam_z-h[1][5]*zoom)) < love.graphics.getWidth()/1.8
				and math.abs((h[1][2]-cam_y)*zoom*cam_z/(cam_z-h[1][5]*zoom)) < love.graphics.getHeight()/1.8 then
					table.insert(effetl,{h[1][1],h[1][2],h[1][5],0,0,0,5,h[2][4],1,2})
					gitr = 6
				else
					gitr = 10
				end
				h[8] = h[8]+spee
				local xe = h[1][3]
				local ye = h[1][4]
				local ze = h[1][5]
				local tre = 0
				while h[9]+tre < h[8] do
					tre = tre+gitr
					xe = h[1][1]+h[2][1]/spee*tre
					ye = h[1][2]+h[2][2]/spee*tre
					ze = h[1][5]+h[2][4]/spee*tre
					if ze < altisol(xe,ye) then
						h[3] = 0
						while ze < altisol(xe,ye) do
							xe = xe-h[2][1]/spee
							ye = ye-h[2][2]/spee
							ze = ze+math.abs(h[2][4]/spee)
						end
						tre = 1000
						h[1][1] = xe
						h[1][2] = ye
						h[1][5] = ze
						h[4] = crono+5
						h[2][4] = math.min(math.pi/2,.02*(altisol(xe,ye)-h[1][5]))
					end
				end
				h[9] = h[9]+tre
				if h[3] == 1 then
					h[2][3] = math.atan2(h[2][2],h[2][1])
					h[1][1] = h[1][1]+h[2][1]
					h[1][2] = h[1][2]+h[2][2]
					h[1][5] = h[1][5]+h[2][4]
					h[2][4] = h[2][4]-missilist[h[5]][3]
				end
			end
	--missi = {1 {x,y,x2,y2,z} ,2 {m,n,direc,o} ,3 phase ,4 timer ,5 type ,6 team ,7 rebon ,8 distparcourue ,9 nextseek }
		end
		h[1][3] = h[1][3]+.2*(h[1][1]-h[1][3])
		h[1][4] = h[1][4]+.2*(h[1][2]-h[1][4])
		if h[4] > crono+.1
		and math.abs((h[1][1]-cam_x)*zoom*cam_z/(cam_z-h[1][5]*zoom)) < love.graphics.getWidth()/1.8
		and math.abs((h[1][2]-cam_y)*zoom*cam_z/(cam_z-h[1][5]*zoom)) < love.graphics.getHeight()/1.8 then
			table.insert(drawlist[math.max(math.min(math.floor(h[1][5]/50+.8)+1,6),1)][2],i)
		end
	end
	for i,h in ipairs(effets) do
		h[4] = h[4]*effetlists[h[10]][1]+effetlists[h[10]][4]
		h[5] = h[5]*effetlists[h[10]][2]+effetlists[h[10]][5]
		h[6] = h[6]*effetlists[h[10]][3]+effetlists[h[10]][6]
		h[1] = h[1]+h[4]
		h[2] = h[2]+h[5]
		h[3] = h[3]+h[6]
		h[7] = h[7]+effetlists[h[10]][7]
		h[8] = h[8]+effetlists[h[10]][8]
		h[9][1] = h[9][1]+effetlists[h[10]][10][1]
		h[9][2] = h[9][2]+effetlists[h[10]][10][2]
		h[9][3] = h[9][3]+effetlists[h[10]][10][3]
		h[9][4] = h[9][4]+effetlists[h[10]][10][4]
		
		if h[9][4] > 10+effetlists[h[10]][10][4] then
			if math.abs((h[1]-cam_x)*zoom*cam_z/(cam_z-h[3]*zoom)) < love.graphics.getWidth()/1.8
			and math.abs((h[2]-cam_y)*zoom*cam_z/(cam_z-h[3]*zoom)) < love.graphics.getHeight()/1.8 then
				table.insert(drawlist[math.max(math.min(math.floor(h[3]/50+.8)+1,6),1)][3],i)
			end
		elseif h[9][4] < 10 then
			table.remove(effets,i)
		end
	--effetlists[0] = {1rm,2rn,3ro,4+m,5+n,6+o,7+sca,8+rot,9app,10{+r,+v,+b,+a},}
	--effet = {1x,2y,3z,4m,5n,6o,7sca,8rot,9{r,v,b,a},10type}
	end
	for i,h in ipairs(effetl) do
		h[4] = h[4]*effetlistl[h[10]][1]+effetlistl[h[10]][4]
		h[5] = h[5]*effetlistl[h[10]][2]+effetlistl[h[10]][5]
		h[6] = h[6]*effetlistl[h[10]][3]+effetlistl[h[10]][6]
		h[1] = h[1]+h[4]
		h[2] = h[2]+h[5]
		h[3] = h[3]+h[6]
		h[7] = h[7]+effetlistl[h[10]][7]
		h[8] = h[8]+effetlistl[h[10]][8]
		h[9] = h[9]+effetlistl[h[10]][10]
		
		if h[9] > 10+effetlistl[h[10]][10] then
			if math.abs((h[1]-cam_x)*zoom*cam_z/(cam_z-h[3]*zoom)) < love.graphics.getWidth()/1.5
			and math.abs((h[2]-cam_y)*zoom*cam_z/(cam_z-h[3]*zoom)) < love.graphics.getHeight()/1.5 then
				table.insert(drawlist[math.max(math.min(math.floor(h[3]/50+.8)+1,6),1)][4],i)
			end
		elseif h[9] < 0 then
			table.remove(effetl,i)
		end
	--effetlistl[0] = {1rm,2rn,3ro,4+m,5+n,6+o,7+sca,8+rot,9app,10{+r,+v,+b,+a},}
	--effet = {1x,2y,3z,4m,5n,6o,7sca,8rot,9{r,v,b,a},10type}
	end
	fps = fps+.01*(1/dot-fps)
	--ws = love.timer.getTime()-ws
	--if ws < 1/60 then
	--	love.timer.sleep((1/60-ws)*740)
	--end
end
function love.draw()
	for i,j in ipairs(drawlist) do
		love.graphics.setColor(255,255,255)
		love.graphics.draw( maper[i] , mapr[i]*(-cam_x)*zoom+love.graphics.getWidth()/2 , mapr[i]*(-cam_y)*zoom+love.graphics.getHeight()/2 ,0,mapr[i]*2.5*zoom,mapr[i]*2.5*zoom)
		for i,h in ipairs(j[3]) do
			love.graphics.setColor(effets[h][9][1],effets[h][9][2],effets[h][9][3],effets[h][9][4])
			love.graphics.draw( effetlists[effets[h][10]][9] , (effets[h][1]-cam_x)*zoom*cam_z/(cam_z-effets[h][3]*zoom)+love.graphics.getWidth()/2 , (effets[h][2]-cam_y)*zoom*cam_z/(cam_z-effets[h][3]*zoom)+love.graphics.getHeight()/2 ,effets[h][8],effets[h][7]*zoom*cam_z/(cam_z-effets[h][3]*zoom)/2,effets[h][7]*zoom*cam_z/(cam_z-effets[h][3]*zoom)/2,effetlists[effets[h][10]][9]:getWidth()/2,effetlists[effets[h][10]][9]:getHeight()/2)
		end
		for i,h in ipairs(j[2]) do
			if missi[h][3] == 0 then
				love.graphics.setColor(255,255,255,math.min(255,50*(missi[h][4]-crono)))
				love.graphics.draw( missilist[missi[h][5]][6] , (missi[h][1][1]-cam_x)*zoom*cam_z/(cam_z-missi[h][1][5]*zoom)+love.graphics.getWidth()/2 , (missi[h][1][2]-cam_y)*zoom*cam_z/(cam_z-missi[h][1][5]*zoom)+love.graphics.getHeight()/2 ,missi[h][2][3],zoom*cam_z/(cam_z-missi[h][1][5]*zoom)/2*math.cos(missi[h][2][4]),zoom*cam_z/(cam_z-missi[h][1][5]*zoom)/2,missilist[missi[h][5]][6]:getWidth()/2,missilist[missi[h][5]][6]:getHeight()/2)
			end
        end
		love.graphics.setCanvas(ligth)
		love.graphics.setColor(255,255,255)
		for i,h in ipairs(j[1]) do
			love.graphics.setColor(255,255,255)
			love.graphics.draw( ombhaut , (unit[h][1][3]-cam_x+(unit[h][1][5]-unit[h][18])/2)*zoom*cam_z/(cam_z-unit[h][1][5]*zoom)+love.graphics.getWidth()/2 , (unit[h][1][4]-cam_y+(unit[h][1][5]-unit[h][18])/2)*zoom*cam_z/(cam_z-unit[h][1][5]*zoom)+love.graphics.getHeight()/2 ,.75,zoom*cam_z/(cam_z-unit[h][18]*zoom),zoom*cam_z/(cam_z-unit[h][18]*zoom),54,60)
		end
		love.graphics.setCanvas()
		love.graphics.setBlendMode( "subtractive" )
		love.graphics.setColor(255,255,255)
		love.graphics.draw( ligth , 0 , 0 )
        ligth:clear()
		love.graphics.setBlendMode( "alpha" )
		for i,h in ipairs(j[1]) do
			local difx = 7*math.cos(unit[h][10][6]+.5*math.pi)
			local dify = 7*math.sin(unit[h][10][6]+.5*math.pi)
	--{arme,pied gauche{x,y,x2,y2},pied droit{x,y,x2,y2},genous gauche{x,y},genous droit{x,y}}
			local diud = math.sqrt((unit[h][16][2][1]-unit[h][1][3]-difx)^2+(unit[h][16][2][2]-unit[h][1][4]-dify)^2)
			local diug = math.sqrt((unit[h][16][3][1]-unit[h][1][3]+difx)^2+(unit[h][16][3][2]-unit[h][1][4]+dify)^2)
			local aud = math.atan2((unit[h][16][2][2]-unit[h][1][4]-dify),(unit[h][16][2][1]-unit[h][1][3]-difx))
			local aug = math.atan2((unit[h][16][3][2]-unit[h][1][4]+dify),(unit[h][16][3][1]-unit[h][1][3]+difx))
			--love.graphics.setColor(120+unit[h][1][5]/2,120+unit[h][1][5]/2,120+unit[h][1][5]/2)
			love.graphics.draw( jambelist[unit[h][15][4]][4][1] , (unit[h][16][2][1]-cam_x)*zoom*cam_z/(cam_z-unit[h][1][5]*zoom)+love.graphics.getWidth()/2 , (unit[h][16][2][2]-cam_y)*zoom*cam_z/(cam_z-unit[h][1][5]*zoom)+love.graphics.getHeight()/2 ,unit[h][10][6],zoom/2*cam_z/(cam_z-unit[h][1][5]*zoom),zoom/2*cam_z/(cam_z-unit[h][1][5]*zoom),20,jambelist[unit[h][15][4]][4][1]:getHeight()/2)
			love.graphics.draw( jambelist[unit[h][15][4]][4][1] , (unit[h][16][3][1]-cam_x)*zoom*cam_z/(cam_z-unit[h][1][5]*zoom)+love.graphics.getWidth()/2 , (unit[h][16][3][2]-cam_y)*zoom*cam_z/(cam_z-unit[h][1][5]*zoom)+love.graphics.getHeight()/2 ,unit[h][10][6],zoom/2*cam_z/(cam_z-unit[h][1][5]*zoom),-zoom/2*cam_z/(cam_z-unit[h][1][5]*zoom),20,jambelist[unit[h][15][4]][4][1]:getHeight()/2)
			love.graphics.draw( jambelist[unit[h][15][4]][4][2] , (unit[h][1][3]+difx-cam_x)*zoom*cam_z/(cam_z-unit[h][1][5]*zoom)+love.graphics.getWidth()/2 , (unit[h][1][4]+dify-cam_y)*zoom*cam_z/(cam_z-unit[h][1][5]*zoom)+love.graphics.getHeight()/2 ,aud,(diud)/(jambelist[unit[h][15][4]][4][3]:getWidth())*zoom*cam_z/(cam_z-unit[h][1][5]*zoom),zoom/2*cam_z/(cam_z-unit[h][1][5]*zoom),0,jambelist[unit[h][15][4]][4][3]:getHeight()/2)
			love.graphics.draw( jambelist[unit[h][15][4]][4][2] , (unit[h][1][3]-difx-cam_x)*zoom*cam_z/(cam_z-unit[h][1][5]*zoom)+love.graphics.getWidth()/2 , (unit[h][1][4]-dify-cam_y)*zoom*cam_z/(cam_z-unit[h][1][5]*zoom)+love.graphics.getHeight()/2 ,aug,(diug)/(jambelist[unit[h][15][4]][4][2]:getWidth())*zoom*cam_z/(cam_z-unit[h][1][5]*zoom),-zoom/2*cam_z/(cam_z-unit[h][1][5]*zoom),0,jambelist[unit[h][15][4]][4][2]:getHeight()/2)
		end
		for i,h in ipairs(j[1]) do
			love.graphics.draw( torcelist[unit[h][15][4]][4][1] , (unit[h][1][3]-cam_x)*zoom*cam_z/(cam_z-(unit[h][1][5]+20)*zoom)+love.graphics.getWidth()/2 , (unit[h][1][4]-cam_y)*zoom*cam_z/(cam_z-(unit[h][1][5]+20)*zoom)+love.graphics.getHeight()/2 ,unit[h][10][3],zoom/2*cam_z/(cam_z-(unit[h][1][5]+20)*zoom),zoom/2*cam_z/(cam_z-(unit[h][1][5]+20)*zoom),torcelist[unit[h][15][4]][4][1]:getWidth()/2,torcelist[unit[h][15][4]][4][1]:getHeight()/2)
			local gupox = unit[h][1][3]+30*math.cos(unit[h][10][3]-.2)+unit[h][10][11]
			local gupoy = unit[h][1][4]+30*math.sin(unit[h][10][3]-.2)+unit[h][10][12]
			--local poi2x = gupox-5*math.cos(unit[h][10][5])*math.cos(unit[h][10][9])
			--local poi2y = gupoy-5*math.sin(unit[h][10][5])*math.cos(unit[h][10][9])
			--local poi1x = gupox+15*math.cos(unit[h][10][5])*math.cos(unit[h][10][9])
			--local poi1y = gupoy+15*math.sin(unit[h][10][5])*math.cos(unit[h][10][9])
			local difx = 15*math.cos(unit[h][10][3]+.5*math.pi)
			local dify = 15*math.sin(unit[h][10][3]+.5*math.pi)
			local diud = math.sqrt((unit[h][20][1][1]-difx)^2+(unit[h][20][1][2]-dify)^2)
			local diug = math.sqrt((unit[h][20][2][1]+difx)^2+(unit[h][20][2][2]+dify)^2)
			local aud = math.atan2((unit[h][20][1][2]-dify),(unit[h][20][1][1]-difx))
			local aug = math.atan2((unit[h][20][2][2]+dify),(unit[h][20][2][1]+difx))
			love.graphics.draw( torcelist[unit[h][15][4]][4][2] , (unit[h][1][3]-difx-cam_x)*zoom*cam_z/(cam_z-(unit[h][1][5]+23)*zoom)+love.graphics.getWidth()/2 , (unit[h][1][4]-dify-cam_y)*zoom*cam_z/(cam_z-(unit[h][1][5]+23)*zoom)+love.graphics.getHeight()/2 ,aug,(diug)/(torcelist[unit[h][15][4]][4][2]:getWidth()-10)*zoom*cam_z/(cam_z-(unit[h][1][5]+23)*zoom),-zoom/2*cam_z/(cam_z-(unit[h][1][5]+23)*zoom),10,torcelist[unit[h][15][4]][4][2]:getHeight()/2)
			love.graphics.draw( torcelist[unit[h][15][4]][4][2] , (unit[h][1][3]+difx-cam_x)*zoom*cam_z/(cam_z-(unit[h][1][5]+23)*zoom)+love.graphics.getWidth()/2 , (unit[h][1][4]+dify-cam_y)*zoom*cam_z/(cam_z-(unit[h][1][5]+23)*zoom)+love.graphics.getHeight()/2 ,aud,(diud)/(torcelist[unit[h][15][4]][4][2]:getWidth()-10)*zoom*cam_z/(cam_z-(unit[h][1][5]+23)*zoom),zoom/2*cam_z/(cam_z-(unit[h][1][5]+23)*zoom),10,torcelist[unit[h][15][4]][4][2]:getHeight()/2)
		end
		for i,h in ipairs(j[5]) do
			love.graphics.draw( weplist[wep[h][7]][11] , (wep[h][1][1]-cam_x)*zoom*cam_z/(cam_z-(wep[h][1][3])*zoom)+love.graphics.getWidth()/2 , (wep[h][1][2]-cam_y)*zoom*cam_z/(cam_z-(wep[h][1][3])*zoom)+love.graphics.getHeight()/2 ,wep[h][2][3],zoom/2*cam_z/(cam_z-(wep[h][1][3])*zoom)*math.cos(wep[h][2][4]),zoom/2*cam_z/(cam_z-(wep[h][1][3])*zoom),weplist[wep[h][7]][11]:getWidth()/2,weplist[wep[h][7]][11]:getHeight()/2)
		end
		for i,h in ipairs(j[1]) do
			love.graphics.draw( epaulelist[unit[h][15][4]][4] , (unit[h][1][3]-cam_x)*zoom*cam_z/(cam_z-(unit[h][1][5]+27)*zoom)+love.graphics.getWidth()/2 , (unit[h][1][4]-cam_y)*zoom*cam_z/(cam_z-(unit[h][1][5]+27)*zoom)+love.graphics.getHeight()/2 ,unit[h][10][4]+math.pi/2,zoom/2*cam_z/(cam_z-(unit[h][1][5]+27)*zoom),zoom/2*cam_z/(cam_z-(unit[h][1][5]+27)*zoom),-10,epaulelist[unit[h][15][4]][4]:getHeight()/2)
			love.graphics.draw( epaulelist[unit[h][15][4]][4] , (unit[h][1][3]-cam_x)*zoom*cam_z/(cam_z-(unit[h][1][5]+27)*zoom)+love.graphics.getWidth()/2 , (unit[h][1][4]-cam_y)*zoom*cam_z/(cam_z-(unit[h][1][5]+27)*zoom)+love.graphics.getHeight()/2 ,unit[h][10][4]+math.pi/2,-zoom/2*cam_z/(cam_z-(unit[h][1][5]+27)*zoom),zoom/2*cam_z/(cam_z-(unit[h][1][5]+27)*zoom),-10,epaulelist[unit[h][15][4]][4]:getHeight()/2)
		end
		for i,h in ipairs(j[1]) do
			love.graphics.draw( casquelist[unit[h][15][4]][4] , (unit[h][1][3]-cam_x)*zoom*cam_z/(cam_z-(unit[h][1][5]+30)*zoom)+love.graphics.getWidth()/2 , (unit[h][1][4]-cam_y)*zoom*cam_z/(cam_z-(unit[h][1][5]+30)*zoom)+love.graphics.getHeight()/2 ,unit[h][10][7],zoom/2*cam_z/(cam_z-(unit[h][1][5]+30)*zoom),zoom/2*cam_z/(cam_z-(unit[h][1][5]+30)*zoom),casquelist[unit[h][15][4]][2][1],casquelist[unit[h][15][4]][2][2])
		end
		for i,h in ipairs(j[2]) do
			if missi[h][3] == 1 then
				love.graphics.draw( missilist[missi[h][5]][4] , (missi[h][1][1]-cam_x)*zoom*cam_z/(cam_z-missi[h][1][5]*zoom)+love.graphics.getWidth()/2 , (missi[h][1][2]-cam_y)*zoom*cam_z/(cam_z-missi[h][1][5]*zoom)+love.graphics.getHeight()/2 ,missi[h][2][3],zoom*cam_z/(cam_z-missi[h][1][5]*zoom)/2*math.sqrt(missi[h][2][1]^2+missi[h][2][2]^2)/math.sqrt(missi[h][2][1]^2+missi[h][2][2]^2+missi[h][2][4]^2),zoom*cam_z/(cam_z-missi[h][1][5]*zoom)/2,missilist[missi[h][5]][4]:getWidth()/2,missilist[missi[h][5]][4]:getHeight()/2)
			end
		end
	end
	if noirceur > 1 then
		love.graphics.setColor(255,255,255,noirceur)
		love.graphics.setCanvas(ligth)
		love.graphics.rectangle( "fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight() )
		love.graphics.setBlendMode( "subtractive" )
		for i,h in ipairs(unit) do
			if h[19] == true then
				local gupox = h[1][3]+30*math.cos(h[10][3]-.2)+h[10][11]
				local gupoy = h[1][4]+30*math.sin(h[10][3]-.2)+h[10][12]
				love.graphics.draw( lampelist[h[15][7]][2] , (gupox-cam_x)*zoom*cam_z/(cam_z-h[1][5]*zoom)+love.graphics.getWidth()/2 , (gupoy-cam_y)*zoom*cam_z/(cam_z-h[1][5]*zoom)+love.graphics.getHeight()/2 ,h[10][5],15*zoom*cam_z/(cam_z-h[1][5]*zoom)/2,15*zoom*cam_z/(cam_z-h[1][5]*zoom)/2*math.cos(h[10][9]),obscur:getWidth()/4,obscur:getHeight()/2)
			end
		end
		for i,h in ipairs(effetl) do
			love.graphics.draw( effetlistl[h[10]][9] , (h[1]-cam_x)*zoom*cam_z/(cam_z-h[3]*zoom)+love.graphics.getWidth()/2 , (h[2]-cam_y)*zoom*cam_z/(cam_z-h[3]*zoom)+love.graphics.getHeight()/2 ,h[8],h[7]*zoom*cam_z/(cam_z-h[3]*zoom)/2,h[7]*zoom*cam_z/(cam_z-h[3]*zoom)/2,effetlistl[h[10]][9]:getWidth()/2,effetlistl[h[10]][9]:getHeight()/2)
		end
		love.graphics.setCanvas()
		love.graphics.setBlendMode( "subtractive" )
		love.graphics.setColor(255,255,255)
		love.graphics.draw( ligth , 0 , 0 )
        ligth:clear()
		love.graphics.setBlendMode( "alpha" )
	end
	love.graphics.setColor(255,255,255)
	--for i,h in ipairs(unit) do
	--	love.graphics.print( h[15][6] ,(h[1][1]-cam_x)*zoom*cam_z/(cam_z-h[1][5]*zoom)+love.graphics.getWidth()/2 , (h[1][2]-cam_y)*zoom*cam_z/(cam_z-h[1][5]*zoom)+love.graphics.getHeight()/2)
	--end
	--for i,h in ipairs(wep) do
	--	love.graphics.print( h[3] ,(h[1][1]-cam_x)*zoom*cam_z/(cam_z-(h[1][3]+20)*zoom)+love.graphics.getWidth()/2 , (h[1][2]-cam_y)*zoom*cam_z/(cam_z-(h[1][3]+20)*zoom)+love.graphics.getHeight()/2)
	--end
	love.graphics.draw( imagu , (moux-cam_x)*zoom*cam_z/(cam_z-mouz*zoom)+love.graphics.getWidth()/2 , (mouy-cam_y)*zoom*cam_z/(cam_z-mouz*zoom)+love.graphics.getHeight()/2 ,0,zoom*cam_z/(cam_z-mouz*zoom)/2,zoom*cam_z/(cam_z-mouz*zoom)/2,25,25)
	--love.graphics.print( math.floor(mouz) ,10+(moux-cam_x)*zoom*cam_z/(cam_z-mouz*zoom)+love.graphics.getWidth()/2 , (mouy-cam_y-3)*zoom*cam_z/(cam_z-mouz*zoom)+love.graphics.getHeight()/2 )
	--for r,g in ipairs(carto) do
	--	for i,h in ipairs(carto[r]) do	
	--		love.graphics.draw( imagu , (r*100-cam_x)*zoom+love.graphics.getWidth()/2 , (i*100-cam_y)*zoom+love.graphics.getHeight()/2 ,0,.1,.1)
	--	end
	--end
	love.graphics.print( math.floor(fps+.5) , 100  , 100  )
	love.graphics.print( zoom , 100  , 150  )
end

