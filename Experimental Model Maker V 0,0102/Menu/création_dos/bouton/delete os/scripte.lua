function B.load(B)				
	B.pos.X = 80
	B.pos.Y = love.graphics.getHeight()-60
	B.Width = 60
	B.Height = 60
	B.popup_text = "Suprimer l'os sélectionné."
end
function B.MR(B,mx,my,bu)
	if bu == "l" then
		for i,h in ipairs(bones.selection) do
			remove_bone(h)
		end
	end
end
function B.drag(B,k,X,Y)
	
end
function B.update(B)

end
function B.condition()
	return(table.maxn(bones.selection)>0)
end
function B.draw()
end





