function love.load()
	love.graphics.toggleFullscreen( )
	Niveau = 1
	CartePhysique = love.image.newImageData("App/Niveaux/"..Niveau.."/Carte.gif")
	Carte = love.graphics.newImage(CartePhysique)
	Carte:setFilter( "nearest","nearest" )
	font = love.graphics.newFont(22)
	Titre = love.graphics.newImage("Titre.png")
	Titre2 = love.graphics.newImage("Titre2.png")
	Over1 = love.graphics.newImage("Over.png")
	Over2 = love.graphics.newImage("Over2.png")
	
	play = false
	Over = false
	Mort = false
	titre_alpha = 1


	Ombre = love.graphics.newImage("App/Elements/Ombre.png")
	Hero = love.graphics.newImage("App/Elements/Héro.gif")
	Monstre = love.graphics.newImage("App/Elements/Méchant.gif")
	Cave = love.audio.newSource( "Son/Cave.ogg" )
	Cave:setLooping( true )

	Cave:setVolume( 1 )
	love.audio.play( Cave )
	Pas = love.audio.newSource( "Son/Pas.ogg" )
	PasEau = love.audio.newSource( "Son/PasEau.ogg" )
	Nage = love.audio.newSource( "Son/Nage.ogg" )
	TempoPas = 0
	Trans = 0
	Eboulis = love.audio.newSource( "Son/Éboulis.ogg" )
	Chute = love.audio.newSource( "Son/Cris Chute.ogg" )
	Bete = love.audio.newSource ( "Son/Bete.ogg" )
	Bete:setLooping( true )

	Bete:setVolume( 0 )
	love.audio.play( Bete )
	Coeur = love.audio.newSource ( "Son/Coeur.ogg" )
	Coeur:setLooping( true )
	Respire = love.audio.newSource ( "Son/Respiration.ogg" )
	Respire:setLooping( true )


	Coeur:setVolume( 0 )
	Respire:setVolume( 0 )
	love.audio.play( Respire )
	love.audio.play( Coeur )
	MonstreEau = love.audio.newSource ( "Son/MonstreEau.ogg" )
	MonstreEau:setLooping( true )

	MonstreEau:setVolume( 0 )
	love.audio.play( MonstreEau )
	VolumeBete = 0
	VolumeReelBete = 0
	VolumeBeteMarin = 0
	VolumeReelBeteMarin = 0
	CrisBete = love.audio.newSource( "Son/Cris Bete.ogg" )
	Focus = love.graphics.newImage("App/Elements/Focus.png")
	Focus2 = love.graphics.newImage("App/Elements/Focus2.png")
	FocusPeur = love.graphics.newImage("App/Elements/Peur.png")
	ToucherAvant = love.graphics.newImage("App/Elements/Toucheravant.png")
	ToucherDroite = love.graphics.newImage("App/Elements/ToucherDroite.png")
	ToucherGauche = love.graphics.newImage("App/Elements/ToucherGauche.png")
	Main_Gauche = 0
	Main_Gauche2 = 0
	Main_Droite = 0
	Main_Droite2 = 0
	Main_Avant = 0
	Main_Avant2 = 0
	Carte = love.graphics.newImage("App/Elements/Carte.png")
	Carreaux = love.graphics.newImage("App/Elements/Carreaux.png")
	CarreauxEau = love.graphics.newImage("App/Elements/CarreauxEau.png")
	CarreauxNoir = love.graphics.newImage("App/Elements/CarreauxNoir.png")
	Point = love.graphics.newImage("App/Elements/Point.png")
	ombre = love.graphics.newFramebuffer( )
	Rune = love.graphics.newImage("App/Elements/Checkpoint.png")
	Rune_Gauche = love.graphics.newImage("App/Elements/Checkpoint Gauche.png")
	Rune_Droite = love.graphics.newImage("App/Elements/Checkpoint Droite.png")
	Rune_Opaciter = 0
	Rune_Gauche_Opaciter = 0
	Rune_Droite_Opaciter = 0
	Carte_Opaciter = 0
	Rune_Opaciter2 = 0
	Rune_Gauche_Opaciter2 = 0
	Rune_Droite_Opaciter2 = 0
	Carte_Opaciter2 = 0




	Pas:setVolume( 0 )
