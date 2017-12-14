function B.load(B)				
	B.pos.X = TLIX+60
	B.pos.Y = TLIY+60
	B.Width = 60
	B.Height = 60

end
function B.MR(B,mx,my,bu)
	if bu == "l" then
		--model_set_anim(model_edit,NC,NC,0)
		model_set_anim(model_edit,NC,mouse.time,0,.1)
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





