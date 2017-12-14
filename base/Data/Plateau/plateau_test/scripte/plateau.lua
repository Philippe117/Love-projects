function S.load(new)
	S.sol = love.graphics.newImage(""..S.lieux.."/ressource/sol.png")
end
function S.creation(O)
	O.txt = 1
	add_to_camera(O)
end
local new = new_function( 0, "plat_update" , 12 )
new.plat = S
function new.F(D,dot)
	

end
function S.draw_cam(O)
	draw_in_world( love.graphics.draw , O.data.sol , O.X , O.Y , O.Z , O.A , 1 , 1 , 0 , 0 )
end

