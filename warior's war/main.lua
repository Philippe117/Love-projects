function love.load()
	--if love.graphics.checkMode( 1024, 768, true ) == true then
	--	love.graphics.toggleFullscreen( )
	--end
--	bruide = love.audio.newSource( "2.ogg", "static" )
	anima = 0
	gotocoin = 0
	iconed = love.graphics.newImage( "titre.png" )
	charg = love.graphics.newImage( "loading.png" )
	etoile = love.graphics.newImage( "etoile.png" )
	plus = love.graphics.newImage( "plus.png" )
	phase = 2

	loa = 0
	bouton = 0
	bout = {}
	menuprincipal()
	bruideclic = love.audio.newSource( "MouseClick1.ogg", "static" )
	musiquedefon = love.audio.newSource( "musmenu.mp3", "Stream")
	cartechoisi = 1
  
	racelist = {}
	racelist[1] = {"Moderne",16}
	racelist[2] = {"Napoleonien",2}
	racelist[3] = {"Romain",6}
	--racelist = {1=nom,2=unit}
	fps = 60
	ita = {}
	ita[1] = {1,{0,0},{0,0},{},{300,0,0,0},{255,255,255},{{love.graphics.getWidth()/2-200,60,0,1,love.graphics.newImage( "poiger.png" ),0},{love.graphics.getWidth()/2-100,60,0,1,love.graphics.newImage( "poicon.png" )},{love.graphics.getWidth()/2,60,0,1,love.graphics.newImage( "poicreu.png" )},{love.graphics.getWidth()/2+100,60,0,1,love.graphics.newImage( "poilon.png" )},{love.graphics.getWidth()/2+200,60,0,1,love.graphics.newImage( "poichoc.png" )}}}
	ita[2] = {1,{0,0},{0,0},{},{300,0,0,0},{255,150,150},{{love.graphics.getWidth()/2-200,60,0,1,123,0},{love.graphics.getWidth()/2-100,60,0,1,123},{love.graphics.getWidth()/2,60,0,1,123},{love.graphics.getWidth()/2+100,60,0,1,123},{love.graphics.getWidth()/2+200,60,0,1,123}}}
	ita[3] = {1,{0,0},{0,0},{},{300,0,0,0},{150,255,150},{{love.graphics.getWidth()/2-200,60,0,1,123,0},{love.graphics.getWidth()/2-100,60,0,1,123},{love.graphics.getWidth()/2,60,0,1,123},{love.graphics.getWidth()/2+100,60,0,1,123},{love.graphics.getWidth()/2+200,60,0,1,123}}}
	ita[4] = {1,{0,0},{0,0},{},{300,0,0,0},{150,150,255},{{love.graphics.getWidth()/2-200,60,0,1,123,0},{love.graphics.getWidth()/2-100,60,0,1,123},{love.graphics.getWidth()/2,60,0,1,123},{love.graphics.getWidth()/2+100,60,0,1,123},{love.graphics.getWidth()/2+200,60,0,1,123}}}
	ita[5] = {1,{0,0},{0,0},{},{300,0,0,0},{150,255,255},{{love.graphics.getWidth()/2-200,60,0,1,123,0},{love.graphics.getWidth()/2-100,60,0,1,123},{love.graphics.getWidth()/2,60,0,1,123},{love.graphics.getWidth()/2+100,60,0,1,123},{love.graphics.getWidth()/2+200,60,0,1,123}}}
	--ita{ 1 build time    , 2{moyene position}  , 3 direct enemie  ,4 obstacle     ,5 priorité   ,6 couleur  ,7 ordre   }
	-- priotité = 1 gold , 2 food , 3 combatent , 4 creuseur ,
	vortexson = love.audio.newSource( "votexson.ogg", "static" )
	musre = 1
	cadre = love.graphics.newImage( "cadre.png" )
	maper = love.graphics.newImage( "carre2.png" )
	maperer = love.graphics.newImage( "carre2.2.png" )
	loade = 0
--love.audio.play(bruide)
	crono = 0
end
function menuprincipal()
	phase = 2
	f = love.graphics.newFont( "comic.ttf", 30 )
	bout = {}
	bout[1] = {100,200,100,50,love.graphics.newImage( "bloc.png" ),"Escarmouche"}
	bout[2] = {100,700,100,50,love.graphics.newImage( "bloc.png" ),"Quiter"}
	bout[3] = {100,100,100,50,love.graphics.newImage( "bloc.png" ),"campagne"}
end
function menuescarmouche()
	phase = 3
	f = love.graphics.newFont( "comic.ttf",30 )
	love.filesystem.load("carte/infocarte.lua")()
	jou = {}
	jou[1] = 0
	jou[2] = 0
	jou[3] = 0
	jou[4] = 0
	jou[5] = 0
	jou[6] = 0
	jou[7] = 0
	jou[8] = 0
	bout = {}
	bout[1] = {900,700,100,50,love.graphics.newImage( "bloc.png" ),"Comencer"}
	bout[2] = {100,700,100,50,love.graphics.newImage( "blocfleche2.png" ),""}
	bout[3] = {700,100,200,50,love.graphics.newImage( "bloc.png" ),"Choisir carte\n"..cartelist[cartechoisi][1]..""}
	for i,h in ipairs(cartelist[cartechoisi][2]) do
		cartelist[cartechoisi][2][i][4] = i
		cartelist[cartechoisi][2][i][5] = 1
		bout[3+i*2] = {150,150+50*i,50,25,love.graphics.newImage( "bloc.png" ),"race"}
		bout[3+i*2-1] = {75,150+50*i,25,25,love.graphics.newImage( "bloc.png" ),cartelist[cartechoisi][2][i][4]}
		jou[i] = 1
	end
	marque = love.graphics.newImage( "emplacement.png" )
	map = love.graphics.newImage( "carte/"..cartelist[cartechoisi][1]..".png" )
	mapsky = love.graphics.newImage( "carte/sky"..cartelist[cartechoisi][4]..".png" )
end
function menucampagne()
	phase = 4
	f = love.graphics.newFont( "comic.ttf",30 )
	bout = {}
	bout[1] = {100,100,100,50,love.graphics.newImage( "bloc.png" ),"Continuer"}
	bout[2] = {100,200,100,50,love.graphics.newImage( "bloc.png" ),"Nouvelle campagne"}
	bout[3] = {100,300,100,50,love.graphics.newImage( "bloc.png" ),"Charger progression"}
	bout[4] = {100,700,100,50,love.graphics.newImage( "blocfleche2.png" ),""}
end
function menuchoidecarte()
	phase = 5
	f = love.graphics.newFont( "comic.ttf", 30 )
	ff = love.graphics.newFont( "comic.ttf", 20 )
	bout = {}
	bout[1] = {100,700,100,50,love.graphics.newImage( "blocfleche2.png" ),""}
	bout[2] = {250,300,50,100,love.graphics.newImage( "blocfleche2.png" ),""}
	bout[3] = {750,300,50,100,love.graphics.newImage( "blocfleche.png" ),""}
end
function clicbout(bu)
	if bu == "l" then
		if phase == 1 then
			if bouton == 1 then
				menuprincipal()
				love.audio.stop(bruideclic)
				love.audio.play(bruideclic)
			end
		elseif phase == 2 then
			if bouton == 1 then
				menuescarmouche()
				love.audio.stop(bruideclic)
				love.audio.play(bruideclic)
			elseif bouton == 2 then
				love.event.push('q')
			elseif bouton == 3 then
				menucampagne()
				love.audio.stop(bruideclic)
				love.audio.play(bruideclic)
			end
		elseif phase == 3 then
			if bouton == 1 then
				phase = 0
				bout = {}
				loa = 2
				--love.audio.stop(musiquedefon)
				love.audio.stop(bruideclic)
				love.audio.play(bruideclic)
				loade = 1
			elseif bouton == 2 then
				menuprincipal()
				love.audio.stop(bruideclic)
				love.audio.play(bruideclic)
			elseif bouton == 3 then
				menuchoidecarte()
				love.audio.stop(bruideclic)
				love.audio.play(bruideclic)
			end
			for i,h in ipairs(cartelist[cartechoisi][2]) do
				if bouton == 3+i*2 then
					if racelist[h[5]+1] ~= nil then
						cartelist[cartechoisi][2][i][5] = cartelist[cartechoisi][2][i][5]+1
					else
						cartelist[cartechoisi][2][i][5] = 1
					end
				end
				if bouton == 3+i*2-1 then
					jou[cartelist[cartechoisi][2][i][4]] = 0
					cartelist[cartechoisi][2][i][4] = cartelist[cartechoisi][2][i][4]+1
					if h[4] > 5 then
						cartelist[cartechoisi][2][i][4] = 1
					end
					corect = 1
					for e,g in ipairs(cartelist[cartechoisi][2]) do
						if h[4] == g[4]
						and e ~= i then
							corect = 0
						end
					end
					if corect == 0 then
						while corect == 0 do
							cartelist[cartechoisi][2][i][4] = cartelist[cartechoisi][2][i][4]+1
							if h[4] > 5 then
								cartelist[cartechoisi][2][i][4] = 1
							end
							corect = 1
							for e,g in ipairs(cartelist[cartechoisi][2]) do
								if h[4] == g[4]
								and e ~= i then
									corect = 0
								end
							end
						end
					end
					jou[cartelist[cartechoisi][2][i][4]] = 1
					bout[3+i*2-1] = {75,150+50*i,25,25,love.graphics.newImage( "bloc.png" ),cartelist[cartechoisi][2][i][4]}
				end
			end
		elseif phase == 4 then
			if bouton == 1 then
				love.audio.stop(bruideclic)
				love.audio.play(bruideclic)
			elseif bouton == 2 then
				love.audio.stop(bruideclic)
				love.audio.play(bruideclic)
			elseif bouton == 3 then
				love.audio.stop(bruideclic)
				love.audio.play(bruideclic)
			elseif bouton == 4 then
				phase = 2
				menuprincipal()
				love.audio.stop(bruideclic)
				love.audio.play(bruideclic)
			end
		elseif phase == 5 then
			if bouton == 1 then
				menuescarmouche()
				love.audio.stop(bruideclic)
				love.audio.play(bruideclic)
			elseif bouton == 2 then
				if cartelist[cartechoisi-1] ~= nil then
					cartechoisi = cartechoisi-1
					map = love.graphics.newImage( "carte/"..cartelist[cartechoisi][1]..".png" )
					mapsky = love.graphics.newImage( "carte/sky"..cartelist[cartechoisi][4]..".png" )
					love.audio.stop(bruideclic)
					love.audio.play(bruideclic)
				else
					while cartelist[cartechoisi+1] ~= nil do
						cartechoisi = cartechoisi+1
					end
					map = love.graphics.newImage( "carte/"..cartelist[cartechoisi][1]..".png" )
					mapsky = love.graphics.newImage( "carte/sky"..cartelist[cartechoisi][4]..".png" )
				end
			elseif bouton == 3 then
				if cartelist[cartechoisi+1] ~= nil then
					cartechoisi = cartechoisi+1
					map = love.graphics.newImage( "carte/"..cartelist[cartechoisi][1]..".png" )
					mapsky = love.graphics.newImage( "carte/sky"..cartelist[cartechoisi][4]..".png" )
					love.audio.stop(bruideclic)
					love.audio.play(bruideclic)
				else
					cartechoisi = 1
					map = love.graphics.newImage( "carte/"..cartelist[cartechoisi][1]..".png" )
					mapsky = love.graphics.newImage( "carte/sky"..cartelist[cartechoisi][4]..".png" )
				end
			end
		end
	end
	if bu == "r" then
		if phase == 3 then
			for i,h in ipairs(cartelist[cartechoisi][2]) do
				if bouton == 3+i*2 then
					if racelist[h[5]-1] ~= nil then
						cartelist[cartechoisi][2][i][5] = cartelist[cartechoisi][2][i][5]-1
					else
						while racelist[h[5]+1] ~= nil do
							cartelist[cartechoisi][2][i][5] = cartelist[cartechoisi][2][i][5]+1
						end
					end
				end
				if bouton == 3+i*2-1 then
					jou[cartelist[cartechoisi][2][i][4]] = 0
					cartelist[cartechoisi][2][i][4] = cartelist[cartechoisi][2][i][4]-1
					if h[4] < 1 then
						cartelist[cartechoisi][2][i][4] = 5
					end
					corect = 1
					for e,g in ipairs(cartelist[cartechoisi][2]) do
						if h[4] == g[4]
						and e ~= i then
							corect = 0
						end
					end
					if corect == 0 then
						while corect == 0 do
							cartelist[cartechoisi][2][i][4] = cartelist[cartechoisi][2][i][4]-1
							if h[4] < 1 then
								cartelist[cartechoisi][2][i][4] = 5
							end
							corect = 1
							for e,g in ipairs(cartelist[cartechoisi][2]) do
								if h[4] == g[4]
								and e ~= i then
									corect = 0
								end
							end
						end
					end
					jou[cartelist[cartechoisi][2][i][4]] = 1
					bout[3+i*2-1] = {75,150+50*i,25,25,love.graphics.newImage( "bloc.png" ),cartelist[cartechoisi][2][i][4]}
				end
			end
		end
	end
end
	--phase {0=load,1=play,2=menuprinc,3=escarmouche,4=menupause}
