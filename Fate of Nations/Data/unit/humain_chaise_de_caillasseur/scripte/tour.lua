function T.load(T)
	T.app = {{	app = model_humain_chaise_a_caillasseur	}}
	T.range = 120
	T.circle_sise = 15
	T.colision_circle = 15

	T.use_ia = true
	T.attacable = true
	T.santer = 60
	T.present = true
	T.prix = 40
	T.hauteur = 20
	T.zone_sise = 75

	T.anim_atack = 3
	T.anim_stand = 1
	T.anim_mort = 4
	T.anim_build = 2


end
function T.start(T)
end
function T.creation(T,Q)
	Q.X = math.floor(Q.X/30)*30+15
	Q.Y = math.floor(Q.Y/30)*30+15
	set_color_b(Q.X,Q.Y,200+Q.equipe)
	if Q.mode == "normal" then
		for i,h in ipairs(Q.app) do
			h.app.speed = 1
			h.app.anim = T.anim_stand
			h.app.nextanim = T.anim_stand
		end
	elseif Q.mode == "build" then
		for i,h in ipairs(Q.app) do
			h.app.speed = 1
			h.app.anim = T.anim_build
			h.app.nextanim = T.anim_build
		end
	end
	for i,h in ipairs(Q.app) do
		h.app.X = Q.X
		h.app.Y = Q.Y
		h.app.speed = math.random(5,15)/10
	end
	Q.projectile = unit_humain_caillasse
	Q.dist = 100
end
function T.hit(T,Q)
end
function T.mort(T,Q)
	set_color_b(Q.X,Q.Y,0)
	Q.app[1].app.nextanim = T.anim_mort
	Q.app[1].app.speed = 1
	Q.mX = 0
	Q.mY = 0
end
function T.ia(T,Q)
	if Q.mode == "normal" then
		local near = T.range
		for i,h in ipairs(equipe[3-Q.equipe].unit) do
			if h.unit.etat ~= "mort"
			and h.unit.etat ~= "fini"
			and  h.unit.attacable == true then
				local dist = math.sqrt((Q.X-h.unit.X)^2+(Q.Y-h.unit.Y)^2)
				dist = math.sqrt((Q.X-h.unit.X-h.unit.mX*dist)^2+(Q.Y-h.unit.Y-h.unit.mY*dist)^2)
				if dist < near then
					near = dist
					Q.mode = "combat"
					Q.cible = h.unit
					Q.app[1].app.nextanim = T.anim_atack
					Q.app[1].app.speed = 2
				end
			end
		end
	end
end
function T.update(T,Q,dot)
	if Q.etat == "vivant" then
		if Q.mode == "build" then
			Q.app[1].app.speed = Q.app[1].app.speed*.95
			if Q.app[1].app.anim == T.anim_build
			and Q.app[1].app.frame == 33 then
				Q.mode = "normal"
				Q.app[1].app.nextanim = T.anim_stand
				Q.app[1].app.speed = 1
			end
		elseif Q.mode == "combat" then

			local dist = math.sqrt((Q.X-Q.cible.X-Q.cible.mX*Q.dist)^2+(Q.Y-Q.cible.Y-Q.cible.mY*Q.dist)^2)
			Q.dist = dist



			if dist > T.range+50
			or Q.cible.etat == "mort"
			or Q.cible.etat == "fini"
			or Q.cible.attacable == false then
				Q.mode = "normal"
				Q.cible = nil
				Q.app[1].app.nextanim = T.anim_stand
			else

				local ang = math.atan2(Q.cible.Y+Q.cible.mY*dist/Q.projectile.speed*60-Q.Y,Q.cible.X+Q.cible.mX*dist/Q.projectile.speed*60-Q.X)
				Q.app[1].app.input[1] = ang
				Q.mem , out = frame_pulse(Q.app[1],T.anim_atack,7,Q.mem)
				if out == true then


					local new = unit_create(Q.projectile,Q.equipe,Q.X,Q.Y,Q.Z+30,1)

					new.damage = 7

					new.mX = math.cos(ang)*Q.projectile.speed+math.random(-50,50)/10
					new.mY = math.sin(ang)*Q.projectile.speed+math.random(-50,50)/10
					new.mZ = -(new.Z-Q.cible.Z-(Q.cible.tipe.hauteur*.75))/dist*Q.projectile.speed+Q.projectile.poid*dist/Q.projectile.speed*(1/dot/2)+math.random(-60,40)/10
					new.cible = Q.cible


					if math.random(10) > 5 then
						play_son(_G["son_"..T.nom.."_tire"],1,Q.X,Q.Y)
					else
						play_son(_G["son_"..T.nom.."_tire_2"],1,Q.X,Q.Y)
					end


					Q.app[1].app.speed = math.random(80,120)/80


				end
			end
		end
	elseif Q.etat == "mort" then
		if Q.app[1].app.anim == T.anim_mort
		and Q.app[1].app.frame == 13 then
			Q.etat = "fini"
		end
	end
end
