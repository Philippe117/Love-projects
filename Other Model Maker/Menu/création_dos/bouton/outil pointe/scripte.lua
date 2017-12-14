function B.load(B)				
	B.pos.X = 0
	B.pos.Y = 200
	B.Width = 60
	B.Height = 60
	--bouton_set_text(B,"exit")
	zero_tool = B.pos.Y+5
	tool_tag_Y = zero_tool

--	B.popup = {}
--	B.popup.pos.X = B.X+50
--	B.popup.pos.Y = B.Y+50
--	B.popup.text = "quiter le jeux?"
end
function B.MR(B,mx,my,bu)
	if bu == "l" then
		tool_tag_Y = B.pos.Y+5
		mouse.tool = 0
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





