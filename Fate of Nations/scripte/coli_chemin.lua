function colichemin(x1,y1,x2,y2,team,long)
	local ex = x2
	local ey = y2

	local possi = true
	local erg = 0
	local dist = math.sqrt((x2-x1)^2+(y2-y1)^2)


	if x1 < 0 then
		
		erg = dist+100
		ex = -15
		ey = y1
		possi = false

	elseif x1 > M.Width then

		erg = dist+100
		ex = M.Width+15
		ey = y1
		possi = false

	else

		while erg < math.min(dist+12,long) do

			if x1+(x2-x1)/dist*erg < 0 then
				erg = dist+100
				ex = -15
				ey = y2
			elseif x1+(x2-x1)/dist*erg > M.Width then
				erg = dist+100
				ex = M.Width+15
				ey = y2


			else
				local col = colibl(	x1+(x2-x1)/dist*erg+12 ,
							y1+(y2-y1)/dist*erg+12 )
				if col == 200+team
				or col == 200 then

					possi = false
				end
				if possi == true then
					local col = colibl(	x1+(x2-x1)/dist*erg-12 ,
								y1+(y2-y1)/dist*erg+12 )
					if col == 200+team
					or col == 200 then

						possi = false
					end
				end
				if possi == true then
					local col = colibl(	x1+(x2-x1)/dist*erg-12 ,
								y1+(y2-y1)/dist*erg-12 )
					if col == 200+team
					or col == 200 then

						possi = false
					end
				end
				if possi == true then
					local col = colibl(	x1+(x2-x1)/dist*erg-12 ,
								y1+(y2-y1)/dist*erg-12 )
					if col == 200+team
					or col == 200 then

						possi = false

					end
				end


				if possi == false then

					erg = dist+100
				else
					ex = x1+(x2-x1)/dist*(erg-10)
					ey = y1+(y2-y1)/dist*(erg-10)

				end
			end

			erg = erg+10

		end

	end



	return possi,ex,ey
end







