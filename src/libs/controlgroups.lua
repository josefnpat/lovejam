local controlgroups = {}

function controlgroups.new(init)
  init = init or {}
  local self = {}
  self._data = {}
  self.keypressed = controlgroups.keypressed
  return self
end

function controlgroups:keypressed(key,selection,notif)
  local key_number = tonumber(key)
  if key_number ~= nil and key_number >= 0 and key_number <= 9 then
    if love.keyboard.isDown("lctrl") then
      -- set controlgroup
      self._data[key_number] = selection:getSelected()
      notif:add(libs.i18n('mission.notification.controlgroup.set',{group=key_number}),nil,nil,nil,1)
    else
      -- change to controlgroup
      if self._data[key_number] then
        selection:setSelected(self._data[key_number])
        notif:add(libs.i18n('mission.notification.controlgroup.use',{group=key_number}),nil,nil,nil,1)
      end
    end
  end
end

return controlgroups
