local new = new_function(fonction,"load",12)
function new.F()
	point1 = load_image("point")
	point2 = load_image("point2")
	plaque = load_image("plaque2")
	--os1 = load_image("os")
	--os2 = load_image("os2")
	bones = {}
	bones.selectable = add_list_to_collect_routine({},"selectable",true)
	bones.preselection = add_list_to_collect_routine({},"preselected",true,bone_dans_le_carre)
	bones.selection = add_list_to_collect_routine({},"selected",true)
	bones.nomdos = 1

	bones.list = {}
	bones.list.molette = 0
	bones.list.moletteC = 0
	bones.list.X = 0
	bones.list.Y = 410
	bones.list.W = 64
	bones.list.H = 200

end
function make_model_selectable(model)
	for i,h in ipairs(model.bone) do
		h.chef = h
		h.tete.chef = h
		h.id = i
		h.tete.id = i

		h.tete.amIselectable = bone_amIselectable
		h.tete.MR = bone_MR
		h.tete.MP = bone_MP
		h.anim = {}

		h.point = {}
		h.point.MR = bone_point_MR
		h.point.MP = bone_point_MP
		h.point.id = i
		h.point.chef = h
		h.point.amIselectable = bone_point_amIselectable

		add_data_to_a_list(mouse.selectable,h.point)
		add_data_to_a_list(mouse.selectable,h.tete)
		add_data_to_a_list(bones.selectable,h)

		for e,g in ipairs(model.data.anim) do
			h.anim[e] = g
		end
	end
end
function add_bone_to_selectable(bone)
	bone.point = {}
	bone.chef = bone
	for i,h in ipairs(bone.chef.bone) do
		h.tete.chef = h
		h.id = i
		h.tete.id = i
		h.point.id = i
		h.point.chef = h
	end

	bone.tete.amIselectable = bone_amIselectable
	bone.tete.MR = bone_MR
	bone.tete.MP = bone_MP

	bone.point.MR = bone_point_MR
	bone.point.MP = bone_point_MP
	bone.point.amIselectable = bone_point_amIselectable

	add_data_to_a_list(bones.selectable,bone)
	add_data_to_a_list(mouse.selectable,bone.point)
	add_data_to_a_list(mouse.selectable,bone.tete)

	bone.anim = {}
	for e,g in ipairs(bone.chef.data.anim) do
		bone.anim[e] = g
	end
end

function remove_bone(bone)
	local id = bone.id
	bone.data.eta = false
	bone.eta = false
	for i,h in ipairs(bone.maitre.bone) do
		if h.id > id then
			h.id = h.id-1
			h.point.id = h.id
		end
		if h.data.base.tipe == 1 then

			if h.data.base.pos > id then
				h.data.base.pos = h.data.base.pos-1
			elseif h.data.base.pos == id then
				h.data.base.tipe = 0
				h.data.base.pos = {X=h.base.pos.X,Y=h.base.pos.Y}
				h.base.eta = false
				h.base = {}
				h.base.pos = {X=h.data.base.pos.X,Y=h.data.base.pos.Y}
				h.base.pos.vec = {}
				h.base.pos.vec.D = math.atan2( h.base.pos.Y , h.base.pos.X )
				h.base.pos.vec.L = math.sqrt((h.base.pos.X)^2+(h.base.pos.Y)^2)
				h.base.vec = {}
				h.base.vec.D = 0
				h.base.vec.L = 1
				h.base.L = 1
				h.base.pos.scale = 1


				h.base.chef = h.chef
				h.base.amIselectable = bone_amIselectable
				h.base.MR = bone_MR
				h.base.MP = bone_MP
				add_data_to_a_list(mouse.selectable,h.base)
			end


		end
		if h.data.tete.tipe == 2 then
			if h.data.tete.pos > id then
				h.data.tete.pos = h.data.tete.pos-1


			elseif h.data.tete.pos == id then

				h.data.tete.tipe = 0
				h.data.tete.pos = {X=h.tete.pos.X,Y=h.tete.pos.Y}
				h.tete.eta = false
				h.tete = {}
				h.tete.pos = {X=h.data.tete.pos.X,Y=h.data.tete.pos.Y}

				h.old_pos = {}
				h.old_pos.X = h.data.tete.pos.X
				h.old_pos.Y = h.data.tete.pos.Y

				h.tete.vec = {}
				h.tete.vec.D = math.atan2( h.tete.pos.Y-h.base.pos.Y , h.tete.pos.X-h.base.pos.X )
				h.tete.vec.L = math.sqrt((h.tete.pos.X-h.base.pos.X)^2+(h.tete.pos.Y-h.base.pos.Y)^2)
				h.tete.pos.vec = {}
				h.tete.pos.vec.D = math.atan2( h.tete.pos.Y , h.tete.pos.X )
				h.tete.pos.vec.L = math.sqrt((h.tete.pos.X)^2+(h.tete.pos.Y)^2)


				h.tete.chef = h.chef
				h.tete.amIselectable = bone_amIselectable
				h.tete.MR = bone_MR
				h.tete.MP = bone_MP
				add_data_to_a_list(mouse.selectable,h.tete)
			end
		end
		h.base.id = h.id
		h.tete.id = h.id
	end

	for i,h in ipairs(bone.maitre.data.anim) do
		table.remove(h.bone,id)
	end
	table.remove(bone.maitre.data.bone,id)
	table.remove(bone.maitre.bone,id)
	garbage_collect(bones.selectable,"selectable")
	--garbage_collect(bones.selected,"selected")