function loading()
	clir = 0
	clil = 0
	env = love.audio.newSource( "lobbybackgroundsound.ogg", "Streaming" )
	env:setLooping( true )
	mus = {{"mus1.mp3",200},{"mus2.mp3",210},{"mus3.mp3",200},{"mus4.mp3",120},{"mus5.mp3",180},{"mus6.mp3",136},{"mus7.mp3",60},{"mus8.mp3",150}}
	trew = table.maxn(mus)
	moux = 0
	mouy = 0
	f = love.graphics.newFont( "comic.ttf", 30 )
	ff = love.graphics.newFont( "comic.ttf", 15 )
	fff = love.graphics.newFont( "comic.ttf", 100 )
	ffff = love.graphics.newFont( "comic.ttf", 12 )
	love.graphics.setFont( f )
	map = love.image.newImageData( "carte/"..cartelist[cartechoisi][1]..".png")

	soundlist = {}
	timeson = 0

	mape = love.graphics.newImage( map )
	mapea = love.graphics.newImage( map )
	mape:setFilter( "nearest","nearest" )


	gri = love.graphics.newImage( "grille.png" )
	mapo = love.graphics.newImage( "carte/sky"..cartelist[cartechoisi][4]..".png" )
	maperx = ((mape:getWidth()-10)/4+.68*love.graphics.getWidth())/mapo:getWidth()
	mapery = (mape:getHeight()/4+.85*love.graphics.getHeight())/mapo:getHeight()
	sour = love.graphics.newImage( "sourie.png" )
	sourp = love.graphics.newImage( "souriep.png" )
	stop = love.graphics.newImage( "block.png" )
	stand = love.graphics.newImage( "stand.png" )
	creus = love.graphics.newImage( "creuse.png" )
	fle = love.graphics.newImage( "fleche.png" )
	jump = love.graphics.newImage( "jump.png" )
	fum = love.graphics.newImage( "fumee.png" )
	interd = love.graphics.newImage( "interdit.png" )
	mart = love.graphics.newImage( "marteau.png" )
	sang = love.graphics.newImage( "sang.png" )
	sang2 = love.graphics.newImage( "sang2.png" )
	sang3 = love.graphics.newImage( "sang3.png" )
	sang4 = love.graphics.newImage( "sang4.png" )
	boule = love.graphics.newImage( "boule.png" )
	bule = love.graphics.newImage( "bule.png" )
	toc = {}
	toc[1] = love.sound.newSoundData( "heatscanneridle2.ogg" )
	toc[2] = love.sound.newSoundData( "heatscanneridle3.ogg" )
	toc[3] = love.sound.newSoundData( "heatscanneridle4.ogg" )
	toc[4] = love.sound.newSoundData( "heatscanneridle5.ogg" )
	stos = love.sound.newSoundData( "RallyPointPlace1.ogg" )
	nearest = 1
	pluseco = {0,0,0,0,0}
	moineco = {0,0,0,0,0}
	feue = love.graphics.newImage( "feu.png" )
	maxunit = 50
	newm = 0
	refre = 0
	zoom = 5
	DTR = 180/math.pi
	elu = 1
	ps = 10
	T1 = 2
	play = 1
	sel = love.graphics.newImage( "selec.png" )
	goldico = love.graphics.newImage( "gold.png" )
	manaico = love.graphics.newImage( "mana.png" )
	remind = 1
	expl = love.graphics.newImage( "explo.png" )
	cloc = love.graphics.newImage( "cloc.png" )
	cloc2 = love.graphics.newImage( "cloc2.png" )
	vortex = love.graphics.newImage( "vortex.png" )
	vortex2 = love.graphics.newImage( "vortex2.png" )
	vortex3 = love.graphics.newImage( "vortex3.png" )
	vortex4 = love.graphics.newImage( "vortex4.png" )
	gold = {}
	gold[1] = 200
	gold[2] = 200
	gold[3] = 200
	gold[4] = 200
	gold[5] = 200
	goldmax = {}
	goldmax[1] = 200
	goldmax[2] = 200
	goldmax[3] = 200
	goldmax[4] = 200
	goldmax[5] = 200

	food = {}
	food[1] = 0
	food[2] = 0
	food[3] = 0
	food[4] = 0
	food[5] = 0
	foodmax = {}
	foodmax[1] = 10
	foodmax[2] = 10
	foodmax[3] = 10
	foodmax[4] = 10
	foodmax[5] = 10
	goldtime = 0
	efftime = 0
	intx = love.graphics.getWidth()/2
	inty = 0
	intyr = 0
	intn = 0
	inta = 0
	unitlist = {}
	missilist = {}
	ide = 1
	love.filesystem.load("unit.lua")()
	unit = {}
	--{ 1 { 1 X , 2 Y , 3 x2 , 4 y2 } , 2 { 1 M , 2 N } , 3 { 1 appang{ 1 angjambe , 2 angcorp , 3 angtète } , 2 poid , 3 vitesse , 4 équipe , 5 type d'unité } , 4 phase , 5 { 1 déplacement , 2 HP , 3 Timer de mor , 4 timer d'ataque , 5 { 1 ciblex , 2 cibley,3 cibleid } , 6 framej , 7 framet ,8 speed } , 6  direc , 7 mana , 8 angpied , 9 ability timer , 10 maitre , 11 acolite , 12 id, 13 {besoin 1 clic "r" ou "l", 2 force},14 createtime 15 time,16 angbuild , 17 posbuiy,18 bouge }
	--phase {0 = mort , 1 = move , 2 = combat , 3 comb move , 4 creuse , 5 stop , 6 lance , 7 construit }
	poivi = love.graphics.newImage( "poitup.png" )
	aura = love.graphics.newImage( "ora.png" )
	missi = {}


		--{ 1 poid , 2 speed , 3 damage , 4 force , 5 scale , 6 app , 7 timer , 8 destru , 9 app boom ,10 { coloboom}, 11 nbkill , 12 nb rebon , 13 force rebon , 14 taille , 15 son , 16 (1 nb 2 frix 3 sc 4 +sc 5 r+ 6 a 7 a+ 8 grav 9 frix 10 img 11 timer 12 r 13 v 14 b 15 r+ 16 v+ 17 b+ )}



	--{ 1 X , 2 Y , 3 M , 4 N , 5 timer ,6 type , 7 taille , 8 team , 9 direc , 10 mode , 11 rebon , 12 dx , 13 dy  }
	effet = {}
	--{ 1 X , 2 Y , 3 M , 4 N , 5 sx ,6 sy , 7 sx+ , 8 sy+ , 9 r , 10 r+ , 11 a , 12 a+ , 13 img , 14 timer , 15 grav , 16 frix }
	-- [1] team
	-- [2] = ( 1 = bloc{id} , 2 = jump{m,n,id} , 3 =
	cartog = {}
	cartogt = {}
	-- [1] team
	-- [2] = ( 1 = bloc{id} , 2 = jump{m,n,id} , 3 =
	wx = 1
	while wx < mape:getWidth()/10+1 do
		cartog[wx] = {}
		cartogt[wx] = {false,false,0}
		--cartogt[wx] = {bloqueur,trempoline,nb de unit}
		wx = wx+1
	end
	for i,h in ipairs(unitlist) do
		number1 = h[2][1][1]
		number2 = h[2][1][2]
		number3 = h[2][1][3]
		number4 = h[2][1][4]
		h[2] = {{love.graphics.newImage( "app/unit/unit"..number3.."/unit 1,1.png" ),love.graphics.newImage( "app/unit/unit"..number3.."/unit 1,2.png" ),love.graphics.newImage( "app/unit/unit"..number3.."/unit 1,3.png" ),love.graphics.newImage( "app/unit/unit"..number3.."/unit 1,4.png" )},{love.graphics.newImage( "app/unit/unit"..number2.."/unit 2,1.png" )},{love.graphics.newImage( "app/unit/unit"..number1.."/unit 3,1.png" ),love.graphics.newImage( "app/unit/unit"..number1.."/unit 3,2.png" ),love.graphics.newImage( "app/unit/unit"..number1.."/unit 3,3.png" ),love.graphics.newImage( "app/unit/unit"..number1.."/unit 3,4.png" )},h[2][2],h[2][3],h[2][4],h[2][5],love.graphics.newImage( "app/unit/unit"..number4.."/unit icon.png" ),h[2][6],h[2][7],h[2][8]}
		if h[11][1] == 5 then
			h[11][10] = h[11][9]
			h[11][9] = h[11][8]
			h[11][2] = love.image.newImageData("app/batiment/obj"..h[11][2]..".png" )
			h[11][8] = h[11][7]
			h[11][7] = love.graphics.newImage(h[11][2])
		end
		if h[12][1] == 5 then
			h[12][10] = h[12][9]
			h[12][9] = h[12][8]
			h[12][2] = love.image.newImageData("app/batiment/obj"..h[12][2]..".png" )
			h[12][8] = h[12][7]
			h[12][7] = love.graphics.newImage(h[12][2])
		end
		if h[11][1] == 6 then
			h[11][8] = love.graphics.newImage("app/ability/sor"..h[11][8]..".png" )
		end
		if h[12][1] == 6 then
			h[12][8] = love.graphics.newImage("app/ability/sor"..h[12][8]..".png" )
		end
		if h[17][1] ~= 1 then
			h[17][1] = love.sound.newSoundData( "son/tire/"..h[17][1]..".ogg" )
		end
		if h[17][2] ~= 1 then
			h[17][2] = love.sound.newSoundData( "son/tire/"..h[17][2]..".ogg" )
		end
		if h[18] ~= 0 then
			h[18] = love.sound.newSoundData( "son/mort/"..h[18]..".ogg" )
		end
		h[21] = {0,0,0,0,0,0}
	end
	for i,h in ipairs(missilist) do
		h[6] = love.graphics.newImage( "app/projectile/missi"..h[6]..".png" )
		h[9] = love.graphics.newImage( "app/projectile/boom"..h[9]..".png" )
		if h[15][1] ~= 0 then
			h[15][1] = love.sound.newSoundData( "son/impact/"..h[15][1]..".ogg" )
		end
		if h[15][2] ~= 0 then
			h[15][2] = love.sound.newSoundData( "son/impact/"..h[15][2]..".ogg" )
		end
		if h[15][3] ~= 0 then
			h[15][3] = love.sound.newSoundData( "son/impact/"..h[15][3]..".ogg" )
		end
		if h[16][1] ~= 0 then
			h[16][10] = love.graphics.newImage( "app/effet/"..h[16][10]..".png" )
		end
	end
	--point 1 x 2 y 3 éta 4 dist


	particule = {}





	start()
end

function addparticule(ex,ey,em,en,tipe)


	table.insert(particule,{{ex,ey},{em,en},crono+1} )





end


function start()
	crono = 0
	love.audio.stop(musiquedefon)
	love.audio.play( env )
	musi = math.random(1,trew)
	musique = love.audio.newSource(  mus[musi][1], "Streaming")
	timermus = .1
	love.audio.play( vortexson )
	zoom = math.max(zoom,love.graphics.getWidth()/mape:getWidth(),love.graphics.getHeight()/mape:getHeight())
	cam_x = math.min(math.max(mape:getWidth(),love.graphics.getWidth()/2/zoom),mape:getWidth()/2-love.graphics.getWidth()/2/zoom)
	cam_y = math.min(math.max(mape:getHeight(),love.graphics.getHeight()/2/zoom),-love.graphics.getHeight()/2/zoom)
	for i,h in ipairs(cartelist[cartechoisi][2]) do
		if h[4] == 1 then
			zoom = math.max(zoom,love.graphics.getWidth()/mape:getWidth(),love.graphics.getHeight()/mape:getHeight())
			cam_x = math.min(math.max(h[1],love.graphics.getWidth()/2/zoom),mape:getWidth()-love.graphics.getWidth()/2/zoom)
			cam_y = math.min(math.max(h[2],love.graphics.getHeight()/2/zoom),mape:getHeight()-love.graphics.getHeight()/2/zoom)
		end
	end
	cade = 3
	loade = 0
end
function love.mousepressed( mx, my, bu )
	if phase == 1
	and cade == 0
	and loade == 0 then
		if play == 1
		or play == 0 then
			if ita[1][7][1][4] == 1
			or ita[1][7][1][6] == 1 then
				if bu == "l" then
					ita[1][7][1][3] = 2
				elseif bu == "r" then
					ita[1][7][1][3] = 0
					ita[1][7][1][1] = love.graphics.getWidth()/2-200
					ita[1][7][1][2] = 60
				end
			elseif ita[1][7][2][4] == 1
			or ita[1][7][2][6] == 1 then
				if bu == "l" then
					ita[1][7][2][3] = 2
				elseif bu == "r" then
					ita[1][7][2][3] = 0
					ita[1][7][2][1] = love.graphics.getWidth()/2-100
					ita[1][7][2][2] = 60
				end
			elseif ita[1][7][3][4] == 1
			or ita[1][7][3][6] == 1 then
				if bu == "l" then
					ita[1][7][3][3] = 2
				elseif bu == "r" then
					ita[1][7][3][3] = 0
					ita[1][7][3][1] = love.graphics.getWidth()/2
					ita[1][7][3][2] = 60
				end
			elseif ita[1][7][4][4] == 1
			or ita[1][7][4][6] == 1 then
				if bu == "l" then
					ita[1][7][4][3] = 2
				elseif bu == "r" then
					ita[1][7][4][3] = 0
					ita[1][7][4][1] = love.graphics.getWidth()/2+100
					ita[1][7][4][2] = 60
				end
			elseif ita[1][7][5][4] == 1
			or ita[1][7][5][6] == 1 then
				if bu == "l" then
					ita[1][7][5][3] = 2
				elseif bu == "r" then
					ita[1][7][5][3] = 0
					ita[1][7][5][1] = love.graphics.getWidth()/2+200
					ita[1][7][5][2] = 60
				end
			elseif near < 10
			and unit[nearest] ~= nil then
				moux = 0
				if bu == "l" then
					if unitlist[unit[nearest][3][5]][11][1] == 0 then
						if unitlist[unit[nearest][3][5]][12][3] == 0 then
							if unit[nearest][4] == 5 then
								unit[nearest][4] = 1
							else
								if timeson < crono then
									timeson = crono+.02
									table.insert(soundlist,{love.audio.newSource(stos),crono+.5})
									soundlist[table.maxn(soundlist)][1]:setVolume(math.max(math.min(.15*zoom/math.sqrt((unit[nearest][1][1]-cam_x)^2+(unit[nearest][1][2]-cam_y)^2)*140,2),.2))
									love.audio.play(soundlist[table.maxn(soundlist)][1])
								end

								unit[nearest][4] = 5
								unit[nearest][5][7] = 4





							end
						else
							if unit[nearest][18] == 0 then
								unit[nearest][18] = 1
							else
								if timeson < crono then
									timeson = crono+.02
									table.insert(soundlist,{love.audio.newSource(stos),crono+.5})
									soundlist[table.maxn(soundlist)][1]:setVolume(math.max(math.min(.15*zoom/math.sqrt((unit[nearest][1][1]-cam_x)^2+(unit[nearest][1][2]-cam_y)^2)*140,2),.2))
									love.audio.play(soundlist[table.maxn(soundlist)][1])
								end
								unit[nearest][18] = 0
								unit[nearest][5][7] = 4












							end
						end
					elseif unitlist[unit[nearest][3][5]][11][1] == 1 then
						if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][5] >= 0
						and gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][11][4] >= 0
						and food[unit[nearest][3][4]]+unitlist[unitlist[unit[nearest][3][5]][11][2]][16] <= math.min(foodmax[unit[nearest][3][4]],maxunit)
						and crono > unit[nearest][9] then
							gold[unit[nearest][3][4]] = gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][11][4]
							creation(unit[nearest][1][1]+math.random(-20,20)/10,unit[nearest][1][2]+math.random(-20,20)/10,unitlist[unit[nearest][3][5]][11][2],unit[nearest][3][4],unit[nearest][6] ,0)
							unit[nearest][5][4] = crono+unitlist[unit[nearest][3][5]][11][3]
							unit[nearest][9] = crono+unitlist[unit[nearest][3][5]][11][3]
	 						unit[nearest][7] = unit[nearest][7]-unitlist[unit[nearest][3][5]][11][5]
						end
					elseif unitlist[unit[nearest][3][5]][11][1] == 2 then
						if unit[nearest][4] == 6.1 then
							unit[nearest][4] = 1
						else
							unit[nearest][6] = unit[nearest][5][1]
							unit[nearest][4] = 6.1
							unit[nearest][5][7] = 4
						end
					elseif unitlist[unit[nearest][3][5]][11][1] == 3 then
							if unit[nearest][4] == 4.1 then
								unit[nearest][4] = 1
								unit[nearest][5][7] = 4
							else
								if coli(unit[nearest][1][1]-1,unit[nearest][1][2]+2*unitlist[unit[nearest][3][5]][2][9]+1,map) == false
								or coli(unit[nearest][1][1]+1,unit[nearest][1][2]+2*unitlist[unit[nearest][3][5]][2][9]+1,map) == false then
									unit[nearest][5][4] = crono+2*dote/math.sqrt(unitlist[unit[nearest][3][5]][11][2]^2+unitlist[unit[nearest][3][5]][11][3]^2)
									unit[nearest][4] = 4.1
									unit[nearest][18] = 1
								end
							end
					elseif unitlist[unit[nearest][3][5]][11][1] == 4 then
						if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][4] >= 0
						and gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][11][3] >= 0
						and crono > unit[nearest][9] then
							gold[unit[nearest][3][4]] = gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][11][3]
							unit[nearest][7] = unit[nearest][7]-unitlist[unit[nearest][3][5]][11][4]
							explosion( unit[nearest][1][1] , unit[nearest][1][2] , unitlist[unit[nearest][3][5]][11][5] , unitlist[unit[nearest][3][5]][11][6] , unitlist[unit[nearest][3][5]][11][8] , unitlist[unit[nearest][3][5]][11][7], unitlist[unit[nearest][3][5]][11][9],unit[nearest][3][4],.1)
							killing(nearest)
							table.insert(effet,{unit[nearest][1][1],unit[nearest][1][2],0,.01,.02*unitlist[unit[nearest][3][5]][11][7],.02*unitlist[unit[nearest][3][5]][11][7],.001,.001,0,.01,200,-2.5,expl,crono+5,-.002,.01,255,255,255,-1,-1,-1})
							unit[nearest][5][7] = 1
				--explosion(px,py,ps,pd,pf,pdes,kill,team)
				--capaciter type4 explose ( 2 type , 3  price , 4 mana , 5 sise , 6 damage , 7 dest , 8 force , 9 kill )
						end
					elseif unitlist[unit[nearest][3][5]][11][1] == 5 then
						if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][6] >= 0
						and gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][11][5] >= 0 then
							if coli(unit[nearest][1][1]-1,unit[nearest][1][2]+2*unitlist[unit[nearest][3][5]][2][9]+1,map) == false
							or coli(unit[nearest][1][1]+1,unit[nearest][1][2]+2*unitlist[unit[nearest][3][5]][2][9]+1,map) == false then
								if unit[nearest][1][1] > unitlist[unit[nearest][3][5]][11][2]:getWidth()*(.5-.5*unit[nearest][6])
								and unit[nearest][1][1] < mape:getWidth()-unitlist[unit[nearest][3][5]][11][2]:getWidth()*(.5+.5*unit[nearest][6]) then
									gold[unit[nearest][3][4]] = gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][11][5]
									unit[nearest][7] = unit[nearest][7]-unitlist[unit[nearest][3][5]][11][6]
									unit[nearest][2][1] = 0
									unit[nearest][2][2] = unitlist[unit[nearest][3][5]][11][2]:getHeight()-1
									unit[nearest][4] = 7.1
									unit[nearest][5][5] = {unit[nearest][1][1],unit[nearest][1][2]+30+unitlist[unit[nearest][3][5]][2][9]+1,0,0}
									unit[nearest][5][4] = 0
									unit[nearest][5][3] = 0
									ita[unit[nearest][3][4]][1] = crono+unitlist[unit[nearest][3][5]][11][4]*.8+1
									sdfg = -unitlist[unit[nearest][3][5]][11][2]:getWidth()/1.5
									dfgh = -unitlist[unit[nearest][3][5]][11][2]:getWidth()/1.5
									unit[nearest][17] = 0
									while sdfg < unitlist[unit[nearest][3][5]][11][2]:getWidth()/1.5 do
										if coli(unit[nearest][1][1]+unit[nearest][6]*unitlist[unit[nearest][3][5]][11][2]:getWidth(),unit[nearest][1][2]+unitlist[unit[nearest][3][5]][2][9]+dfgh+1,map) == false then
											sdfg = sdfg+.5
										else
											unit[nearest][16] = dfgh/unitlist[unit[nearest][3][5]][11][2]:getWidth()
										end
									sdfg = sdfg+1
									dfgh = dfgh+1
									end
								end
							end
						end
					elseif unitlist[unit[nearest][3][5]][11][1] == 6 then
						if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][7] >= 0
						and gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][11][6] >= 0
						and crono > unit[nearest][9] then
							gold[unit[nearest][3][4]] = gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][11][6]
							unit[nearest][7] = unit[nearest][7]-unitlist[unit[nearest][3][5]][11][7]
							table.insert(missi,{unit[nearest][1][3]+2*unitlist[unit[nearest][3][5]][2][7]*math.cos(-.5*math.pi-unit[nearest][3][1][2]) ,unit[nearest][1][4]+2*unitlist[unit[nearest][3][5]][2][7]*math.sin(-.5*math.pi-unit[nearest][3][1][2]),2*unitlist[unit[nearest][3][5]][11][3]*unit[nearest][6],2*unitlist[unit[nearest][3][5]][11][4],crono+missilist[unitlist[unit[nearest][3][5]][11][2]][7]+math.random(-4,4)/4,unitlist[unit[nearest][3][5]][11][2],1,unit[nearest][3][4],math.atan2(unitlist[unit[nearest][3][5]][11][4],unitlist[unit[nearest][3][5]][11][3]*unit[nearest][6]),1,0,unit[nearest][1][3]+unitlist[unit[nearest][3][5]][2][7]*math.cos(-.5*math.pi-unit[nearest][3][1][2]) ,unit[nearest][1][4]+unitlist[unit[nearest][3][5]][2][7]*math.sin(-.5*math.pi-unit[nearest][3][1][2]),0,0})
							unit[nearest][3][1][3] = -math.atan(unitlist[unit[nearest][3][5]][11][4]/(.001010101+(unitlist[unit[nearest][3][5]][11][3]*unit[nearest][6])))
							unit[nearest][5][4] = crono+unitlist[unit[nearest][3][5]][11][5]
							unit[nearest][9] = crono+unitlist[unit[nearest][3][5]][11][5]
							unit[nearest][5][7] = 1
						end
					elseif unitlist[unit[nearest][3][5]][11][1] == 7 then
						if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][5] >= 0
						and gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][11][6] >= 0
						and crono > unit[nearest][9] then
							if coli(unit[nearest][1][1]-1,unit[nearest][1][2]+2*unitlist[unit[nearest][3][5]][2][9]+1,map) == false
							or coli(unit[nearest][1][1]+1,unit[nearest][1][2]+2*unitlist[unit[nearest][3][5]][2][9]+1,map) == false then
								gold[unit[nearest][3][4]] = gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][11][6]
								unit[nearest][7] = unit[nearest][7]-unitlist[unit[nearest][3][5]][11][5]
								unit[nearest][2][1] = unitlist[unit[nearest][3][5]][11][2]*unit[nearest][5][1]
								unit[nearest][2][2] = unitlist[unit[nearest][3][5]][11][3]
								unit[nearest][3][1][3] = -math.atan(unitlist[unit[nearest][3][5]][11][4]/(.001010101+(unitlist[unit[nearest][3][5]][11][3])))
								unit[nearest][9] = crono+unitlist[unit[nearest][3][5]][11][4]
								table.insert(effet,{unit[nearest][1][1],unit[nearest][1][2]+unitlist[unit[nearest][3][5]][9],0,.01,.5,.5,.01,.01,0,.01,200,-1.5,fum,crono+5,-.002,.01,255,255,255,-1,-1,-1})
								unit[nearest][1][2] = unit[nearest][1][2]-1
							end
						end
					elseif unitlist[unit[nearest][3][5]][11][1] == 8 then
						if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][3] >= 0
						and gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][11][4] >= 0
						and crono > unit[nearest][9] then
							if coli(unit[nearest][1][1]-1,unit[nearest][1][2]+2*unitlist[unit[nearest][3][5]][2][9]+1,map) == false
							or coli(unit[nearest][1][1]+1,unit[nearest][1][2]+2*unitlist[unit[nearest][3][5]][2][9]+1,map) == false then
								gold[unit[nearest][3][4]] = gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][11][4]
								unit[nearest][7] = unit[nearest][7]-unitlist[unit[nearest][3][5]][11][3]
								unit[nearest][3][5] = unitlist[unit[nearest][3][5]][11][2]
							end
						end
					end
				end
				if bu == "r" then
					if unitlist[unit[nearest][3][5]][12][1] == 0 then
						if unitlist[unit[nearest][3][5]][12][3] == 0 then
							if unit[nearest][4] == 5 then
								unit[nearest][4] = 1
							else
								if timeson < crono then
									timeson = crono+.02
									table.insert(soundlist,{love.audio.newSource(stos),crono+.5})
									soundlist[table.maxn(soundlist)][1]:setVolume(math.max(math.min(.15*zoom/math.sqrt((unit[nearest][1][1]-cam_x)^2+(unit[nearest][1][2]-cam_y)^2)*140,2),.2))
									love.audio.play(soundlist[table.maxn(soundlist)][1])
								end

								unit[nearest][4] = 5
								unit[nearest][5][7] = 4
							end
						else
							if unit[nearest][18] == 0 then
								unit[nearest][18] = 1
							else
								if timeson < crono then
									timeson = crono+.02
									table.insert(soundlist,{love.audio.newSource(stos),crono+.5})
									soundlist[table.maxn(soundlist)][1]:setVolume(math.max(math.min(.15*zoom/math.sqrt((unit[nearest][1][1]-cam_x)^2+(unit[nearest][1][2]-cam_y)^2)*140,2),.2))
									love.audio.play(soundlist[table.maxn(soundlist)][1])
								end
								unit[nearest][18] = 0
								unit[nearest][5][7] = 4
							end
						end
					elseif unitlist[unit[nearest][3][5]][12][1] == 1 then
						if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][5] >= 0
						and gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][12][4] >= 0
						and food[unit[nearest][3][4]]+unitlist[unitlist[unit[nearest][3][5]][12][2]][16] <= math.min(foodmax[unit[nearest][3][4]],maxunit)
						and crono > unit[nearest][9] then
							creation(unit[nearest][1][1]+math.random(-20,20)/10,unit[nearest][1][2]+math.random(-20,20)/10,unitlist[unit[nearest][3][5]][12][2],unit[nearest][3][4],unit[nearest][6] ,0)
							unit[nearest][7] = unit[nearest][7]-unitlist[unit[nearest][3][5]][12][5]
							gold[unit[nearest][3][4]] = gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][12][4]
							unit[nearest][5][4] = crono+unitlist[unit[nearest][3][5]][12][3]+1.5
							unit[nearest][9] = crono+unitlist[unit[nearest][3][5]][12][3]
						end
					elseif unitlist[unit[nearest][3][5]][12][1] == 2 then
						if unit[nearest][4] == 6.2 then
							unit[nearest][4] = 1
						else
							unit[nearest][6] = unit[nearest][5][1]
							unit[nearest][4] = 6.2
							unit[nearest][5][7] = 4
						end
					elseif unitlist[unit[nearest][3][5]][12][1] == 3 then
						if unit[nearest][4] == 4.2 then
							unit[nearest][4] = 1
							unit[nearest][5][7] = 4
						else
							if coli(unit[nearest][1][1]-1,unit[nearest][1][2]+2*unitlist[unit[nearest][3][5]][2][9]+1,map) == false
							or coli(unit[nearest][1][1]+1,unit[nearest][1][2]+2*unitlist[unit[nearest][3][5]][2][9]+1,map) == false then
								unit[nearest][5][4] = crono+2*dote/math.sqrt(unitlist[unit[nearest][3][5]][12][2]^2+unitlist[unit[nearest][3][5]][12][3]^2)
								unit[nearest][4] = 4.2
								unit[nearest][18] = 1
							end
						end
					elseif unitlist[unit[nearest][3][5]][12][1] == 4 then
						if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][4] >= 0
						and gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][12][3] >= 0
						and crono > unit[nearest][9] then
							gold[unit[nearest][3][4]] = gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][12][3]
							unit[nearest][7] = unit[nearest][7]-unitlist[unit[nearest][3][5]][12][4]
							explosion( unit[nearest][1][1] , unit[nearest][1][2] , unitlist[unit[nearest][3][5]][12][5] , unitlist[unit[nearest][3][5]][12][6] , unitlist[unit[nearest][3][5]][12][8] , unitlist[unit[nearest][3][5]][12][7], unitlist[unit[nearest][3][5]][12][9],.1)
							killing(nearest)
							unit[nearest][5][7] = 1
							table.insert(effet,{unit[nearest][1][1],unit[nearest][1][2],0,.01,.02*unitlist[unit[nearest][3][5]][12][7],.02*unitlist[unit[nearest][3][5]][12][7],.001,.001,0,.01,200,-2.5,expl,crono+5,-.002,.01,255,255,255,-1,-1,-1})
							--{ 1 X , 2 Y , 3 M , 4 N , 5 timer ,6 type , 7 taille , 8 team , 9 direc , 10 mode , 11 rebon , 12 dx , 13 dy  }
						end
					elseif unitlist[unit[nearest][3][5]][12][1] == 5 then
						if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][6] >= 0
						and gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][12][5] >= 0 then
							if coli(unit[nearest][1][1]-1,unit[nearest][1][2]+2*unitlist[unit[nearest][3][5]][2][9]+1,map) == false
							or coli(unit[nearest][1][1]+1,unit[nearest][1][2]+2*unitlist[unit[nearest][3][5]][2][9]+1,map) == false then
								if unit[nearest][1][1] > unitlist[unit[nearest][3][5]][12][2]:getWidth()*(.5-.5*unit[nearest][6])
								and unit[nearest][1][1] < mape:getWidth()-unitlist[unit[nearest][3][5]][12][2]:getWidth()*(.5+.5*unit[nearest][6])then
									gold[unit[nearest][3][4]] = gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][12][5]
									unit[nearest][2][1] = 0
									unit[nearest][2][2] = unitlist[unit[nearest][3][5]][12][2]:getHeight()-1
									unit[nearest][4] = 7.2
									unit[nearest][5][5] = {unit[nearest][1][1],unit[nearest][1][2]+30+unitlist[unit[nearest][3][5]][2][9]+1,0,0}
									unit[nearest][5][4] = 0
									unit[nearest][7] = unit[nearest][7]-unitlist[unit[nearest][3][5]][12][6]
									ita[unit[nearest][3][4]][1] = crono+unitlist[unit[nearest][3][5]][12][4]*.8+1
									sdfg = -unitlist[unit[nearest][3][5]][12][2]:getWidth()/1.5
									dfgh = -unitlist[unit[nearest][3][5]][12][2]:getWidth()/1.5
									unit[nearest][17] = 0
									while sdfg < unitlist[unit[nearest][3][5]][12][2]:getWidth()/1.5 do
										if coli(unit[nearest][1][1]+unit[nearest][6]*unitlist[unit[nearest][3][5]][12][2]:getWidth(),unit[nearest][1][2]+unitlist[unit[nearest][3][5]][2][9]+dfgh+1,map) == false then
											sdfg = sdfg+.5
										else
											unit[nearest][16] = dfgh/unitlist[unit[nearest][3][5]][12][2]:getWidth()
										end
									sdfg = sdfg+1
									dfgh = dfgh+1
									end
								end
							end
						end
					elseif unitlist[unit[nearest][3][5]][12][1] == 6 then
						if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][7] >= 0
						and gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][12][6] >= 0
						and crono > unit[nearest][9] then
							gold[unit[nearest][3][4]] = gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][12][6]
							unit[nearest][7] = unit[nearest][7]-unitlist[unit[nearest][3][5]][12][7]
							table.insert(missi,{unit[nearest][1][3]+2*unitlist[unit[nearest][3][5]][2][7]*math.cos(-.5*math.pi-unit[nearest][3][1][2]) ,unit[nearest][1][4]+2*unitlist[unit[nearest][3][5]][2][7]*math.sin(-.5*math.pi-unit[nearest][3][1][2]),2*unitlist[unit[nearest][3][5]][12][3]*unit[nearest][6],2*unitlist[unit[nearest][3][5]][12][4],crono+missilist[unitlist[unit[nearest][3][5]][12][2]][7]+math.random(-4,4)/4,unitlist[unit[nearest][3][5]][12][2],1,unit[nearest][3][4],math.atan2(unitlist[unit[nearest][3][5]][12][4],unitlist[unit[nearest][3][5]][12][3]),1,0,unit[nearest][1][3]+unitlist[unit[nearest][3][5]][2][7]*math.cos(-.5*math.pi-unit[nearest][3][1][2]) ,unit[nearest][1][4]+unitlist[unit[nearest][3][5]][2][7]*math.sin(-.5*math.pi-unit[nearest][3][1][2]),0,0})
							unit[nearest][3][1][3] = -math.atan(unitlist[unit[nearest][3][5]][12][4]/(.0000001+math.abs(unitlist[unit[nearest][3][5]][12][3])))
							unit[nearest][5][4] = crono+unitlist[unit[nearest][3][5]][12][5]
							unit[nearest][9] = crono+unitlist[unit[nearest][3][5]][12][5]
							unit[nearest][5][7] = 1
						end
					elseif unitlist[unit[nearest][3][5]][12][1] == 7 then
						if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][5] >= 0
						and gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][12][6] >= 0
						and crono > unit[nearest][9] then
							if coli(unit[nearest][1][1]-1,unit[nearest][1][2]+2*unitlist[unit[nearest][3][5]][2][9]+1,map) == false
							or coli(unit[nearest][1][1]+1,unit[nearest][1][2]+2*unitlist[unit[nearest][3][5]][2][9]+1,map) == false then
								gold[unit[nearest][3][4]] = gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][12][6]
								unit[nearest][7] = unit[nearest][7]-unitlist[unit[nearest][3][5]][12][5]
								unit[nearest][2][1] = unitlist[unit[nearest][3][5]][12][2]*unit[nearest][5][1]
								unit[nearest][2][2] = unitlist[unit[nearest][3][5]][12][3]
								unit[nearest][3][1][3] = -math.atan(unitlist[unit[nearest][3][5]][12][4]/(.0010101+(unitlist[unit[nearest][3][5]][12][3])))
								unit[nearest][9] = crono+unitlist[unit[nearest][3][5]][12][4]
								table.insert(effet,{unit[nearest][1][1],unit[nearest][1][2]+unitlist[unit[nearest][3][5]][9],0,.01,.5,.5,.01,.01,0,.01,200,-1.5,fum,crono+5,-.002,.01,255,255,255,-1,-1,-1})
								unit[nearest][1][2] = unit[nearest][1][2]-1
							end
						end
					elseif unitlist[unit[nearest][3][5]][12][1] == 8 then
						if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][3] >= 0
						and gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][12][4] >= 0
						and crono > unit[nearest][9] then
							if coli(unit[nearest][1][1]-1,unit[nearest][1][2]+2*unitlist[unit[nearest][3][5]][2][9]+1,map) == false
							or coli(unit[nearest][1][1]+1,unit[nearest][1][2]+2*unitlist[unit[nearest][3][5]][2][9]+1,map) == false then
								gold[unit[nearest][3][4]] = gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][12][4]
								unit[nearest][7] = unit[nearest][7]-unitlist[unit[nearest][3][5]][12][3]
								unit[nearest][3][5] = unitlist[unit[nearest][3][5]][12][2]
							end
						end
					end
				end
			end
		end
		if bu == "wd" then
			if zoom > 2.4 then
				zoom = math.max(.9*zoom,love.graphics.getWidth()/mape:getWidth(),love.graphics.getHeight()/mape:getHeight())
				cam_x = math.min(math.max(cam_x+.1*(-love.mouse.getX()+love.graphics.getWidth()/2)/zoom,love.graphics.getWidth()/2/zoom),mape:getWidth()-love.graphics.getWidth()/2/zoom)
				cam_y = math.min(math.max(cam_y+.1*(-love.mouse.getY()+love.graphics.getHeight()/2)/zoom,love.graphics.getHeight()/2/zoom),mape:getHeight()-love.graphics.getHeight()/2/zoom)
				musique:setVolume( math.min(.2*zoom,1) )

			end
		end
		if bu == "wu" then
			if zoom < 30 then
				zoom = math.max(1.1*zoom,math.min(mape:getWidth()/love.graphics.getWidth(),mape:getHeight()/love.graphics.getHeight()))
				cam_x = math.min(math.max(cam_x-.1*(-love.mouse.getX()+love.graphics.getWidth()/2)/zoom,love.graphics.getWidth()/2/zoom),mape:getWidth()-love.graphics.getWidth()/2/zoom)
				cam_y =math.min(math.max( cam_y-.1*(-love.mouse.getY()+love.graphics.getHeight()/2)/zoom,love.graphics.getHeight()/2/zoom),mape:getHeight()-love.graphics.getHeight()/2/zoom)
				musique:setVolume( math.min(.2*zoom,1) )
			end
		end
	end
	if bouton ~= 0 then
		clicbout(bu)
	end
end
function love.mousereleased( mx, my, bu )
	if phase == 1
	and loade == 0 then
		if play == 1
		or play == 0 then
love.mouse.getX()
			if ita[1][7][1][3] == 2 then
				if ita[1][7][1][6] == 1 then
					ita[1][7][1][3] = 0
					ita[1][7][1][1] = love.graphics.getWidth()/2-200
					ita[1][7][1][2] = 60
				else
					ita[1][7][1][3] = 1
					ita[1][7][1][1] = (love.mouse.getX()-love.graphics.getWidth()/2)/zoom+cam_x
					ita[1][7][1][2] = (love.mouse.getY()-love.graphics.getHeight()/2)/zoom+cam_y
				end
			elseif ita[1][7][2][3] ==2 then
				if ita[1][7][2][6] == 1 then
					ita[1][7][2][3] = 0
					ita[1][7][2][1] = love.graphics.getWidth()/2-100
					ita[1][7][2][2] = 60
				else
					ita[1][7][2][3] = 1
					ita[1][7][2][1] = (love.mouse.getX()-love.graphics.getWidth()/2)/zoom+cam_x
					ita[1][7][2][2] = (love.mouse.getY()-love.graphics.getHeight()/2)/zoom+cam_y
				end
			elseif ita[1][7][3][3] ==2 then
				if ita[1][7][3][6] == 1 then
					ita[1][7][3][3] = 0
					ita[1][7][3][1] = love.graphics.getWidth()/2
					ita[1][7][3][2] = 60
				else
					ita[1][7][3][3] = 1
					ita[1][7][3][1] = (love.mouse.getX()-love.graphics.getWidth()/2)/zoom+cam_x
					ita[1][7][3][2] = (love.mouse.getY()-love.graphics.getHeight()/2)/zoom+cam_y
				end
			elseif ita[1][7][4][3] ==2 then
				if ita[1][7][4][6] == 1 then
					ita[1][7][4][3] = 0
					ita[1][7][4][1] = love.graphics.getWidth()/2+100
					ita[1][7][4][2] = 60
				else
					ita[1][7][4][3] = 1
					ita[1][7][4][1] = (love.mouse.getX()-love.graphics.getWidth()/2)/zoom+cam_x
					ita[1][7][4][2] = (love.mouse.getY()-love.graphics.getHeight()/2)/zoom+cam_y
				end
			elseif ita[1][7][5][3] ==2 then
				if ita[1][7][5][6] == 1 then
					ita[1][7][5][3] = 0
					ita[1][7][5][1] = love.graphics.getWidth()/2+200
					ita[1][7][5][2] = 60
				else
					ita[1][7][5][3] = 1
					ita[1][7][5][1] = (love.mouse.getX()-love.graphics.getWidth()/2)/zoom+cam_x
					ita[1][7][5][2] = (love.mouse.getY()-love.graphics.getHeight()/2)/zoom+cam_y
				end
			end
		end
	end
end
function love.keypressed( bu )
	if bu == " " then
		if phase == 1 then
			if play == 1 then
				play = 0
				love.audio.pause( )
				bout = {}
				intyr = -80
				bout[1] = {100,50,100,50,love.graphics.newImage( "bloc.png" ),"Quiter"}
			elseif play == 0 then
				bout = {}
				play = 1
				love.audio.resume( )
				intyr = 0
			end
		end
	elseif bu == "escape" then
		love.event.push('q')
	end
end
function obstacle(ox,oy,teame)
	dfrg = 0
	for r,zt in ipairs(ita[teame][4]) do
		if math.abs(ox-zt[1]) < 5
		and math.abs(oy-zt[2]) < 5 then
			zt[3] = zt[3]+1
			dfrg = 1
		end
	end
	if dfrg == 0 then
		table.insert(ita[teame][4],{ox,oy,1})
	end
end
function creation(px,py,typ,equip,dire,master)
	food[equip] = food[equip]+unitlist[typ][16]
		for e,g in ipairs(unitlist[typ][15]) do
			if g[1] == 1 then
				goldmax[equip] = goldmax[equip]+g[3]
			elseif g[1] == 2 then

				foodmax[equip] = foodmax[equip]+g[2]
			end
		end
	ide = ide+1
	table.insert(unit,{{px,py,px,py},{0,0},{{0,0,0},unitlist[typ][4],unitlist[typ][3],equip,typ},1,{dire,unitlist[typ][1],1,1,{0,0,0},1,4,unitlist[typ][3]},dire,unitlist[typ][13],0,crono+1.5,master,0,ide,0,crono+1.0123,0,0,0,1})
	unitlist[typ][21][equip] = unitlist[typ][21][equip]+1
end
function killing(id)
	if id == nearest then
		nearest = 0
	end
	food[unit[id][3][4]] = food[unit[id][3][4]]-unitlist[unit[id][3][5]][16]
	if unitlist[unit[id][3][5]][18] ~= 0 then

		if timeson < crono then
			timeson = crono+.02
			table.insert(soundlist,{love.audio.newSource(unitlist[unit[id][3][5]][18]),crono+1})
			soundlist[table.maxn(soundlist)][1]:setVolume( math.min(1/(1+math.sqrt((unit[id][1][1]-cam_x)^2+(unit[id][1][2]-cam_y)^2)+(20/zoom)^2)*20,2) )
			love.audio.play(soundlist[table.maxn(soundlist)][1])
		end




	end
	unitlist[unit[id][3][5]][21][unit[id][3][4]] = unitlist[unit[id][3][5]][21][unit[id][3][4]]-1
	unit[id][5][3] = crono+1
	unit[id][5][5][3] = 0
	if math.floor(unit[id][4]) == 7 then
		unit[id][2][1] = 0
		unit[id][2][2] = 0
	end
	unit[id][4] = 0
	unit[id][5][7] = 4
	if unit[id][10] ~= 0 then
		for e,g in ipairs(unit) do
			if g[12] == unit[id][10] then
				g[11] = g[11]-1
			end
		end
	end
	vic = 1
	for e,g in ipairs(unit) do
		if g[10] == unit[id][12] then
			g[10] = 0
		end
		if g[3][4] == unit[id][3][4]
		and e ~= id
		and math.floor(unitlist[g[3][5]][10]) == 4
		and g[4] ~= 0 then
			vic = 0
		end
	end
	if vic == 1 then
		jou[unit[id][3][4]] = 0
		vic = 0
		for tu,wr in ipairs(jou) do
			if wr == 1 then
				vic = vic+1
				gagnent = tu
			end
		end
		if vic == 1 then
			play = 2
			love.audio.stop()
			musvic = love.audio.newSource( "HeroicVictory.ogg","Streaming")
			love.audio.play(musvic)
			bout = {}
			bout[1] = {100,50,100,50,love.graphics.newImage( "bloc.png" ),"Quiter"}
		end
	end
	for e,g in ipairs(unitlist[unit[id][3][5]][15]) do
		if g[1] == 1 then
			goldmax[unit[id][3][4]] = goldmax[unit[id][3][4]]-g[3]
		elseif g[1] == 2 then
			foodmax[unit[id][3][4]] = foodmax[unit[id][3][4]]-g[2]
		elseif g[1] == 4 then
			explosion( unit[id][1][1],unit[id][1][2] , g[3] , g[2] , g[5] , g[4], g[6],unit[id][3][4],.1)
			table.insert(effet,{unit[id][1][1],unit[id][1][2],0,.01,.02*g[3],.02*g[3],.001,.001,0,.01,200,-2.5,expl,crono+5,-.002,.01,255,255,255,-1,-1,-1})
		elseif g[1] == 5 then
		fghj = 0
			while fghj < g[3] do
				fghj = fghj+1
				creation(unit[id][1][1]+math.random(-20,20)/10,unit[id][1][2]+math.random(-20,20)/10,g[2],unit[id][3][4],unit[id][6],0)
			end
		end
	end
