function T.load(T)
	T.app = {{	app = model_humain_terrain_vacant	}}
	T.selectable = true
	T.santer = 500
	T.circle_sise = 15
	T.colision_circle = 15
	T.vrais_nom = "grote"
	T.present = true
end
function T.start(T)
end
function T.creation(T,Q)
	Q.X = math.floor(Q.X/30)*30+15
	Q.Y = math.floor(Q.Y/30)*30+15
	Q.timer = .5
	set_color_b(Q.X,Q.Y,200+Q.equipe)
	if Q.mode == "build" then
		for i,h in ipairs(Q.app) do
			h.app.speed = .6
			h.app.anim = 3
			h.app.nextanim = 3
			h.app.A = 0
		end
	elseif Q.mode == "normal" then
		for i,h in ipairs(Q.app) do
			h.app.speed = 1
			h.app.nextanim = 1
			h.app.A = 0
		end
	end
end
function T.hit(T,Q)
end
function T.mort(T,Q)
	--set_color_b(Q.X,Q.Y,0)
	Q.app[1].app.nextanim = 2
end
function T.ia(T,Q)
end
function T.update(T,Q,dot)
	if Q.etat == "vivant" then
		if Q.mode == "build" then
			if Q.app[1].app.anim == 3
			and Q.app[1].app.frame == 5 then
				Q.mode = "normal"
				Q.app[1].app.nextanim = 1
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
