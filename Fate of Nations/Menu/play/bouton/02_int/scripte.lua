function B.init(B)
	B.X = 282
	B.Y = love.graphics.getHeight()-254


	B.text = ""
end
function B.clic_gauche(B)

end
function B.clic_droit(B)

end



function B.condition()
	if selection ~= nil then
		return(true)
	end
end