end
function tire(px,py,px2,py2,typ,pre,team,ident)
	diste = math.sqrt((px-px2)^2+(py-py2)^2)
	if diste < 15 then
		if unitlist[unit[ident][3][5]][7] > diste then
			if math.random(pre) < 10 then
				unit[unit[ident][5][5][3]][5][2] = unit[unit[ident][5][5][3]][5][2]-math.random(.8*missilist[typ][3],1.2*missilist[typ][3])
				if math.floor(unitlist[unit[unit[ident][5][5][3]][3][5]][10]) ~= 4
				and math.floor(unit[unit[ident][5][5][3]][4]) ~= 7 then
					local forde = unit[unit[ident][5][5][3]][2][1]-math.min(math.abs(missilist[typ][4]/(.1+diste)*missilist[typ][5]/2),math.abs(missilist[typ][4]))
					unit[unit[ident][5][5][3]][2][1] = forde*(px2-px)/diste
					unit[unit[ident][5][5][3]][2][2] = forde*(py2-py)/diste
					if forde > 1 then
						unit[unit[ident][5][5][3]][1][2] = unit[unit[ident][5][5][3]][1][2]-1
					end
					if unitlist[unit[unit[ident][5][5][3]][3][5]][24] == 1 then
						table.insert(effet,{unit[unit[ident][5][5][3]][1][1]-1.5*unit[unit[ident][5][5][3]][2][1],unit[unit[ident][5][5][3]][1][2]-1.5*unit[unit[ident][5][5][3]][2][2],.8*unit[unit[ident][5][5][3]][2][1],.8*unit[unit[ident][5][5][3]][2][2]-.2,missilist[typ][3]*math.random(40,80)/2000,missilist[typ][3]*math.random(40,80)/2000,.001,.001,math.atan2((py2-py),(px2-px))+math.pi+math.random(-45,45)/57,math.random(-50,50)/1000,255,-8,sang,crono+.6,.02,.2,255,255,255,-1,-1,-1})
					elseif unitlist[unit[unit[ident][5][5][3]][3][5]][24] == 2 then
						table.insert(effet,{unit[unit[ident][5][5][3]][1][1]-1.5*unit[unit[ident][5][5][3]][2][1],unit[unit[ident][5][5][3]][1][2]-1.5*unit[unit[ident][5][5][3]][2][2],.8*unit[unit[ident][5][5][3]][2][1],.8*unit[unit[ident][5][5][3]][2][2]-.2,missilist[typ][3]*math.random(40,80)/2000,missilist[typ][3]*math.random(40,80)/2000,.001,.001,math.atan2((py2-py),(px2-px))+math.pi+math.random(-45,45)/57,math.random(-50,50)/1000,255,-8,sang2,crono+.6,.04,.8,255,255,255,-6,-7,-7})
					elseif unitlist[unit[unit[ident][5][5][3]][3][5]][24] == 3 then
						table.insert(effet,{unit[unit[ident][5][5][3]][1][1]-1.5*unit[unit[ident][5][5][3]][2][1],unit[unit[ident][5][5][3]][1][2]-1.5*unit[unit[ident][5][5][3]][2][2],.8*unit[unit[ident][5][5][3]][2][1],.8*unit[unit[ident][5][5][3]][2][2]-.2,missilist[typ][3]*math.random(40,80)/2000,missilist[typ][3]*math.random(40,80)/2000,.001,.001,math.atan2((py2-py),(px2-px))+math.pi+math.random(-45,45)/57,math.random(-100,100)/1000,255,-8,sang3,crono+.6,.02,.2,255,255,255,0,0,0})
					elseif unitlist[unit[unit[ident][5][5][3]][3][5]][24] == 4 then
						table.insert(effet,{unit[unit[ident][5][5][3]][1][1]-1.5*unit[unit[ident][5][5][3]][2][1],unit[unit[ident][5][5][3]][1][2]-1.5*unit[unit[ident][5][5][3]][2][2],.8*unit[unit[ident][5][5][3]][2][1],.8*unit[unit[ident][5][5][3]][2][2]-.2,missilist[typ][3]*math.random(40,80)/2000,missilist[typ][3]*math.random(40,80)/2000,.001,.001,math.atan2((py2-py),(px2-px))+math.pi+math.random(-45,45)/57,math.random(-100,100)/1000,255,-8,sang4,crono+.6,.02,.2,255,255,255,0,0,0})
					end
					if unit[unit[ident][5][5][3]][5][2] < 0 then
						unit[unit[ident][5][5][3]][1][2] = unit[unit[ident][5][5][3]][1][2]-1
						killing(unit[ident][5][5][3])

					elseif missilist[typ][17] ~= 0 then
						if math.floor(unit[unit[ident][5][5][3]][4]) ~= 7
						and math.floor(unit[unit[ident][5][5][3]][4]) ~= 4 then
							unit[unit[ident][5][5][3]][5][4] = unit[unit[ident][5][5][3]][5][4]+missilist[typ][17]
							unit[unit[ident][5][5][3]][3][2] = crono+missilist[typ][17]
							unit[unit[ident][5][5][3]][3][1][3] = -.6*unit[unit[ident][5][5][3]][6]
							if unit[unit[ident][5][5][3]][4] ~= 8 then
								unit[unit[ident][5][5][3]][16] = unit[unit[ident][5][5][3]][4]
								unit[unit[ident][5][5][3]][4] = 8
							end
						end
					end
				end
			end
		else
			unit[ident][4] = 1
			unit[ident][5][5][3] = 0
		end
	else
		prem = math.random(-pre,pre)/100
		pren = math.random(-pre,pre)/100

		distgh = math.sqrt((px-px2)^2+(py-py2)^2)
		unit[ident][3][1][3] = math.atan(((py2+pren-py)/distgh*missilist[typ][2]-.5*distgh*missilist[typ][1]/missilist[typ][2])/-(.001010101+(((px2+prem-px)/distgh*missilist[typ][2]))))
		table.insert(missi,{px,py,2*(px2-px)/diste*missilist[typ][2]+prem*missilist[typ][2],2*(py2-py)/diste*missilist[typ][2]+pren*missilist[typ][2]-.5*diste*missilist[typ][1]/missilist[typ][2],crono+missilist[typ][7],typ,1,team,math.atan2(py2-py,px2-px),1,0,px,py,0,0})
	end
end
function coli(px,py,ima)
	if px > 6
	and px < ima:getWidth()-6
	and py > 6
	and py < ima:getHeight()-6 then
		r, g, b, a = map:getPixel( math.floor(px), math.floor(py) )
		if a~=255 then
			rep = true
		else
			rep = false
		end
	else
		rep = false
	end
	return(rep)
end
function coli2(px,py,equ)
	rep = false
	ex = math.floor(math.min(math.max(px/10,1),table.maxn(cartog)))
	if cartogt[ex][3] > 0 then
		for i,h in ipairs(cartog[ex]) do
			if unit[h][3][4] ~= equ then
				if math.sqrt((px-unit[h][1][1])^2+(py-unit[h][1][2])^2) < 6 then
					rep = true
					who = h
				end
			end
		end
	end
	return(rep)
end
function coli3(px,py,ima)
	if px > 6
	and px < ima:getWidth()-6
	and py > 6
	and py < ima:getHeight()-6 then
		r, g, b, a = map:getPixel( math.floor(px), math.floor(py) )
		if a < 10 then
			rep = true
		else
			rep = false
		end
	else
		rep = false
	end
	return(rep)
end
function explosion(px,py,ps,pd,pf,pdes,kill,team,sonne)
	table.insert(effet,{px,py,0,.01,.1*ps,.1*ps,.01,.01,0,.01,150,-1.5,fum,crono+5,-.002,.01,255,255,255,-1,-1,-1})
	--{ 1 X , 2 Y , 3 M , 4 N , 5 sx ,6 sy , 7 sx+ , 8 sy+ , 9 r , 10 r+ , 11 a , 12 a+ , 13 img , 14 timer , 15 grav , 16 frix }
	py = py-.2*pdes
	pdes = pdes*2
	pd = 2*pd
	ps = 2*ps
	pf = 2*pf
	if pdes > 0.1 then
		dx = -pdes
		if newm == 0 then
			refre = crono+.4
		end
		while dx < math.floor(pdes) do
			dy = -pdes
			while dy < math.floor(pdes) do
				if px+dx > 0
				and py+dy > 0
				and px+dx < mape:getWidth()
				and py+dy < mape:getHeight()
				and math.sqrt(dx^2+1.6*dy^2) <= math.floor(.5*pdes) then
					if coli3(px+dx,py+dy,mape) == false then
						map:setPixel( math.floor(px+dx), math.floor(py+dy), 0, 0, 0, 0 )
						newm = 1
					end
				end
				dy = dy+1
			end
			dx = dx+1
		end
	end
	py = py+.15*pdes
	ex = math.floor(math.min(math.max(px/10,1),table.maxn(cartog)))
	ki = 0
	for i,h in ipairs(cartog[ex]) do
		if unit[h][3][4] ~= team
		and ki < kill
		and unit[h][4] ~= 0 then
			dist = math.sqrt((px-unit[h][1][1])^2+(py-unit[h][1][2])^2)
			if dist < pd then
				if math.floor(unitlist[unit[h][3][5]][10]) ~= 4
				and math.floor(unit[h][4]) ~= 7 then
					ang = math.atan2((py-unit[h][1][2]),(px-unit[h][1][1]))
					local forde = math.abs(unit[h][2][1]-math.min(pf/(.1+dist)*ps/2,pf))
					unit[h][2][1] = forde*math.cos(ang)
					unit[h][2][2] = (forde*math.sin(ang)-forde)/2
					if forde > 1 then
						unit[h][1][2] = unit[h][1][2]-1
					end
				end
				unit[h][5][2] = unit[h][5][2]-math.min((pd/(1+dist)*ps/2),pd)
				ki = ki+1
				if unit[h][5][2] < 0 then
					unit[h][1][2] = unit[h][1][2]-1
					killing(h)
				elseif sonne ~= 0 then
					if math.floor(unit[h][4]) ~= 7
					and math.floor(unit[h][4]) ~= 4 then
						unit[h][5][4] = unit[h][5][4]+sonne
						unit[h][3][2] = crono+sonne
						unit[h][3][1][3] = -.6*unit[h][6]
						if unit[h][4] ~= 8 then
							unit[h][16] = unit[h][4]
							unit[h][4] = 8
						end
					end
				end
			end
		end
	end
end
function creusage(px,py,ps)
	ps = 2*ps
	if ps > 0 then
		dx = -ps
		if newm == 0 then
			refre = crono+.4
		end
		creu = false
		while dx < math.floor(ps) do
			dy = -ps
			while dy < math.floor(ps) do
				if px+dx > 0
				and py+dy > 0
				and px+dx < mape:getWidth()
				and py+dy < mape:getHeight()
				and math.sqrt(dx^2+dy^2) <= math.floor(.5*ps) then
					if coli3(px+dx,py+dy,mape) == false then
						map:setPixel( math.floor(px+dx), math.floor(py+dy), 0, 0, 0, 0 )
						newm = 1
						creu = true
					end
				end
				dy = dy+1
			end
			dx = dx+1
		end
	end
	return(creu)
