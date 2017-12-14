function S.load(D)


end

function load_blueprint(D)


end


function S.creation(O)
	O.img = O.data.img[math.random(1,table.maxn(O.data.img))]

end
local new = new_function( 0, "objet_update" , 12 )
new.obj = S
function new.F(D,dot)
	for i,O in ipairs(D.objet) do
		if O.eta.camera then
			if not inview( O.X , O.Y , O.Z , 400 ,100 ) then
				O.eta.camera = false
			end
		else
			if inview( O.X , O.Y , O.Z , 400 , 100 ) then
				add_to_camera(O)
			end
		end
	end
end
function S.draw_cam(O)
	love.graphics.setColor(255,255,255)
	draw_in_world( love.graphics.draw , O.img , O.X , O.Y , O.Z , 0 , 1,1,90,0)
end

