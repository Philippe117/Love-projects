function draw_liste(list,variable,X,Y)
	for i,h in ipairs(list) do
		love.graphics.print( math.floor(h[variable]) , X,Y+14*(i-1),0,.5)
	end
end
