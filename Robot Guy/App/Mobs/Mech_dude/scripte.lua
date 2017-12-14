function T.init(T)
end
function T.sprite(T)
	T[4] = {"Stand","Walk","Mort"}
end
function T.creation(Nt,sx,sy)
	table.insert( obj , {{sx,sy-.5},{0,0,0,1},Nt,1,1,1,1,
								mode = 1,
								x = sx,
								y = sy-.5,
								timermissile = 0,
								timetire = 0,
								vie = 8
								})
	--1={x,y},2={m,n,o},3=type,4=app{Stand,Explose},5=anim,6=frame,7=lastframe,
end
function T.toucher(mi,Q)
	Q.vie = math.max(Q.vie-missilist[mi[4]][2],0)
	if Q.vie == 0 then
		Q[5] = 3
		Q[6] = 1
		Q[7] = 0
	end
end
function T.MP(T,Q,mx,my,bu)
end
function T.MR(T,Q,mx,my,bu)
end
function T.KP(T,Q,k)
end
function T.KR(T,Q,k)
end
function T.update(T,Q,I,dot)
	if Q[5] == 1 then
		Q[6] = 	Q[6]+.1
		if Q[6] >= table.maxn(sprite[T[4][Q[5]]])+1 then
			Q[6] = 1
		end
		Q[2][1] = .9*Q[2][1]+.04*(Q.x-Q[1][1])
		Q[2][2] = .9*Q[2][2]+.04*(Q.y-Q[1][2])
		if math.abs(x-Q[1][1]) < 10
		and math.abs(y-Q[1][2]) < 8 then
			Q[5] = 2
			Q[6] = 1
			Q[7] = 0
		end
	elseif Q[5] == 2 then
		Q[6] = 	Q[6]+.2
		if Q[6] >= table.maxn(sprite[T[4][Q[5]]])+1 then
			Q[6] = 1
		end
		if Q.mode == 1 then
			if math.abs(x-Q.x) > 14
			or math.abs(y-Q.y) > 10
			and vivant == 1 then
				Q.mode = 2
			
			else
				if Q.timermissile < crono then
					creation(Q[1][1],Q[1][2]-.5,unit_Missile_dude)
					Q.timermissile = crono+3
				end
				Q[2][1] = .9*Q[2][1]+.003*(x-5*(x-Q[1][1])/math.abs(x-Q[1][1])-Q[1][1])
				Q[2][2] = .9*Q[2][2]+.002*(y-2.5-Q[1][2])
				Q[2][4] = -(x-Q[1][1]+.001)/math.abs(x-Q[1][1]+.001)
				if math.abs(x-Q[1][1]) > 10
				or math.abs(y-Q[1][2]) > .5 then
					if Q.timetire < crono then
						tire(Q[1][1]-.8*Q[2][4],Q[1][2]+.5,math.atan(.2*(y-Q[1][2])/math.abs(x-Q[1][1])),-Q[2][4],false,1)
						Q.timetire = crono+.8
					end
				end
			end
		elseif Q.mode == 2 then
			if math.abs(Q.x-Q[1][1]) < 1
			and math.abs(Q.y-Q[1][2]) < 1 then
				Q[5] = 1
				Q[6] = 1
				Q[7] = 0
				Q.mode = 1
			end
			Q[2][1] = .9*Q[2][1]+.004*(Q.x-Q[1][1])
			Q[2][2] = .9*Q[2][2]+.004*(Q.y-Q[1][2])
			Q[2][4] = -(x-Q[1][1]+.001)/math.abs(x-Q[1][1]+.001)
		end
		if coli(Q[1][1]+1,Q[1][2]) >= 150 then
			Q[1][1] = math.floor(Q[1][1])
			Q[2][1] = math.min(0,Q[2][1])
		end
		if coli(Q[1][1]-1,Q[1][2]) >= 150 then
			Q[1][1] = math.floor(Q[1][1]+1)
			Q[2][1] = math.max(0,Q[2][1])
		end
		if coli(Q[1][1],Q[1][2]+1) >= 150 then
			Q[1][2] = math.floor(Q[1][2])
			Q[2][2] = math.min(0,Q[2][2])
		end
		if coli(Q[1][1],Q[1][2]-1) >= 150 then
			Q[1][2] = math.floor(Q[1][2]+1)
			Q[2][2] = math.max(0,Q[2][2])
		end
		cartog[math.max(1,math.min(table.maxn(cartog),math.floor(Q[1][1])))][math.max(1,math.min(table.maxn(cartog[1]),math.floor(Q[1][2])))] = I
	elseif Q[5] == 3 then
		Q[6] = 	Q[6]+.2
		if Q[6] >= table.maxn(sprite[T[4][Q[5]]])+1 then
			table.remove(obj,I)
		end
	end
end
function T.draw(T,Q)
	if Q[5] == 2
	and Q.mode == 1 then
		love.graphics.setFont( chifre_X )
		love.graphics.print( "boss:"..Q.vie.."" , 800 , 80 )
	end
end

