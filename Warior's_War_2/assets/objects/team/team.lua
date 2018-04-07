--
-- Created by Philippe La Madeleine
-- User: philippe
-- Date: 31/12/17
-- Time: 1:23 PM
-- To change this template use File | Settings | File Templates.
--
--
team = {}
team.__index = team

function team.create(name)
    local self = setmetatable({}, team)
    self.name = name
    self.members = setmetatable({}, { __mode = 'vk' })
    self.foes = setmetatable({}, { __mode = 'vk' })
    self.status = "war"
    objectManager.subscribeObject(self)
    return self
end

function team.addMember(self, member)
    table.insert(self.members, member)
    member.team = self
    member.target = setmetatable({}, { __mode = 'vk' })
    return member
end

function team.getNearestTarget(self, x, y, range)
    local closest = nil
    local closestDistance = range
    for i, member in pairs(self.members) do
        if member.target[1] then
            local dx = member.target[1].position.x-x
            local dy = member.target[1].position.y-y
            local distance = ((dx)^2+ (dy)^2)^0.5
            if distance < closestDistance then
                closest = member.target[1]
                closestDistance = distance
            end
        end
    end
    return closest, closestDistance
end