end










function bone_MP(h,mx,my,bu)
	if mouse.tool == "create_os_coord" or mouse.tool == "create_os_vector" then
		if bu == "l" then
			mouse.eta = "creating_os"
			mouse.base = { tipe = 1}
			mouse.base.pos = h.pos
			mouse.base.vec = h.vec
			mouse.base.posid = h.id
		end
	elseif mouse.tool == 0 then
		if bu == "l" then
			mouse.eta = "clicking_os"
			mouse.T = chrono+74
			mouse.oX = mouse.pos.X
			mouse.oY = mouse.pos.Y
		end
	end
end

function bone_MR(h,mx,my,bu)
	if mouse.eta == "clicking_os" then
		if mouse.tool == 0 then
			if bu == "l" then
				if not love.keyboard.isDown( "lshift" ) and not love.keyboard.isDown( "rshift" ) then
					clear_list(bones.selection)
				end
				if h.chef.eta.selected then
					h.chef.eta.selected = false
				else
					add_data_to_a_list(bones.selection,h.chef)
				end
			end
		end
	elseif mouse.eta == "creating_os" then
		if bu == "l" then
			mouse.eta = 1
			add_bone_to_selectable(create_bone(model_edit,create_new_bone(model_data_edit,mouse.base,{tipe=2,pos=h.id})))
			if not love.keyboard.isDown( "lshift" ) and not love.keyboard.isDown( "rshift" ) then
				mouse.tool = 0
				tool_tag_Y = zero_tool
			end

		end
	end
end
function create_new_bone(model_data,base,tete)
	rapporter_erreur("ajout d'un novel os à "..model_data.nom.."")
	local new = {}
	new.nom = "new bone #"..bones.nomdos..""
	bones.nomdos = bones.nomdos+1
	if base.tipe == 0 then
		new.base = base
	elseif base.tipe == 1 then
		new.base = {}
		new.base.pos = base.posid
		new.base.tipe = 1
	end
	new.tete = tete
--	new.tete.pos = {}
--	new.tete.pos.X = tete.pos.X or base.pos.X+new.tete.vec.L*math.cos( new.tete.vec.D )
--	new.tete.pos.Y = tete.pos.Y or base.pos.Y+new.tete.vec.L*math.sin( new.tete.vec.D )
	table.insert(model_data.bone,new)
	for i,h in ipairs(model_data.anim) do
		table.insert(h.bone,{})
	end
	add_historique(model_edit)
	return new
end
function bone_dans_le_carre(bone)
	local mX , mY = pos_screen_to_world(love.mouse.getX(),love.mouse.getY(),0)
	return math.abs((mX+mouse.selzX)/2-bone.tX) < math.abs(mX-mouse.selzX)/2 and math.abs((mY+mouse.selzY)/2-bone.tY) < math.abs(mY-mouse.selzY)/2
