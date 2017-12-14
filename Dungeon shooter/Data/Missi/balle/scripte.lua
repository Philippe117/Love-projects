function T.init(T)
	T.speed = 40
	T.timer = 1
	T.domagemin = 20
	T.domagemax = 40
	T.colision = .1


end
function T.creation(T,Q,I,sx,sy)
	Q.app = {	{sprite = missi_balle_anim_stand, x = Q.x , y = Q.y , z = Q.z , A = Q.A , Az = Q.Az , frame = 1 , lastframe = 0} 	 }
end
function T.mort(T,Q,I,M)

	if M == "pierre" then
		Q.app[1].sprite = _G["missi_"..T.nom.."_anim_ground"]
	elseif M == "sang" then
		Q.app[1].sprite = _G["missi_"..T.nom.."_anim_flesh"]
	end


	Q.app[1].frame = 1
	Q.app[1].lastframe = 0



end
function T.update(T,Q,I,dot)

end
