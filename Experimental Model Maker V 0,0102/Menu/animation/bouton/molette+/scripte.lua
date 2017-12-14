function B.load(B)				
	B.pos.X = PLX
	B.pos.Y = PLY-30
	B.Width = 80
	B.Height = 30
	--bouton_set_text(B,"exit")
	--zero_tool = B.pos.Y+5
	--tool_tag_Y = zero_tool

--	B.popup = {}
--	B.popup.pos.X = B.X+50
--	B.popup.pos.Y = B.Y+50
--	B.popup.text = "quiter le jeux?"
end
function B.MR(B,mx,my,bu)
	if bu == "l" then
		bones.list.moletteC = math.max(bones.list.moletteC-1,0)




	end
end
function B.drag(B,k,X,Y)
	
end
function B.update(B)

end
function B.condition()
	return(true)
end
function B.draw()
end





