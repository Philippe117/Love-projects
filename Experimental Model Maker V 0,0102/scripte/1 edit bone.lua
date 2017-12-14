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

function add_bone_to_selectable(bone)
	bone.chef = bone
	bone.tete.chef = bone
	if bone.data.tete.tipe ~= 2 then
		bone.tete.pos.chef = bone
	end
	bone.tX = 0
	bone.tY = 0
	bone.amIselectable = bone_amIselectable
	add_data_to_a_list(bones.selectable,bone)

	for i,h in ipairs(bones.selectable) do
		h.id = i
	end
--	rapporter_erreur( "(------------(  txt3 : "..txt3.." s  )------------)")
	return bone
end
function choose_canselect()
	if mouse.canselect then
		mouse.canselect.pointed = nil
	end
	mouse.canselect = nil
	local oldval = 100000
	for i,h in ipairs(bones.selectable) do
		local sel , val = execute_en_silence(h.amIselectable,h)
		if sel and ( not val or val < oldval ) then
			mouse.canselect = h
			oldval = val or oldval
		end
	end
	if mouse.canselect then
		mouse.canselect.pointed = true
	end
	return mouse.canselect
end
function remove_bone(bone)
	local id = bone.id
	bone.data.eta = false
	bone.eta = false
	bone.tete.eta = false
	for i,h in ipairs(bone.maitre.bone) do
		if h.id > id then
			h.id = h.id-1
		end
		if h.data.base.tipe == 1 then
			if h.data.base.pos > id then
				h.data.base.pos = h.data.base.pos-1
			elseif h.data.base.pos == id then
				h.data.base.tipe = 0
				h.data.base.pos = {X=h.base.pos.X,Y=h.base.pos.Y}
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
	garbage_collect(mouse.selectable,"selectable")
--	for i,h in ipairs(bone.maitre.bone) do
--	end
end

function determine_animation_point(bn)

	local Pmin = .05
	for i,h in ipairs(model_edit.anim_points[model_edit.animation]) do
		local minus = math.abs(bn.temps-h.temps)
		if minus < Pmin then
			Pcansel = h
			Pmin = minus
		end
	end
	if Pmin == .05 then
		Pcansel = nil
	end
	Psel = Pcansel
	if Psel then
		local tew = 0
		if bn.anim[0] then
			for i,h in ipairs(Psel.bone) do
				if h.temps == bn.anim[bn.anim_index].temps then
					tew = h
				end
			end
		end
		if tew == 0 then
			local new = {}
			if bn.data.tete.tipe == 0 then
				new.pos = {}
				new.pos.X = bn.tete.pos.X
				new.pos.Y = bn.tete.pos.Y
			elseif bn.data.tete.tipe == 1 then
				new.vec = {}
				new.vec.D = bn.tete.vec.D
				new.vec.L = bn.tete.vec.L
				new.vec.eritrot = bn.tete.vec.eritrot
			end
			new.temps = bn.temps
			new.Sdep = mouse.Sdep
			new.Sari = mouse.Sari
			local mew = new
			bn.anim.maxn = table.maxn(bn.anim)
			for i = 0 , bn.anim.maxn do
				local h = bn.anim[i]
				if h.temps > new.temps then
					bn.anim[i] , mew = mew , h
				end
			end
			bn.anim.maxn = bn.anim.maxn+1
			bn.anim[bn.anim.maxn] = mew
			add_data_to_a_list(Psel.bone, bn )
			return new
		else
			return bn.anim[bn.anim_index]
		end
		return bn.anim[bn.anim_index-1]
	else
		local new = {}
		if bn.data.tete.tipe == 0 then
			new.pos = {}
			new.pos.X = bn.tete.pos.X
			new.pos.Y = bn.tete.pos.Y
	--rapporter_erreur( "anim.pos = { X = "..new.pos.X.." , Y = "..new.pos.Y.."}")

		elseif bn.data.tete.tipe == 1 then
			new.vec = {}
			new.vec.D = bn.tete.vec.D
			new.vec.L = bn.tete.vec.L
			new.vec.eritrot = bn.tete.vec.eritrot
		end
		new.temps = bn.temps
		new.Sdep = mouse.Sdep
		new.Sari = mouse.Sari
		local mew = new
		bn.anim.maxn = table.maxn(bn.anim)
		for i = 0 , bn.anim.maxn do
			local h = bn.anim[i]
			if h.temps > new.temps then
				bn.anim[i] , mew = mew , h
			end
		end
		bn.anim.maxn = bn.anim.maxn+1
		bn.anim[bn.anim.maxn] = mew
		tew = {}---------------------------------------------------------------------------------------------------======================000000000000000000000
		tew.temps = bn.temps
		tew.bone = add_list_to_collect_routine({},"anim_edit",true) 
		add_data_to_a_list(tew.bone, bn )
		Psel = add_data_to_a_list (bn.maitre.anim_points[bn.maitre.animation] ,tew)
		return new
	end
