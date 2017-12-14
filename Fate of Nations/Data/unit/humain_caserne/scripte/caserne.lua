function T.load(T)
	T.app = {{	app = model_humain_caserne	}}
	T.selectable = true
	T.attacable = true
	T.ligne = true
	T.santer = 500
	T.circle_sise = 15
	T.colision_circle = 15
	T.vrais_nom = "caserne"
	T.present = true
	T.prix = 80
	T.hauteur = 25
	T.zone_sise = 100

end
function T.start(T)
end
function T.creation(T,Q)
	Q.X = math.floor(Q.X/30)*30+15
	Q.Y = math.floor(Q.Y/30)*30+15
	Q.ligne_X = Q.X
	Q.ligne_Y = Q.Y
	Q.possi_ligne = false
	Q.liste = {}
	Q.pointe = {1,1}
	Q.progression = 0
	set_color_b(Q.X,Q.Y,200+Q.equipe)
	Q.chemin = {}
	if Q.mode == "normal" then
		for i,h in ipairs(Q.app) do
			h.app.speed = 1
			h.app.nextanim = 1
		end
	elseif Q.mode == "build" then
		for i,h in ipairs(Q.app) do
			h.app.speed = .2
			h.app.anim = 3
			h.app.nextanim = 3
		end
	end
	Q.longeur_ligne_total = 0
	Q.longeur_ligne = 0
	Q.longeur_ligne_max = 1000
end
function T.hit(T,Q)
	if Q.santer <= 0 then
		new = unit_create( unit_humain_grote , Q.equipe , Q.X , Q.Y , 0 , Q.sens , "build")
		if selection == Q then
			selectioner(new)
		end
	end
end
function T.mort(T,Q)
	add_chemin(Q , {})
	--set_color_b(Q.X,Q.Y,0)
	Q.app[1].app.nextanim = 2


end
function T.ia(T,Q)
end
function T.update(T,Q,dot)
	if Q.etat == "vivant" then
		if Q.mode == "build" then
			if Q.app[1].app.anim == 3
			and Q.app[1].app.frame == 7 then
				Q.mode = "normal"
				Q.app[1].app.nextanim = 1
				Q.app[1].app.speed = 1
			end
		elseif Q.mode == "normal" then


			if Q.chemin[1] ~= nil then
				Q.progression = Q.progression-dot
				if Q.liste[Q.pointe[1]] ~= nil then
					if Q.progression <= 0 then
						local distr = math.sqrt((Q.X-Q.chemin[1].X)^2+(Q.Y-Q.chemin[1].Y)^2)
						new = unit_create(Q.liste[Q.pointe[1]].unit,Q.equipe,Q.X+(Q.chemin[1].X-Q.X)/distr*25,Q.Y+(Q.chemin[1].Y-Q.Y)/distr*25,Q.Z,1)
						new.chemin = Q.chemin
						new.chef = Q

						if Q.pointe[2] < Q.liste[Q.pointe[1]].nb then
							Q.pointe[2] = Q.pointe[2]+1
						else
							Q.pointe[2] = 1
							if Q.pointe[1] < table.maxn(Q.liste) then
								Q.pointe[1] = Q.pointe[1]+1
							else
								Q.pointe[1] = 1
							end
						end
						Q.progression = Q.liste[Q.pointe[1]].unit.build_time
					end
				end
			end
		end
	elseif Q.etat == "mort" then
		if Q.app[1].app.anim == 2
		and Q.app[1].app.frame == 5 then
			Q.etat = "fini"
		end
	end
	for i,h in ipairs(Q.app) do
		h.app.X = Q.X
		h.app.Y = Q.Y
		--h.app.sx = math.floor(math.sin(crono))*2+1
		--h.app.input[1] = math.floor(math.sin(crono))*math.pi
		--h.app.A = math.sin(crono)
	end
end




