scripte = {}

fonction = {	load = {} ,
		start = {} ,
		MP = {} ,
		MR = {} ,
		KP = {} ,
		KR = {} ,
		update = {} ,
		play_update = {} ,
		draw = {}
					}
local list = love.filesystem.getDirectoryItems("scripte")
for i,h in ipairs(list) do
	S = {}
	nom = nil
	love.filesystem.load("scripte/"..h.."" )()
	if nom ~= nil then
		S.nom = nom
		_G["scripte_"..S.nom..""] = S
	end
	table.insert( scripte , S )

end
S = nil
function check_script(scr)
	if scr.load ~= nil then
		table.insert( fonction.load , scr.load )
	end
	if scr.start ~= nil then
		table.insert( fonction.start , scr.start )
	end
	if scr.MP ~= nil then
		table.insert( fonction.MP , scr.MP )
	end
	if scr.MR ~= nil then
		table.insert( fonction.MR , scr.MR )
	end
	if scr.KP ~= nil then
		table.insert( fonction.KP , scr.KP )
	end
	if scr.KR ~= nil then
		table.insert( fonction.KR , scr.KR )
	end
	if scr.update ~= nil then
		table.insert( fonction.update , scr.update )
	end
	if scr.play_update ~= nil then
		table.insert( fonction.play_update , scr.play_update )
	end
	if scr.draw ~= nil then
		table.insert( fonction.draw , scr.draw )
	end
end
function sort_light(list) --   <-->   1,2,3,...
	for i,h in ipairs(list) do
		if i > 1
		and h.prio > list[i-1].prio then
			list[i],list[i-1] = list[i-1],list[i]
		end
	end
	local i = table.maxn(list)
	while i > 1 do
		if list[i].prio > list[i-1].prio then
			list[i],list[i-1] = list[i-1],list[i]
		end
		i = i-1
	end

end

function sort_inv_light(list) --   >--<   ...,3,2,1
	for i,h in ipairs(list) do
		if i > 1
		and h.prio < list[i+1].prio then
			list[i],list[i-1] = list[i-1],list[i]
		end
	end
	local i = table.maxn(list)
	while i > 1 do
		if list[i].prio < list[i-1].prio then
			list[i],list[i-1] = list[i-1],list[i]
		end
		i = i-1
	end
	return (list)
end

function sort(list) --   <-->   1,2,3,...
	for i,h in ipairs(list) do
		local w = i
		while w > 1 and h.prio > list[w-1].prio do
			list[w],list[w-1] = list[w-1],list[w]
			w = w-1
		end
	end

end

function sort_inv(list) --   >--<   ...,3,2,1
	for i,h in ipairs(list) do
		local w = i
		while w > 1 and h.prio < list[w-1].prio do
			list[w],list[w-1] = list[w-1],list[w]
			w = w-1
		end
	end
	return (list)
end
function sort_func()
	sort(fonction.load)
	sort(fonction.start)
	sort(fonction.MP)
	sort(fonction.MR)
	sort(fonction.KP)
	sort(fonction.KR)
	sort(fonction.update)
	sort(fonction.play_update)
	sort_inv(fonction.draw)
end
for i,h in ipairs(scripte) do
	check_script(h)
end
w = 1
while w < 50 do
	sort_func()
	w = w+1
end
