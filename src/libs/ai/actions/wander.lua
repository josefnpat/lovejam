local action = {}

function action.new(init)
  init = init or {}
  local self = {}
  self.updateFixed = action.updateFixed
  self.update = action.update
  self.last_wander = {}
  return self
end

function action:updateFixed(ai)
  local actions,actions_count = {},0
  local currentPocket = ai:getCurrentPocket()
  local user_id = ai:getUser().id
  for _,object in pairs(ai:getStorage().objects) do
    if object.user == user_id then
      if self.last_wander[object.index] == nil and not libs.net.hasMoveTarget(object) then
        self.last_wander[object.index] = math.random()*5+5
        table.insert(actions,function()
          if libs.net.hasMoveTarget(object) then return end
          libs.net.moveToTarget(
            ai:getServer(),
            object,
            currentPocket.x+math.random(-512,512),
            currentPocket.y+math.random(-512,512),
            true)
        end)
        actions_count = actions_count + 1
      end
    end
  end
  return actions,actions_count
end

function action:update(dt,ai)
  local user_id = ai:getUser().id
  for _,object in pairs(ai:getStorage().objects) do
    if object.user == user_id then
      if self.last_wander[object.index] then
        self.last_wander[object.index] = self.last_wander[object.index] - dt
        if self.last_wander[object.index] <= 0 then
          self.last_wander[object.index] = nil
        end
      end
    end
  end
end

return action
