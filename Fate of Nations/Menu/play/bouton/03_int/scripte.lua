function B.init(B)
	B.X = 688
	B.Y = love.graphics.getHeight()-100


	B.text = ""
end
function B.clic_gauche(B)

end
function B.clic_droit(B)

end



function B.condition()
	if selection ~= nil
	and selection.liste ~= nil then
			return(true)
	end
end
