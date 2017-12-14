function B.init(B)				
	B.X = 500
	B.Y = 600
	B.text = "delete frame"
	anim_os_sel = 0
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y-50
	B.popup.text = "suprimer le frame"
end
function B.clic_gauche(B)
	table.remove(model.model_data.bone[select].tete.anim[model.anim] , model.bone[select].anim_frame )
	model.bone[select].anim_frame = model.bone[select].anim_frame-1
	model_blink_anim(model,model.anim,model.temp)	
end



function B.clic_droit(B)
	
end


function B.update_popup(B)

end
function B.condition()

	return( tool == "anim_os"
		and select ~= 0
		and model.model_data.bone[select].tete.tipe ~= 2
		and model.bone[select].anim_frame ~= 1
		and model.model_data.bone[select].tete.anim[model.anim][model.bone[select].anim_frame].temp == model.temp )

end
