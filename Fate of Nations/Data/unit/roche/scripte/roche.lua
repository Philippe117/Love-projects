function T.load(T)
	T.app = {{	app = model_prop_roche	}}



end
function T.start(T)


end
function T.creation(T,Q)
	Q.X = math.floor(Q.X/30)*30+15
	Q.Y = math.floor(Q.Y/30)*30+15

	set_color_b(Q.X,Q.Y,200)

	for i,h in ipairs(Q.app) do
		h.app.X = Q.X
		h.app.Y = Q.Y
	end
end
function T.hit(T,Q)


end
function T.mort(T,Q)


end
function T.ia(T,Q)


end
function T.update(T,Q,dot)


end
