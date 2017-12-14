function B.init(B)
	B.X = -1000
	B.Y = -1000
	B.text = ""
end

function B.clic_gauche(B)
	modname = "Model/"..B.text..""

	model_data = load_model("Model/",B.text)

	model = create_model(model_data,{ X = 0 , Y = 0 , A = 0 },1)


	set_menu(menu_main)
	menu.load(menu)




	saving = love.filesystem.newFile("Model/"..B.text.."/scripte.lua")

end
function B.clic_droit(B)
end
function B.condition()
	return(true)
end