end




function create_new_bone(model_data,base,tete,L)
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
	new.L = L or 10
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

function bone_amIselectable(bone)
	local mY = bones.list.Y+(bone.id-bones.list.molette)*20
	if love.mouse.getX() < bones.list.X+bones.list.W+10
	and love.mouse.getY() < mY+10
	and love.mouse.getY() > mY-10
	and bone.id-bones.list.molette >= 0
	and bone.id-bones.list.molette <= math.floor(bones.list.H/20) then
		return true , 0
	else
		local mX , mY = pos_screen_to_world(love.mouse.getX(),love.mouse.getY(),0)
		local rep = (bone.tX-mX)^2+(bone.tY-mY)^2
	--	txt = rep
		return rep < math.max(1,6/ratio(0)/camera.zoom)^2 , rep
	end
end


local new = new_function(fonction,"update",0)
function new.F(dot)
--txt2 = ratio(0)
	for i,h in ipairs(bones.selectable) do
		local dist = math.sqrt((h.chef.tete.pos.X-h.chef.tete.chef.base.pos.X)^2+(h.chef.tete.pos.Y-h.chef.tete.chef.base.pos.Y)^2)
		h.tX = h.chef.tete.pos.X+(h.chef.base.pos.X-h.chef.tete.pos.X)/dist
		h.tY = h.chef.tete.pos.Y+(h.chef.base.pos.Y-h.chef.tete.pos.Y)/dist
	end
	bones.list.molette = bones.list.molette+math.max(-.1,math.min(.1,(bones.list.moletteC-bones.list.molette)/2))
end

function draw_bone(bone,X,Y,A,sx,sy)
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
	love.graphics.setLine(math.max(4,scale*.8), "smooth")
	love.graphics.line( X1, Y1, (X1+X2)/2, (Y1+Y2)/2 )
	love.graphics.setLine(math.max(1.5,scale*.4), "smooth")
	love.graphics.line( (X1+X2)/2, (Y1+Y2)/2 , X2, Y2 )

	--love.graphics.print( "temps:"..(bone.temps or 0).."" , X1 , Y1 )
end
function draw_bone2(bone,X,Y,A,sx,sy)
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
	love.graphics.draw(point1,X2,Y2,0,math.max(.2,scale*.025),math.max(.2,scale*.025),10,10)
	local dist = math.sqrt((X1-X2)^2+(Y1-Y2)^2)
	local eX = X2+(X1-X2)/dist*scale
	local eY = Y2+(Y1-Y2)/dist*scale
	love.graphics.draw(point2,eX,eY,A,math.max(.4,scale*.05),math.max(.4,scale*.05),10,10)
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
txt2 = bones.list.Y


		local ang2 = h.chef.tete.pos.vec.D
		local X4 = X_world_to_screen(h.chef.tete.pos.vec.L*math.cos(ang2))
		local Y4 = Y_world_to_screen(h.chef.tete.pos.vec.L*math.sin(ang2))


		local X2 = math.max((X1+X4)/2-math.abs(Y1-Y4)/2,X1+30)
		local Y2 = Y1





		local X3 = math.min((X1+X4)/2+math.abs(Y1-Y4)/2,X4-30)
		local Y3 = Y4


		local cr ,cg , cb = 0,0,0,1
		if get_eta(h,"selected") then
			if h.pointed or get_eta(h,"preselected") then
				cr ,cg ,cb,ca = 150,255,40,250
			else
				cr ,cg , cb,ca = 60,200,40,200
			end
		else
			if h.pointed or get_eta(h,"preselected") then
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
		love.graphics.print( "L:"..(math.floor(h.chef.tete.vec.L/h.chef.L*10)/10).."" , X1-50 , Y1-10 )
		love.graphics.print( "id:"..h.chef.id.." anin: "..h.anim_index.."" , X1+50 , Y1-10 )

	end


--	txt = table.maxn(bones.selectable)


	love.graphics.setColor(r,g,b,al)
end