--Méchants------------------------------------------------------------------------------------
	carto = {}
	Mechant = {}
	X = 0
	Y = 0
	Direction = 1
	wx = 0
	while wx < CartePhysique:getWidth() do
		carto[wx] = {}
		wy = 0
		while wy < CartePhysique:getHeight()+1 do
			carto[wx][wy] = 0
			if R == 255 then--carte---1=sol--2=eau--3=rune--4=carte--5=entrée--6=sortie
				carto[wx][wy] = 1
			elseif R == 200 then
				carto[wx][wy] = 2
			elseif R == 180 then
				carto[wx][wy] = 2
			elseif R == 100 then
				carto[wx][wy] = 1
			elseif R == 50 then
				carto[wx][wy] = 1
			end
			if V == 255 then
				carto[wx][wy] = 3
			elseif V == 200 then
				carto[wx][wy] = 4
			end
			R, V, B, al = CartePhysique:getPixel( math.min(math.max(0,math.floor(wx)),CartePhysique:getWidth()-1), math.min(math.max(0,math.floor(wy)),CartePhysique:getHeight()-1) )
			if B == 255 then
				X = wx
				Y = wy
				carto[wx][wy] = 5
			elseif B == 250 then
				carto[wx][wy] = 6
			elseif B == 200 then
				Creation(wx,wy,"Terrestre")
			elseif B == 100 then
				Creation(wx,wy,"Marin")
			end
			wy = wy+1
		end
		wx = wx+1
	end



Chrono = 0
end
--Physique----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Coli(ex,ey)
	R, V, B, al = CartePhysique:getPixel( math.min(math.max(0,math.floor(ex)),CartePhysique:getWidth()-1), math.min(math.max(0,math.floor(ey)),CartePhysique:getHeight()-1) )
	return (R)
end
function ColiV(ex,ey)
	R, V, B, al = CartePhysique:getPixel( math.min(math.max(0,math.floor(ex)),CartePhysique:getWidth()-1), math.min(math.max(0,math.floor(ey)),CartePhysique:getHeight()-1) )
	return (V)
end
function Terrain(ex,ey)
	Rouge = Coli(ex,ey)
	if Rouge == 100 then
		love.audio.stop( Pas )
		love.audio.play( Pas )
		love.audio.stop( Eboulis )
		love.audio.play( Eboulis )
		TempoPas = Chrono+2.0
	elseif Rouge == 50 then
		love.audio.stop( Chute )
		love.audio.play( Chute )
		TempoPas = Chrono+2.0
		Mort = true
	elseif Rouge == 200 then
		love.audio.stop( PasEau )
		love.audio.play( PasEau )
		TempoPas = Chrono+.7
	elseif Rouge == 180 then
		love.audio.stop( Nage )
		love.audio.play( Nage )
		TempoPas = Chrono+2.4
	elseif Rouge == 255 then
		love.audio.stop( Pas )
		love.audio.play( Pas )
		TempoPas = Chrono+.7
	end
end
--Création Méchants-------------------------------------------------------------------------------------
function Creation(EX,EY,tipe)
	table.insert(Mechant,{{EX,EY},tipe})
end
--souris controle----------------------------------------------------------------------------------------------------------------------------------------------------------------------
function love.mousepressed( mx, my, bu )
--ordre ici
end
function love.mousereleased( mx, my, bu )
--ordre ici
end
--Clavier controle----------------------------------------------------------------------------------------------------------------------------------------------------------------------
function love.keypressed( Bouton )
--ici
	if Bouton == "escape" then
		love.event.push('q')
	elseif Bouton == " " then
		
		play = true
		Mort = false
		Over = false

	end