end
function love.update(dot)
	dote = dot
	if dot < 1/60 then
		love.timer.sleep(1/60-dot)
	end
	fps = fps+.01*(1/dot-fps)
	if phase == 0 then
		if loa == 1 then
			loading()
			loa = 0
			phase = 1
		end
	elseif phase == 1 then
		if moux ~= love.mouse.getX()+cam_x
		or mouy ~= love.mouse.getY()+cam_y then
			near = 10000000
			for i,h in ipairs(unit) do
				if h[4] ~= 0
				and h[3][4] == 1
				and math.floor(h[4]) ~= 7 then
					di = math.sqrt(((love.mouse.getX()-love.graphics.getWidth()/2)/zoom+cam_x-h[1][3])^2+((love.mouse.getY()-love.graphics.getHeight()/2)/zoom+cam_y-h[1][4])^2)
					if di < near then
						near = di
						nearest = i
					end
				end
			end
		end
		moux = love.mouse.getX()+cam_x
		mouy = love.mouse.getY()+cam_y
		if cade == 3
		and cade < crono then
			for i,h in ipairs(cartelist[cartechoisi][2]) do
				creation(h[1],h[2],racelist[h[5]][2],h[4],h[3] ,0)
			end
			cade = 4
		end
		if cade == 4
		and cade < crono then
			for i,h in ipairs(unit) do
				h[2][1] = 0
				h[2][2] = unitlist[h[3][5]][11][2]:getHeight()-1
				h[4] = 7.1
				h[5][5] = {h[1][1],h[1][2]+30+unitlist[h[3][5]][2][9]+1,h[5][5][3],0}
				h[5][4] = 0
				h[5][3] = 0
				ita[h[3][4]][1] = crono+unitlist[h[3][5]][11][4]*.8
				sdfg = -unitlist[unit[nearest][3][5]][11][2]:getWidth()/1.5
				dfgh = -unitlist[unit[nearest][3][5]][11][2]:getWidth()/1.5
				h[17] = 0
				while sdfg < unitlist[h[3][5]][11][2]:getWidth()/1.5 do
					if coli(h[1][1]+h[6]*unitlist[h[3][5]][11][2]:getWidth(),h[1][2]+unitlist[h[3][5]][2][9]+dfgh+1,map) == false then
						sdfg = sdfg+.5
					else
						h[16] = dfgh/unitlist[h[3][5]][11][2]:getWidth()
					end
				sdfg = sdfg+1
				dfgh = dfgh+1
				end
			end
			cade = 0
		end
		if ita[1][7][1][3] == 0 then
			ita[1][7][1][4] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-ita[1][7][1][1])^2+(love.mouse.getY()-ita[1][7][1][2])^2)-48))
			ita[1][7][1][6] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-love.graphics.getWidth()/2+200)^2+(love.mouse.getY()-60)^2)-48))
		elseif ita[1][7][1][3] == 1 then
			ita[1][7][1][4] = 1/math.max(1,1+.04*(math.sqrt(((love.mouse.getX()-love.graphics.getWidth()/2)/zoom+cam_x-ita[1][7][1][1])^2+((love.mouse.getY()-love.graphics.getHeight()/2)/zoom+cam_y-ita[1][7][1][2])^2)-48/zoom))
			ita[1][7][1][6] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-love.graphics.getWidth()/2+200)^2+(love.mouse.getY()-60)^2)-48))
		elseif ita[1][7][1][3] == 2 then
			ita[1][7][1][6] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-love.graphics.getWidth()/2+200)^2+(love.mouse.getY()-60)^2)-48))
		end
		if ita[1][7][2][3] == 0 then
			ita[1][7][2][4] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-ita[1][7][2][1])^2+(love.mouse.getY()-ita[1][7][2][2])^2)-48))
			ita[1][7][2][6] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-love.graphics.getWidth()/2+100)^2+(love.mouse.getY()-60)^2)-48))
		elseif ita[1][7][2][3] == 1 then
			ita[1][7][2][4] = 1/math.max(1,1+.04*(math.sqrt(((love.mouse.getX()-love.graphics.getWidth()/2)/zoom+cam_x-ita[1][7][2][1])^2+((love.mouse.getY()-love.graphics.getHeight()/2)/zoom+cam_y-ita[1][7][2][2])^2)-48/zoom))
			ita[1][7][2][6] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-love.graphics.getWidth()/2+100)^2+(love.mouse.getY()-60)^2)-48))
		elseif ita[1][7][2][3] == 2 then
			ita[1][7][2][6] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-love.graphics.getWidth()/2+100)^2+(love.mouse.getY()-60)^2)-48))
		end
		if ita[1][7][3][3] == 0 then
			ita[1][7][3][4] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-ita[1][7][3][1])^2+(love.mouse.getY()-ita[1][7][3][2])^2)-48))
			ita[1][7][3][6] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-love.graphics.getWidth()/2)^2+(love.mouse.getY()-60)^2)-48))
		elseif ita[1][7][3][3] == 1 then
			ita[1][7][3][4] = 1/math.max(1,1+.04*(math.sqrt(((love.mouse.getX()-love.graphics.getWidth()/2)/zoom+cam_x-ita[1][7][3][1])^2+((love.mouse.getY()-love.graphics.getHeight()/2)/zoom+cam_y-ita[1][7][3][2])^2)-48/zoom))
			ita[1][7][3][6] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-love.graphics.getWidth()/2)^2+(love.mouse.getY()-60)^2)-48))
		elseif ita[1][7][3][3] == 2 then
			ita[1][7][3][6] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-love.graphics.getWidth()/2)^2+(love.mouse.getY()-60)^2)-48))
		end
		if ita[1][7][4][3] == 0 then
			ita[1][7][4][4] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-ita[1][7][4][1])^2+(love.mouse.getY()-ita[1][7][4][2])^2)-48))
			ita[1][7][4][6] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-love.graphics.getWidth()/2-100)^2+(love.mouse.getY()-60)^2)-48))
		elseif ita[1][7][4][3] == 1 then
			ita[1][7][4][4] = 1/math.max(1,1+.04*(math.sqrt(((love.mouse.getX()-love.graphics.getWidth()/2)/zoom+cam_x-ita[1][7][4][1])^2+((love.mouse.getY()-love.graphics.getHeight()/2)/zoom+cam_y-ita[1][7][4][2])^2)-48/zoom))
			ita[1][7][4][6] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-love.graphics.getWidth()/2-100)^2+(love.mouse.getY()-60)^2)-48))
		elseif ita[1][7][4][3] == 2 then
			ita[1][7][4][6] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-love.graphics.getWidth()/2-100)^2+(love.mouse.getY()-60)^2)-48))
		end
		if ita[1][7][5][3] == 0 then
			ita[1][7][5][4] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-ita[1][7][5][1])^2+(love.mouse.getY()-ita[1][7][5][2])^2)-48))
			ita[1][7][5][6] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-love.graphics.getWidth()/2-200)^2+(love.mouse.getY()-60)^2)-48))
		elseif ita[1][7][5][3] == 1 then
			ita[1][7][5][4] = 1/math.max(1,1+.04*(math.sqrt(((love.mouse.getX()-love.graphics.getWidth()/2)/zoom+cam_x-ita[1][7][5][1])^2+((love.mouse.getY()-love.graphics.getHeight()/2)/zoom+cam_y-ita[1][7][5][2])^2)-48/zoom))
			ita[1][7][5][6] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-love.graphics.getWidth()/2-200)^2+(love.mouse.getY()-60)^2)-48))
		elseif ita[1][7][5][3] == 2 then
			ita[1][7][5][6] = 1/math.max(1,1+.01*(math.sqrt((love.mouse.getX()-love.graphics.getWidth()/2-200)^2+(love.mouse.getY()-60)^2)-48))
		end
		if love.keyboard.isDown("up") then
			cam_y = math.min(math.max(cam_y-800*dot/zoom,love.graphics.getHeight()/2/zoom),mape:getHeight()-love.graphics.getHeight()/2/zoom)
		end
		if love.keyboard.isDown("down") then
			cam_y = math.min(cam_y+800*dot/zoom,mape:getHeight()-love.graphics.getHeight()/2/zoom)
		end
		if love.keyboard.isDown("left") then
			cam_x = math.max(cam_x-800*dot/zoom,love.graphics.getWidth()/2/zoom)
		end
		if love.keyboard.isDown("right") then
			cam_x = math.min(cam_x+800*dot/zoom,mape:getWidth()-love.graphics.getWidth()/2/zoom)
		end
		intx = intx+.1*(love.mouse.getX()-intx)
		if love.mouse.getY() < love.graphics.getHeight()-(sour:getHeight()-93) then
			inta = inta+.1*(255-inta)
		else
			inta = inta+.1*(50-inta)
		end
		intn = .6*intn-.1*(inty-intyr)
		inty = inty+intn
		if play == 0 then
		elseif play == 1 then
			--position et obstacle
			for r,z in ipairs(ita) do
				z[2] = {0,0}
				for k,yy in ipairs(ita[r][4]) do
					yy[3] = yy[3]-.05*dot
					if yy[3] < 0 then
						table.remove(ita[r][4],k)
					end
				end
			end
			for i,h in ipairs(unit) do
				ex = math.floor(math.min(math.max(h[1][1]/10,2),table.maxn(cartog)))
				if math.abs(ex*10-h[1][1]+5) > 3 then
					exr = math.floor(math.min(math.max(ex+((h[1][1]/10-ex)-.5)^0,2),table.maxn(cartog)))
					table.insert(cartog[ex],i)
					table.insert(cartog[exr],i)
					if h[4] == 5 then
						cartogt[ex][1] = true
						cartogt[exr][1] = true
					elseif h[4] == 6.1 then
						cartogt[ex][2] = true
						cartogt[exr][2] = true
					elseif h[4] == 6.2 then
						cartogt[ex][2] = true
						cartogt[exr][2] = true
					end
					cartogt[ex][3] = cartogt[ex][3]+1
					cartogt[exr][3] = cartogt[exr][3]+1
				else
					table.insert(cartog[ex],i)
					if h[4] == 5 then
						cartogt[ex][1] = true
					elseif h[4] == 6.1 then
						cartogt[ex][2] = true
					elseif h[4] == 6.2 then
						cartogt[ex][2] = true
					end
					cartogt[ex][3] = cartogt[ex][3]+1
				end
				if math.floor(unitlist[h[3][5]][10]) == 4 then
					if ita[h[3][4]][2][1] == 0
					and ita[h[3][4]][2][2] == 0 then
						ita[h[3][4]][2] = {h[1][1],h[1][2]}
					else
						ita[h[3][4]][2] = {(h[1][1]+ita[h[3][4]][2][1])/2,(h[1][2]+ita[h[3][4]][2][2])/2}
					end
				end
			end
			--wwwwwwwwwwwwwwwwwwww
			--inteligence artificiel
			if remind < crono then
					--besoin maitre
				for c,v in ipairs(ita) do
					if c ~= 1 then
						v[5][1] = v[5][1]-.1*(v[5][1]-math.max(600-gold[c],0))
						v[5][2] = v[5][2]-.1*(v[5][2]-math.max(7*(foodmax[c]-food[c]),0))
						v[5][3] = v[5][3]-.1*(v[5][3]-math.max(300-4*(foodmax[c]-food[c]),0))
						for k,yy in ipairs(ita[c][4]) do
							v[5][4] = v[5][4]+yy[3]
						end
						v[5][4] = math.max(math.min(300-400/v[5][4],300),0)
						--fin besoin maitre-- réponce: ita[#][5][#] = niveau de besoin
						--1=gold , 2=food , 3=pop , 4=creus
						--calcul position enemie
						v[3] = {0,0}
						for r,z in ipairs(ita) do
							if z[2][1] ~= 0
							and z[2][2] ~= 0
							and r ~= c then
								if v[3][1] == 0
								and v[3][2] == 0 then
									v[3] = z[2]
								else
									v[3] = {(z[2][1]+v[3][1])/2,(z[2][2]+v[3][2])/2}
								end
							end
						end
						--fin calcul position enemie -- reponce: ita[#][3] = {x,y}
						--utilisation des point de controle
						if food[c] > 30 then
							v[7][1][1] = v[7][1][1]-.2*(v[7][1][1]-(v[3][1]+math.random(-200,200)))
							v[7][1][3] = 1
							v[7][5][1] = v[7][1][1]-.2*(v[7][1][1]-(v[3][1]+math.random(-200,200)))
							v[7][5][3] = 1
						elseif food[c] < 20 then
							v[7][1][1] = v[7][1][1]-.2*(v[7][1][1]-(v[2][1]+math.random(0,200)*(v[3][1]-v[2][1])/(1+math.abs(v[3][1]-v[2][1]))))
							v[7][1][3] = 1
							v[7][5][1] = v[7][1][1]-.2*(v[7][1][1]-(v[2][1]+math.random(0,200)*(v[3][1]-v[2][1])/(1+math.abs(v[3][1]-v[2][1]))))
							v[7][5][3] = 1
						else
							v[7][1][3] = 0
							v[7][5][3] = 0
						end
						if food[c] > 30 then
							v[7][4][1] = v[7][4][1]-.2*(v[7][4][1]-(v[3][1]-math.random(0,100)*(v[3][1]-v[2][1])/(1+math.abs(v[3][1]-v[2][1]))))
							v[7][4][3] = 1
						elseif food[c] < 20 then
							v[7][4][1] = v[7][4][1]-.2*(v[7][4][1]-(v[2][1]+math.random(0,100)*(v[3][1]-v[2][1])/(1+math.abs(v[3][1]-v[2][1]))))
							v[7][4][3] = 1
						else
							v[7][4][3] = 0
						end
						if food[c] > 15 then
							v[7][3][1] = v[7][3][1]-.2*(v[7][3][1]-(v[3][1]+math.random(0,200)*(v[3][1]-v[2][1])/(1+math.abs(v[3][1]-v[2][1]))))
							v[7][3][3] = 1
						else
							v[7][3][1] = v[7][3][1]-.2*(v[7][3][1]-(v[2][1]+math.random(0,300)*(v[3][1]-v[2][1])/(1+math.abs(v[3][1]-v[2][1]))))
							v[7][3][3] = 1
						end
						v[7][2][1] = v[7][2][1]-.2*(v[7][2][1]-(v[2][1]+math.random(-100,200)*(v[3][1]-v[2][1])/(1+math.abs(v[3][1]-v[2][1]))))
						v[7][2][3] = 1
					end
--{{love.graphics.getWidth()/2-200,60,0,1,love.graphics.newImage( "poiger.png" ),0},{love.graphics.getWidth()/2-100,60,0,1,love.graphics.newImage( "poicon.png" )},{love.graphics.getWidth()/2,60,0,1,love.graphics.newImage( "poicreu.png" )},{love.graphics.getWidth()/2+100,60,0,1,love.graphics.newImage( "poilon.png" )}}
					--utilisation des point de controle
				end
				remind = crono+2
			end
			creusr = {0,1}
			if unit[elu] ~= nil then
				if unit[elu][3][4] ~= 1 then
					if unit[elu][4] ~= 0
					and math.floor(unit[elu][4]) ~= 7 then
						--besoin de L'élue
						if unitlist[unit[elu][3][5]][11][1] == 3
						or unitlist[unit[elu][3][5]][12][1] == 3 then
							--calcul de proximité de lieu de creusage
							for q,w in ipairs(ita[unit[elu][3][4]][4]) do
								if w[3] > 1 then
									if math.abs(unit[elu][1][1]-w[1]) < 8
									and math.abs(unit[elu][1][2]-w[2]) < 8 then
										creusr = {w[3],q}
									end
								end
							end
							--fin calcul de proximité de lieu de creusage -- réponce: creusr = {force,num du lieux}
						end
						if unitlist[unit[elu][3][5]][11][1] == 7
						or unitlist[unit[elu][3][5]][12][1] == 7
						or unitlist[unit[elu][3][5]][11][1] == 5
						or unitlist[unit[elu][3][5]][12][1] == 5
						or unitlist[unit[elu][3][5]][11][1] == 2
						or unitlist[unit[elu][3][5]][12][1] == 2 then
							-- calcul d'analise du terrain
							if coli(unit[elu][1][1],unit[elu][1][2]+6,map) == false then
								if coli(unit[elu][1][1]+16*unit[elu][6],unit[elu][1][2]-2,map) == false then
									terrain = "mur"
								elseif coli(unit[elu][1][1]+16*unit[elu][6],unit[elu][1][2]+2,map) == false then
									terrain = "monte"
								elseif coli(unit[elu][1][1]+16*unit[elu][6],unit[elu][1][2]+6,map) == false then
									terrain = "plat"
								elseif coli(unit[elu][1][1]+16*unit[elu][6],unit[elu][1][2]+10,map) == false then
									terrain = "trou"
								else
									terrain = "précipice"
								end
							else
								terrain = "non"
							end
							--fin calcul d'analise du terrain --réponce: terrain = type de terrain
						end
						--fin besoin de L'élue
						--ordre a l'élue
						clir = 0
						clil = 0
						proui = 0
						--wwwwwwwwwww11wwwwwwwwwww
						if unitlist[unit[elu][3][5]][11][1] == 1 then
							clir = math.random(0,6-math.min(5/math.sqrt(math.max(1,ita[unit[elu][3][4]][5][1]*unitlist[unit[elu][3][5]][11][7])/100),5))
							clir = clir+math.random(0,6-math.min(5/math.sqrt(math.max(1,ita[unit[elu][3][4]][5][2]*unitlist[unit[elu][3][5]][11][8])/300),5))
							clir = clir+math.random(0,6-math.min(5/math.sqrt(math.max(1,ita[unit[elu][3][4]][5][3]*unitlist[unit[elu][3][5]][11][9])/300),5))
							clir = clir+math.random(0,6-math.min(5/math.sqrt(math.max(1,ita[unit[elu][3][4]][5][4]*unitlist[unit[elu][3][5]][11][10])/1200),5))
							if unitlist[unitlist[unit[elu][3][5]][11][2]][21][unit[elu][3][4]] == 0 then
								clir = clir+500
							end
							if (pluseco[unit[elu][3][4]]+moineco[unit[elu][3][4]]) < 10 then
								if unitlist[unit[elu][3][5]][11][7] < 0 then
									clir = 0
								elseif unitlist[unit[elu][3][5]][11][7] > 0 then
									clir = clir+800
								end
							elseif (pluseco[unit[elu][3][4]]+moineco[unit[elu][3][4]]) > 20 then
								if unitlist[unit[elu][3][5]][11][7] < 0 then
									clir = clir+400
								elseif unitlist[unit[elu][3][5]][11][7] > 0 then
									clir = clir-400
								end
							end
						elseif unitlist[unit[elu][3][5]][11][1] == 2 then
							if (unit[elu][1][1]-ita[unit[elu][3][4]][3][1])*unit[elu][6] < 0 then
								if terrain == "mur"
								or terrain == "précipice"then
									clir = math.random(0,301-math.min(300/math.sqrt(math.max(1,unitlist[unit[elu][3][5]][11][4])),300))
								end
							end
						elseif unitlist[unit[elu][3][5]][11][1] == 3 then
							if ita[unit[elu][3][4]][7][3][3] == 1 then
								if math.floor(unit[elu][4]) ~= 4
								and (unit[elu][1][1]-ita[unit[elu][3][4]][7][3][1])*unit[elu][6]*unitlist[unit[elu][3][5]][11][2] < 0
								and (unit[elu][1][2]-ita[unit[elu][3][4]][7][3][2]+50)*unitlist[unit[elu][3][5]][11][3] < 0 then
									if creusr[1] > 0 then
										clir = math.random(0,2001-math.min(2000/math.sqrt(math.max(1,unitlist[unit[elu][3][5]][11][7]+creusr[1])),2000))
									end
								end
							else
								if math.floor(unit[elu][4]) ~= 4 then
									if creusr[1] > 0 then
										clir = math.random(0,201-math.min(200/math.sqrt(math.max(1,unitlist[unit[elu][3][5]][11][7]+creusr[1])),200))
									end
								end
							end
						elseif unitlist[unit[elu][3][5]][11][1] == 4 then
							if unit[elu][4] == 2
							or unit[elu][4] == 3 then
								clir = math.random(0,20)
							end
						elseif unitlist[unit[elu][3][5]][11][1] == 5 then
							if crono > ita[unit[elu][3][4]][1] then
								proui = (ita[unit[elu][3][4]][5][2]*unitlist[unit[elu][3][5]][11][9][2])/600+(ita[unit[elu][3][4]][5][3]*unitlist[unit[elu][3][5]][11][9][3])/600+(ita[unit[elu][3][4]][5][4]*unitlist[unit[elu][3][5]][11][9][4])/600
								if terrain == "précipice"
								or terrain == "trou"
								or terrain == "plat" then
									clir = math.random(0,200)+math.random(0,501-math.min(500/math.sqrt(math.max(1,ita[unit[elu][3][4]][5][1]*unitlist[unit[elu][3][5]][11][9][1])/100),500))
									clir = clir+math.random(0,201-math.min(200/math.sqrt(math.max(1,ita[unit[elu][3][4]][5][2]*unitlist[unit[elu][3][5]][11][9][2])/100),200))
									clir = clir+math.random(0,201-math.min(200/math.sqrt(math.max(1,ita[unit[elu][3][4]][5][3]*unitlist[unit[elu][3][5]][11][9][3])/100),200))
									clir = clir+math.random(0,201-math.min(200/math.sqrt(math.max(1,ita[unit[elu][3][4]][5][4]*unitlist[unit[elu][3][5]][11][9][4])/100),200))
									if unitlist[unit[elu][3][5]][11][3][1] ~= 0
									and unitlist[unitlist[unit[elu][3][5]][11][3][1]][21][unit[elu][3][4]] == 0 then
										clir = clir+1000
									end
									if (pluseco[unit[elu][3][4]]+moineco[unit[elu][3][4]]) < 10 then
										if unitlist[unit[elu][3][5]][11][9][1] < 0 then
											clir = 0
										elseif unitlist[unit[elu][3][5]][11][9][1] > 0 then
											clir = clir+800
										end
									elseif (pluseco[unit[elu][3][4]]+moineco[unit[elu][3][4]]) > 20 then
										if unitlist[unit[elu][3][5]][11][9][1] < 0 then
											clir = clir+400
										elseif unitlist[unit[elu][3][5]][11][9][1] > 0 then
											clir = clir-400
										end
									end
								end
							end
						elseif unitlist[unit[elu][3][5]][11][1] == 6 then
							if unit[elu][4] == 2
							or unit[elu][4] == 3 then
								clir = math.random(0,301-math.min(300/math.sqrt(math.max(1,unitlist[unit[elu][3][5]][11][9])),300))
							end
						elseif unitlist[unit[elu][3][5]][11][1] == 7 then
							if terrain == "précipice"
							or terrain == "trou"
							or terrain == "mur" then
								clir = math.random(0,80)
							end
						elseif unitlist[unit[elu][3][5]][11][1] == 8 then
							clir = math.random(0,1)
						end
						--wwwwwwwwwwwwww12wwwwwwwwwwwwww
						if unitlist[unit[elu][3][5]][12][1] == 1 then
							clil = math.random(0,16-math.min(15/math.sqrt(math.max(1,ita[unit[elu][3][4]][5][1]*unitlist[unit[elu][3][5]][12][7])/100),5))
							clil = clil+math.random(0,6-math.min(5/math.sqrt(math.max(1,ita[unit[elu][3][4]][5][2]*unitlist[unit[elu][3][5]][12][8])/300),5))
							clil = clil+math.random(0,6-math.min(5/math.sqrt(math.max(1,ita[unit[elu][3][4]][5][3]*unitlist[unit[elu][3][5]][12][9])/300),5))
							clil = clil+math.random(0,6-math.min(5/math.sqrt(math.max(1,ita[unit[elu][3][4]][5][4]*unitlist[unit[elu][3][5]][12][10])/1200),5))
							if unitlist[unitlist[unit[elu][3][5]][12][2]][21][unit[elu][3][4]] == 0 then
								clil = clil+500
							end
							if (pluseco[unit[elu][3][4]]+moineco[unit[elu][3][4]]) < 10 then
								if unitlist[unit[elu][3][5]][12][7] < 0 then
									clil = 0
								elseif unitlist[unit[elu][3][5]][12][7] > 0 then
									clil = clil+800
								end
							elseif (pluseco[unit[elu][3][4]]+moineco[unit[elu][3][4]]) > 20 then
								if unitlist[unit[elu][3][5]][12][7] < 0 then
									clil = clil+400
								elseif unitlist[unit[elu][3][5]][12][7] > 0 then
									clil = clil-400
								end
							end
						elseif unitlist[unit[elu][3][5]][12][1] == 2 then
							if (unit[elu][1][1]-ita[unit[elu][3][4]][3][1])*unit[elu][6] < 0 then
								if terrain == "mur"
								or terrain == "précipice"then
									clil = math.random(0,301-math.min(300/math.sqrt(math.max(1,unitlist[unit[elu][3][5]][12][4])),300))
								end
							end
						elseif unitlist[unit[elu][3][5]][12][1] == 3 then
							if ita[unit[elu][3][4]][7][3][3] == 1 then
								if math.floor(unit[elu][4]) ~= 4
								and (unit[elu][1][1]-ita[unit[elu][3][4]][7][3][1])*unit[elu][6]*unitlist[unit[elu][3][5]][12][2] < 0
								and (unit[elu][1][2]-ita[unit[elu][3][4]][7][3][2]+50)*unitlist[unit[elu][3][5]][12][3] < 0 then
									if creusr[1] > 0 then
										clil = math.random(0,2001-math.min(2000/math.sqrt(math.max(1,unitlist[unit[elu][3][5]][12][7]+creusr[1])),2000))
									end
								end
							else
								if math.floor(unit[elu][4]) ~= 4 then
									if creusr[1] > 0 then
										clil = math.random(0,201-math.min(200/math.sqrt(math.max(1,unitlist[unit[elu][3][5]][12][7]+creusr[1])),200))
									end
								end
							end
						elseif unitlist[unit[elu][3][5]][12][1] == 4 then
							if unit[elu][4] == 2
							or unit[elu][4] == 3 then
								clil = math.random(0,20)
							end
						elseif unitlist[unit[elu][3][5]][12][1] == 5 then
							if crono > ita[unit[elu][3][4]][1] then
								clil = math.random(0,200)+math.random(0,501-math.min(500/math.sqrt(math.max(1,ita[unit[elu][3][4]][5][1]*unitlist[unit[elu][3][5]][12][9][1]/100)),500))
								clil = clil+math.random(0,201-math.min(200/math.sqrt(math.max(1,ita[unit[elu][3][4]][5][2]*unitlist[unit[elu][3][5]][12][9][2])/100),200))
								clil = clil+math.random(0,201-math.min(200/math.sqrt(math.max(1,ita[unit[elu][3][4]][5][3]*unitlist[unit[elu][3][5]][12][9][3])/100),200))
								clil = clil+math.random(0,201-math.min(200/math.sqrt(math.max(1,ita[unit[elu][3][4]][5][4]*unitlist[unit[elu][3][5]][12][9][4])/100),200))
								if unitlist[unit[elu][3][5]][12][3][1] ~= 0
								and unitlist[unitlist[unit[elu][3][5]][12][3][1]][21][unit[elu][3][4]] == 0 then
									clil = clil+1000
								end
								if (pluseco[unit[elu][3][4]]+moineco[unit[elu][3][4]]) < 10 then
									if unitlist[unit[elu][3][5]][12][9][1] < 0 then
										clil = 0
									elseif unitlist[unit[elu][3][5]][12][9][1] > 0 then
										clil = clil+800
									end
								elseif (pluseco[unit[elu][3][4]]+moineco[unit[elu][3][4]]) > 20 then
									if unitlist[unit[elu][3][5]][12][9][1] < 0 then
										clil = clil+400
									elseif unitlist[unit[elu][3][5]][12][9][1] > 0 then
										clil = clil-400
									end
								end
							end
						elseif unitlist[unit[elu][3][5]][12][1] == 6 then
							if unit[elu][4] == 2
							or unit[elu][4] == 3 then
								clil = math.random(0,301-math.min(300/math.sqrt(math.max(1,unitlist[unit[elu][3][5]][12][9])),300))
							end
						elseif unitlist[unit[elu][3][5]][12][1] == 7 then
							if terrain == "précipice"
							or terrain == "trou"
							or terrain == "mur" then
								clil = math.random(0,80)
							end
						elseif unitlist[unit[elu][3][5]][12][1] == 8 then
							clil = math.random(0,1)
						end
						if math.max(clir,clil) > math.random(0,2000) then
							ret = nearest
							rete = near
							near = 1
							nearest = elu
							derf1 = ita[1][7][1][4]
							derf2 = ita[1][7][2][4]
							derf3 = ita[1][7][3][4]
							derf4 = ita[1][7][4][4]
							derf5 = ita[1][7][5][4]
							ita[1][7][1][4] = .1
							ita[1][7][2][4] = .1
							ita[1][7][3][4] = .1
							ita[1][7][4][4] = .1
							ita[1][7][5][4] = .1
							derf11 = ita[1][7][1][6]
							derf21 = ita[1][7][2][6]
							derf31 = ita[1][7][3][6]
							derf41 = ita[1][7][4][6]
							derf51 = ita[1][7][5][6]
							ita[1][7][1][6] = .1
							ita[1][7][2][6] = .1
							ita[1][7][3][6] = .1
							ita[1][7][4][6] = .1
							ita[1][7][5][6] = .1
							niu = moux
							if clir > clil then
								love.mousepressed( 0 , 0 , "l" )
							else
								love.mousepressed( 0 , 0 , "r" )
							end
							nearest = ret
							near = rete
							ita[1][7][1][4] = derf1
							ita[1][7][2][4] = derf2
							ita[1][7][3][4] = derf3
							ita[1][7][4][4] = derf4
							ita[1][7][5][4] = derf5
							ita[1][7][1][6] = derf11
							ita[1][7][2][6] = derf21
							ita[1][7][3][6] = derf31
							ita[1][7][4][6] = derf41
							ita[1][7][5][6] = derf51
							moux = niu
						end
					--fin ordre a l'élue
					end
				else
					if ita[1][7][3][3] == 1
					and unit[elu][4] ~= 0 then
						if unitlist[unit[elu][3][5]][11][1] == 3
						or unitlist[unit[elu][3][5]][12][1] == 3 then
							creusr = 0
							for q,w in ipairs(ita[1][4]) do
								if w[3] > .1 then
									if math.abs(unit[elu][1][1]-w[1]) < 10
									and math.abs(unit[elu][1][2]-w[2]) < 12 then
										creusr = .010101
										if math.abs(unit[elu][1][1]-w[1]) < 5
										and math.abs(unit[elu][1][2]-w[2]) < 5 then
											creusr = w[3]
										end
									end
								end
							end
							if unitlist[unit[elu][3][5]][11][1] == 3
							and unit[elu][7] > .2*unitlist[unit[elu][3][5]][13] then
								if math.floor(unit[elu][4]) ~= 4
								and (unit[elu][1][1]-ita[1][7][3][1])*unit[elu][6]*unitlist[unit[elu][3][5]][11][2] < 0
								and(unit[elu][1][2]-ita[1][7][3][2])*unitlist[unit[elu][3][5]][11][3] < 0 then
									 if creusr > .1 then
										ret = nearest
										rete = near
										near = 1
										nearest = elu
										derf1 = ita[1][7][1][4]
										derf2 = ita[1][7][2][4]
										derf3 = ita[1][7][3][4]
										derf4 = ita[1][7][4][4]
										derf5 = ita[1][7][5][4]
										ita[1][7][1][4] = .1
										ita[1][7][2][4] = .1
										ita[1][7][3][4] = .1
										ita[1][7][4][4] = .1
										ita[1][7][5][4] = .1
										derf11 = ita[1][7][1][6]
										derf21 = ita[1][7][2][6]
										derf31 = ita[1][7][3][6]
										derf41 = ita[1][7][4][6]
										derf51 = ita[1][7][5][6]
										ita[1][7][1][6] = .1
										ita[1][7][2][6] = .1
										ita[1][7][3][6] = .1
										ita[1][7][4][6] = .1
										ita[1][7][5][6] = .1
										niu = moux
										love.mousepressed( 0 , 0 , "l" )
										nearest = ret
										near = rete
										ita[1][7][1][4] = derf1
										ita[1][7][2][4] = derf2
										ita[1][7][3][4] = derf3
										ita[1][7][4][4] = derf4
										ita[1][7][5][4] = derf5
										ita[1][7][1][6] = derf11
										ita[1][7][2][6] = derf21
										ita[1][7][3][6] = derf31
										ita[1][7][4][6] = derf41
										ita[1][7][5][6] = derf51
										moux = niu
									elseif creusr == .010101 then
										unit[elu][18] = .5
									else
										unit[elu][18] = 1
									end
								end
							end
							if unitlist[unit[elu][3][5]][12][1] == 3
							and unit[elu][7] > .2*unitlist[unit[elu][3][5]][13] then
								if math.floor(unit[elu][4]) ~= 4
								and (unit[elu][1][1]-ita[1][7][3][1])*unit[elu][6]*unitlist[unit[elu][3][5]][12][2] < 0
								and (unit[elu][1][2]-ita[1][7][3][2])*unitlist[unit[elu][3][5]][12][3] < 0 then
									if creusr > .1 then
										ret = nearest
										rete = near
										near = 1
										nearest = elu
										derf1 = ita[1][7][1][4]
										derf2 = ita[1][7][2][4]
										derf3 = ita[1][7][3][4]
										derf4 = ita[1][7][4][4]
										derf5 = ita[1][7][5][4]
										ita[1][7][1][4] = .1
										ita[1][7][2][4] = .1
										ita[1][7][3][4] = .1
										ita[1][7][4][4] = .1
										ita[1][7][5][4] = .1
										derf11 = ita[1][7][1][6]
										derf21 = ita[1][7][2][6]
										derf31 = ita[1][7][3][6]
										derf41 = ita[1][7][4][6]
										derf51 = ita[1][7][5][6]
										ita[1][7][1][6] = .1
										ita[1][7][2][6] = .1
										ita[1][7][3][6] = .1
										ita[1][7][4][6] = .1
										ita[1][7][5][6] = .1
										niu = moux
										love.mousepressed( 0 , 0 , "r" )
										nearest = ret
										near = rete
										ita[1][7][1][4] = derf1
										ita[1][7][2][4] = derf2
										ita[1][7][3][4] = derf3
										ita[1][7][4][4] = derf4
										ita[1][7][5][4] = derf5
										ita[1][7][1][6] = derf11
										ita[1][7][2][6] = derf21
										ita[1][7][3][6] = derf31
										ita[1][7][4][6] = derf41
										ita[1][7][5][6] = derf51
										moux = niu
									elseif creusr == .010101 then
										unit[elu][18] = .5
									else
										unit[elu][18] = 1
									end
								end
							end
						end
					end
				end
			end
			--fin inteligence artificiel
			--ita{ 1 build time    , 2{moyene position}  , 3 direction enemie  ,4 obstacle     ,5 priorité       }
			-- priotité = gold , food , combatent , creuser ,
			if refre < crono
			and newm == 1 then
				mape = love.graphics.newImage( map )
				mapea = love.graphics.newImage( map )
				mape:setFilter( "nearest","nearest" )

				newm = 0
			end
			if crono > goldtime then
				pluseco = {0,0,0,0,0}
				moineco = {0,0,0,0,0}
				for i,h in ipairs(unit) do
					for e,g in ipairs(unitlist[h[3][5]][15]) do
						if g[1] == 1 then
							gold[h[3][4]] = gold[h[3][4]]+g[2]
							if g[2] < 0 then
								moineco[h[3][4]] = moineco[h[3][4]]+g[2]
							else
								pluseco[h[3][4]] = pluseco[h[3][4]]+g[2]
							end

						end
					end
					gold[h[3][4]] = math.min(gold[h[3][4]],goldmax[h[3][4]])
				end
				goldtime = crono+1
			end
			for i,h in ipairs(unit) do
				if h[14] ~= crono+1.0123
				and h[14] < crono then
					dfrtet = 0
					for e,g in ipairs(unitlist[h[3][5]][15]) do
						if g[1] == 3 then
							if h[11] >= g[5] then
								h[14] = crono+g[3]
							elseif food[h[3][4]]+unitlist[g[2]][16] <= math.min(foodmax[h[3][4]],maxunit)-1 then
								h[11] = h[11]+1
								creation(h[1][1],h[1][2],g[2],h[3][4],h[6] ,h[12])
								h[14] = crono+g[3]
							end
							dfrtet = 1
						end
					end
					if dfrtet == 0 then
						h[14] = math.huge
					end
				end
			end
			if unit[elu+1] ~= nil then
				elu = elu+1
			else
				elu = 1
			end
			if unit[elu] ~= nil then
				if unitlist[unit[elu][3][5]][10] == 1
				or unitlist[unit[elu][3][5]][10] == 4.1
				or unitlist[unit[elu][3][5]][10] == 3 then
					if math.floor(unit[elu][4]) == 1
					or unit[elu][4] == 2
					or unit[elu][4] == 3 then
						chosen = 0
						min = math.huge
						px = math.floor(unit[elu][1][1]/10)
						sdx = -math.floor(unitlist[unit[elu][3][5]][7]/10)-1
						while sdx < unitlist[unit[elu][3][5]][7]/10+1 do
							ex = math.min(math.max(px+sdx,1),table.maxn(cartog))
							sdx = sdx+1
							if cartogt[ex][3] > 0 then
								for i,h in ipairs(cartog[ex]) do
									if elu ~= h
									and unit[h][4] ~= 0 then
										if unit[h][3][4] ~= unit[elu][3][4] then
											distelu = math.sqrt((unit[h][1][1]-unit[elu][1][1])^2+(unit[h][1][2]-unit[elu][1][2])^2)
											if distelu < 2*unitlist[unit[elu][3][5]][7] then
												vx = unit[elu][1][1]+unitlist[unit[elu][3][5]][2][7]*math.cos(-.5*math.pi-unit[elu][3][1][2])
												vy = unit[elu][1][2]+unitlist[unit[elu][3][5]][2][7]*math.sin(-.5*math.pi-unit[elu][3][1][2])
												possi = 1
												hgf = 0
												while hgf < distelu do
													if coli(vx,vy,map) == false then
														if math.floor(unitlist[unit[h][3][5]][10]) == 4
														and missilist[unitlist[unit[elu][3][5]][5]][8] > 0
														and hgf > distelu-30 then
															distelu = 1
														else
															hgf = 1000
															possi = 0
														end
													end
													hgf = hgf+3
													vx = unit[elu][1][1]+2*(unit[h][1][1]-unit[elu][1][1])/distelu*hgf
													vy = unit[elu][1][2]+2*(unit[h][1][2]-unit[elu][1][2])/distelu*hgf
												end
												if possi == 1 then
													if min > distelu then
														min = distelu
														chosen = h
													end
												end
											end
										end
									end
								end
							end
						end
						if chosen ~= 0 then
							distelu = math.sqrt((unit[chosen][1][1]-unit[elu][1][1])^2+(unit[chosen][1][2]-unit[elu][1][2])^2)
							if math.floor(unitlist[unit[chosen][3][5]][10]) == 4
							and unitlist[unit[chosen][3][5]][7] < 15 then
								unit[elu][5][5] = {unit[chosen][1][1]+math.random(-4-unitlist[unit[chosen][3][5]][8],unitlist[unit[elu][3][5]][8]+4),unit[chosen][1][2]+math.random(-4-unitlist[unit[elu][3][5]][8],unitlist[unit[elu][3][5]][8]+4),chosen,unit[chosen][12]}
							else
								unit[elu][5][5] = {unit[chosen][1][1],unit[chosen][1][2],chosen,unit[chosen][12]}
							end
							if unitlist[unit[elu][3][5]][10] == 1
							or unitlist[unit[elu][3][5]][10] == 4.1 then
								unit[elu][4] = 2
								unit[elu][5][1] = (unit[chosen][1][1]-unit[elu][1][1])/math.abs(unit[chosen][1][1]-unit[elu][1][1])
								unit[elu][6] = (unit[chosen][1][1]-unit[elu][1][1])/math.abs(unit[chosen][1][1]-unit[elu][1][1])
							elseif unitlist[unit[elu][3][5]][10] == 3 then
								unit[elu][4] = 3
								unit[elu][6] = (unit[chosen][1][1]-unit[elu][1][1])/math.abs(unit[chosen][1][1]-unit[elu][1][1])
							end
						else
							unit[elu][5][5][3] = 0
							unit[elu][4] = 1
						end
					end
				end
			end
			for i,h in ipairs(unit) do
				ex = math.floor(math.min(math.max(h[1][1]/10,1),table.maxn(cartog)))
				kilede = 0
				if h[4] == 0 then
					h[3][1][1] = h[3][1][1]-.1*(h[3][1][1]+h[6]*(h[8]+.5*math.pi))
					h[3][1][2] = h[3][1][2]-.12*(h[3][1][2]+h[6]*(h[8]-.5*math.pi))
					h[3][1][3] = h[3][1][3]-.14*(h[3][1][3]+h[6]*(h[8]-.5*math.pi))
					h[1][2] = h[1][2]+.2
				else
					if math.floor(h[4]) == 1 then
						h[3][1][3] = h[3][1][3]-.05*(h[3][1][3]+h[8])

					elseif h[4] == 4.1 then
						h[3][1][3] = h[3][1][3]-.05*(h[3][1][3]+math.atan(unitlist[h[3][5]][11][3]*h[5][1]/unitlist[h[3][5]][11][2])+.001)
					elseif h[4] == 4.2 then
						h[3][1][3] = h[3][1][3]-.05*(h[3][1][3]+math.atan(unitlist[h[3][5]][12][3]*h[5][1]/unitlist[h[3][5]][12][2]))
					elseif h[4] == 6.1 then
						h[3][1][3] = h[3][1][3]-.05*(h[3][1][3]+math.atan(unitlist[h[3][5]][11][3]*h[5][1]/unitlist[h[3][5]][11][2])+.001)
					elseif h[4] == 6.2 then
						h[3][1][3] = h[3][1][3]-.05*(h[3][1][3]+math.atan(unitlist[h[3][5]][12][3]*h[5][1]/unitlist[h[3][5]][12][2])+.001)
					elseif math.floor(h[4]) == 7 then
						h[3][1][3] = h[3][1][3]-.05*(h[3][1][3]+1)
					end
					h[3][1][1] = h[3][1][1]-.1*(h[3][1][1]-h[8])
					h[3][1][2] = h[3][1][2]-.05*(h[3][1][2]-(.5*(h[3][1][3]-h[3][1][1])))
				end
				h[7] = math.min(h[7]+unitlist[h[3][5]][14],unitlist[h[3][5]][13])
				if h[4] == 1 then -- normal-- normal-- normal-- normal-- normal-- normal-- normal-- normal
					h[5][7] = math.min(h[5][7]+8/unitlist[h[3][5]][6]*dot,4)
					if math.floor(unitlist[h[3][5]][10]) ~= 4 then
						if h[15] < crono then
							if unitlist[h[3][5]][22] ~= 0
							and ita[h[3][4]][7][unitlist[h[3][5]][22]][3] == 1 then
								if (ita[h[3][4]][7][unitlist[h[3][5]][22]][1]+20)-h[1][1] < 0 then
									h[5][1] = -1
									h[6] = -1
									h[5][8] = unitlist[h[3][5]][3]
								elseif (ita[h[3][4]][7][unitlist[h[3][5]][22]][1]-20)-h[1][1] > 0 then
									h[5][1] = 1
									h[6] = 1
									h[5][8] = unitlist[h[3][5]][3]
								else
									h[5][8] = .5*unitlist[h[3][5]][3]
								end
							end
						end
						pied1 = 0
						pied2 = 0
						if math.floor(unitlist[h[3][5]][10]) ~= 4 then
							pied = -4
							while pied < 4 do
								if coli(h[1][1]+4,h[1][2]+pied+unitlist[h[3][5]][2][9],map) == true then
									pied1 = pied
								end
								if coli(h[1][1]-4,h[1][2]+pied+unitlist[h[3][5]][2][9],map) == true then
									pied2 = pied
								end
								pied = pied+.6
							end
							h[8] = math.atan((pied1-pied2)/8)
						end
						h[2][1] = h[2][1]/1.01
						h[2][2] = h[2][2]/1.01
						--centre
						if coli(h[1][1],h[1][2],map) == false then
								h[1][1] = h[1][1]-2*h[2][1]
								h[1][2] = h[1][2]-2*h[2][2]
						end
						--grav
						if coli(h[1][1]-1,h[1][2]+2*unitlist[h[3][5]][2][9],map) == true
						and coli(h[1][1]+1,h[1][2]+2*unitlist[h[3][5]][2][9],map) == true then
							h[2][2] = h[2][2]+unitlist[h[3][5]][4]
						else
							if math.abs(h[2][2]) > unitlist[h[3][5]][9] then
								killing(i)
							end
							if cartogt[ex][1] == true
							or cartogt[ex][2] == true then
								for f,k in ipairs(cartog[ex]) do
									if unit[k][4] == 6.1 then
										if math.sqrt((h[1][1]-unit[k][1][1])^2+(h[1][2]-unit[k][1][2])^2) < 6 then
											unit[k][7] = unit[k][7]-unitlist[unit[k][3][5]][11][4]
											h[1][2] = h[1][2]-1
											h[2][1] = h[2][1]+unitlist[unit[k][3][5]][11][2]*unit[k][6]+h[5][1]*h[18]*h[5][8]*2
											h[2][2] = h[2][2]+unitlist[unit[k][3][5]][11][3]*2
											unit[k][5][7] = 1
											if math.abs(unitlist[unit[k][3][5]][11][2]) > .01 then
												h[5][1] = (unitlist[unit[k][3][5]][11][2]/math.abs(unitlist[unit[k][3][5]][11][2]))*unit[k][6]
												h[6] = (unitlist[unit[k][3][5]][11][2]/math.abs(unitlist[unit[k][3][5]][11][2]))*unit[k][6]
											end
										end
									elseif unit[k][4] == 6.2 then
										if math.sqrt((h[1][1]-unit[k][1][1])^2+(h[1][2]-unit[k][1][2])^2) < 6 then
											unit[k][7] = unit[k][7]-unitlist[unit[k][3][5]][12][4]
											h[1][2] = h[1][2]-1
											h[2][1] = h[2][1]+unitlist[unit[k][3][5]][12][2]*unit[k][6]+h[5][1]*h[18]*h[5][8]*2
											h[2][2] = h[2][2]+unitlist[unit[k][3][5]][12][3]*2
											unit[k][5][7] = 1
											if math.abs(unitlist[unit[k][3][5]][12][2]) > .01 then
												h[5][1] = (unitlist[unit[k][3][5]][12][2]/math.abs(unitlist[unit[k][3][5]][12][2]))*unit[k][6]
												h[6] = (unitlist[unit[k][3][5]][12][2]/math.abs(unitlist[unit[k][3][5]][12][2]))*unit[k][6]
											end
										end
									elseif unit[k][4] == 5 then
										if math.sqrt((h[1][1]-unit[k][1][1])^2+(h[1][2]-unit[k][1][2])^2) < 6 then
											local sen = (h[1][1]-unit[k][1][1])/math.abs(h[1][1]-unit[k][1][1])
											h[1][1] = h[1][1]-sen
											h[5][1] = -sen
											h[6] = -sen
										end
									end
								end
							end
							h[1][1] = h[1][1]+h[5][1]*h[18]*h[5][8]*2
							h[5][6] = h[5][6]+.5*math.abs(h[5][8]*h[18])*unitlist[h[3][4]][19]
							if h[5][6] >= 5 then
								h[5][6] = 1
							end
						end
						--bas
						if coli(h[1][1]-1,h[1][2]+2*unitlist[h[3][5]][2][9]-1,map) == false
						or coli(h[1][1]+1,h[1][2]+2*unitlist[h[3][5]][2][9]-1,map) == false then
							h[2][2] = 0
							h[2][1] = 0
							h[1][2] = h[1][2]-1
						--haut
						elseif coli(h[1][1],h[1][2]+unitlist[h[3][5]][2][9]-6,map) == false then
							h[2][2] = -.2*h[2][2]
							h[2][1] = 0
							h[1][2] = h[1][2]+1
						end
						--gauche
						if coli(h[1][1]-1,h[1][2]+unitlist[h[3][5]][2][9]-5,map) == false then
								obstacle(h[1][1],h[1][2],h[3][4])
							h[1][1] = h[1][1]+1
							h[5][1] = 1
							h[6] = math.abs(h[6])
							h[15] = crono+2
						--droite
						elseif coli(h[1][1]+1,h[1][2]+unitlist[h[3][5]][2][9]-5,map) == false then
								obstacle(h[1][1],h[1][2],h[3][4])
							h[1][1] = h[1][1]-1
							h[5][1] = -1
							h[6] = -math.abs(h[6])
							h[15] = crono+2
						end
						h[1][1] = h[1][1]+h[2][1]
						h[1][2] = h[1][2]+h[2][2]
					end
				elseif h[4] == 2 then --combat--combat--combat--combat--combat--combat--combat--combat--combat--combat
					h[2][1] = h[2][1]/1.01
					h[2][2] = h[2][2]/1.01
					if math.floor(unitlist[h[3][5]][10]) ~= 4 then
						--grav
						if coli(h[1][1]-1,h[1][2]+2*unitlist[h[3][5]][2][9],map) == true
						and coli(h[1][1]+1,h[1][2]+2*unitlist[h[3][5]][2][9],map) == true then
							h[2][2] = h[2][2]+unitlist[h[3][5]][4]
						else
							if math.abs(h[2][2]) > unitlist[h[3][5]][9] then
								killing(i)
							end
							h[2][1] = 0
							h[2][2] = 0
						end
						--bas
						if coli(h[1][1]-1,h[1][2]+2*unitlist[h[3][5]][2][9]-1,map) == false
						or coli(h[1][1]+1,h[1][2]+2*unitlist[h[3][5]][2][9]-1,map) == false then
							h[2][2] = 0
							h[2][1] = 0
							h[1][2] = h[1][2]-1
						--haut
						elseif coli(h[1][1],h[1][2]+unitlist[h[3][5]][2][9]-6,map) == false then
							h[2][2] = -.2*h[2][2]
							h[2][1] = 0
							h[1][2] = h[1][2]+1
						end
						--droite
						if coli(h[1][1]+1,h[1][2]+unitlist[h[3][5]][2][9]-5,map) == false then
							h[2][1] = -.2*h[2][1]
							h[2][2] = 0
							h[1][1] = h[1][1]-1
						--gauche
						elseif coli(h[1][1]-1,h[1][2]+unitlist[h[3][5]][2][9]-5,map) == false then
							h[2][1] = -.2*h[2][1]
							h[2][2] = 0
							h[1][1] = h[1][1]+1
						end
						h[1][1] = h[1][1]+h[2][1]
						h[1][2] = h[1][2]+h[2][2]
					end
					if h[5][5][3] ~= 0
					and unit[h[5][5][3]] ~= nil then
						if unit[h[5][5][3]][4] == 0
						or unit[h[5][5][3]][12] ~= h[5][5][4] then
							h[4] = 1
							h[5][5][3] = 0
						else
							distgh = math.sqrt((unit[h[5][5][3]][1][1]-h[1][1])^2+(unit[h[5][5][3]][1][2]-h[1][2])^2)
							h[3][1][3] = h[3][1][3]-.05*(h[3][1][3]-math.atan(((unit[h[5][5][3]][1][2]-h[1][2])/distgh*missilist[unitlist[h[3][5]][5]][2]-.5*distgh*missilist[unitlist[h[3][5]][5]][1]/missilist[unitlist[h[3][5]][5]][2])/-(.0010101010101+(((unit[h[5][5][3]][1][1]-h[1][1])/distgh*missilist[unitlist[h[3][5]][5]][2])))))
							if crono > h[5][4] then
								tire(h[1][3]+unitlist[h[3][5]][2][7]*math.cos(-.5*math.pi-h[3][1][2]) ,h[1][4]+unitlist[h[3][5]][2][7]*math.sin(-.5*math.pi-h[3][1][2]),h[5][5][1],h[5][5][2],unitlist[h[3][5]][5],unitlist[h[3][5]][8],h[3][4],i)
								h[5][4] = crono+unitlist[h[3][5]][6]*(1+math.random(-20,20)/100)
								h[5][7] = 1
								soue = math.random(1,2)
								if unitlist[h[3][5]][17][soue] ~= 1 then
									if timeson < crono then
									timeson = crono+.02
										table.insert(soundlist,{love.audio.newSource(unitlist[h[3][5]][17][soue]),crono+1})
										soundlist[table.maxn(soundlist)][1]:setVolume( math.min(1/(1+math.sqrt((h[1][1]-cam_x)^2+(h[1][2]-cam_y)^2)+(20/zoom)^2)*20,2) )
										love.audio.play(soundlist[table.maxn(soundlist)][1])
									end











								end
							end
						end
					end
					h[5][7] = math.min(h[5][7]+5/unitlist[h[3][5]][6]*dot,4)
				elseif h[4] == 3 then -- combat move-- combat move-- combat move-- combat move-- combat move-- combat move-- combat move
					h[2][1] = h[2][1]/1.01
					h[2][2] = h[2][2]/1.01
					if h[15] < crono then
						if unitlist[h[3][5]][22] ~= 0
						and ita[h[3][4]][7][unitlist[h[3][5]][22]][3] == 1 then
							if (ita[h[3][4]][7][unitlist[h[3][5]][22]][1]+20)-h[1][1] < 0 then
								h[5][1] = -1
								h[5][8] = unitlist[h[3][5]][3]
							elseif (ita[h[3][4]][7][unitlist[h[3][5]][22]][1]-20)-h[1][1] > 0 then
								h[5][1] = 1
								h[5][8] = unitlist[h[3][5]][3]
							else
								h[5][8] = .5*unitlist[h[3][5]][3]
							end
						end
					end
					--centre
					if coli(h[1][1],h[1][2],map) == false then
							h[1][1] = h[1][1]-2*h[2][1]
							h[1][2] = h[1][2]-2*h[2][2]
					end
					--grav
					if coli(h[1][1]-1,h[1][2]+2*unitlist[h[3][5]][2][9],map) == true
					and coli(h[1][1]+1,h[1][2]+2*unitlist[h[3][5]][2][9],map) == true then
						h[2][2] = h[2][2]+unitlist[h[3][5]][4]
					else
						if math.abs(h[2][2]) > unitlist[h[3][5]][9] then
							killing(i)
						end
						if cartogt[ex][1] == true
						or cartogt[ex][2] == true then
							for f,k in ipairs(cartog[ex]) do
								if unit[k][4] == 6.1 then
									if math.sqrt((h[1][1]-unit[k][1][1])^2+(h[1][2]-unit[k][1][2])^2) < 6 then
										unit[k][7] = unit[k][7]-unitlist[unit[k][3][5]][11][4]
										h[1][2] = h[1][2]-1
										h[2][1] = h[2][1]+unitlist[unit[k][3][5]][11][2]*unit[k][6]+h[5][1]*h[18]*h[5][8]*2
										h[2][2] = h[2][2]+unitlist[unit[k][3][5]][11][3]*2
										unit[k][5][7] = 1
										if math.abs(unitlist[unit[k][3][5]][11][2]) > .01 then
											h[5][1] = (unitlist[unit[k][3][5]][11][2]/math.abs(unitlist[unit[k][3][5]][11][2]))*unit[k][6]
											h[6] = (unitlist[unit[k][3][5]][11][2]/math.abs(unitlist[unit[k][3][5]][11][2]))*unit[k][6]
										end
									end
								elseif unit[k][4] == 6.2 then
									if math.sqrt((h[1][1]-unit[k][1][1])^2+(h[1][2]-unit[k][1][2])^2) < 6 then
										unit[k][7] = unit[k][7]-unitlist[unit[k][3][5]][12][4]
										h[1][2] = h[1][2]-1
										h[2][1] = h[2][1]+unitlist[unit[k][3][5]][12][2]*unit[k][6]+h[5][1]*h[18]*h[5][8]*2
										h[2][2] = h[2][2]+unitlist[unit[k][3][5]][12][3]*2
										unit[k][5][7] = 1
										if math.abs(unitlist[unit[k][3][5]][12][2]) > .01 then
											h[5][1] = (unitlist[unit[k][3][5]][12][2]/math.abs(unitlist[unit[k][3][5]][12][2]))*unit[k][6]
											h[6] = (unitlist[unit[k][3][5]][12][2]/math.abs(unitlist[unit[k][3][5]][12][2]))*unit[k][6]
										end
									end
								elseif unit[k][4] == 5 then
									if math.sqrt((h[1][1]-unit[k][1][1])^2+(h[1][2]-unit[k][1][2])^2) < 6 then
										local sen = (h[1][1]-unit[k][1][1])/math.abs(h[1][1]-unit[k][1][1])
										h[1][1] = h[1][1]-sen
										h[5][1] = -sen
										h[6] = -sen
									end
								end
							end
						end
						h[1][1] = h[1][1]+h[5][1]*h[18]*h[5][8]*2
						h[5][6] = h[5][6]+.5*math.abs(h[5][8]*h[18])*unitlist[h[3][4]][19]
						if h[5][6] >= 5 then
							h[5][6] = 1
						end
					end
					--bas
					if coli(h[1][1]-1,h[1][2]+2*unitlist[h[3][5]][2][9]-1,map) == false
					or coli(h[1][1]+1,h[1][2]+2*unitlist[h[3][5]][2][9]-1,map) == false then
						h[2][2] = 0
						h[2][1] = 0
						h[1][2] = h[1][2]-1
					--haut
					elseif coli(h[1][1],h[1][2]+unitlist[h[3][5]][2][9]-6,map) == false then
						h[2][2] = -.2*h[2][2]
						h[2][1] = 0
						h[1][2] = h[1][2]+1
					end
					--droite
					if coli(h[1][1]+1,h[1][2]+unitlist[h[3][5]][2][9]-5,map) == false then
						if (h[1][1]-ita[h[3][4]][3][1])*h[6] < 0 then
							obstacle(h[1][1],h[1][2],h[3][4])
						end
						h[2][1] = -.2*h[2][1]
						h[2][2] = 0
						h[1][1] = h[1][1]-1
						h[5][1] = -1
					--gauche
					elseif coli(h[1][1]-1,h[1][2]+unitlist[h[3][5]][2][9]-5,map) == false then
						if (h[1][1]-ita[h[3][4]][3][1])*h[6] < 0 then
							obstacle(h[1][1],h[1][2],h[3][4])
						end
						h[2][1] = -.2*h[2][1]
						h[2][2] = 0
						h[1][1] = h[1][1]+1
						h[5][1] = 1
					end
					if h[5][5][3] ~= 0
					and unit[h[5][5][3]] ~= nil then
						if unit[h[5][5][3]][4] == 0
						or unit[h[5][5][3]][12] ~= h[5][5][4] then
							h[4] = 1
							h[5][5][3] = 0
						else
							distgh = math.sqrt((unit[h[5][5][3]][1][1]-h[1][1])^2+(unit[h[5][5][3]][1][2]-h[1][2])^2)
							h[3][1][3] = h[3][1][3]-.05*(h[3][1][3]-math.atan(((unit[h[5][5][3]][1][2]-h[1][2])/distgh*missilist[unitlist[h[3][5]][5]][2]-.5*distgh*missilist[unitlist[h[3][5]][5]][1]/missilist[unitlist[h[3][5]][5]][2])/-(.0010101010101+(((unit[h[5][5][3]][1][1]-h[1][1])/distgh*missilist[unitlist[h[3][5]][5]][2])))))
							if crono > h[5][4] then
								tire(h[1][3]+unitlist[h[3][5]][2][7]*math.cos(-.5*math.pi-h[3][1][2]) ,h[1][4]+unitlist[h[3][5]][2][7]*math.sin(-.5*math.pi-h[3][1][2]),h[5][5][1],h[5][5][2],unitlist[h[3][5]][5],unitlist[h[3][5]][8],h[3][4],i)
								h[5][4] = crono+unitlist[h[3][5]][6]*(1+math.random(-20,20)/100)
								h[5][7] = 1
								soue = math.random(1,2)
								if unitlist[h[3][5]][17][soue] ~= 1 then
									if timeson < crono then
									timeson = crono+.02
										table.insert(soundlist,{love.audio.newSource(unitlist[h[3][5]][17][soue]),crono+1})
										soundlist[table.maxn(soundlist)][1]:setVolume( math.min(1/(1+math.sqrt((h[1][1]-cam_x)^2+(h[1][2]-cam_y)^2)+(20/zoom)^2)*20,2) )
										love.audio.play(soundlist[table.maxn(soundlist)][1])
									end


								end
							end
						end
					else
						h[4] = 1
					end
					h[1][1] = h[1][1]+h[2][1]
					h[1][2] = h[1][2]+h[2][2]
					h[5][7] = math.min(h[5][7]+5/unitlist[h[3][5]][6]*dot,4)
				elseif h[4] == 4.1 then -- creuse-- creuse-- creuse-- creuse-- creuse-- creuse-- creuse-- creuse
					h[1][1] = h[1][1]+unitlist[h[3][5]][11][2]*h[5][1]
					h[1][2] = h[1][2]+unitlist[h[3][5]][11][3]
					h[5][6] = h[5][6]+.5*math.abs(unitlist[h[3][5]][11][2])*unitlist[h[3][4]][19]
					if h[5][6] >= 5 then
						h[5][6] = 1
					end
					h[5][7] = math.min(h[5][7]+4*math.sqrt(unitlist[h[3][5]][11][2]^2+unitlist[h[3][5]][11][3]^2),4)
					if crono > h[5][4] then

						if coli(h[1][1]-unitlist[h[3][5]][11][4]/1.5,h[1][2]+unitlist[h[3][5]][11][4],map) == true
						and coli(h[1][1]+unitlist[h[3][5]][11][4]/1.5,h[1][2]+unitlist[h[3][5]][11][4],map) == true then
							h[4] = 1
							h[5][7] = 4
						end
						if creusage(h[1][1]+unitlist[h[3][5]][11][2]*h[5][1],h[1][2]+unitlist[h[3][5]][11][3],unitlist[h[3][5]][11][4]) == true
						and h[7]-unitlist[h[3][5]][11][6] >= 0
						and gold[h[3][4]]-unitlist[h[3][5]][11][5] >= 0 then
							for r,z in ipairs(ita[h[3][4]][4]) do
								if math.abs(h[1][1]-z[1]) < 5
								and math.abs(h[1][2]-z[2]) < 5 then
									z[3] = .1
								end
							end
							h[7] = h[7]-unitlist[h[3][5]][11][6]
							h[5][4] = crono+2*dot/math.sqrt(unitlist[h[3][5]][11][2]^2+unitlist[h[3][5]][11][3]^2)
							h[5][7] = 1
						else
							h[4] = 1
							h[5][7] = 4
						end
					end
				elseif h[4] == 4.2 then -- creuse-- creuse-- creuse-- creuse-- creuse-- creuse-- creuse-- creuse
					h[1][1] = h[1][1]+unitlist[h[3][5]][12][2]*h[5][1]
					h[1][2] = h[1][2]+unitlist[h[3][5]][12][3]
					h[5][6] = h[5][6]+.5*math.abs(unitlist[h[3][5]][12][2])*unitlist[h[3][4]][19]
					if h[5][6] >= 5 then
						h[5][6] = 1
					end
					h[5][7] = math.min(h[5][7]+4*math.sqrt(unitlist[h[3][5]][12][2]^2+unitlist[h[3][5]][12][3]^2),4)
					if crono > h[5][4] then

						if coli(h[1][1]-unitlist[h[3][5]][12][4]/1.5,h[1][2]+unitlist[h[3][5]][12][4],map) == true
						and coli(h[1][1]+unitlist[h[3][5]][12][4]/1.5,h[1][2]+unitlist[h[3][5]][12][4],map) == true then
							h[4] = 1
							h[5][7] = 4
						end
						if creusage(h[1][1]+unitlist[h[3][5]][12][2]*h[5][1],h[1][2]+unitlist[h[3][5]][12][3],unitlist[h[3][5]][12][4]) == true
						and h[7]-unitlist[h[3][5]][12][6] >= 0
						and gold[h[3][4]]-unitlist[h[3][5]][12][5] >= 0 then
							for r,z in ipairs(ita[h[3][4]][4]) do
								if math.abs(h[1][1]-z[1]) < 5
								and math.abs(h[1][2]-z[2]) < 5 then
									z[3] = .1
								end
							end
							h[7] = h[7]-unitlist[h[3][5]][12][6]
							h[5][4] = crono+2*dot/math.sqrt(unitlist[h[3][5]][12][2]^2+unitlist[h[3][5]][12][3]^2)
							h[5][7] = 1
						else
							h[4] = 1
							h[5][7] = 4
						end
					end
				elseif h[4] == 5 then -- bloc-- bloc-- bloc-- bloc-- bloc-- bloc-- bloc-- bloc-- bloc-- bloc
					h[2][1] = h[2][1]/1.01
					h[2][2] = h[2][2]/1.01
					if math.floor(unitlist[h[3][5]][10]) ~= 4 then
						--grav
						if coli(h[1][1]-1,h[1][2]+2*unitlist[h[3][5]][2][9],map) == true
						and coli(h[1][1]+1,h[1][2]+2*unitlist[h[3][5]][2][9],map) == true then
							h[2][2] = h[2][2]+unitlist[h[3][5]][4]
						else
							if math.abs(h[2][2]) > unitlist[h[3][5]][9] then
								killing(i)
							end
							h[2][1] = 0
							h[2][2] = 0
						end
						--bas
						if coli(h[1][1]-1,h[1][2]+2*unitlist[h[3][5]][2][9]-1,map) == false
						or coli(h[1][1]+1,h[1][2]+2*unitlist[h[3][5]][2][9]-1,map) == false then
							h[2][2] = 0
							h[2][1] = 0
							h[1][2] = h[1][2]-1
						end
						--haut
						if coli(h[1][1],h[1][2]+unitlist[h[3][5]][2][9]-6,map) == false then
							h[2][2] = -.2*h[2][2]
							h[2][1] = 0
							h[1][2] = h[1][2]+1
						end
						--droite
						if coli(h[1][1]+1,h[1][2]+unitlist[h[3][5]][2][9]-5,map) == false then
							h[2][1] = -.2*h[2][1]
							h[2][2] = 0
							h[1][1] = h[1][1]-1
						end
						--gauche
						if coli(h[1][1]-1,h[1][2]+unitlist[h[3][5]][2][9]-5,map) == false then
							h[2][1] = -.2*h[2][1]
							h[2][2] = 0
							h[1][1] = h[1][1]+1
						end
					end
					h[1][1] = h[1][1]+h[2][1]
					h[1][2] = h[1][2]+h[2][2]
				elseif h[4] == 6.1 then -- trempoline-- trempoline-- trempoline-- trempoline-- trempoline-- trempoline-- trempoline
					h[2][1] = h[2][1]/1.01
					h[2][2] = h[2][2]/1.01
					if math.floor(unitlist[h[3][5]][10]) ~= 4 then
						--grav
						if coli(h[1][1]-1,h[1][2]+2*unitlist[h[3][5]][2][9],map) == true
						and coli(h[1][1]+1,h[1][2]+2*unitlist[h[3][5]][2][9],map) == true then
							h[2][2] = h[2][2]+unitlist[h[3][5]][4]
						else
							if math.abs(h[2][2]) > unitlist[h[3][5]][9] then
								killing(i)
							end
							h[2][1] = 0
							h[2][2] = 0
						end
						--bas
						if coli(h[1][1]-1,h[1][2]+2*unitlist[h[3][5]][2][9]-1,map) == false
						or coli(h[1][1]+1,h[1][2]+2*unitlist[h[3][5]][2][9]-1,map) == false then
							h[2][2] = 0
							h[2][1] = 0
							h[1][2] = h[1][2]-1
						end
						--haut
						if coli(h[1][1],h[1][2]+unitlist[h[3][5]][2][9]-6,map) == false then
							h[2][2] = -.2*h[2][2]
							h[2][1] = 0
							h[1][2] = h[1][2]+1
						end
						--droite
						if coli(h[1][1]+1,h[1][2]+unitlist[h[3][5]][2][9]-5,map) == false then
							h[2][1] = -.2*h[2][1]
							h[2][2] = 0
							h[1][1] = h[1][1]-1
						end
						--gauche
						if coli(h[1][1]-1,h[1][2]+unitlist[h[3][5]][2][9]-2,map) == false then
							h[2][1] = -.2*h[2][1]
							h[2][2] = 0
							h[1][1] = h[1][1]+1
						end
					end
					h[5][7] = math.min(h[5][7]+8/unitlist[h[3][5]][6]*dot,4)
					h[1][1] = h[1][1]+h[2][1]
					h[1][2] = h[1][2]+h[2][2]
				elseif h[4] == 6.2 then-- trempoline-- trempoline-- trempoline-- trempoline-- trempoline-- trempoline-- trempoline
					h[2][1] = h[2][1]/1.01
					h[2][2] = h[2][2]/1.01
					if math.floor(unitlist[h[3][5]][10]) ~= 4 then
						--grav
						if coli(h[1][1]-1,h[1][2]+2*unitlist[h[3][5]][2][9],map) == true
						and coli(h[1][1]+1,h[1][2]+2*unitlist[h[3][5]][2][9],map) == true then
							h[2][2] = h[2][2]+unitlist[h[3][5]][4]
						else
							if math.abs(h[2][2]) > unitlist[h[3][5]][9] then
								killing(i)
							end
							h[2][1] = 0
							h[2][2] = 0
						end
						--bas
						if coli(h[1][1]-1,h[1][2]+2*unitlist[h[3][5]][2][9]-1,map) == false
						or coli(h[1][1]+1,h[1][2]+2*unitlist[h[3][5]][2][9]-1,map) == false then
							h[2][2] = 0
							h[2][1] = 0
							h[1][2] = h[1][2]-1
						end
						--haut
						if coli(h[1][1],h[1][2]+unitlist[h[3][5]][2][9]-6,map) == false then
							h[2][2] = -.2*h[2][2]
							h[2][1] = 0
							h[1][2] = h[1][2]+1
						end
						--droite
						if coli(h[1][1]+1,h[1][2]+unitlist[h[3][5]][2][9]-5,map) == false then
							h[2][1] = -.2*h[2][1]
							h[2][2] = 0
							h[1][1] = h[1][1]-1
						end
						--gauche
						if coli(h[1][1]-1,h[1][2]+unitlist[h[3][5]][2][9]-5,map) == false then
							h[2][1] = -.2*h[2][1]
							h[2][2] = 0
							h[1][1] = h[1][1]+1
						end
					end
					h[1][1] = h[1][1]+h[2][1]
					h[1][2] = h[1][2]+h[2][2]
					h[5][7] = math.min(h[5][7]+8/unitlist[h[3][5]][6]*dot,4)
				elseif h[4] == 7.1 then -- construit -- construit -- construit -- construit -- construit -- construit -- construit
					if h[5][7] <= 4 then
						h[5][7] = h[5][7]+dot*8
					else
						h[5][7] = 1
						sou = math.floor(math.random(1,4))
						if timeson < crono then
									timeson = crono+.02
							table.insert(soundlist,{love.audio.newSource(toc[sou]),crono+1})
							soundlist[table.maxn(soundlist)][1]:setVolume( math.min(1/(1+math.sqrt((h[1][1]-cam_x)^2+(h[1][2]-cam_y)^2)+(20/zoom)^2)*20,2) )
							love.audio.play(soundlist[table.maxn(soundlist)][1])
						end

					end
					if crono > h[5][4] then
						h[5][4] = 0
						while h[5][4]/dot <= (unitlist[h[3][5]][11][2]:getWidth()*unitlist[h[3][5]][11][2]:getHeight())/unitlist[h[3][5]][11][4] do
							h[2][1] = h[2][1]+1
							h[17] = h[17]+h[16]
							if h[2][1] >= unitlist[h[3][5]][11][2]:getWidth() then
								h[2][1] = 1
								h[2][2] = h[2][2]-1
								h[17] = 0
								if h[2][2] < 0 then
									h[4] = 1
									h[1][1] = h[5][5][1]
									h[1][2] = h[5][5][2]-30-unitlist[h[3][5]][2][9]
									h[2][1] = 0
									h[2][2] = 0
									h[5][4] = 999999999999999999
									if unitlist[h[3][5]][11][3][1] ~= 0 then
										creation(h[1][1]+unitlist[h[3][5]][11][3][2]*h[6],h[16]*unitlist[h[3][5]][11][3][2]+h[1][2]+unitlist[h[3][5]][11][2]:getWidth()-unitlist[h[3][5]][11][3][3],unitlist[h[3][5]][11][3][1],h[3][4],unitlist[h[3][5]][11][3][4]*h[6] ,0)
									end
								end
							end
							if h[4] ~= 1 then
								if h[1][1] > 4
								and h[1][1] < map:getWidth()-4
								and h[1][2] > 4
								and h[1][2] < map:getHeight()-4 then
									ir, ig, ib, ia = unitlist[h[3][5]][11][2]:getPixel( math.floor(h[2][1]), math.floor(h[2][2]) )
									r, g, b, a = map:getPixel( h[5][5][1]+h[2][1]*h[6] , h[5][5][2]-unitlist[h[3][5]][11][2]:getHeight()+h[2][2]+h[17] )
									djyu = 1
									if h[2][2] > unitlist[h[3][5]][11][2]:getHeight()-30
									and a == 255
									and ia == 255 then
										djyu = 0
									end
									if ia*djyu ~= 0 then
										h[5][4] = h[5][4]+1
										h[1][1] = h[5][5][1]+h[2][1]*h[6]
										h[1][2] = h[5][5][2]-unitlist[h[3][5]][11][2]:getHeight()+h[2][2]+h[17]
										if ia < 255
										and ia*djyu > 100
										or a*djyu == 100*(1+unitlist[h[3][5]][11][10]) then
											map:setPixel( h[5][5][1]+h[2][1]*h[6] , h[5][5][2]-unitlist[h[3][5]][11][2]:getHeight()+h[2][2]+h[17] , ir,ig, ib, 100 )
										else
											if h[2][2] < unitlist[h[3][5]][11][2]:getHeight()-30 then
												map:setPixel( h[5][5][1]+h[2][1]*h[6] , h[17]+h[5][5][2]-unitlist[h[3][5]][11][2]:getHeight()+h[2][2] , (r*(255-ia)*a/255+ir*ia)/255,(g*(255-ia)*a/255+ig*ia)/255, (b*(255-ia)*a/255+ib*ia)/255, math.max(ia,a) )
											else
												map:setPixel( h[5][5][1]+h[2][1]*h[6] , h[17]+h[5][5][2]-unitlist[h[3][5]][11][2]:getHeight()+h[2][2] , (ir*(255-a)*ia/255+r*a)/255,(ig*(255-a)*ia/255+g*a)/255, (ib*(255-a)*ia/255+b*a)/255, math.max(ia,a) )
											end
										end
										if math.random(0,100) > 90 then
											table.insert(effet,{h[5][5][1]+h[2][1]*h[6],h[17]+h[5][5][2]-unitlist[h[3][5]][11][2]:getHeight()+h[2][2],0,.01,.7,.7,.01,.01,0,.01,100,-1.5,fum,crono+5,-.002,.01,255,255,255,-1,-1,-1})
										end
										if newm == 0 then
											refre = crono+.3
										end
										newm = 1
									end
								else


									h[4] = 1
									h[1][1] = h[5][5][1]
									h[1][2] = h[5][5][2]-30-unitlist[h[3][5]][2][9]
									h[2][1] = 0
									h[2][2] = 0
									h[5][4] = 999999999999999999
									if unitlist[h[3][5]][11][3][1] ~= 0 then
										creation(h[1][1]+unitlist[h[3][5]][11][3][2]*h[6],h[16]*unitlist[h[3][5]][11][3][2]+h[1][2]+unitlist[h[3][5]][11][2]:getWidth()-unitlist[h[3][5]][11][3][3],unitlist[h[3][5]][11][3][1],h[3][4],unitlist[h[3][5]][11][3][4]*h[6] ,0)
									end



								end
							end

						end
						h[5][4] = crono+unitlist[h[3][5]][11][4]/(unitlist[h[3][5]][11][2]:getWidth()*unitlist[h[3][5]][11][2]:getHeight())
					end
				elseif h[4] == 7.2 then -- construit -- construit -- construit -- construit -- construit -- construit -- construit
					if h[5][7] <= 4 then
						h[5][7] = h[5][7]+dot*8
					else
						h[5][7] = 1
						sou = math.floor(math.random(1,4))

						if timeson < crono then
							timeson = crono+.02
							table.insert(soundlist,{love.audio.newSource(toc[sou]),crono+1})
							soundlist[table.maxn(soundlist)][1]:setVolume( math.min(1/(1+math.sqrt((h[1][1]-cam_x)^2+(h[1][2]-cam_y)^2)+(20/zoom)^2)*20,2) )
							love.audio.play(soundlist[table.maxn(soundlist)][1])
						end

					end
					if crono > h[5][4] then
						h[5][4] = 0
						while h[5][4]/dot <= (unitlist[h[3][5]][12][2]:getWidth()*unitlist[h[3][5]][12][2]:getHeight())/unitlist[h[3][5]][12][4] do
							h[17] = h[17]+h[16]
							h[2][1] = h[2][1]+1
							if h[2][1] >= unitlist[h[3][5]][12][2]:getWidth() then
								h[17] = 0
								h[2][1] = 1
								h[2][2] = h[2][2]-1
								if h[2][2] < 0 then
									h[4] = 1
									h[1][1] = h[5][5][1]
									h[1][2] = h[5][5][2]-30-unitlist[h[3][5]][2][9]
									h[2][1] = 0
									h[2][2] = 0
									h[5][4] = 999999999999999999
									if unitlist[h[3][5]][12][3][1] ~= 0 then
										creation(h[1][1]+unitlist[h[3][5]][12][3][2]*h[6],h[16]*unitlist[h[3][5]][12][3][2]+h[1][2]+unitlist[h[3][5]][12][2]:getWidth()-unitlist[h[3][5]][12][3][3],unitlist[h[3][5]][12][3][1],h[3][4],unitlist[h[3][5]][12][3][4]*h[6] ,0)
									end
								end
							end
							if h[4] ~= 1 then




								if h[1][1] > 4
								and h[1][1] < map:getWidth()-4
								and h[1][2] > 4
								and h[1][2] < map:getHeight()-4 then
									ir, ig, ib, ia = unitlist[h[3][5]][12][2]:getPixel( math.floor(h[2][1]), math.floor(h[2][2]) )
									r, g, b, a = map:getPixel( h[5][5][1]+h[2][1]*h[6] , h[17]+h[5][5][2]-unitlist[h[3][5]][12][2]:getHeight()+h[2][2] )
									djyu = 1
									if h[2][2] > unitlist[h[3][5]][12][2]:getHeight()-30
									and a == 255
									and ia == 255 then
										djyu = 0
									end
									if ia*djyu ~= 0 then
										h[5][4] = h[5][4]+1
										h[1][1] = h[5][5][1]+h[2][1]*h[6]
										h[1][2] = h[5][5][2]-unitlist[h[3][5]][12][2]:getHeight()+h[2][2]+h[17]
										if ia < 255
										and ia*djyu > 100
										or a*djyu == 100*(1+unitlist[h[3][5]][12][10]) then
											map:setPixel( h[5][5][1]+h[2][1]*h[6] , h[17]+h[5][5][2]-unitlist[h[3][5]][12][2]:getHeight()+h[2][2] , ir,ig, ib, 100 )
										else
											if h[2][2] < unitlist[h[3][5]][12][2]:getHeight()-30 then
												map:setPixel( h[5][5][1]+h[2][1]*h[6] , h[17]+h[5][5][2]-unitlist[h[3][5]][12][2]:getHeight()+h[2][2] , (r*(255-ia)*a/255+ir*ia)/255,(g*(255-ia)*a/255+ig*ia)/255, (b*(255-ia)*a/255+ib*ia)/255, math.max(ia,a) )
											else
												map:setPixel( h[5][5][1]+h[2][1]*h[6] , h[17]+h[5][5][2]-unitlist[h[3][5]][12][2]:getHeight()+h[2][2] , (ir*(255-a)*ia/255+r*a)/255,(ig*(255-a)*ia/255+g*a)/255, (ib*(255-a)*ia/255+b*a)/255, math.max(ia,a) )
											end
										end
										if math.random(0,100) > 90 then
											table.insert(effet,{h[5][5][1]+h[2][1]*h[6],h[17]+h[5][5][2]-unitlist[h[3][5]][12][2]:getHeight()+h[2][2],0,.01,.7,.7,.01,.01,0,.01,100,-1.5,fum,crono+5,-.002,.01,255,255,255,-1,-1,-1})
										end
										if newm == 0 then
											refre = crono+.3
										end
										newm = 1
									end
								else

									h[4] = 1
									h[1][1] = h[5][5][1]
									h[1][2] = h[5][5][2]-30-unitlist[h[3][5]][2][9]
									h[2][1] = 0
									h[2][2] = 0
									h[5][4] = 999999999999999999
									if unitlist[h[3][5]][12][3][1] ~= 0 then
										creation(h[1][1]+unitlist[h[3][5]][12][3][2]*h[6],h[16]*unitlist[h[3][5]][12][3][2]+h[1][2]+unitlist[h[3][5]][12][2]:getWidth()-unitlist[h[3][5]][12][3][3],unitlist[h[3][5]][12][3][1],h[3][4],unitlist[h[3][5]][12][3][4]*h[6] ,0)
									end

								end
							end

						end
						h[5][4] = crono+unitlist[h[3][5]][12][4]/(unitlist[h[3][5]][12][2]:getWidth()*unitlist[h[3][5]][12][2]:getHeight())
					end
				elseif h[4] == 8 then -- sonnée -- sonnée -- sonnée -- sonnée -- sonnée -- sonnée
					h[2][1] = h[2][1]/1.01
					h[2][2] = h[2][2]/1.01
					if math.floor(unitlist[h[3][5]][10]) ~= 4 then
						--grav
						if coli(h[1][1]-1,h[1][2]+2*unitlist[h[3][5]][2][9],map) == true
						and coli(h[1][1]+1,h[1][2]+2*unitlist[h[3][5]][2][9],map) == true then
							h[2][2] = h[2][2]+unitlist[h[3][5]][4]
						else
							if math.abs(h[2][2]) > unitlist[h[3][5]][9] then
								killing(i)
							end
							h[2][1] = 0
							h[2][2] = 0
						end
						--bas
						if coli(h[1][1]-1,h[1][2]+2*unitlist[h[3][5]][2][9]-1,map) == false
						or coli(h[1][1]+1,h[1][2]+2*unitlist[h[3][5]][2][9]-1,map) == false then
							h[2][2] = 0
							h[2][1] = 0
							h[1][2] = h[1][2]-1
						end
						--haut
						if coli(h[1][1],h[1][2]+unitlist[h[3][5]][2][9]-6,map) == false then
							h[2][2] = -.2*h[2][2]
							h[2][1] = 0
							h[1][2] = h[1][2]+1
						end
						--droite
						if coli(h[1][1]+1,h[1][2]+unitlist[h[3][5]][2][9]-5,map) == false then
							h[2][1] = -.2*h[2][1]
							h[2][2] = 0
							h[1][1] = h[1][1]-1
						end
						--gauche
						if coli(h[1][1]-1,h[1][2]+unitlist[h[3][5]][2][9]-5,map) == false then
							h[2][1] = -.2*h[2][1]
							h[2][2] = 0
							h[1][1] = h[1][1]+1
						end
					end
					h[1][1] = h[1][1]+h[2][1]
					h[1][2] = h[1][2]+h[2][2]
					if h[3][2] < crono then
						h[4] = h[16]
					end
				end
			end
			for i,h in ipairs(missi) do
--{ 1 X , 2 Y , 3 M , 4 N , 5 timer ,6 type , 7 taille , 8 team , 9 direc , 10 mode , 11 rebon , 12 dx , 13 dy , 14 distance }
				h[3] = h[3]/1.0001
				h[4] = h[4]/1.0001+2*missilist[h[6]][1]
				if h[11] ~= 0 then
					h[9] = h[9]+.01
				else
					h[9] = math.atan2(h[4],h[3])
				end
						spee = math.sqrt(h[3]^2+h[4]^2)
						if missilist[h[6]][16][1] ~= 0 then
							h[15] = h[15]+spee
							if h[15] > h[14] then
								tre = 0
								while h[15] > h[14]+tre do
									tre = tre+missilist[h[6]][16][1]
									table.insert(effet,{h[12]-h[3]+h[3]*(h[14]-(h[15]-tre))/spee,h[13]-h[4]+h[4]*(h[14]-(h[15]-tre))/spee,h[3]*missilist[h[6]][16][2],h[4]*missilist[h[6]][16][2],missilist[h[6]][16][3],missilist[h[6]][16][3],missilist[h[6]][16][4],missilist[h[6]][16][4],h[9],missilist[h[6]][16][5],missilist[h[6]][16][6],missilist[h[6]][16][7],missilist[h[6]][16][10],crono+missilist[h[6]][16][11],missilist[h[6]][16][8],missilist[h[6]][16][9],missilist[h[6]][16][12],missilist[h[6]][16][13],missilist[h[6]][16][14],missilist[h[6]][16][15],missilist[h[6]][16][16],missilist[h[6]][16][17]})
				--{ 1 X , 2 Y , 3 M , 4 N , 5 sx ,6 sy , 7 sx+ , 8 sy+ , 9 r , 10 r+ , 11 a , 12 a+ , 13 img , 14 timer , 15 grav , 16 frix }

-- 1 nb 2 speed 3 sc 4 +sc 5 r+ 6 a 7 a+ 8 grav 9 frix 10 img 11 timer 12 r 13 v 14 b

								end
								h[14] = h[14]+tre
							end
						end
				if h[10] == 1 then
					if crono > h[5] then
						explosion(h[1],h[2],missilist[h[6]][5],missilist[h[6]][3],missilist[h[6]][4],missilist[h[6]][8],missilist[h[6]][11],h[8],missilist[h[6]][17])
						sou = math.random(1,3)
						if timeson < crono then
									timeson = crono+.02
							table.insert(soundlist,{love.audio.newSource(missilist[h[6]][15][sou]),crono+1})
							soundlist[table.maxn(soundlist)][1]:setVolume( math.min(1/(1+math.sqrt((h[1]-cam_x)^2+(h[2]-cam_y)^2)+(100/zoom)^2)*2*20,2) )
							love.audio.play(soundlist[table.maxn(soundlist)][1])
						end


						h[5] = crono+1
						h[10] = 0
						h[8] = 100
					else
						spee = math.sqrt(h[3]^2+h[4]^2)
						wx = h[1]
						wy = h[2]
						tre = 0
						while tre < spee do
							tre = tre+4
							wx = wx+h[3]*4/spee
							wy = wy+h[4]*4/spee
							if coli2(h[1],h[2],h[8]) == true then
								h[1] = wx
								h[2] = wy
								explosion(h[1],h[2],missilist[h[6]][5],missilist[h[6]][3],missilist[h[6]][4],missilist[h[6]][8],missilist[h[6]][11],h[8],missilist[h[6]][17])
								sou = math.random(1,3)

								if timeson < crono then
									timeson = crono+.02
									table.insert(soundlist,{love.audio.newSource(missilist[h[6]][15][sou]),crono+1})
									soundlist[table.maxn(soundlist)][1]:setVolume(( math.min(1/(1+math.sqrt((h[1]-cam_x)^2+(h[2]-cam_y)^2)+(100/zoom)^2)*2*20,2) ))
									love.audio.play(soundlist[table.maxn(soundlist)][1])
								end



								h[5] = crono+1
								h[10] = 0
								h[8] = 100
								tre = math.huge
								if unitlist[unit[who][3][5]][24] == 1 then
									table.insert(effet,{h[1]-1.5*h[3],h[2]-1.5*h[4],.8*h[3],.8*h[4]-.2,missilist[h[6]][3]*math.random(40,80)/2000,missilist[h[6]][3]*math.random(40,80)/2000,.001,.001,h[9]+math.pi+math.random(-45,45)/57,math.random(-50,50)/1000,255,-8,sang,crono+.6,.02,.2,255,255,255,-1,-1,-1})
								elseif unitlist[unit[who][3][5]][24] == 2 then
									table.insert(effet,{h[1]-1.5*h[3],h[2]-1.5*h[4],.8*h[3],.8*h[4]-.2,missilist[h[6]][3]*math.random(60,120)/2000,missilist[h[6]][3]*math.random(60,120)/2000,.001,.001,h[9]+math.pi+math.random(-45,45)/57,math.random(-50,50)/1000,255,-8,sang2,crono+.6,.02,.2,255,255,255,-6,-7,-8})
								elseif unitlist[unit[who][3][5]][24] == 3 then
									table.insert(effet,{h[1]-1.5*h[3],h[2]-1.5*h[4],.8*h[3],.8*h[4]-.2,missilist[h[6]][3]*math.random(40,80)/2000,missilist[h[6]][3]*math.random(40,80)/2000,.001,.001,h[9]+math.pi+math.random(-45,45)/57,math.random(-100,100)/1000,255,-8,sang3,crono+.6,.02,.2,255,255,255,-1,-1,-1})
								elseif unitlist[unit[who][3][5]][24] == 4 then
									table.insert(effet,{h[1]-1.5*h[3],h[2]-1.5*h[4],.8*h[3],.8*h[4]-.2,missilist[h[6]][3]*math.random(60,120)/2000,missilist[h[6]][3]*math.random(60,120)/2000,.001,.001,h[9]+math.pi+math.random(-45,45)/57,math.random(-100,100)/1000,255,-8,sang4,crono+.6,.02,.2,255,255,255,-1,-1,-1})
								end
	--{ 1 X , 2 Y , 3 M , 4 N , 5 sx ,6 sy , 7 sx+ , 8 sy+ , 9 r , 10 r+ , 11 a , 12 a+ , 13 img , 14 timer , 15 grav , 16 frix }
	--{ 1 X , 2 Y , 3 M , 4 N , 5 timer ,6 type , 7 taille , 8 team , 9 direc , 10 mode , 11 rebon , 12 dx , 13 dy  }
							elseif coli(h[1],h[2],map) == false then
								if h[11] < missilist[h[6]][12]
								or missilist[h[6]][12] > 20 then
									h[1] = h[1]-h[3]
									h[2] = h[2]-h[4]
									h[3] = missilist[h[6]][13]*h[3]
									h[4] = missilist[h[6]][13]*h[4]
									--X
									if coli(h[1]+3,h[2],map) == false then
										h[3] = -math.abs(h[3])
										h[1] = h[1]-.01
									end
									if coli(h[1]-3,h[2],map) == false then
										h[3] = math.abs(h[3])
										h[1] = h[1]+.01
									end
									--Y
									if coli(h[1],h[2]+3,map) == false then
										h[4] = -math.abs(h[4])
										h[2] = h[2]-.01
									end
									if coli(h[1],h[2]-3,map) == false then
										h[4] = math.abs(h[4])
										h[2] = h[2]+.01
									end
									h[11] = h[11]+1
									h[1] = h[1]+h[3]
									h[2] = h[2]+h[4]
									spee = math.sqrt(h[3]^2+h[4]^2)
								else
									explosion(h[1],h[2],missilist[h[6]][5],missilist[h[6]][3],missilist[h[6]][4],missilist[h[6]][8],missilist[h[6]][11],h[8],missilist[h[6]][17])
									sou = math.random(1,3)
									if timeson < crono then
									timeson = crono+.02
										table.insert(soundlist,{love.audio.newSource(missilist[h[6]][15][sou]),crono+1})
										soundlist[table.maxn(soundlist)][1]:setVolume( math.min(1/(1+math.sqrt((h[1]-cam_x)^2+(h[2]-cam_y)^2)+(100/zoom)^2)*2*20,2) )
										love.audio.play(soundlist[table.maxn(soundlist)][1])
									end





									h[5] = crono+1
									h[10] = 0
									h[8] = 100
								end
							end
						end
						h[1] = h[1]+h[3]
						h[2] = h[2]+h[4]
					end
				elseif h[10] == 0 then
					h[3] = .6*h[3]
					h[4] = .6*h[4]
					h[7] = h[7]+1
					h[8] = h[8]-2
					if h[8] < 1 then
						table.remove(missi,i)
					end
				end
				h[12] = h[12]+.3*(h[1]-h[12])
				h[13] = h[13]+.3*(h[2]-h[13])
			end
			for i,h in ipairs(unit) do
				if h[4] == 0 then -- mort -- mort -- mort -- mort -- mort -- mort -- mort -- mort -- mort -- mort
					h[2][1] = h[2][1]/1.01
					h[2][2] = h[2][2]/1.01
					if math.floor(unitlist[h[3][5]][10]) ~= 4 then
						if h[1][1] > 5
						and h[1][2] < mape:getWidth()-5
						and h[1][1] > 5
						and h[1][2] < mape:getHeight()-5 then
							--grav
							if coli(h[1][1]-1,h[1][2]+6,map) == true
							and coli(h[1][1]+1,h[1][2]+6,map) == true then
								h[2][2] = h[2][2]+unitlist[h[3][5]][4]
							else
								h[2][1] = 0
								h[2][2] = 0
							end
							--haut
							if coli(h[1][1],h[1][2]-3,map) == false then
								h[2][2] = -.2*h[2][2]
								h[2][1] = 0
								h[1][2] = h[1][2]+1
							end
							--droite
							if coli(h[1][1]+1,h[1][2]-2,map) == false then
								h[2][1] = -.2*h[2][1]
								h[2][2] = 0
								h[1][1] = h[1][1]-1
							end
							--gauche
							if coli(h[1][1]-1,h[1][2]-2,map) == false then
								h[2][1] = -.2*h[2][1]
								h[2][2] = 0
								h[1][1] = h[1][1]+1
							end
						else
							h[2][2] = h[2][2]+.1
						end
					end
					if h[5][3] < crono then
						if nearest >= i then
							nearest = nearest-1
						end
						table.remove(unit,i)
						kilede = 1
					end
					h[1][1] = h[1][1]+h[2][1]
					h[1][2] = h[1][2]+h[2][2]
				end
				h[1][3] = h[1][3]+.2*(h[1][1]-h[1][3])
				h[1][4] = h[1][4]+.2*(h[1][2]-h[1][4])
			end
			for f,k in ipairs(cartog) do
				cartog[f] = {}
				cartogt[f] = {false,false,0}
			end
			for i,h in ipairs(effet) do
				h[1] = h[1]+h[3]
				h[2] = h[2]+h[4]
				h[3] = h[3]-h[3]*h[16]
				h[4] = h[4]+h[15]-h[4]*h[16]
				h[5] = h[5]+h[7]
				h[6] = h[6]+h[8]
				h[10] = h[10]-h[10]*h[16]
				h[9] = h[9]+h[10]
				h[11] = math.min(math.max(h[11]+h[12],0),255)
				h[17] = math.min(math.max(h[17]+h[20],0),255)
				h[18] = math.min(math.max(h[18]+h[21],0),255)
				h[19] = math.min(math.max(h[19]+h[22],0),255)
				if h[14] < crono
				or h[11] < 1 then
					table.remove(effet,i)
				end


-- 1 nb 2 frix 3 sc 4 +sc 5 r+ 6 a 7 a+ 8 grav 9 frix 10 img 11 timer 12 r 13 v 14 b 15 r+ 16 v+ 17 b+


			end
		--{ 1 X , 2 Y , 3 M , 4 N , 5 sx ,6 sy , 7 sx+ , 8 sy+ , 9 r , 10 r+ , 11 a , 12 a+ , 13 img , 14 timer , 15 grav , 16 frix , 17,18,19,20color }
			if crono == 0 then
				crono = crono+.02
			else
				crono = crono+dot
			end
			for i,h in ipairs(soundlist) do
				if h[2] < crono-5.5 then
					table.remove(soundlist,i)
				end
			end


			if timermus < crono then
				love.audio.stop( musique )
				lmu = musi
				while lmu == musi do
					musi = math.floor(math.random(10000,10000*trew)/10000)
				end
				musique = love.audio.newSource(  mus[musi][1], "Streaming")
				love.audio.play(musique)
				timermus = crono+mus[musi][2]
			end
		end
	elseif phase == 2 then
		crono = crono+dot
		if musre ~= 0 then
			musre = musre+.1
			if musre > 2 then
				love.audio.play(musiquedefon)
				musre = 0
			end
		end
		gotocoin = .95*gotocoin
		anima = anima+.002*(-anima+400)+.002*(math.min(400-anima,0))
	elseif phase == 3 then
		crono = crono+dot
		anima = anima+.01*(-anima+1100)
		gotocoin = gotocoin+.075*(-gotocoin+(love.graphics.getWidth()/2-50))
	elseif phase == 4 then
		crono = crono+dot
		anima = anima+.01*(-anima+1100)
		gotocoin = gotocoin+.075*(-gotocoin+(love.graphics.getWidth()/2-50))
	elseif phase == 5 then
		crono = crono+dot
		anima = anima+.01*(-anima+1100)
		gotocoin = gotocoin+.075*(-gotocoin+(love.graphics.getWidth()/2-50))
	end
	loa = loa-1
	bouton = 0
	for i,h in ipairs(bout) do
		if math.abs(love.mouse.getX()-h[1]) < h[3]
		and math.abs(love.mouse.getY()-h[2]) < h[4] then
			bouton = i
		end
	end
end
function love.draw()
	love.graphics.setColor(255,255,255)
	if phase == 0 then
		love.graphics.draw( maper , 0,0, 0,love.graphics.getWidth()/maper:getWidth(),love.graphics.getHeight()/maper:getHeight())
		love.graphics.draw( iconed , love.graphics.getWidth()/2 , 350 , 0 , 2,2 , 150 ,150)
		love.graphics.draw( charg , love.graphics.getWidth()/2 , 680 , 0 , 1,1 , 300 ,70)
	elseif phase == 1 then
		love.graphics.setColor(255,255,255)
		love.graphics.draw( mapo , (-.68*love.graphics.getWidth()/2-cam_x/4)*zoom+love.graphics.getWidth()/2 , (-.96*love.graphics.getHeight()/2-cam_y/4)*zoom+love.graphics.getHeight()/2 ,0,maperx*zoom,mapery*zoom)

		love.graphics.setColor(0,0,0,100)
		love.graphics.draw( mapea , (-cam_x)*zoom^.95+love.graphics.getWidth()/2 , (-cam_y)*zoom^.95+love.graphics.getHeight()/2 ,0,zoom^.95)


		love.graphics.setColor(255,255,255)
		for i,h in ipairs(missi) do
			if h[10] == 1 then
				if missilist[h[6]][12] ~= 0 then
					love.graphics.setColor(255,255-255/(1+math.abs(crono-h[5])*2),255-255/(1+math.abs(crono-h[5])))
				end
				love.graphics.draw( missilist[h[6]][6] ,(h[12]-cam_x)*zoom+love.graphics.getWidth()/2,(h[13]-cam_y)*zoom+love.graphics.getHeight()/2,h[9],2*zoom*.2*missilist[h[6]][14],2*zoom*.2*missilist[h[6]][14],missilist[h[6]][6]:getWidth()/2,missilist[h[6]][6]:getHeight()/2)
					love.graphics.setColor(255,255,255)
			end
		end
		for i,h in ipairs(unit) do
			if math.floor(unitlist[h[3][5]][10]) ~= 4
			or play ~= 0 then
				if near > 10
				or nearest ~= i then
					love.graphics.setColor(ita[h[3][4]][6][1],ita[h[3][4]][6][2],ita[h[3][4]][6][3])
					love.graphics.draw( unitlist[h[3][5]][2][1][math.floor(h[5][6])] ,(h[1][3]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][4]-cam_y)*zoom+love.graphics.getHeight()/2,math.pi+h[3][1][1],unitlist[h[3][5]][2][6]*zoom*.2*-h[5][1],-unitlist[h[3][5]][2][6]*zoom*.2,unitlist[h[3][5]][2][1][math.floor(h[5][6])]:getWidth()/2+unitlist[h[3][5]][2][11][1],unitlist[h[3][5]][2][1][math.floor(h[5][6])]:getHeight()/4*1+unitlist[h[3][5]][2][11][2])
					love.graphics.draw( unitlist[h[3][5]][2][2][1] ,(h[1][3]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][4]-cam_y)*zoom+love.graphics.getHeight()/2,-h[3][1][2],unitlist[h[3][5]][2][5]*zoom*.2*h[6],unitlist[h[3][5]][2][5]*zoom*.2,unitlist[h[3][5]][2][2][1]:getWidth()/2+unitlist[h[3][5]][2][10][1],unitlist[h[3][5]][2][2][1]:getHeight()/4*3+unitlist[h[3][5]][2][10][2])

					love.graphics.draw( unitlist[h[3][5]][2][3][math.floor(h[5][7])] ,(h[1][3]-cam_x+2*unitlist[h[3][5]][2][7]*math.cos(-.5*math.pi-h[3][1][2]))*zoom+love.graphics.getWidth()/2,(h[1][4]-cam_y+unitlist[h[3][5]][2][7]*2*math.sin(-.5*math.pi-h[3][1][2]))*zoom+love.graphics.getHeight()/2,-h[3][1][3],unitlist[h[3][5]][2][4]*zoom*.2*h[6],unitlist[h[3][5]][2][4]*zoom*.2,unitlist[h[3][5]][2][3][math.floor(h[5][7])]:getWidth()/4,unitlist[h[3][5]][2][3][math.floor(h[5][7])]:getHeight()/2)
				end
			end
		end

		if crono < 6 then
			love.graphics.setColor(255,255,255)
			for i,h in ipairs(cartelist[cartechoisi][2]) do
				love.graphics.draw( vortex2 ,(h[1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[2]-cam_y)*zoom+love.graphics.getHeight()/2,-crono^1.2,zoom*math.sin(math.pi/6*(6-crono))*.9 ,-zoom*math.sin(math.pi/6*(6-crono))*.9,20,20)
				love.graphics.draw( vortex3 ,(h[1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[2]-cam_y)*zoom+love.graphics.getHeight()/2,.3*math.sin(3*crono),zoom*math.sin(math.pi/6*(5.9-crono))*.5 ,-zoom*math.sin(math.pi/6*(5.9-crono))*.5,20,20)
				love.graphics.draw( vortex ,(h[1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[2]-cam_y)*zoom+love.graphics.getHeight()/2,crono^1.2,zoom*math.sin(math.pi/6*(6-crono))*.7 ,-zoom*math.sin(math.pi/6*(6-crono))*.7,20,20)
				if crono > 5 then
					love.graphics.setColor(255,255,255,255*math.max(6-crono,0))
					love.graphics.draw( vortex4 ,(h[1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[2]-cam_y)*zoom+love.graphics.getHeight()/2,math.pi/4,zoom*math.sin(math.max(crono-5,0)*math.pi) ,-zoom*math.sin(math.max(crono-5,0)*math.pi),40,40)
					love.graphics.setColor(255,255,255)
				elseif crono < 1 then
					love.graphics.setColor(255,255,255,255*math.max(2-crono,0))
					love.graphics.draw( vortex4 ,(h[1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[2]-cam_y)*zoom+love.graphics.getHeight()/2,math.pi/4,2*zoom*math.sin(math.max(crono,0)*math.pi) ,2*-zoom*math.sin(math.max(crono,0)*math.pi),40,40)
					love.graphics.setColor(255,255,255)
				end
			end
		end


		for i,h in ipairs(missi) do
			if h[10] == 0 then
				love.graphics.setColor(missilist[h[6]][10][1],missilist[h[6]][10][2],missilist[h[6]][10][3],h[8]/100*255)
				love.graphics.draw( missilist[h[6]][9] ,(h[1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[2]-cam_y)*zoom+love.graphics.getHeight()/2,h[9],2*zoom*(missilist[h[6]][8]/missilist[h[6]][9]:getWidth()+.02),-2*zoom*(missilist[h[6]][8]/missilist[h[6]][9]:getHeight()+.02),missilist[h[6]][9]:getWidth()/2,missilist[h[6]][9]:getHeight()/2)

			end
		end
	--love.graphics.print( table.maxn(soundlist) , 860-love.graphics.getFont():getHeight( ) , 60 )

		love.graphics.setColor(255,255,255)
		love.graphics.draw( mape , (-cam_x)*zoom+love.graphics.getWidth()/2 , (-cam_y)*zoom+love.graphics.getHeight()/2 ,0,zoom)


		for i,h in ipairs(effet) do
			love.graphics.setColor(h[17],h[18],h[19],h[11])
			love.graphics.draw(h[13],(h[1]-cam_x)*zoom+love.graphics.getWidth()/2,(h[2]-cam_y)*zoom+love.graphics.getHeight()/2,h[9],h[5]*zoom,h[6]*-zoom,h[13]:getWidth()/2,h[13]:getHeight()/2)
		--{ 1 X , 2 Y , 3 M , 4 N , 5 sx ,6 sy , 7 sx+ , 8 sy+ , 9 r , 10 r+ , 11 a , 12 a+ , 13 img , 14 timer , 15 grav , 16 frix , 17,18,19,20color }
		end



		love.graphics.setColor(255,255,255)
		for i,h in ipairs(unit) do
			--love.graphics.print(""..h[3][2].."\n"..h[16].."" , (h[1][3]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][4]-cam_y)*zoom+love.graphics.getHeight()/2)
			if play == 0
			and math.floor(unitlist[h[3][5]][10]) == 4 then
				if near > 10
				or nearest ~= i then
					love.graphics.setColor(ita[h[3][4]][6][1],ita[h[3][4]][6][2],ita[h[3][4]][6][3])
					love.graphics.draw( unitlist[h[3][5]][2][1][math.floor(h[5][6])] ,(h[1][3]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][4]-cam_y)*zoom+love.graphics.getHeight()/2,math.pi+h[3][1][1],unitlist[h[3][5]][2][6]*zoom*.2*-h[5][1],-unitlist[h[3][5]][2][6]*zoom*.2,unitlist[h[3][5]][2][1][math.floor(h[5][6])]:getWidth()/2+unitlist[h[3][5]][2][11][1],unitlist[h[3][5]][2][1][math.floor(h[5][6])]:getHeight()/4*1+unitlist[h[3][5]][2][11][2])
					love.graphics.draw( unitlist[h[3][5]][2][2][1] ,(h[1][3]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][4]-cam_y)*zoom+love.graphics.getHeight()/2,-h[3][1][2],unitlist[h[3][5]][2][5]*zoom*.2*h[6],unitlist[h[3][5]][2][5]*zoom*.2,unitlist[h[3][5]][2][2][1]:getWidth()/2+unitlist[h[3][5]][2][10][1],unitlist[h[3][5]][2][2][1]:getHeight()/4*3+unitlist[h[3][5]][2][10][2])

					love.graphics.draw( unitlist[h[3][5]][2][3][math.floor(h[5][7])] ,(h[1][3]-cam_x+unitlist[h[3][5]][2][7]*2*math.cos(-.5*math.pi-h[3][1][2]))*zoom+love.graphics.getWidth()/2,(h[1][4]-cam_y+unitlist[h[3][5]][2][7]*2*math.sin(-.5*math.pi-h[3][1][2]))*zoom+love.graphics.getHeight()/2,-h[3][1][3],unitlist[h[3][5]][2][4]*zoom*.2*h[6],unitlist[h[3][5]][2][4]*zoom*.2,unitlist[h[3][5]][2][3][math.floor(h[5][7])]:getWidth()/4,unitlist[h[3][5]][2][3][math.floor(h[5][7])]:getHeight()/2)
				end
			end
			if h[4] == 5 then
				love.graphics.draw( stop ,(h[1][3]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][4]-cam_y-4-unitlist[h[3][5]][2][7])*zoom+love.graphics.getHeight()/2,0,zoom*.05,zoom*.05,25,25)
			end
		love.graphics.setColor(255,255,255)
			if h[3][4] == 1 then
				if h[4] ~= 0 then
					love.graphics.setColor(255,255,255-255*math.max((goldtime-crono)-.5,0),255*math.max((goldtime-crono)-.5,0))
					for e,g in ipairs(unitlist[h[3][5]][15]) do
						if g[1] == 1 then
							love.graphics.printf(g[2], (h[1][3]-cam_x)*zoom+love.graphics.getWidth()/2,(h[1][4]-cam_y-(10-10*math.max((goldtime-crono)/2,0)))*zoom+love.graphics.getHeight()/2,10-love.graphics.getFont():getHeight( ),"center")
						end
					end
					love.graphics.setColor(255,255,255)
				end
			end
		end
			--love.graphics.setColor(255,0,0)
			--love.graphics.draw( aura , (ita[2][7][1][1]-cam_x)*zoom+love.graphics.getWidth()/2 , 0 , 0 , 1.05*zoom, love.graphics.getHeight()/40 , 20 ,0)
			--love.graphics.print( ita[2][7][1][1] , 50 , 100 )
			--love.graphics.setColor(255,255,0)
			--love.graphics.draw( aura , (ita[2][7][2][1]-cam_x)*zoom+love.graphics.getWidth()/2 , 0 , 0 , 1.05*zoom, love.graphics.getHeight()/40 , 20 ,0)
			--love.graphics.print( ita[2][7][2][1] , 50 , 140 )
			--love.graphics.setColor(150,100,70)
			--love.graphics.draw( aura , (ita[2][7][3][1]-cam_x)*zoom+love.graphics.getWidth()/2 , 0 , 0 , 1.05*zoom, love.graphics.getHeight()/40 , 20 ,0)
			--love.graphics.print( ita[2][7][3][1] , 50 , 180 )
			--love.graphics.setColor(0,100,255)
			--love.graphics.draw( aura , (ita[2][7][4][1]-cam_x)*zoom+love.graphics.getWidth()/2 , 0 , 0 , 1.05*zoom, love.graphics.getHeight()/40 , 20 ,0)
			--love.graphics.print( ita[2][7][4][1] , 50 , 220 )
		if unit[nearest] ~= nil
		and near < 10 then
				love.graphics.setColor(ita[unit[nearest][3][4]][6][1],ita[unit[nearest][3][4]][6][2],ita[unit[nearest][3][4]][6][3])
				love.graphics.draw( unitlist[unit[nearest][3][5]][2][1][math.floor(unit[nearest][5][6])] ,(unit[nearest][1][3]-cam_x)*zoom+love.graphics.getWidth()/2,(unit[nearest][1][4]-cam_y)*zoom+love.graphics.getHeight()/2,math.pi+unit[nearest][3][1][1],unitlist[unit[nearest][3][5]][2][6]*zoom*.24*-unit[nearest][5][1],unitlist[unit[nearest][3][5]][2][6]*-zoom*.24,unitlist[unit[nearest][3][5]][2][1][math.floor(unit[nearest][5][6])]:getWidth()/2+unitlist[unit[nearest][3][5]][2][11][1],unitlist[unit[nearest][3][5]][2][1][math.floor(unit[nearest][5][6])]:getHeight()/4+unitlist[unit[nearest][3][5]][2][11][2])
				love.graphics.draw( unitlist[unit[nearest][3][5]][2][2][1] ,(unit[nearest][1][3]-cam_x)*zoom+love.graphics.getWidth()/2,(unit[nearest][1][4]-cam_y)*zoom+love.graphics.getHeight()/2,-unit[nearest][3][1][2],unitlist[unit[nearest][3][5]][2][5]*zoom*.24*unit[nearest][6],unitlist[unit[nearest][3][5]][2][5]*zoom*.24,unitlist[unit[nearest][3][5]][2][2][1]:getWidth()/2+unitlist[unit[nearest][3][5]][2][10][1],unitlist[unit[nearest][3][5]][2][2][1]:getHeight()/4*3+unitlist[unit[nearest][3][5]][2][10][2])
				love.graphics.draw( unitlist[unit[nearest][3][5]][2][3][math.floor(unit[nearest][5][7])] ,(unit[nearest][1][3]-cam_x+unitlist[unit[nearest][3][5]][2][7]*2.4*math.cos(-.5*math.pi-unit[nearest][3][1][2]))*zoom+love.graphics.getWidth()/2,(unit[nearest][1][4]-cam_y+unitlist[unit[nearest][3][5]][2][7]*2.4*math.sin(-.5*math.pi-unit[nearest][3][1][2]))*zoom+love.graphics.getHeight()/2,-unit[nearest][3][1][3],unitlist[unit[nearest][3][5]][2][4]*zoom*.24*unit[nearest][6],unitlist[unit[nearest][3][5]][2][4]*zoom*.24,unitlist[unit[nearest][3][5]][2][3][math.floor(unit[nearest][5][7])]:getWidth()/4,unitlist[unit[nearest][3][5]][2][3][math.floor(unit[nearest][5][7])]:getHeight()/2)
			love.graphics.setColor(255,0,0,inta)
			love.graphics.draw( bule , intx+2*inty-78 , love.graphics.getHeight()+1.4*inty+10 ,0 , -2 , -2*unit[nearest][5][2]/unitlist[unit[nearest][3][5]][1],22,0)
			love.graphics.setColor(0,0,255,inta)
			love.graphics.draw( bule , intx-2*inty+78 , love.graphics.getHeight()+1.4*inty+10 ,0 , 2 , -2*unit[nearest][7]/unitlist[unit[nearest][3][5]][13],22,0)
		end
		love.graphics.setColor(255,255,255,ita[1][7][5][4]*255)
		if ita[1][7][5][3] == 0 then
			love.graphics.draw( ita[1][7][5][5] , ita[1][7][5][1] , ita[1][7][5][4]*ita[1][7][5][2] , 0 , ita[1][7][5][4], ita[1][7][5][4] , 50 ,50)
		elseif ita[1][7][5][3] == 1 then
			love.graphics.draw( aura , (ita[1][7][5][1]-cam_x)*zoom+love.graphics.getWidth()/2 , 0 , 0 , 1.05*zoom, love.graphics.getHeight()/40 , 20 ,0)
			love.graphics.setColor(255,255,255,ita[1][7][5][6]*100)
			love.graphics.draw( poivi , love.graphics.getWidth()/2+200 , 60 , 0 , ita[1][7][5][6], ita[1][7][5][6] , 50 ,50)
			love.graphics.draw(  ita[1][7][5][5] , love.graphics.getWidth()/2+200 , 60 , 0 , ita[1][7][5][6], ita[1][7][5][6] , 50 ,50)
			love.graphics.setColor(255,255,255,ita[1][7][5][4]*255)
			love.graphics.draw( ita[1][7][5][5] , (ita[1][7][5][1]-cam_x)*zoom+love.graphics.getWidth()/2,(ita[1][7][5][2]-cam_y)*zoom+love.graphics.getHeight()/2 , 0 , ita[1][7][5][4], ita[1][7][5][4] , 50 ,50)
		elseif ita[1][7][5][3] == 2 then
			love.graphics.draw( aura , love.mouse.getX() , 0 , 0 , 1.05*zoom, love.graphics.getHeight()/40 , 20 ,0)
			love.graphics.setColor(255,255,255,ita[1][7][5][6]*100)
			love.graphics.draw( poivi , love.graphics.getWidth()/2+200 , 60 , 0 , ita[1][7][5][6], ita[1][7][5][6] , 50 ,50)
			love.graphics.draw(  ita[1][7][5][5] , love.graphics.getWidth()/2+200 , 60 , 0 , ita[1][7][5][6], ita[1][7][5][6] , 50 ,50)
			love.graphics.setColor(255,255,255,ita[1][7][5][4]*255)
			love.graphics.draw( ita[1][7][5][5] , love.mouse.getX() , love.mouse.getY() , 0 , 1, 1 , 50 ,50)
		end
		love.graphics.setColor(255,255,255,ita[1][7][4][4]*255)
		if ita[1][7][4][3] == 0 then
			love.graphics.draw( ita[1][7][4][5] , ita[1][7][4][1] , ita[1][7][4][4]*ita[1][7][4][2] , 0 , ita[1][7][4][4], ita[1][7][4][4] , 50 ,50)
		elseif ita[1][7][4][3] == 1 then
			love.graphics.draw( aura , (ita[1][7][4][1]-cam_x)*zoom+love.graphics.getWidth()/2 , 0 , 0 , 1.05*zoom, love.graphics.getHeight()/40 , 20 ,0)
			love.graphics.setColor(255,255,255,ita[1][7][4][6]*100)
			love.graphics.draw( poivi , love.graphics.getWidth()/2+100 , 60 , 0 , ita[1][7][4][6], ita[1][7][4][6] , 50 ,50)
			love.graphics.draw(  ita[1][7][4][5] , love.graphics.getWidth()/2+100 , 60 , 0 , ita[1][7][4][6], ita[1][7][4][6] , 50 ,50)
			love.graphics.setColor(255,255,255,ita[1][7][4][4]*255)
			love.graphics.draw( ita[1][7][4][5] , (ita[1][7][4][1]-cam_x)*zoom+love.graphics.getWidth()/2,(ita[1][7][4][2]-cam_y)*zoom+love.graphics.getHeight()/2 , 0 , ita[1][7][4][4], ita[1][7][4][4] , 50 ,50)
		elseif ita[1][7][4][3] == 2 then
			love.graphics.draw( aura , love.mouse.getX() , 0 , 0 , 1.05*zoom, love.graphics.getHeight()/40 , 20 ,0)
			love.graphics.setColor(255,255,255,ita[1][7][4][6]*100)
			love.graphics.draw( poivi , love.graphics.getWidth()/2+100 , 60 , 0 , ita[1][7][4][6], ita[1][7][4][6] , 50 ,50)
			love.graphics.draw(  ita[1][7][4][5] , love.graphics.getWidth()/2+100 , 60 , 0 , ita[1][7][4][6], ita[1][7][4][6] , 50 ,50)
			love.graphics.setColor(255,255,255,ita[1][7][4][4]*255)
			love.graphics.draw( ita[1][7][4][5] , love.mouse.getX() , love.mouse.getY() , 0 , 1, 1 , 50 ,50)
		end

		love.graphics.setColor(255,255,255,ita[1][7][3][4]*255)
		if ita[1][7][3][3] == 0 then
			love.graphics.draw( ita[1][7][3][5] , ita[1][7][3][1] , ita[1][7][3][4]*ita[1][7][3][2] , 0 , ita[1][7][3][4], ita[1][7][3][4] , 50 ,50)
		elseif ita[1][7][3][3] == 1 then
			love.graphics.draw( aura , (ita[1][7][3][1]-cam_x)*zoom+love.graphics.getWidth()/2 , 0 , 0 , 1.05*zoom, love.graphics.getHeight()/40 , 20 ,0)
			love.graphics.setColor(255,255,255,ita[1][7][3][6]*100)
			love.graphics.draw( poivi , love.graphics.getWidth()/2 , 60 , 0 , ita[1][7][3][6], ita[1][7][3][6] , 50 ,50)
			love.graphics.draw(  ita[1][7][3][5] , love.graphics.getWidth()/2 , 60 , 0 , ita[1][7][3][6], ita[1][7][3][6] , 50 ,50)
			love.graphics.setColor(255,255,255,ita[1][7][3][4]*255)
			love.graphics.draw( ita[1][7][3][5] , (ita[1][7][3][1]-cam_x)*zoom+love.graphics.getWidth()/2,(ita[1][7][3][2]-cam_y)*zoom+love.graphics.getHeight()/2 , 0 , ita[1][7][3][4], ita[1][7][3][4] , 50 ,50)
		elseif ita[1][7][3][3] == 2 then
			love.graphics.draw( aura , love.mouse.getX() , 0 , 0 , 1.05*zoom, love.graphics.getHeight()/40 , 20 ,0)
			love.graphics.setColor(255,255,255,ita[1][7][3][6]*100)
			love.graphics.draw( poivi , love.graphics.getWidth()/2 , 60 , 0 , ita[1][7][3][6], ita[1][7][3][6] , 50 ,50)
			love.graphics.draw(  ita[1][7][3][5] , love.graphics.getWidth()/2 , 60 , 0 , ita[1][7][3][6], ita[1][7][3][6] , 50 ,50)
			love.graphics.setColor(255,255,255,ita[1][7][3][4]*255)
			love.graphics.draw( ita[1][7][3][5] , love.mouse.getX() , love.mouse.getY() , 0 , 1, 1 , 50 ,50)
		end
		love.graphics.setColor(255,255,255,ita[1][7][2][4]*255)
		if ita[1][7][2][3] == 0 then
			love.graphics.draw( ita[1][7][2][5] , ita[1][7][2][1] , ita[1][7][2][4]*ita[1][7][2][2] , 0 , ita[1][7][2][4], ita[1][7][2][4] , 50 ,50)
		elseif ita[1][7][2][3] == 1 then
			love.graphics.draw( aura , (ita[1][7][2][1]-cam_x)*zoom+love.graphics.getWidth()/2 , 0 , 0 , 1.05*zoom, love.graphics.getHeight()/40 , 20 ,0)
			love.graphics.setColor(255,255,255,ita[1][7][2][6]*100)
			love.graphics.draw( poivi , love.graphics.getWidth()/2-100 , 60 , 0 , ita[1][7][2][6], ita[1][7][2][6] , 50 ,50)
			love.graphics.draw(  ita[1][7][2][5] , love.graphics.getWidth()/2-100 , 60 , 0 , ita[1][7][2][6], ita[1][7][2][6] , 50 ,50)
			love.graphics.setColor(255,255,255,ita[1][7][2][4]*255)
			love.graphics.draw( ita[1][7][2][5] , (ita[1][7][2][1]-cam_x)*zoom+love.graphics.getWidth()/2,(ita[1][7][2][2]-cam_y)*zoom+love.graphics.getHeight()/2 , 0 , ita[1][7][2][4], ita[1][7][2][4] , 50 ,50)
		elseif ita[1][7][2][3] == 2 then
			love.graphics.draw( aura , love.mouse.getX() , 0 , 0 , 1.05*zoom, love.graphics.getHeight()/40 , 20 ,0)
			love.graphics.setColor(255,255,255,ita[1][7][2][6]*100)
			love.graphics.draw( poivi , love.graphics.getWidth()/2-100 , 60 , 0 , ita[1][7][2][6], ita[1][7][2][6] , 50 ,50)
			love.graphics.draw(  ita[1][7][2][5] , love.graphics.getWidth()/2-100 , 60 , 0 , ita[1][7][2][6], ita[1][7][2][6] , 50 ,50)
			love.graphics.setColor(255,255,255,ita[1][7][2][4]*255)
			love.graphics.draw( ita[1][7][2][5] , love.mouse.getX() , love.mouse.getY() , 0 , 1, 1 , 50 ,50)
		end
		love.graphics.setColor(255,255,255,ita[1][7][1][4]*255)
		if ita[1][7][1][3] == 0 then
			love.graphics.draw( ita[1][7][1][5] , ita[1][7][1][1] , ita[1][7][1][4]*ita[1][7][1][2] , 0 , ita[1][7][1][4], ita[1][7][1][4] , 50 ,50)
		elseif ita[1][7][1][3] == 1 then
			love.graphics.draw( aura , (ita[1][7][1][1]-cam_x)*zoom+love.graphics.getWidth()/2 , 0 , 0 , 1.05*zoom, love.graphics.getHeight()/40 , 20 ,0)
			love.graphics.setColor(255,255,255,ita[1][7][1][6]*100)
			love.graphics.draw( poivi , love.graphics.getWidth()/2-200 , 60 , 0 , ita[1][7][1][6], ita[1][7][1][6] , 50 ,50)
			love.graphics.draw(  ita[1][7][1][5] , love.graphics.getWidth()/2-200 , 60 , 0 , ita[1][7][1][6], ita[1][7][1][6] , 50 ,50)
			love.graphics.setColor(255,255,255,ita[1][7][1][4]*255)
			love.graphics.draw( ita[1][7][1][5] , (ita[1][7][1][1]-cam_x)*zoom+love.graphics.getWidth()/2,(ita[1][7][1][2]-cam_y)*zoom+love.graphics.getHeight()/2 , 0 , ita[1][7][1][4], ita[1][7][1][4] , 50 ,50)
		elseif ita[1][7][1][3] == 2 then
			love.graphics.draw( aura , love.mouse.getX() , 0 , 0 , 1.05*zoom, love.graphics.getHeight()/40 , 20 ,0)
			love.graphics.setColor(255,255,255,ita[1][7][1][6]*100)
			love.graphics.draw( poivi , love.graphics.getWidth()/2-200 , 60 , 0 , ita[1][7][1][6], ita[1][7][1][6] , 50 ,50)
			love.graphics.draw(  ita[1][7][1][5] , love.graphics.getWidth()/2-200 , 60 , 0 , ita[1][7][1][6], ita[1][7][1][6] , 50 ,50)
			love.graphics.setColor(255,255,255,ita[1][7][1][4]*255)		love.graphics.draw( ita[1][7][1][5] , love.mouse.getX() , love.mouse.getY() , 0 , 1, 1 , 50 ,50)
		end
		love.graphics.setColor(255,255,255,inta)
		love.graphics.draw( boule , intx+2*inty-78 , love.graphics.getHeight()+1.4*inty+10 ,0 , -2 , 2,25,47)
		love.graphics.draw( boule , intx-2*inty+78 , love.graphics.getHeight()+1.4*inty+10 ,0 , 2 , 2,25,47)
		love.graphics.draw( sourp , intx+1.8*inty , love.graphics.getHeight()+1.65*inty ,0 , 1 , .5,55,0)
		love.graphics.draw( sourp , intx-1.8*inty , love.graphics.getHeight()+1.65*inty ,0 , -1 , .5,55,0)
		love.graphics.draw( sourp , intx+1.8*inty , love.graphics.getHeight()+1.2*inty-14 ,0 , 2 , 2,55,0)
		love.graphics.draw( sourp , intx-1.8*inty , love.graphics.getHeight()+1.2*inty-14 ,0 , -2 , 2,55,0)
		love.graphics.draw( sour , intx-sour:getWidth()/2 , love.graphics.getHeight()+inty-93  )
		if unit[nearest] ~= nil
		and near < 10 then




			love.graphics.setColor(255,255,255)
			love.graphics.draw( unitlist[unit[nearest][3][5]][2][8] , intx , love.graphics.getHeight()+.5*inty-25 , 0 , 1, 1 , 25 ,25)
			love.graphics.draw( sel , (unit[nearest][1][3]-cam_x)*zoom+love.graphics.getWidth()/2-15,(unit[nearest][1][4]-cam_y)*zoom+love.graphics.getHeight()/2-15 )
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle( "fill", (unit[nearest][1][3]-cam_x-5)*zoom+love.graphics.getWidth()/2, (unit[nearest][1][4]-cam_y-9)*zoom+love.graphics.getHeight()/2, 10*zoom, 1.2*zoom )
			love.graphics.setColor(0,255,0)
			love.graphics.rectangle( "fill", (unit[nearest][1][3]-cam_x-4.8)*zoom+love.graphics.getWidth()/2, (unit[nearest][1][4]-cam_y-8.8)*zoom+love.graphics.getHeight()/2, 9.6*unit[nearest][5][2]/unitlist[unit[nearest][3][5]][1]*zoom, .8*zoom )
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle( "fill", (unit[nearest][1][3]-cam_x-4.8)*zoom+love.graphics.getWidth()/2, (unit[nearest][1][4]-cam_y-7.9)*zoom+love.graphics.getHeight()/2, 9.6*zoom, 1.1*zoom )
			love.graphics.setColor(0,0,255)
			love.graphics.rectangle( "fill", (unit[nearest][1][3]-cam_x-4.6)*zoom+love.graphics.getWidth()/2, (unit[nearest][1][4]-cam_y-7.7)*zoom+love.graphics.getHeight()/2, 9.2*unit[nearest][7]/unitlist[unit[nearest][3][5]][13]*zoom, .7*zoom )
			love.graphics.setColor(255,255,255,inta)
			if crono < unit[nearest][9] then
				love.graphics.draw( cloc , intx , love.graphics.getHeight()+inty-120 , 0 ,1,1,48,63)
				love.graphics.draw( cloc2 , intx , love.graphics.getHeight()+inty-120 , (crono-unit[nearest][9])*2*math.pi+.5*math.pi ,1,1,33,6)
				love.graphics.setColor(0,0,0,inta)
				love.graphics.print( -math.floor(crono-unit[nearest][9]) , intx-10 , love.graphics.getHeight()+inty-120 )
			end
			if play == 0 then
				love.graphics.setFont( ff )
				love.graphics.setColor(255,255,255,inta)
				love.graphics.print( unitlist[unit[nearest][3][5]][20] , intx-75 , love.graphics.getHeight()+inty+60-love.graphics.getFont():getHeight( ))
				if unitlist[unit[nearest][3][5]][11][1] == 0 then
					love.graphics.print( "Arret" , intx-110+inty , love.graphics.getHeight()+1.65*inty+20-love.graphics.getFont():getHeight( ) )
					love.graphics.printf( "enpeche les unites de passer." , intx-150+inty , love.graphics.getHeight()+inty-6 ,140 )
				elseif unitlist[unit[nearest][3][5]][11][1] == 1 then
					love.graphics.print( "Creer" , intx-110+inty , love.graphics.getHeight()+1.65*inty+20-love.graphics.getFont():getHeight( ) )
					if unitlist[unitlist[unit[nearest][3][5]][11][2]][16] ~= 0 then
						textop = "requier "..unitlist[unitlist[unit[nearest][3][5]][11][2]][16].." de pop"
					else
						textop = ""
					end
					love.graphics.setFont( ffff )
					love.graphics.printf( "Creer "..unitlist[unitlist[unit[nearest][3][5]][11][2]][20].."\n"..unitlist[unitlist[unit[nearest][3][5]][11][2]][23]..".\n"..textop.."" , intx-150+inty , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) ,140 )
					love.graphics.setFont( ff )
				elseif unitlist[unit[nearest][3][5]][11][1] == 2 then
					love.graphics.print( "trempoline" , intx-110+inty , love.graphics.getHeight()+1.65*inty+20-love.graphics.getFont():getHeight( ) )
					love.graphics.printf( "fait bondire les unites a proximite." , intx-150+inty , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) ,140 )
				elseif unitlist[unit[nearest][3][5]][11][1] == 3 then
					love.graphics.print( "creuser" , intx-110+inty , love.graphics.getHeight()+1.65*inty+20-love.graphics.getFont():getHeight( ) )
					love.graphics.printf( "fait creuser l'unite." , intx-150+inty , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) ,140 )
				elseif unitlist[unit[nearest][3][5]][11][1] == 4 then
					love.graphics.print( "exploser" , intx-110+inty , love.graphics.getHeight()+1.65*inty+20 )
					love.graphics.printf( "fait exploser l'unite." , intx-150+inty , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) ,140 )
				elseif unitlist[unit[nearest][3][5]][11][1] == 5 then
					love.graphics.print( "construire" , intx-110+inty , love.graphics.getHeight()+1.65*inty+20-love.graphics.getFont():getHeight( ) )
					love.graphics.setFont( ffff )
					if unitlist[unit[nearest][3][5]][11][3][1] ~= 0 then
						if unitlist[unitlist[unit[nearest][3][5]][11][3][1]][16] ~= 0 then
							textop = "requier "..unitlist[unitlist[unit[nearest][3][5]][11][3][1]][16].." de pop"
						else
							textop = ""
						end
						love.graphics.printf( "construire "..unitlist[unitlist[unit[nearest][3][5]][11][3][1]][20].."\n"..unitlist[unitlist[unit[nearest][3][5]][11][3][1]][23]..".\n"..textop..""     , intx-150+inty , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) ,140 )
					else
						love.graphics.printf( "construire la structure."      , intx-150+inty , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) ,140 )
					end
					love.graphics.setFont( ff )
				elseif unitlist[unit[nearest][3][5]][11][1] == 6 then
					love.graphics.print( unitlist[unit[nearest][3][5]][11][10] , intx-110+inty , love.graphics.getHeight()+1.65*inty+20-love.graphics.getFont():getHeight( ) )
					love.graphics.printf( unitlist[unit[nearest][3][5]][11][11] , intx-150+inty , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) ,140 )
				elseif unitlist[unit[nearest][3][5]][11][1] == 7 then
					love.graphics.print( "sauter" , intx-110+inty , love.graphics.getHeight()+1.65*inty+20 )
					love.graphics.printf( "faire sauter." , intx-150+inty , love.graphics.getHeight()+inty-6 ,140 )
				elseif unitlist[unit[nearest][3][5]][11][1] == 8 then
					love.graphics.print( "transformation" , intx-110+inty , love.graphics.getHeight()+1.65*inty+20-love.graphics.getFont():getHeight( ) )
					love.graphics.printf( "transformer en "..unitlist[unitlist[unit[nearest][3][5]][11][2]][20].."." , intx-150+inty , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) ,140 )
				end
				if unitlist[unit[nearest][3][5]][12][1] == 0 then
					love.graphics.print( "Arret" , intx+30-inty , love.graphics.getHeight()+1.65*inty+20-love.graphics.getFont():getHeight( ) )
					love.graphics.printf( "enpeche les unites de passer." , intx+10-inty , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) ,140 )
				elseif unitlist[unit[nearest][3][5]][12][1] == 1 then
					love.graphics.print( "Creer" , intx+30-inty , love.graphics.getHeight()+1.65*inty+20-love.graphics.getFont():getHeight( ) )
					if unitlist[unitlist[unit[nearest][3][5]][12][2]][16] ~= 0 then
						textop = "requier "..unitlist[unitlist[unit[nearest][3][5]][12][2]][16].." de pop"
					else
						textop = ""
					end
					love.graphics.setFont( ffff )
					love.graphics.printf( "Creer "..unitlist[unitlist[unit[nearest][3][5]][12][2]][20].."\n"..unitlist[unitlist[unit[nearest][3][5]][12][2]][23]..".\n"..textop.."" , intx+10-inty , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) ,140 )
					love.graphics.setFont( ff )
				elseif unitlist[unit[nearest][3][5]][12][1] == 2 then
					love.graphics.print( "trempoline" , intx+30-inty , love.graphics.getHeight()+1.65*inty+20-love.graphics.getFont():getHeight( ) )
					love.graphics.printf( "fait bondire les unites a proximite." , intx+10-inty , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) ,140 )
				elseif unitlist[unit[nearest][3][5]][12][1] == 3 then
					love.graphics.print( "creuser" , intx+30-inty , love.graphics.getHeight()+1.65*inty+20-love.graphics.getFont():getHeight( ) )
					love.graphics.printf( "fait creuser l'unite." , intx+10-inty , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) ,140 )
				elseif unitlist[unit[nearest][3][5]][12][1] == 4 then
					love.graphics.print( "exploser" , intx+30-inty , love.graphics.getHeight()+1.65*inty+20-love.graphics.getFont():getHeight( ) )
					love.graphics.printf( "fait exploser l'unite." , intx+10-inty , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) ,140 )
				elseif unitlist[unit[nearest][3][5]][12][1] == 5 then
					love.graphics.print( "construire" , intx+30-inty , love.graphics.getHeight()+1.65*inty+20-love.graphics.getFont():getHeight( ) )
					love.graphics.setFont( ffff )
					if unitlist[unit[nearest][3][5]][12][3][1] ~= 0 then
						if unitlist[unitlist[unit[nearest][3][5]][12][3][1]][16] ~= 0 then
							textop = "requier "..unitlist[unitlist[unit[nearest][3][5]][12][3][1]][16].." de pop"
						else
							textop = ""
						end
						love.graphics.printf( "construire "..unitlist[unitlist[unit[nearest][3][5]][12][3][1]][20].."\n"..unitlist[unitlist[unit[nearest][3][5]][12][3][1]][23]..".\n"..textop..""     , intx+10-inty , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) ,140 )
					else
						love.graphics.printf( "construire la structure."      , intx+10-inty , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) ,140 )
					end
					love.graphics.setFont( ff )
				elseif unitlist[unit[nearest][3][5]][12][1] == 6 then
					love.graphics.print( unitlist[unit[nearest][3][5]][12][10] , intx+30-inty , love.graphics.getHeight()+1.65*inty+20-love.graphics.getFont():getHeight( ) )
					love.graphics.printf( unitlist[unit[nearest][3][5]][12][11] , intx+10-inty , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) ,140 )
				elseif unitlist[unit[nearest][3][5]][12][1] == 7 then
					love.graphics.print( "sauter" , intx+30-inty , love.graphics.getHeight()+1.65*inty+20-love.graphics.getFont():getHeight( ) )
					love.graphics.printf( "faire sauter." , intx+10-inty , love.graphics.getHeight()+inty-6 -love.graphics.getFont():getHeight( ),140 )
				elseif unitlist[unit[nearest][3][5]][12][1] == 8 then
					love.graphics.print( "transformation" , intx+30-inty , love.graphics.getHeight()+1.65*inty+20-love.graphics.getFont():getHeight( ) )
					love.graphics.printf( "transformer en "..unitlist[unitlist[unit[nearest][3][5]][12][2]][20].."." , intx+10-inty , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) ,140 )
				end
			end
			love.graphics.setColor(255,255,255,inta)
			if unitlist[unit[nearest][3][5]][11][1] == 0 then
				if unitlist[unit[nearest][3][5]][11][3] == 0 then
					if unit[nearest][4] == 5 then
						love.graphics.draw( stop , intx-45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
						love.graphics.draw( interd , intx-45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
					else
						love.graphics.draw( stop , intx-45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
					end
				else
					if unit[nearest][18] == 0 then
						love.graphics.draw( stand , intx-45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
						love.graphics.draw( interd , intx-45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
					else
						love.graphics.draw( stand , intx-45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
					end
				end
			elseif unitlist[unit[nearest][3][5]][11][1] == 1 then
				if crono < unit[nearest][9]
				or unit[nearest][7]-unitlist[unit[nearest][3][5]][11][5] < 0
				or gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][11][4] < 0
				or food[unit[nearest][3][4]]+unitlist[unitlist[unit[nearest][3][5]][11][2]][16] > math.min(foodmax[unit[nearest][3][4]],maxunit) then
					love.graphics.setColor(255,255,255,inta/2)
				end
				love.graphics.draw( unitlist[unitlist[unit[nearest][3][5]][11][2]][2][8] , intx-45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
				love.graphics.draw( plus , intx-60 , love.graphics.getHeight()+inty-50 , 0 , 1, 1 , 10 ,10)
				love.graphics.setFont( ff )
				if unitlist[unit[nearest][3][5]][11][5] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][5] < 0 then
						love.graphics.setColor(50,50,255,inta/2)
					else
						love.graphics.setColor(50,50,255,inta)
					end
					love.graphics.draw( manaico , intx-65 , love.graphics.getHeight()+inty-20 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][11][5].."" , intx-60 , love.graphics.getHeight()+inty-20-love.graphics.getFont():getHeight( ) )
				end
				if unitlist[unit[nearest][3][5]][11][4] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][4] < 0 then
						love.graphics.setColor(255,255,0,inta/2)
					else
						love.graphics.setColor(255,255,0,inta)
					end
					love.graphics.draw( goldico , intx-65 , love.graphics.getHeight()+inty-6 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][11][4].."" , intx-60 , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) )
				end
				love.graphics.setColor(255,255,255,inta)
			elseif unitlist[unit[nearest][3][5]][11][1] == 2 then
				if unit[nearest][4] == 6.1 then
					love.graphics.draw( jump , intx-45 , love.graphics.getHeight()+inty-65 , math.atan(unitlist[unit[nearest][3][5]][11][3]*unit[nearest][5][1]/unitlist[unit[nearest][3][5]][11][2]), unit[nearest][5][1], 1 , 25 ,25 )
					love.graphics.draw( interd , intx-45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
				else
					love.graphics.draw( feue , intx-45 , love.graphics.getHeight()+inty-65 , math.atan(unitlist[unit[nearest][3][5]][11][3]*unit[nearest][5][1]/unitlist[unit[nearest][3][5]][11][2]), unit[nearest][5][1]*(unitlist[unit[nearest][3][5]][11][2]/math.abs(unitlist[unit[nearest][3][5]][11][2])), 1 , -15 ,1 )
					love.graphics.draw( jump , intx-45 , love.graphics.getHeight()+inty-65 , math.atan(unitlist[unit[nearest][3][5]][11][3]*unit[nearest][5][1]/unitlist[unit[nearest][3][5]][11][2]), unit[nearest][5][1]*(unitlist[unit[nearest][3][5]][11][2]/math.abs(unitlist[unit[nearest][3][5]][11][2])), 1 , 25 ,25 )
				end
				love.graphics.setFont( ff )
				if unitlist[unit[nearest][3][5]][11][4] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][4] < 0 then
						love.graphics.setColor(50,50,255,inta/2)
					else
						love.graphics.setColor(50,50,255,inta)
					end
					love.graphics.draw( manaico , intx-65 , love.graphics.getHeight()+inty-20 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][11][4].."" , intx-60 , love.graphics.getHeight()+inty-20-love.graphics.getFont():getHeight( ) )
				end
				if unitlist[unit[nearest][3][5]][11][5] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][5] < 0 then
						love.graphics.setColor(255,255,0,inta/2)
					else
						love.graphics.setColor(255,255,0,inta)
					end
					love.graphics.draw( goldico , intx-65 , love.graphics.getHeight()+inty-6 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][11][5].."" , intx-60 , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) )
				end
				love.graphics.setColor(255,255,255,inta)
			elseif unitlist[unit[nearest][3][5]][11][1] == 3 then
				if unit[nearest][4] == 4.1 then
					love.graphics.draw( fle , intx-45 , love.graphics.getHeight()+inty-65 , math.atan(unitlist[unit[nearest][3][5]][11][3]*unit[nearest][5][1]/unitlist[unit[nearest][3][5]][11][2]), unit[nearest][5][1]*(unitlist[unit[nearest][3][5]][11][2]/math.abs(unitlist[unit[nearest][3][5]][11][2])), 1 , 25 ,25 )
					love.graphics.draw( creus , intx-45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
					love.graphics.draw( interd , intx-45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
				else
					love.graphics.draw( fle , intx-45 , love.graphics.getHeight()+inty-65 , math.atan(unitlist[unit[nearest][3][5]][11][3]*unit[nearest][5][1]/unitlist[unit[nearest][3][5]][11][2]), unit[nearest][5][1]*(unitlist[unit[nearest][3][5]][11][2]/math.abs(unitlist[unit[nearest][3][5]][11][2])), 1 , 25 ,25 )
					love.graphics.draw( creus , intx-45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
				end
				love.graphics.setFont( ff )
				if unitlist[unit[nearest][3][5]][11][6] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][6] < 0 then
						love.graphics.setColor(50,50,255,inta/2)
					else
						love.graphics.setColor(50,50,255,inta)
					end
					love.graphics.draw( manaico , intx-65 , love.graphics.getHeight()+inty-20 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][11][6].."" , intx-60 , love.graphics.getHeight()+inty-20-love.graphics.getFont():getHeight( ) )
				end
				if unitlist[unit[nearest][3][5]][11][5] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][5] < 0 then
						love.graphics.setColor(255,255,0,inta/2)
					else
						love.graphics.setColor(255,255,0,inta)
					end
					love.graphics.draw( goldico , intx-65 , love.graphics.getHeight()+inty-6 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][11][5].."" , intx-60 , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) )
				end
				love.graphics.setColor(255,255,255,inta)
			elseif unitlist[unit[nearest][3][5]][11][1] == 4 then
				if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][4] <= 0
				or gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][11][3] <= 0
				or crono < unit[nearest][9] then
					love.graphics.setColor(255,255,255,inta/2)
				end
				love.graphics.draw( expl , intx-45 , love.graphics.getHeight()+inty-65 , 0 , 1 , 1 , 25 ,25 )
				love.graphics.setFont( ff )
				if unitlist[unit[nearest][3][5]][11][4] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][4] < 0 then
						love.graphics.setColor(50,50,255,inta/2)
					else
						love.graphics.setColor(50,50,255,inta)
					end
					love.graphics.draw( manaico , intx-65 , love.graphics.getHeight()+inty-20 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][11][4].."" , intx-60 , love.graphics.getHeight()+inty-20-love.graphics.getFont():getHeight( ) )
				end
				if unitlist[unit[nearest][3][5]][11][3] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][3] < 0 then
						love.graphics.setColor(255,255,0,inta/2)
					else
						love.graphics.setColor(255,255,0,inta)
					end
					love.graphics.draw( goldico , intx-65 , love.graphics.getHeight()+inty-6 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][11][3].."" , intx-60 , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) )
				end
				love.graphics.setColor(255,255,255,inta)
			elseif unitlist[unit[nearest][3][5]][11][1] == 5 then
				if crono < unit[nearest][9]
				or unit[nearest][7]-unitlist[unit[nearest][3][5]][11][6] < 0
				or gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][11][5] < 0 then
					love.graphics.setColor(255,255,255,inta/2)
				end
				love.graphics.draw( unitlist[unit[nearest][3][5]][11][7] , intx-45 , love.graphics.getHeight()+inty-65 , 0 , 50/math.max(unitlist[unit[nearest][3][5]][11][7]:getWidth(),unitlist[unit[nearest][3][5]][11][7]:getHeight())*unit[nearest][6], 50/math.max(unitlist[unit[nearest][3][5]][11][7]:getWidth(),unitlist[unit[nearest][3][5]][11][7]:getHeight()) , unitlist[unit[nearest][3][5]][11][7]:getWidth()/2 ,unitlist[unit[nearest][3][5]][11][7]:getHeight()/2)
				love.graphics.draw( mart , intx-60 , love.graphics.getHeight()+inty-50 , 0 , 1, 1 , 15 ,15)
				love.graphics.setFont( ff )
				if unitlist[unit[nearest][3][5]][11][6] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][6] < 0 then
						love.graphics.setColor(50,50,255,inta/2)
					else
						love.graphics.setColor(50,50,255,inta)
					end
					love.graphics.draw( manaico , intx-65 , love.graphics.getHeight()+inty-20 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][11][6].."" , intx-60 , love.graphics.getHeight()+inty-20-love.graphics.getFont():getHeight( ) )
				end
				if unitlist[unit[nearest][3][5]][11][5] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][5] < 0 then
						love.graphics.setColor(255,255,0,inta/2)
					else
						love.graphics.setColor(255,255,0,inta)
					end
					love.graphics.draw( goldico , intx-65 , love.graphics.getHeight()+inty-6 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][11][5].."" , intx-60 , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) )
				end
				love.graphics.setColor(255,255,255,inta)
			elseif unitlist[unit[nearest][3][5]][11][1] == 6 then
				if crono < unit[nearest][9]
				or unit[nearest][7]-unitlist[unit[nearest][3][5]][11][7] < 0
				or gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][11][6] < 0 then
					love.graphics.setColor(255,255,255,inta/2)
				end
				love.graphics.draw( unitlist[unit[nearest][3][5]][11][8] , intx-45 , love.graphics.getHeight()+inty-65 , math.atan(unitlist[unit[nearest][3][5]][11][4]/unitlist[unit[nearest][3][5]][11][3])*unit[nearest][6] , 1*unit[nearest][6]*(unitlist[unit[nearest][3][5]][11][3]/math.abs(unitlist[unit[nearest][3][5]][11][3])), 1 , 25 ,25)
				love.graphics.setFont( ff )
				if unitlist[unit[nearest][3][5]][11][7] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][7] < 0 then
						love.graphics.setColor(50,50,255,inta/2)
					else
						love.graphics.setColor(50,50,255,inta)
					end
					love.graphics.draw( manaico , intx-65 , love.graphics.getHeight()+inty-20 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][11][7].."" , intx-60 , love.graphics.getHeight()+inty-20-love.graphics.getFont():getHeight( ) )
				end
				if unitlist[unit[nearest][3][5]][11][6] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][6] < 0 then
						love.graphics.setColor(255,255,0,inta/2)
					else
						love.graphics.setColor(255,255,0,inta)
					end
					love.graphics.draw( goldico , intx-65 , love.graphics.getHeight()+inty-6 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][11][6].."" , intx-60 , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) )
				end
				love.graphics.setColor(255,255,255,inta)
			elseif unitlist[unit[nearest][3][5]][11][1] == 7 then
				if crono < unit[nearest][9]
				or unit[nearest][7]-unitlist[unit[nearest][3][5]][11][5] < 0
				or gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][11][6] < 0 then
					love.graphics.setColor(255,255,255,inta/2)
				end
				love.graphics.draw( fle , intx-45 , love.graphics.getHeight()+inty-65 , math.atan(unitlist[unit[nearest][3][5]][11][3]/unitlist[unit[nearest][3][5]][11][2])*unit[nearest][6] , 1*unit[nearest][6]*(unitlist[unit[nearest][3][5]][11][2]/math.abs(unitlist[unit[nearest][3][5]][11][2])), 1 , 25 ,25)
				love.graphics.setFont( ff )
				if unitlist[unit[nearest][3][5]][11][5] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][5] < 0 then
						love.graphics.setColor(50,50,255,inta/2)
					else
						love.graphics.setColor(50,50,255,inta)
					end
					love.graphics.draw( manaico , intx-65 , love.graphics.getHeight()+inty-20 , 0 , 1, -1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][11][5].."" , intx-60 , love.graphics.getHeight()+inty-20-love.graphics.getFont():getHeight( ) )
				end
				if unitlist[unit[nearest][3][5]][11][6] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][11][6] < 0 then
						love.graphics.setColor(255,255,0,inta/2)
					else
						love.graphics.setColor(255,255,0,inta)
					end
					love.graphics.draw( goldico , intx-65 , love.graphics.getHeight()+inty-6 , 0 , 1, -1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][11][6].."" , intx-60 , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) )
				end
				love.graphics.setColor(255,255,255,inta)
			end
			if unitlist[unit[nearest][3][5]][12][1] == 0 then
				if unitlist[unit[nearest][3][5]][12][3] == 0 then
					if unit[nearest][4] == 5 then
						love.graphics.draw( stop , intx+45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
						love.graphics.draw( interd , intx+45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
					else
						love.graphics.draw( stop , intx+45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
					end
				else
					if unit[nearest][18] == 0 then
						love.graphics.draw( stand , intx+45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
						love.graphics.draw( interd , intx+45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
					else
						love.graphics.draw( stand , intx+45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
					end
				end
			elseif unitlist[unit[nearest][3][5]][12][1] == 1 then
				if crono < unit[nearest][9]
				or unit[nearest][7]-unitlist[unit[nearest][3][5]][12][5] < 0
				or gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][12][4] < 0
				or food[unit[nearest][3][4]]+unitlist[unitlist[unit[nearest][3][5]][12][2]][16] > math.min(foodmax[unit[nearest][3][4]],maxunit) then
					love.graphics.setColor(255,255,255,inta/2)
				end
				love.graphics.draw( unitlist[unitlist[unit[nearest][3][5]][12][2]][2][8] , intx+45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
				love.graphics.draw( plus , intx+30 , love.graphics.getHeight()+inty-50 , 0 , 1, 1 , 10 ,10)
				love.graphics.setFont( ff )
				if unitlist[unit[nearest][3][5]][12][5] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][5] < 0 then
						love.graphics.setColor(50,50,255,inta/2)
					else
						love.graphics.setColor(50,50,255,inta)
					end
					love.graphics.draw( manaico , intx+32 , love.graphics.getHeight()+inty-20 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][12][5].."" , intx+37 , love.graphics.getHeight()+inty-20-love.graphics.getFont():getHeight( ) )
				end
				if unitlist[unit[nearest][3][5]][12][4] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][4] < 0 then
						love.graphics.setColor(255,255,0,inta/2)
					else
						love.graphics.setColor(255,255,0,inta)
					end
					love.graphics.draw( goldico , intx+32 , love.graphics.getHeight()+inty-6 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][12][4].."" , intx+37 , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) )
				end
				love.graphics.setColor(255,255,255,inta)
			elseif unitlist[unit[nearest][3][5]][12][1] == 2 then
				if unit[nearest][4] == 6.2 then
					love.graphics.draw( jump , intx+45 , love.graphics.getHeight()+inty-65 , math.atan(unitlist[unit[nearest][3][5]][12][3]*unit[nearest][5][1]/unitlist[unit[nearest][3][5]][12][2]), unit[nearest][5][1], 1 , 25 ,25 )
					love.graphics.draw( interd , intx+45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
				else
					love.graphics.draw( feue , intx+45 , love.graphics.getHeight()+inty-65 , math.atan(unitlist[unit[nearest][3][5]][12][3]*unit[nearest][5][1]/unitlist[unit[nearest][3][5]][12][2]), unit[nearest][5][1]*(unitlist[unit[nearest][3][5]][12][2]/math.abs(unitlist[unit[nearest][3][5]][12][2])), 1 , -15 ,11 )
					love.graphics.draw( jump , intx+45 , love.graphics.getHeight()+inty-65 , math.atan(unitlist[unit[nearest][3][5]][12][3]*unit[nearest][5][1]/unitlist[unit[nearest][3][5]][12][2]), unit[nearest][5][1]*(unitlist[unit[nearest][3][5]][12][2]/math.abs(unitlist[unit[nearest][3][5]][12][2])), 1 , 25 ,25 )
					love.graphics.setFont( ff )
					if unitlist[unit[nearest][3][5]][12][4] ~= 0 then
						if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][4] < 0 then
							love.graphics.setColor(50,50,255,inta/2)
						else
							love.graphics.setColor(50,50,255,inta)
						end
						love.graphics.draw( manaico , intx+32 , love.graphics.getHeight()+inty-20 , 0 , 1, 1 , 10 ,0)
						love.graphics.print( ""..-unitlist[unit[nearest][3][5]][12][4].."" , intx+37 , love.graphics.getHeight()+inty-20-love.graphics.getFont():getHeight( ) )
					end
					if unitlist[unit[nearest][3][5]][12][5] ~= 0 then
						if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][5] < 0 then
							love.graphics.setColor(255,255,0,inta/2)
						else
							love.graphics.setColor(255,255,0,inta)
						end
						love.graphics.draw( goldico , intx+32 , love.graphics.getHeight()+inty-6 , 0 , 1, 1 , 10 ,0)
						love.graphics.print( ""..-unitlist[unit[nearest][3][5]][12][5].."" , intx+37 , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) )
					end
				end
				love.graphics.setColor(255,255,255,inta)
			elseif unitlist[unit[nearest][3][5]][12][1] == 3 then
				if unit[nearest][4] == 4.2 then
					love.graphics.draw( fle , intx+45 , love.graphics.getHeight()+inty-65 , math.atan(unitlist[unit[nearest][3][5]][12][3]*unit[nearest][5][1]/unitlist[unit[nearest][3][5]][12][2]), unit[nearest][5][1]*(unitlist[unit[nearest][3][5]][12][2]/math.abs(unitlist[unit[nearest][3][5]][12][2])), 1 , 25 ,25 )
					love.graphics.draw( creus , intx+45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
					love.graphics.draw( interd , intx+45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
				else
					love.graphics.draw( fle , intx+45 , love.graphics.getHeight()+inty-65 , math.atan(unitlist[unit[nearest][3][5]][12][3]*unit[nearest][5][1]/unitlist[unit[nearest][3][5]][12][2]), unit[nearest][5][1]*(unitlist[unit[nearest][3][5]][12][2]/math.abs(unitlist[unit[nearest][3][5]][12][2])), 1 , 25 ,25 )
					love.graphics.draw( creus , intx+45 , love.graphics.getHeight()+inty-65 , 0 , 1, 1 , 25 ,25)
				end
				love.graphics.setFont( ff )
				if unitlist[unit[nearest][3][5]][12][6] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][6] < 0 then
						love.graphics.setColor(50,50,255,inta/2)
					else
						love.graphics.setColor(50,50,255,inta)
					end
					love.graphics.draw( manaico , intx+32 , love.graphics.getHeight()+inty-20 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][12][6].."" , intx+37 , love.graphics.getHeight()+inty-20-love.graphics.getFont():getHeight( ) )
				end
				if unitlist[unit[nearest][3][5]][12][5] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][5] < 0 then
						love.graphics.setColor(255,255,0,inta/2)
					else
						love.graphics.setColor(255,255,0,inta)
					end
					love.graphics.draw( goldico , intx+32 , love.graphics.getHeight()+inty-6 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][12][5].."" , intx+37 , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) )
				end
				love.graphics.setColor(255,255,255,inta)
			elseif unitlist[unit[nearest][3][5]][12][1] == 4 then
				if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][4] <= 0
				or gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][12][3] <= 0
				or crono < unit[nearest][9] then
					love.graphics.setColor(255,255,255,inta/2)
				end
				love.graphics.draw( expl , intx+45 , love.graphics.getHeight()+inty-65 , 0 , 1 , 1 , 25 ,25 )
				love.graphics.setFont( ff )
				if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][4] < 0 then
					love.graphics.setColor(50,50,255,inta/2)
				else
					love.graphics.setColor(50,50,255,inta)
				end
				love.graphics.print( ""..-unitlist[unit[nearest][3][5]][12][4].." pt." , intx+37 , love.graphics.getHeight()+inty-20-love.graphics.getFont():getHeight( ) )
				if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][3] < 0 then
					love.graphics.setColor(255,255,0,inta/2)
				else
					love.graphics.setColor(255,255,0,inta)
				end
				love.graphics.print( ""..-unitlist[unit[nearest][3][5]][12][3].." $" , intx+37 , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) )
				if unitlist[unit[nearest][3][5]][12][4] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][4] < 0 then
						love.graphics.setColor(50,50,255,inta/2)
					else
						love.graphics.setColor(50,50,255,inta)
					end
					love.graphics.draw( manaico , intx+32 , love.graphics.getHeight()+inty-20 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][12][4].."" , intx+37 , love.graphics.getHeight()+inty-20-love.graphics.getFont():getHeight( ) )
				end
				if unitlist[unit[nearest][3][5]][12][3] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][3] < 0 then
						love.graphics.setColor(255,255,0,inta/2)
					else
						love.graphics.setColor(255,255,0,inta)
					end
					love.graphics.draw( goldico , intx+32 , love.graphics.getHeight()+inty-6 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][12][3].."" , intx+37 , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) )
				end
				love.graphics.setColor(255,255,255,inta)
			elseif unitlist[unit[nearest][3][5]][12][1] == 5 then
				if crono < unit[nearest][9]
				or unit[nearest][7]-unitlist[unit[nearest][3][5]][12][6] < 0
				or gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][12][5] < 0 then
					love.graphics.setColor(255,255,255,inta/2)
				end
				love.graphics.draw( unitlist[unit[nearest][3][5]][12][7] , intx+45 , love.graphics.getHeight()+inty-65 , 0 , 50/math.max(unitlist[unit[nearest][3][5]][12][7]:getWidth(),unitlist[unit[nearest][3][5]][12][7]:getHeight())*unit[nearest][6], 50/math.max(unitlist[unit[nearest][3][5]][12][7]:getWidth(),unitlist[unit[nearest][3][5]][12][7]:getHeight()) , unitlist[unit[nearest][3][5]][12][7]:getWidth()/2 ,unitlist[unit[nearest][3][5]][12][7]:getHeight()/2)
				love.graphics.draw( mart , intx+30 , love.graphics.getHeight()+inty-50 , 0 , 1, 1 , 15 ,15)
				love.graphics.setFont( ff )
				if unitlist[unit[nearest][3][5]][12][6] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][6] < 0 then
						love.graphics.setColor(50,50,255,inta/2)
					else
						love.graphics.setColor(50,50,255,inta)
					end
					love.graphics.draw( manaico , intx+32 , love.graphics.getHeight()+inty-20 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][12][6].."" , intx+37 , love.graphics.getHeight()+inty-20-love.graphics.getFont():getHeight( ) )
				end
				if unitlist[unit[nearest][3][5]][12][5] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][5] < 0 then
						love.graphics.setColor(255,255,0,inta/2)
					else
						love.graphics.setColor(255,255,0,inta)
					end
					love.graphics.draw( goldico , intx+32 , love.graphics.getHeight()+inty-6 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][12][5].."" , intx+37 , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) )
				end
				love.graphics.setColor(255,255,255,inta)
			elseif unitlist[unit[nearest][3][5]][12][1] == 6 then
				if crono < unit[nearest][9]
				or unit[nearest][7]-unitlist[unit[nearest][3][5]][12][7] < 0
				or gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][12][6] < 0 then
					love.graphics.setColor(255,255,255,inta/2)
				end
				love.graphics.draw( unitlist[unit[nearest][3][5]][12][8] , intx+45 , love.graphics.getHeight()+inty-65 , math.atan(unitlist[unit[nearest][3][5]][12][4]/unitlist[unit[nearest][3][5]][12][3])*unit[nearest][6] , 1*unit[nearest][6]*(unitlist[unit[nearest][3][5]][12][3]/math.abs(unitlist[unit[nearest][3][5]][12][3])), 1 , 25 ,25)
				love.graphics.setFont( ff )
				if unitlist[unit[nearest][3][5]][12][7] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][7] < 0 then
						love.graphics.setColor(50,50,255,inta/2)
					else
						love.graphics.setColor(50,50,255,inta)
					end
					love.graphics.draw( manaico , intx+32 , love.graphics.getHeight()+inty-20 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][12][7].."" , intx+37 , love.graphics.getHeight()+inty-20-love.graphics.getFont():getHeight( ) )
				end
				if unitlist[unit[nearest][3][5]][12][6] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][6] < 0 then
						love.graphics.setColor(255,255,0,inta/2)
					else
						love.graphics.setColor(255,255,0,inta)
					end
					love.graphics.draw( goldico , intx+32 , love.graphics.getHeight()+inty-6 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][12][6].."" , intx+37 , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) )
				end
				love.graphics.setColor(255,255,255,inta)
			elseif unitlist[unit[nearest][3][5]][12][1] == 7 then
				if crono < unit[nearest][9]
				or unit[nearest][7]-unitlist[unit[nearest][3][5]][12][5] < 0
				or gold[unit[nearest][3][4]]-unitlist[unit[nearest][3][5]][12][6] < 0 then
					love.graphics.setColor(255,255,255,inta/2)
				end
				love.graphics.draw( fle , intx+45 , love.graphics.getHeight()+inty-65 , math.atan(unitlist[unit[nearest][3][5]][12][3]/unitlist[unit[nearest][3][5]][12][2])*unit[nearest][6] , 1*unit[nearest][6]*(unitlist[unit[nearest][3][5]][12][2]/math.abs(unitlist[unit[nearest][3][5]][12][2])), 1 , 25 ,25)
				love.graphics.setFont( ff )
				if unitlist[unit[nearest][3][5]][12][5] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][5] < 0 then
						love.graphics.setColor(50,50,255,inta/2)
					else
						love.graphics.setColor(50,50,255,inta)
					end
					love.graphics.draw( manaico , intx+32 , love.graphics.getHeight()+inty-20 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][12][5].."" , intx+37 , love.graphics.getHeight()+inty-20-love.graphics.getFont():getHeight( ) )
				end
				if unitlist[unit[nearest][3][5]][12][6] ~= 0 then
					if unit[nearest][7]-unitlist[unit[nearest][3][5]][12][6] < 0 then
						love.graphics.setColor(255,255,0,inta/2)
					else
						love.graphics.setColor(255,255,0,inta)
					end
					love.graphics.draw( goldico , intx+32 , love.graphics.getHeight()+inty-6 , 0 , 1, 1 , 10 ,0)
					love.graphics.print( ""..-unitlist[unit[nearest][3][5]][12][6].."" , intx+37 , love.graphics.getHeight()+inty-6-love.graphics.getFont():getHeight( ) )
				end
				love.graphics.setColor(255,255,255,inta)
			end
			love.graphics.setColor(255,255,255)
		end
		if play == 2 then
			love.graphics.setColor(255,255,0)
			love.graphics.setFont( fff )
			love.graphics.print("joueur "..gagnent.." gagne", 50,love.graphics.getHeight()/2-love.graphics.getFont():getHeight( ))
		end
		love.graphics.setFont( f )
		love.graphics.setColor(255,255,0)
		love.graphics.print(""..gold[1].."/"..goldmax[1].."$ +"..(pluseco[1]+moineco[1]).."$/s", 30,30-1.3*inty-love.graphics.getFont():getHeight( ))
		--love.graphics.print(""..pluseco[2].."-"..moineco[2].."", 100,100)
		love.graphics.setColor(200,150,100)
		love.graphics.print(""..food[1].."/"..math.min(foodmax[1],maxunit).." pop", 30,60-1.3*inty-love.graphics.getFont():getHeight( ))
		love.graphics.setColor(255,255,255)
		love.graphics.draw( gri , love.graphics.getWidth()/2 , love.graphics.getHeight()/2 , 0 , 2.8, 2 , 200 ,200)
	elseif phase == 2 then
		love.graphics.setColor(255,255,255)
		love.graphics.draw( maper , 0,0, 0,love.graphics.getWidth()/maper:getWidth(),love.graphics.getHeight()/maper:getHeight())
		love.graphics.setColor(255,255,255,math.min(anima,255))
		love.graphics.draw( iconed , love.graphics.getWidth()/2+gotocoin-.5*math.max(400-anima,0) , 350-gotocoin/(love.graphics.getWidth()/2-50)*300+.2*math.max(400-anima,0) , 0 , .2+math.min(anima,400)/200*(((love.graphics.getWidth()/2-50)-gotocoin)/(love.graphics.getWidth()/2-50)),.2+math.min(anima,400)/200*(((love.graphics.getWidth()/2-50)-gotocoin)/(love.graphics.getWidth()/2-50)) , 150 ,150)
		love.graphics.setColor(255,255,255,math.max(255-anima,0))
		love.graphics.draw( maperer , 0,0, 0,love.graphics.getWidth()/maper:getWidth(),love.graphics.getHeight()/maper:getHeight())
		love.graphics.setColor(255,255,255,(50+math.max(0,100*math.sin(2*crono)))*math.min(.2*anima,255)/255)
		love.graphics.draw( etoile , 760,270, .4*math.sin(.8*crono),2.5,2.5,150,150)
		love.graphics.setColor(255,255,255,(50+math.max(0,100*math.cos(1.95*crono)))*math.min(.2*anima,255)/255)
		love.graphics.draw( etoile , 760,270, .4*math.cos(.85*crono),2.5,2.5,150,150)
		love.graphics.setColor(255,255,255)
	elseif phase == 3 then
		love.graphics.setColor(255,255,255)
		love.graphics.draw( maper , 0,0, 0,love.graphics.getWidth()/maper:getWidth(),love.graphics.getHeight()/maper:getHeight())
		love.graphics.setColor(255,255,255,math.min(anima,255))
		love.graphics.draw( iconed , love.graphics.getWidth()/2+gotocoin-.5*math.max(400-anima,0) , 350-gotocoin/(love.graphics.getWidth()/2-50)*300+.2*math.max(400-anima,0) , 0 , .2+math.min(anima,400)/200*(((love.graphics.getWidth()/2-50)-gotocoin)/(love.graphics.getWidth()/2-50)),.2+math.min(anima,400)/200*(((love.graphics.getWidth()/2-50)-gotocoin)/(love.graphics.getWidth()/2-50)) , 150 ,150)
		love.graphics.setColor(255,255,255,math.max(255-anima,0))
		love.graphics.draw( maperer , 0,0, 0,love.graphics.getWidth()/maper:getWidth(),love.graphics.getHeight()/maper:getHeight())
		love.graphics.setColor(255,255,255,(100+50*math.sin(2*crono))*math.min(.2*anima,255)/255)
		love.graphics.draw( etoile , 760,270, .4*math.sin(.8*crono),2.5,2.5,150,150)
		love.graphics.setColor(255,255,255,(100+50*math.cos(1.95*crono))*math.min(.2*anima,255)/255)
		love.graphics.draw( etoile , 760,270, .4*math.cos(.85*crono),2.5,2.5,150,150)
		love.graphics.setColor(255,255,255)
		love.graphics.draw( mapsky , 450,200, 0,map:getWidth()*500/math.max(map:getWidth(),map:getHeight())/mapsky:getWidth(),map:getHeight()*500/math.max(map:getWidth(),map:getHeight())/mapsky:getHeight())
		love.graphics.draw( map , 450,200, 0,500/math.max(map:getWidth(),map:getHeight()),500/math.max(map:getWidth(),map:getHeight()))
		love.graphics.draw( cadre , 450,200, 0,5.206,map:getHeight()/math.max(map:getWidth(),map:getHeight())*5.20,2,2)
		for i,h in ipairs(cartelist[cartechoisi][2]) do
			love.graphics.setColor(2*ita[h[4]][6][1]-255,2*ita[h[4]][6][2]-255,2*ita[h[4]][6][3]-255)
			love.graphics.draw( marque , 450+h[1]*500/math.max(map:getWidth(),map:getHeight()),200+h[2]*500/math.max(map:getWidth(),map:getHeight()), 0,.5,-.5,25,25)
			love.graphics.print(racelist[h[5]][1], 200 , 160+i*50-love.graphics.getFont():getHeight( ) )
			love.graphics.print(h[4], 450+h[1]*500/math.max(map:getWidth(),map:getHeight()) , 200+h[2]*500/math.max(map:getWidth(),map:getHeight())-love.graphics.getFont():getHeight( ))
		end
	elseif phase == 4 then
		love.graphics.setColor(255,255,255)
		love.graphics.draw( maper , 0,0, 0,love.graphics.getWidth()/maper:getWidth(),love.graphics.getHeight()/maper:getHeight())
		love.graphics.setColor(255,255,255,math.min(anima,255))
		love.graphics.draw( iconed , love.graphics.getWidth()/2+gotocoin-.5*math.max(400-anima,0) , 350-gotocoin/(love.graphics.getWidth()/2-50)*300+.2*math.max(400-anima,0) , 0 , .2+math.min(anima,400)/200*(((love.graphics.getWidth()/2-50)-gotocoin)/(love.graphics.getWidth()/2-50)),.2+math.min(anima,400)/200*(((love.graphics.getWidth()/2-50)-gotocoin)/(love.graphics.getWidth()/2-50)) , 150 ,150)
		love.graphics.setColor(255,255,255,math.max(255-anima,0))
		love.graphics.draw( maperer , 0,0, 0,love.graphics.getWidth()/maper:getWidth(),love.graphics.getHeight()/maper:getHeight())
		love.graphics.setColor(255,255,255,(100+50*math.sin(2*crono))*math.min(.2*anima,255)/255)
		love.graphics.draw( etoile , 760,270, .4*math.sin(.8*crono),2.5,2.5,150,150)
		love.graphics.setColor(255,255,255,(100+50*math.cos(1.95*crono))*math.min(.2*anima,255)/255)
		love.graphics.draw( etoile , 760,270, .4*math.cos(.85*crono),2.5,2.5,150,150)
		love.graphics.setColor(255,255,255)
	elseif phase == 5 then
		love.graphics.setColor(255,255,255)
		love.graphics.draw( maper , 0,0, 0,love.graphics.getWidth()/maper:getWidth(),love.graphics.getHeight()/maper:getHeight())
		love.graphics.setColor(255,255,255,math.min(anima,255))
		love.graphics.draw( iconed , love.graphics.getWidth()/2+gotocoin-.5*math.max(400-anima,0) , 350-gotocoin/(love.graphics.getWidth()/2-50)*300+.2*math.max(400-anima,0) , 0 , .2+math.min(anima,400)/200*(((love.graphics.getWidth()/2-50)-gotocoin)/(love.graphics.getWidth()/2-50)),.2+math.min(anima,400)/200*(((love.graphics.getWidth()/2-50)-gotocoin)/(love.graphics.getWidth()/2-50)) , 150 ,150)
		love.graphics.setColor(255,255,255,math.max(255-anima,0))
		love.graphics.draw( maperer , 0,0, 0,love.graphics.getWidth()/maper:getWidth(),love.graphics.getHeight()/maper:getHeight())
		love.graphics.setColor(255,255,255,(100+50*math.sin(2*crono))*math.min(.2*anima,255)/255)
		love.graphics.draw( etoile , 760,270, .4*math.sin(.8*crono),2.5,2.5,150,150)
		love.graphics.setColor(255,255,255,(100+50*math.cos(1.95*crono))*math.min(.2*anima,255)/255)
		love.graphics.draw( etoile , 760,270, .4*math.cos(.85*crono),2.5,2.5,150,150)
		love.graphics.setColor(255,255,255)
		love.graphics.draw( mapsky , 300,250, 0,map:getWidth()*400/math.max(map:getWidth(),map:getHeight())/mapsky:getWidth(),map:getHeight()*400/math.max(map:getWidth(),map:getHeight())/mapsky:getHeight())
		love.graphics.draw( map , 300,250, 0,400/math.max(map:getWidth(),map:getHeight()),400/math.max(map:getWidth(),map:getHeight()))
		love.graphics.draw( cadre , 300,250, 0,4.165,map:getHeight()/math.max(map:getWidth(),map:getHeight())*4.16,2,2)
		love.graphics.printf(cartelist[cartechoisi][1], 300 , 230-love.graphics.getFont():getHeight( ),400,"left" )
		love.graphics.setFont( ff )
		for i,h in ipairs(cartelist[cartechoisi][2]) do
			love.graphics.draw( marque , 300+h[1]*400/math.max(map:getWidth(),map:getHeight()),250+h[2]*400/math.max(map:getWidth(),map:getHeight()), 0,.5,.5,25,25)
		end
		love.graphics.printf(cartelist[cartechoisi][3], 300 , 270+map:getHeight()*400/math.max(map:getWidth(),map:getHeight())-love.graphics.getFont():getHeight( ),400,"left" )
	end
	love.graphics.setFont( f )
	for i,h in ipairs(bout) do
		if bouton == i then
			love.graphics.setColor(230,230,230)
			pese = 5
		else
			love.graphics.setColor(255,255,255)
			pese = 0
		end
		love.graphics.draw( h[5] , h[1]-pese , h[2]+pese , 0 , 2*h[3]/(h[5]:getWidth()-4), 2*h[4]/(h[5]:getHeight()-4) , h[5]:getWidth()/2 ,h[5]:getHeight()/2)
		love.graphics.printf(h[6], h[1]-pese-h[3]+20 , h[2]+pese-h[4]+40-love.graphics.getFont():getHeight( ),h[3]*2,"left" )
	end
	love.graphics.setFont( f )
	love.graphics.print( math.floor(fps*100)/100 , 860-love.graphics.getFont():getHeight( ) , 30 )
end
