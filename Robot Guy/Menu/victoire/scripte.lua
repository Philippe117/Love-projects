function I.load(I)
	sourmode = 1
end
function I.deload(I)
end
function I.MP(I,mx,my,bu)
end
function I.MR(I,mx,my,bu)
end
function I.KP(I,k)
end
function I.KR(I,k)
end
function I.update(I,dot)
end
function I.draw(I)
	love.graphics.setColor(255,255,255)
	love.graphics.setFont( letre_XX )
	love.graphics.print( "Score" , love.graphics.getWidth()/2-130 , 96 )
	--love.graphics.setFont( letre_X )
	--love.graphics.print( "NB de point" , love.graphics.getWidth()/2-200 , 430 )
	love.graphics.setFont( chifre_X )
	love.graphics.printf( ""..point.." pts." , love.graphics.getWidth()/2-150 , 380 ,300, "center" )
end