end
function bone_amIselectable(tete)
	local mX , mY = pos_screen_to_world(love.mouse.getX(),love.mouse.getY(),0)
	local rep = (tete.chef.tX-mX)^2+(tete.chef.tY-mY)^2

	return rep < math.max(1,6/ratio(0)/camera.zoom)^2 , rep
end

function bone_point_amIselectable(point)
	local mY = bones.list.Y+(point.id-bones.list.molette)*20
	txt2 = bones.list.molette
	return love.mouse.getX() < bones.list.X+bones.list.W+10 and love.mouse.getY() < mY+10 and love.mouse.getY() > mY-10 and point.id-bones.list.molette >= 0 and point.id-bones.list.molette <= math.floor(bones.list.H/20) , 0

end




function bone_point_MP(h,mx,my,bu)
	h.pointed = nil
	return bone_MP(h.chef.tete,mx,my,bu)
end
function bone_point_MR(h,mx,my,bu)
	h.pointed = nil
	return bone_MR(h.chef.tete,mx,my,bu)
end


local new = new_function(fonction,"update",0)
function new.F(dot)
txt2 = ratio(0)
	if mouse.eta == "selz" then
		clear_list(bones.preselection)
		election_in_a_list(bones.selectable,bones.preselection,bone_dans_le_carre)
	end
	for i,h in ipairs(bones.selectable) do
		local dist = math.sqrt((h.tete.pos.X-h.tete.chef.base.pos.X)^2+(h.tete.pos.Y-h.tete.chef.base.pos.Y)^2)
		h.tX = h.chef.tete.pos.X+(h.chef.base.pos.X-h.chef.tete.pos.X)/dist
		h.tY = h.chef.tete.pos.Y+(h.chef.base.pos.Y-h.chef.tete.pos.Y)/dist
	end
	bones.list.molette = bones.list.molette+math.max(-.1,math.min(.1,(bones.list.moletteC-bones.list.molette)/2))
end
local new = new_function(fonction,"MR",0)
function new.F(mx,my,bu)
	if mouse.eta == "selz" then
		if bu == "l" then
			mouse.eta = 1
			for i,h in ipairs(bones.preselection) do
				h.eta.preselection = nil
			end

			if not love.keyboard.isDown( "lshift" ) and not love.keyboard.isDown( "rshift" ) then
				copy_list( bones.preselection , bones.selection )
				clear_list( bones.preselection )
			else
				add_list( bones.preselection , bones.selection )
				clear_list( bones.preselection )
			end

		end
	end
end
function draw_bone(bone,X,Y,A,sx,sy)
	local r, g, b, al = love.graphics.getColor( )
	local X = X or 0
	local Y = Y or 0
	local D = A or 0
	local scale = sx or 1
	local ang1 = bone.base.pos.vec.D+D
	local X1 = X+bone.base.pos.vec.L*math.cos(ang1)*scale
	local Y1 = Y+bone.base.pos.vec.L*math.sin(ang1)*scale
	local ang2 = bone.tete.pos.vec.D+D
	local X2 = X+bone.tete.pos.vec.L*math.cos(ang2)*scale
	local Y2 = Y+bone.tete.pos.vec.L*math.sin(ang2)*scale
	local A = D+bone.tete.vec.D
	if get_eta(bone,"selected") then
		if bone.tete.pointed or get_eta(bone,"preselected") or bone.point.pointed then
			love.graphics.setColor(150,255,40)
		else
			love.graphics.setColor(60,200,40)
		end
	else
		if bone.tete.pointed or get_eta(bone,"preselected") or bone.point.pointed then
			love.graphics.setColor(250,230,0)
		else
			love.graphics.setColor(255,255,255)
		end
	end
	love.graphics.setLine(math.max(4,scale*.8), "smooth")
	love.graphics.line( X1, Y1, (X1+X2)/2, (Y1+Y2)/2 )
	love.graphics.setLine(math.max(1.5,scale*.4), "smooth")
	love.graphics.line( (X1+X2)/2, (Y1+Y2)/2 , X2, Y2 )
	love.graphics.setColor(r,g,b,al)
