function T.load(T)
	T.app = {{	app = model_humain_tour	}}
	T.range = 150
	T.circle_sise = 15
	T.colision_circle = 15

	T.use_ia = true
	T.attacable = true
	T.santer = 80
	T.present = true
	T.prix = 50
	T.hauteur = 20
	T.zone_sise = 100

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
			h.app.anim = 1
			h.app.nextanim = 1
		end
	elseif Q.mode == "build" then
		for i,h in ipairs(Q.app) do
			h.app.speed = 1
			h.app.anim = 4
			h.app.nextanim = 4
		end
	end
	for i,h in ipairs(Q.app) do
		h.app.X = Q.X
		h.app.Y = Q.Y
		h.app.speed = math.random(5,15)/10
	end
	Q.projectile = unit_humain_fleche
	Q.dist = 100
end
function T.hit(T,Q)
end
function T.mort(T,Q)
	set_color_b(Q.X,Q.Y,0)
	Q.app[1].app.nextanim = 3
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
					Q.app[1].app.nextanim = 2
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
			if Q.app[1].app.anim == 4
			and Q.app[1].app.frame == 15 then
				Q.mode = "normal"
				Q.app[1].app.nextanim = 1
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
				Q.app[1].app.nextanim = 1
			else

				Q.mem , out = frame_pulse(Q.app[1],2,2,Q.mem)
				if out == true then
					local ang = math.atan2(Q.cible.Y+Q.cible.mY*dist/Q.projectile.speed*60-Q.Y,Q.cible.X+Q.cible.mX*dist/Q.projectile.speed*60-Q.X)

					local new = unit_create(Q.projectile,Q.equipe,Q.X,Q.Y,Q.Z+30,1)

					new.damage = 10

					new.mX = math.cos(ang)*Q.projectile.speed+math.random(-50,50)/10
					new.mY = math.sin(ang)*Q.projectile.speed+math.random(-50,50)/10
					new.mZ = -(new.Z-Q.cible.Z-(Q.cible.tipe.hauteur*.75))/dist*Q.projectile.speed+Q.projectile.poid*dist/Q.projectile.speed*(1/dot/2)+math.random(-60,40)/10
					new.cible = Q.cible


					if math.random(10) > 5 then
						play_son(_G["son_"..T.nom.."_tire"],1,Q.X,Q.Y)
						Q.projectile = unit_humain_fleche
					else
						play_son(_G["son_"..T.nom.."_tire_2"],1,Q.X,Q.Y)
						Q.projectile = unit_lance
					end
					Q.app[1].app.speed = math.random(80,120)/80


				end
			end
		end
	elseif Q.etat == "mort" then
		if Q.app[1].app.anim == 3
		and Q.app[1].app.frame == 8 then
			Q.etat = "fini"
		end
	end
end
