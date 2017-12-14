
function T.load(T)
end
function T.start(T)
end
function T.creation(T,Q)
end
function T.stun(T,Q)
end
function T.destun(T,Q)
end
function T.hit(T,Q)
end
function T.select(T,Q)
end
function T.MP(T,Q,bu,mx,my)
	if bu == "l" then
		selo = true
	end
end
function T.MR(T,Q,bu,mx,my)
	if bu == "l" then
		if selo == true then
			selectioner(canselect)
		else
			selo = false
		end
	end
end
function T.KP(T,Q,k)
end
function T.KR(T,Q,k)
end
function T.update_select(T,Q,dot)
end
function T.draw_select_sol(T,Q)
end
function T.draw_select_par_dessu(T,Q)
end
function T.draw_select_interface(T,Q)
end
function T.deselect(T,Q)
end
function T.mort(T,Q)
end
function T.ia(T,Q)
end
function T.update(T,Q,dot)
end


