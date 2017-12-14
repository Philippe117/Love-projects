function T.init(T)
end
function T.sprite(T)
	T[4] = {"Stand","Devant","Cliquer"}
end
function T.creation(Nt,sx,sy)
	table.insert( obj , {{sx,sy-.5},{0,0,0,1},Nt,1,1,1,1
								})
	--1={x,y},2={m,n,o},3=type,4=app{Stand,Explose},5=anim,6=frame,7=lastframe,
end
function T.toucher(mi,Q)
end
function T.MP(T,Q,mx,my,bu)
end
function T.MR(T,Q,mx,my,bu)
end
function T.KP(T,Q,k)
	if k == bas
	and Q[5] == 2 then
		love.audio.stop(musi)
		Q[5] = 3
		Q[6] = 1
	end
end
function T.KR(T,Q,k)
end
function T.update(T,Q,I,dot)
	if Q[5] == 1 then
		Q[6] = 	Q[6]+.2
		if Q[6] >= table.maxn(sprite[T[4][Q[5]]])+1 then
			Q[6] = 1
		end
		if math.abs(x-Q[1][1]) < 1
		and math.abs(y-Q[1][2]) < 1 then
			Q[5] = 2
			Q[6] = 1
		end
	elseif Q[5] == 2 then
		Q[6] = 	Q[6]+.2
		if Q[6] >= table.maxn(sprite[T[4][Q[5]]])+1 then
			Q[6] = 1
		end
		if math.abs(x-Q[1][1]) > 1
		or math.abs(y-Q[1][2]) > 1 then
			Q[5] = 1
			Q[6] = 1
		end
	elseif Q[5] == 3 then
		Q[6] = 	Q[6]+.2
		x = x+.05*(Q[1][1]-x)
		if math.floor(Q[6]) == 15 then
			visi = false
		end
		if Q[6] >= table.maxn(sprite[T[4][Q[5]]])+1 then
			love.audio.pause(musi)
			menu.deload(menu)
			niv = nextlevel
			set_menu(menu_victoire)
			menu.load(menu)
		end
	end
end
function T.draw(T,Q)
end