end
function draw_bone2(bone,X,Y,A,sx,sy)
	local r, g, b, al = love.graphics.getColor( )
	local X = X or 0
	local Y = Y or 0
	local D = A or 0
	local scale = sx or 1
	local ang1 = bone.base.pos.vec.D+D
	local X1 = X+bone.base.pos.vec.L*math.cos(ang1)*scale
	local Y1 = Y+bone.base.pos.vec.L*math.sin(ang1)*scale
	local ang2 = bone.tete.pos.vec.D+D
	local X2 = X+bone.tete.pos.vec.L*math.cos(ang2)*scale
	local Y2 = Y+bone.tete.pos.vec.L*math.sin(ang2)*scale
	if get_eta(bone,"selected") then
		if bone.tete.pointed or get_eta(bone,"preselected") or bone.point.pointed then
			love.graphics.setColor(150,255,40)
		else
			love.graphics.setColor(60,200,40)
		end
	else
		if bone.tete.pointed or get_eta(bone,"preselected") or bone.point.pointed then
			love.graphics.setColor(250,230,0)
		else
			love.graphics.setColor(255,255,255)
		end
	end
	love.graphics.draw(point1,X2,Y2,0,math.max(.2,scale*.025),math.max(.2,scale*.025),10,10)
	local dist = math.sqrt((X1-X2)^2+(Y1-Y2)^2)
	local eX = X2+(X1-X2)/dist*scale
	local eY = Y2+(Y1-Y2)/dist*scale
	love.graphics.draw(point2,eX,eY,A,math.max(.4,scale*.05),math.max(.4,scale*.05),10,10)
	love.graphics.setColor(r,g,b,al)
end


function draw_selection()
	local X = X or 0
	local Y = Y or 0
	local r, g, b, al = love.graphics.getColor( )
	--for i,h in ipairs(bones.selectable) do
	local mol = math.floor(bones.list.molette+.5)+1
	for i = math.max(1,mol) , math.min(math.floor(bones.list.H/20)+mol-1,table.maxn(bones.selectable)) do
		
		local h = bones.selectable[i]

		local X1 = bones.list.X+bones.list.W
		local Y1 = bones.list.Y+(i-bones.list.molette)*20



		local ang2 = h.tete.pos.vec.D
		local X4 = X_world_to_screen(h.tete.pos.vec.L*math.cos(ang2))
		local Y4 = Y_world_to_screen(h.tete.pos.vec.L*math.sin(ang2))


		local X2 = math.max((X1+X4)/2-math.abs(Y1-Y4)/2,X1+30)
		local Y2 = Y1





		local X3 = math.min((X1+X4)/2+math.abs(Y1-Y4)/2,X4-30)
		local Y3 = Y4


		local cr ,cg , cb = 0,0,0,1
		if get_eta(h,"selected") then
			if h.tete.pointed or get_eta(h,"preselected") or h.point.pointed then
				cr ,cg ,cb,ca = 150,255,40,250
			else
				cr ,cg , cb,ca = 60,200,40,200
			end
		else
			if h.tete.pointed or get_eta(h,"preselected") or h.point.pointed then
				cr ,cg , cb,ca = 255,235,60,200
			else
				cr ,cg , cb,ca = 255,255,255,40
			end
		end

		love.graphics.setColor(cr,cg,cb,ca)
		love.graphics.setLine(1, "smooth")
		love.graphics.line( X1, Y1, X2, Y2 ,X3,Y3,X4,Y4)

		love.graphics.setColor(cr,cg,cb,255)
		love.graphics.draw(plaque,X,Y1-10)

		love.graphics.draw(point2,X1-10,Y1-10)

		love.graphics.setFont( f )
		love.graphics.print( "L:"..(math.floor(h.tete.vec.L/h.L*10)/10).."" , X1-50 , Y1-10 )
		love.graphics.print( "id:"..h.id.."" , X1+50 , Y1-10 )


	end





	love.graphics.setColor(r,g,b,al)
end