end
function love.keyreleased( k )
--ici
end
--Ordre periodique-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
function love.update(dt)
--ici
	if Mort == true then
	play = false
	Over = true
	titre_alpha = titre_alpha+.1*(1-titre_alpha)
	
	end
	if play == true then

		titre_alpha = titre_alpha*.9

		Rune_Gauche_Opaciter2 = Rune_Gauche_Opaciter2*.98-.4
		Rune_Droite_Opaciter2 = Rune_Droite_Opaciter2*.98-.4
		Rune_Opaciter2 = Rune_Opaciter2*.98-.4
		Carte_Opaciter2 = Carte_Opaciter2*.98-.4
		Rune_Gauche_Opaciter = math.min(255,Rune_Gauche_Opaciter+Rune_Gauche_Opaciter2*.98)
		Rune_Droite_Opaciter = math.min(255,Rune_Droite_Opaciter+Rune_Droite_Opaciter2*.98)
		Rune_Opaciter = math.min(255,Rune_Opaciter+Rune_Opaciter2*.98)
		Carte_Opaciter = math.min(255,Carte_Opaciter+Carte_Opaciter2*.98)
		if Rune_Gauche_Opaciter < 0 then
			Rune_Gauche_Opaciter = 0
			Rune_Gauche_Opaciter2 = 0
		end
		if Rune_Droite_Opaciter < 0 then
			Rune_Droite_Opaciter = 0
			Rune_Droite_Opaciter2 = 0
		end
		if Rune_Opaciter < 0 then
			Rune_Opaciter = 0
			Rune_Opaciter2 = 0
		end
		if Carte_Opaciter < 0 then
			Carte_Opaciter = 0
			Carte_Opaciter2 = 0
		end
		Main_Gauche2 = .98*Main_Gauche2-.4
		Main_Droite2 = .98*Main_Droite2-.4
		Main_Avant2 = .98*Main_Avant2-.4
		Main_Gauche = math.min(255,Main_Gauche+Main_Gauche2*.98)
		Main_Droite = math.min(255,Main_Droite+Main_Droite2*.98)
		Main_Avant = math.min(255,Main_Avant+Main_Avant2*.98)
		if Main_Gauche < 0 then
			Main_Gauche = 0
			Main_Gauche2 = 0
		end
		if Main_Droite < 0 then
			Main_Droite = 0
			Main_Droite2 = 0
		end
		if Main_Avant < 0 then
			Main_Avant = 0
			Main_Avant2 = 0
		end
		if Chrono > TempoPas then
			Possi = 0
			if love.keyboard.isDown("up")then
	
				if Coli(X,Y-1) ~= 0 then
					Y = Y-1
					direction = 2
					Possi = 1
				else
					if direction == 1 then
						Main_Gauche2 = 20
						if ColiV(X,Y-1) == 255 then
							Rune_Gauche_Opaciter2 = 20
						end
					elseif direction == 2 then
						Main_Avant2 = 20
						if ColiV(X,Y-1) == 255 then
							Rune_Opaciter2 = 20
						elseif ColiV(X,Y-1) == 200 then
							Carte_Opaciter2 = 20
						end
					elseif direction == 3 then
						Main_Droite2 = 20
						if ColiV(X,Y-1) == 255 then
							Rune_Droite_Opaciter2 = 20
						end
					end
				end
			end
			if love.keyboard.isDown("down")then
	
				if Coli(X,Y+1) ~= 0 then
					Y = Y+1
					direction = 4
					Possi = 1
				else
					if direction == 3 then
						Main_Gauche2 = 20
						if ColiV(X,Y+1) == 255 then
							Rune_Gauche_Opaciter2 = 20
						end
					elseif direction == 4 then
						Main_Avant2 = 20
						if ColiV(X,Y+1) == 255 then
							Rune_Opaciter2 = 20
						elseif ColiV(X,Y+1) == 200 then
							Carte_Opaciter2 = 20
						end
					elseif direction == 1 then
						Main_Droite2 = 20
						if ColiV(X,Y+1) == 255 then
							Rune_Droite_Opaciter2 = 20
						end
					end
				end
			end
			if love.keyboard.isDown("left")then
	
				if Coli(X-1,Y) ~= 0 then
					X = X-1
					direction = 3
					Possi = 1
				else
					if direction == 2 then
						Main_Gauche2 = 20
						if ColiV(X-1,Y) == 255 then
							Rune_Gauche_Opaciter2 = 20
						end
					elseif direction == 3 then
						Main_Avant2 = 20
						if ColiV(X-1,Y) == 255 then
							Rune_Opaciter2 = 20
						elseif ColiV(X-1,Y) == 200 then
							Carte_Opaciter2 = 20
						end
					elseif direction == 4 then
						Main_Droite2 = 20
						if ColiV(X-1,Y) == 255 then
							Rune_Droite_Opaciter2 = 20
						end
					end
				end
			end
			if love.keyboard.isDown("right")then
	
				if Coli(X+1,Y) ~= 0 then
					X = X+1
					direction = 1
					Possi = 1
				else
					if direction == 4 then
						Main_Gauche2 = 20
						if ColiV(X+1,Y) == 255 then
							Rune_Gauche_Opaciter2 = 20
						end
					elseif direction == 1 then
						Main_Avant2 = 20
						if ColiV(X+1,Y) == 255 then
							Rune_Opaciter2 = 20
						elseif ColiV(X+1,Y) == 200 then
							Carte_Opaciter2 = 20
						end
					elseif direction == 2 then
						Main_Droite2 = 20
						if ColiV(X+1,Y) == 255 then
							Rune_Droite_Opaciter2 = 20
						end
					end
				end
			
			end
			if Possi == 1 then
				Terrain(X,Y)
			end
				VolumeReelBeteMarin = 0
				VolumeReelBete = 0
			for i,h in ipairs(Mechant) do
				Distance = math.sqrt((X-h[1][1])^2+(Y-h[1][2])^2)
				if h[2] == "Terrestre" then
					VolumeReelBete = math.min(math.max(1/(Distance^1.3+0.00001),VolumeReelBete),1)
				elseif h[2] == "Marin" then
					VolumeReelBeteMarin = math.min(math.max(1/(Distance^1.1+0.00001),VolumeReelBeteMarin),1)
				end
				if Distance < 1 then
					if h[2] == "Terrestre" then
						love.audio.play( CrisBete )
						Mort = true
					elseif h[2] == "Marin" then
						love.audio.play( CrisBete )
						Mort = true
					end
					TempoPas = TempoPas+2
				end
			end
		end
		VolumeBete = VolumeBete+0.05*(VolumeReelBete-VolumeBete)
		VolumeBeteMarin = VolumeBeteMarin+0.05*(VolumeReelBeteMarin-VolumeBeteMarin)
		Bete:setVolume( VolumeBete )
		MonstreEau:setVolume( VolumeBeteMarin )
		Coeur:setVolume( math.max(VolumeBeteMarin,VolumeBete)^.9*1.2 )
		Respire:setVolume( math.min(math.max(VolumeBeteMarin,VolumeBete),1) )
		Cave:setVolume( 1-math.min(math.max(VolumeBeteMarin,VolumeBete),1) )
		Pas:setVolume( 1-.7*math.min(math.max(VolumeBeteMarin,VolumeBete)^.9,1) )

	else



	end
	Chrono = Chrono+dt

