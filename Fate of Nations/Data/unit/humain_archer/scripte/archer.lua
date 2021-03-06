function T.load(T)
	T.app = {
			{app = model_humain_archer}
						}
	T.circle_sise = 10
	T.colision_circle = 8
	T.speed = 4
	T.santer = 30
	T.use_ia = true
	T.attacable = true
	T.build_time = 6
	T.point = 6
	T.present = true
	T.taille = 3
	T.range = 150
	T.hauteur = 20
end
function T.start(T)
end
function T.creation(T,Q)
	Q.origine_X = Q.X
	Q.origine_Y = Q.Y
	for i,h in ipairs(Q.app) do
		h.app.nextanim = 2
		h.app.input[1] = 0
	end
	Q.direction = true
	Q.ligne_franchie = false

	Q.projectile = unit_humain_fleche
	Q.dist = 100

end
function T.hit(T,Q)
end
function T.stun(T,Q)
	Q.mode = "normal"
	Q.app[1].app.nextanim = 1
	Q.app[1].app.speed = 1

end
function T.destun(T,Q)
	
	Q.app[1].app.nextanim = 2
	Q.app[1].app.speed = 1

end
function T.mort(T,Q)
	--Q.etat = "mort"
	--txt = txt+1
	Q.app[1].app.nextanim = 4
	Q.app[1].app.speed = 1
	play_son(_G["son_"..T.nom.."_mort"],1,Q.X,Q.Y)

end
function T.ia(T,Q)
	if Q.etat == "vivant" then
		if Q.mode == "normal" then
			for i,h in ipairs(equipe[3-Q.equipe].unit) do
				if h.unit.etat ~= "mort"
				and h.unit.etat ~= "fini"
				and h.unit.attacable == true then

					local dist = math.sqrt((Q.X-h.unit.X)^2+(Q.Y-h.unit.Y)^2)
					dist = math.sqrt((Q.X-h.unit.X-h.unit.mX*dist)^2+(Q.Y-h.unit.Y-h.unit.mY*dist)^2)
					if dist < T.range then
						Q.mode = "combat"
						Q.cible = h.unit
						Q.app[1].app.nextanim = 3

						Q.app[1].app.speed = math.random(160,200)/100
					end
				end
			end
			for i,h in ipairs(equipe[Q.equipe].unit) do
				if h.unit.etat ~= "mort"
				and h.unit.etat ~= "fini"
				and h.unit ~= Q then
					local dist = math.sqrt((Q.X-h.unit.X)^2+(Q.Y-h.unit.Y)^2)
					local ang = math.atan2(h.unit.Y-Q.Y,h.unit.X-Q.X)
					if dist < 8 then
						local wx = Q.X+.03*((h.unit.X-math.cos(ang)*8)-Q.X)
						local wy = Q.Y+.03*((h.unit.Y-math.sin(ang)*8)-Q.Y)
						local col = colibl( wx , wy ) 
						if col ~= 200+Q.equipe
						and col ~= 200 then
							Q.X = wx
							Q.Y = wy
						end

					end
				end
			end
		elseif Q.mode == "combat" then
			for i,h in ipairs(equipe[Q.equipe].unit) do
				if h.unit.etat ~= "mort"
				and h.unit.etat ~= "fini"
				and h.unit ~= Q then
					local dist = math.sqrt((Q.X-h.unit.X)^2+(Q.Y-h.unit.Y)^2)
					local ang = math.atan2(h.unit.Y-Q.Y,h.unit.X-Q.X)
					if dist < 8 then
						local wx = Q.X+.03*((h.unit.X-math.cos(ang)*8)-Q.X)
						local wy = Q.Y+.03*((h.unit.Y-math.sin(ang)*8)-Q.Y)
						local col = colibl( wx , wy ) 
						if col ~= 200+Q.equipe
						and col ~= 200 then
							Q.X = wx
							Q.Y = wy
						end
					end
				end
			end
		end
	end
