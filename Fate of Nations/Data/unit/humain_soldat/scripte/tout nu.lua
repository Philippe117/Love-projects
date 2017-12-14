function T.load(T)
	T.app = {
			{app = model_humain_soldat}
						}
	T.circle_sise = 10
	T.colision_circle = 8
	T.speed = 5
	T.santer = 20
	T.use_ia = true
	T.attacable = true
	T.build_time = 8
	T.point = 6
	T.present = true
	T.taille = 3
	T.hauteur = 20
	T.range = 0



	T.anim_atack = 3
	T.anim_walk = 2
	T.anim_stand = 1
	T.anim_mort = 4
end
function T.start(T)
end
function T.creation(T,Q)
	Q.origine_X = Q.X
	Q.origine_Y = Q.Y
	for i,h in ipairs(Q.app) do
		h.app.nextanim = T.anim_walk
		h.app.input[1] = 0
	end
	Q.direction = true
	Q.ligne_franchie = false
end
function T.hit(T,Q)
end
function T.stun(T,Q)
	Q.mode = "normal"
	Q.app[1].app.nextanim = T.anim_stand
	Q.app[1].app.speed = 1

	txt = txt+10

end

function T.destun(T,Q)
	
	Q.app[1].app.nextanim = T.anim_walk
	Q.app[1].app.speed = 1

end

function T.mort(T,Q)
	--Q.etat = "mort"
	--txt = txt+1
	Q.app[1].app.nextanim = T.anim_mort
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
					local dist = math.sqrt((Q.X-h.unit.X)^2+(Q.Y-h.unit.Y)^2+(Q.Z-h.unit.Z)^2)-T.colision_circle-h.unit.tipe.colision_circle
					if dist < T.range then
						Q.mode = "combat"
						Q.cible = h.unit
						Q.app[1].app.nextanim = T.anim_atack
						Q.app[1].app.speed = 1
					end
				end
			end
			for i,h in ipairs(equipe[Q.equipe].unit) do
				if h.unit.etat ~= "mort"
				and h.unit.etat ~= "fini"
				and h.unit ~= Q then
					local dist = math.sqrt((Q.X-h.unit.X)^2+(Q.Y-h.unit.Y)^2+(Q.Z-h.unit.Z)^2)
					local ang = math.atan2(h.unit.Y-Q.Y,h.unit.X-Q.X)
					if dist < 8 then
						Q.X = Q.X+.03*((h.unit.X-math.cos(ang)*8)-Q.X)
						Q.Y = Q.Y+.03*((h.unit.Y-math.sin(ang)*8)-Q.Y)
					end
				end
			end
		elseif Q.mode == "combat" then
			for i,h in ipairs(equipe[Q.equipe].unit) do
				if h.unit.etat ~= "mort"
				and h.unit.etat ~= "fini"
				and h.unit ~= Q then
					local dist = math.sqrt((Q.X-h.unit.X)^2+(Q.Y-h.unit.Y)^2+(Q.Z-h.unit.Z)^2)
					local ang = math.atan2(h.unit.Y-Q.Y,h.unit.X-Q.X)
					if dist < 8 then
						Q.X = Q.X+.03*((h.unit.X-math.cos(ang)*8)-Q.X)
						Q.Y = Q.Y+.03*((h.unit.Y-math.sin(ang)*8)-Q.Y)
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
			local dist = math.sqrt((Q.X-Q.cible.X)^2+(Q.Y-Q.cible.Y)^2+(Q.Z-Q.cible.Z)^2)-T.colision_circle-Q.cible.tipe.colision_circle
			local ang = math.atan2(Q.cible.Y-Q.Y,Q.cible.X-Q.X)
			Q.X = Q.X+.01*((Q.cible.X-math.cos(ang)*(T.colision_circle+Q.cible.tipe.colision_circle))-Q.X)
			Q.Y = Q.Y+.01*((Q.cible.Y-math.sin(ang)*(T.colision_circle+Q.cible.tipe.colision_circle))-Q.Y)
			if Q.cible.etat == "mort"
			or Q.cible.etat == "fini"
			or dist > T.range+8 then
				Q.mode = "normal"
				Q.cible = nil
				Q.app[1].app.nextanim = T.anim_walk
			else
				Q.app[1].app.input[1] = ang
				Q.mem , out = frame_pulse(Q.app[1],3,3,Q.mem)
				if out == true then
					unit_hit(Q.cible,10,"normal")
					Q.app[1].app.speed = math.random(80,120)/100

					if math.random(10) > 5 then
						play_son(_G["son_"..T.nom.."_frape"],1,Q.X,Q.Y)
					else
						play_son(_G["son_"..T.nom.."_frape_2"],1,Q.X,Q.Y)
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
		if Q.app[1].app.anim == T.anim_mort
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