end
--Graphisme-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function love.draw()

	if play == true then
		--ici
		--love.graphics.draw(Carte,0,0,0,10,10)
		--love.graphics.draw(Hero,X*10,Y*10,0)
		--for i,h in ipairs(Mechant) do
		--	love.graphics.draw(Monstre,h[1][1]*10,h[1][2]*10,0)
		--end
		love.graphics.setColor(255,255,255,Rune_Droite_Opaciter)
		love.graphics.draw(Rune_Droite,0,0,0,love.graphics.getWidth()/Rune_Droite:getWidth(),love.graphics.getHeight()/Rune_Droite:getHeight())
		love.graphics.setColor(255,255,255,Rune_Gauche_Opaciter)
		love.graphics.draw(Rune_Gauche,0,0,0,love.graphics.getWidth()/Rune_Gauche:getWidth(),love.graphics.getHeight()/Rune_Gauche:getHeight())
		love.graphics.setColor(255,255,255,Rune_Opaciter)
		love.graphics.draw(Rune,0,0,0,love.graphics.getWidth()/Rune:getWidth(),love.graphics.getHeight()/Rune:getHeight())
		love.graphics.setColor(255,255,255,120)
		--Carreaux = love.graphics.newImage("App/Elements/Carreaux.png")
		--CarreauxEau = love.graphics.newImage("App/Elements/CarreauxEau.png")
		love.graphics.setColor(255,255,255)
		if Carte_Opaciter > .1 then
			love.graphics.setRenderTarget(ombre)
			wx = 0
			while wx < CartePhysique:getWidth() do
				wy = 1
				while wy < CartePhysique:getHeight()+1 do
					--carte---1=sol--2=eau--3=rune--4=carte--5=entrée--6=sortie
					if carto[wx][wy] == 1
					or carto[wx][wy] == 2 then
						love.graphics.draw(Carreaux,314+wx*love.graphics.getWidth()/CartePhysique:getWidth()*.62,36+(wy)*love.graphics.getHeight()/CartePhysique:getHeight()*.65,0,love.graphics.getWidth()/CartePhysique:getWidth()/Carreaux:getWidth()*1,love.graphics.getHeight()/CartePhysique:getHeight()/Carreaux:getHeight()*1)
					end
					wy = wy+1
				end
				wx = wx+1
			end
			love.graphics.setBlendMode( "subtractive" )
			wx = 0
			while wx < CartePhysique:getWidth() do
				wy = 1
				while wy < CartePhysique:getHeight()+1 do
					--carte---1=sol--2=eau--3=rune--4=carte--5=entrée--6=sortie
					if carto[wx][wy] == 1 then
						love.graphics.draw(CarreauxNoir,318+wx*love.graphics.getWidth()/CartePhysique:getWidth()*.62,40+(wy)*love.graphics.getHeight()/CartePhysique:getHeight()*.65,0,love.graphics.getWidth()/CartePhysique:getWidth()/CarreauxNoir:getWidth()*.7,love.graphics.getHeight()/CartePhysique:getHeight()/CarreauxNoir:getHeight()*.7)
					elseif carto[wx][wy] == 2 then
						love.graphics.draw(CarreauxEau,318+wx*love.graphics.getWidth()/CartePhysique:getWidth()*.62,40+(wy)*love.graphics.getHeight()/CartePhysique:getHeight()*.65,0,love.graphics.getWidth()/CartePhysique:getWidth()/CarreauxEau:getWidth()*.7,love.graphics.getHeight()/CartePhysique:getHeight()/CarreauxEau:getHeight()*.7)
					end
					wy = wy+1
				end
				wx = wx+1
			end
			love.graphics.setBlendMode( "alpha" )
			love.graphics.setRenderTarget()
			love.graphics.setColor(255,255,255,Carte_Opaciter/2)
			love.graphics.draw(Carte,0,0,0,love.graphics.getWidth()/Carte:getWidth(),love.graphics.getHeight()/Carte:getHeight())
			love.graphics.draw(Point,314+X*love.graphics.getWidth()/CartePhysique:getWidth()*.62,36+(Y+1)*love.graphics.getHeight()/CartePhysique:getHeight()*.65,0,love.graphics.getWidth()/CartePhysique:getWidth()/Carreaux:getWidth()*1,love.graphics.getHeight()/CartePhysique:getHeight()/Carreaux:getHeight()*1)
			love.graphics.setColor(255,255,255,Carte_Opaciter/5)
			love.graphics.draw( ombre , 0 , 0 )
		end
		love.graphics.setColor(255,255,255,150+105*math.sin(Chrono))
		love.graphics.draw(Focus,0,0,0,love.graphics.getWidth()/Focus:getWidth(),love.graphics.getHeight()/Focus:getHeight())
		love.graphics.setColor(255,255,255,150-105*math.sin(Chrono))
		love.graphics.draw(Focus2,0,0,0,love.graphics.getWidth()/Focus2:getWidth(),love.graphics.getHeight()/Focus2:getHeight())
		love.graphics.setColor(255,255,255,math.min(255,255*math.max(VolumeBeteMarin,VolumeBete)^.8))
		love.graphics.draw(FocusPeur,0,0,0,love.graphics.getWidth()/FocusPeur:getWidth(),love.graphics.getHeight()/FocusPeur:getHeight())
		love.graphics.setColor(255,255,255,Main_Droite)
		love.graphics.draw(ToucherDroite,0,0,0,love.graphics.getWidth()/ToucherDroite:getWidth(),love.graphics.getHeight()/ToucherDroite:getHeight())
		love.graphics.setColor(255,255,255,Main_Gauche)
		love.graphics.draw(ToucherGauche,0,0,0,love.graphics.getWidth()/ToucherGauche:getWidth(),love.graphics.getHeight()/ToucherGauche:getHeight())
		love.graphics.setColor(255,255,255,Main_Avant)
		love.graphics.draw(ToucherAvant,0,0,0,love.graphics.getWidth()/ToucherAvant:getWidth(),love.graphics.getHeight()/ToucherAvant:getHeight())
		love.graphics.setColor(255,255,255)

	--Titre----------------------------------------------------------------------------------------------------------------------------

	else



	end
		titre_draw(titre_alpha)

	
	

		Over_draw()