end
function T.update(T,Q,dot)
	if Q.etat == "vivant" then
		if Q.ligne_franchie == false then
			if Q.equipe == 1 then
				if Q.X > M.Width then
					Q.ligne_franchie = true
					equipe[Q.equipe].point = equipe[Q.equipe].point+T.point
					Q.chemin = {{X = M.Width+200 , Y = Q.Y}}
					Q.attacable = false
					Q.nextpoint = 1
					Q.can_die = false
					Q.ia.etat = "fini"
				end
			elseif Q.equipe == 2 then
				if Q.X < 0 then
					Q.ligne_franchie = true
					equipe[Q.equipe].point = equipe[Q.equipe].point+T.point
					Q.chemin = {{X = -200 , Y = Q.Y}}
					Q.attacable = false
					Q.nextpoint = 1
					Q.can_die = false
					Q.ia.etat = "fini"
				end
			end
		else
			if Q.equipe == 1 then
				if Q.X > M.Width+110 then
					Q.etat = "fini"
				end
			elseif Q.equipe == 2 then
				if Q.X < -110 then
					Q.etat = "fini"
				end
			end
		end
		if Q.mode == "normal" then
			if Q.chemin[Q.nextpoint] ~= nil then
				if Q.direction == true then

					local dist = math.sqrt((Q.X-Q.chemin[Q.nextpoint].X)^2+(Q.Y-Q.chemin[Q.nextpoint].Y)^2)
					local col = colibl(	Q.X ,
								Q.Y )
					if col ~= 200+Q.equipe
					and col ~= 200 then


						if dist > Q.speed*dot+10 then
							Q.mX = .8*Q.mX+Q.speed*(Q.chemin[Q.nextpoint].X-Q.X)/dist*dot
							Q.mY = .8*Q.mY+Q.speed*(Q.chemin[Q.nextpoint].Y-Q.Y)/dist*dot
						else
							Q.nextpoint = Q.nextpoint+1
						end
					else
						Q.direction = false

						local liste = {}
						w = 1
						while w < Q.nextpoint do
							table.insert(liste,Q.chef.chemin[w])
							w = w+1
						end
						table.insert(liste,{X = Q.X-5*(Q.chemin[Q.nextpoint].X-Q.X)/dist , Y = Q.Y-5*(Q.chemin[Q.nextpoint].Y-Q.Y)/dist})


						add_chemin(Q.chef , liste)

						--Q.chef.chemin[Q.nextpoint] = nil
						Q.nextpoint = Q.nextpoint-1

					end
				else
					local dist = math.sqrt((Q.X-Q.chemin[Q.nextpoint].X)^2+(Q.Y-Q.chemin[Q.nextpoint].Y)^2)
					if dist > Q.speed*dot+10 then
						Q.mX = .8*Q.mX+Q.speed*(Q.chemin[Q.nextpoint].X-Q.X)/dist*dot
						Q.mY = .8*Q.mY+Q.speed*(Q.chemin[Q.nextpoint].Y-Q.Y)/dist*dot
					else
						Q.nextpoint = Q.nextpoint-1
					end
				end
			else
				if Q.direction == true then
					--Q.etat = "fini"
					Q.direction = false
					Q.nextpoint = Q.nextpoint-2
				else
					local dist = math.sqrt((Q.X-Q.origine_X)^2+(Q.Y-Q.origine_Y)^2)
					if dist > Q.speed*dot+10 then
						Q.mX = .8*Q.mX+Q.speed*(Q.origine_X-Q.X)/dist*dot
						Q.mY = .8*Q.mY+Q.speed*(Q.origine_Y-Q.Y)/dist*dot
					else
						Q.etat = "fini"
						Q.ia.etat = "fini"
					end
				end
			end
			local vitesse = math.sqrt(Q.mX^2+Q.mY^2)
			Q.app[1].app.speed = vitesse*3
			if Q.mX < 0 then
				Q.sens = -1
			elseif Q.mX > 0 then
				Q.sens = 1
			end
		elseif Q.mode == "combat" then
			Q.mX = .9*Q.mX
			Q.mY = .9*Q.mY
			if Q.X < Q.cible.X then
				Q.sens = 1
			elseif Q.X > Q.cible.X then
				Q.sens = -1
			end
			local dist = math.sqrt((Q.X-Q.cible.X-Q.cible.mX*Q.dist)^2+(Q.Y-Q.cible.Y-Q.cible.mY*Q.dist)^2)
			Q.dist = dist
			local ang = math.atan2(Q.cible.Y+Q.cible.mY*dist/Q.projectile.speed*60-Q.Y,Q.cible.X+Q.cible.mX*dist/Q.projectile.speed*60-Q.X)

			if Q.cible.etat == "mort"
			or Q.cible.etat == "fini"
			or dist > T.range+30 then
				Q.mode = "normal"
				Q.cible = nil
				Q.app[1].app.nextanim = 2
			else
				Q.app[1].app.input[1] = ang
				Q.mem , out = frame_pulse(Q.app[1],3,6,Q.mem)
				if out == true then
					--unit_hit(Q.cible,10,"normal")

					local new = unit_create(Q.projectile,Q.equipe,Q.X,Q.Y,Q.Z+18,1)

					new.damage = 4

					new.mX = math.cos(ang)*Q.projectile.speed+math.random(-50,50)/10
					new.mY = math.sin(ang)*Q.projectile.speed+math.random(-50,50)/10
					new.mZ = -(new.Z-Q.cible.Z-(Q.cible.tipe.hauteur*.75))/dist*Q.projectile.speed+Q.projectile.poid*dist/Q.projectile.speed*(1/dot/2)+math.random(-60,40)/10
					new.cible = Q.cible



					Q.app[1].app.speed = math.random(160,200)/100

					if math.random(10) > 5 then
						play_son(_G["son_"..T.nom.."_tire"],1,Q.X,Q.Y)
					else
						play_son(_G["son_"..T.nom.."_tire_2"],1,Q.X,Q.Y)
					end



				end
			end
		end

		if Q.Z > 0 then
			Q.mZ = Q.mZ-T.poid*dot
		else
			Q.Z = 0
			Q.mZ = math.max(Q.mZ,0)
		end
		Q.A = Q.A+.1*angle(Q.A,0)
		Q.sc = Q.sc+.1*(1-Q.sc)

	elseif Q.etat == "stuned" then
		Q.mX = .9*Q.mX
		Q.mY = .9*Q.mY
		Q.app[1].app.input[1] = Q.app[1].app.input[1]+.1*angle(Q.app[1].app.input[1],Q.A)

	elseif Q.etat == "mort" then
		Q.mX = .9*Q.mX
		Q.mY = .9*Q.mY
		if Q.app[1].app.anim == 4
		and Q.app[1].app.frame == 10 then
			Q.etat = "fini"
		end

		if Q.Z > 0 then
			Q.mZ = Q.mZ-T.poid*dot
		else
			Q.Z = 0
			Q.mZ = math.max(Q.mZ,0)
		end
		Q.A = Q.A+.1*angle(Q.A,0)
		Q.sc = Q.sc+.1*(1-Q.sc)
	end
	Q.X = Q.X+Q.mX
	Q.Y = Q.Y+Q.mY
	Q.Z = Q.Z+Q.mZ
	for i,h in ipairs(Q.app) do
		--h.app.speed = math.sin(crono)
		h.app.X = Q.X
		h.app.Y = Q.Y
		h.app.Z = Q.Z
		h.app.sx = Q.sens
		
		h.app.A = Q.A
		h.app.alpha = Q.alpha
		h.app.sc = Q.sc
		--h.app.sx = math.floor(math.sin(crono))*2+1
		--h.app.input[1] = math.floor(math.sin(crono))*math.pi
		--h.app.A = Q.A
	end
end