end

function titre_draw(alpha)

	love.graphics.setColor(255,255,255,255*alpha)
	love.graphics.draw(Titre,0,0,0,love.graphics.getWidth()/Titre:getWidth(),love.graphics.getHeight()/Titre:getHeight())
	love.graphics.setColor(255,255,255,(150-105*math.sin(Trans))*alpha)
	love.graphics.draw(Titre2,0,0,0,love.graphics.getWidth()/Titre2:getWidth(),love.graphics.getHeight()/Titre2:getHeight())
	love.graphics.setColor(255,255,255,(150-105*math.sin(Chrono))*alpha)
	love.graphics.draw(Ombre,0,0,0,love.graphics.getWidth()/Ombre:getWidth(),love.graphics.getHeight()/Ombre:getHeight())
	Trans = Chrono*2.0
	love.graphics.setFont(font)
	love.graphics.printf("Appuyer sur espace",0,600,love.graphics.getWidth(),'center')

end

function Over_draw ()
	if Over == true then

		love.graphics.setColor(255,255,255)
		love.graphics.draw(Over1,0,0,0,love.graphics.getWidth()/Over1:getWidth(),love.graphics.getHeight()/Over1:getHeight())
		love.graphics.setColor(255,255,255,(150-105*math.sin(Trans)))
		love.graphics.draw(Over2,0,0,0,love.graphics.getWidth()/Over2:getWidth(),love.graphics.getHeight()/Over2:getHeight())
		love.graphics.setColor(255,255,255,(150-105*math.sin(Chrono)))
		love.graphics.draw(Ombre,0,0,0,love.graphics.getWidth()/Ombre:getWidth(),love.graphics.getHeight()/Ombre:getHeight())
		Trans = Chrono*2.0
		love.graphics.setFont(font)
		love.graphics.printf("Enfin, je vois clair!",0,600,love.graphics.getWidth(),'center')
	end
end
