local objectrenderer = {}

local data = {}

function objectrenderer.load(loadAssets)
  for _,type in pairs(love.filesystem.getDirectoryItems("assets/mp_objects")) do
    local object_dir = "assets/mp_objects/"..type.."/object"
    local renders_dir ="assets/mp_objects/"..type.."/renders"
    local icons_dir = "assets/mp_objects/"..type.."/icons"
    local renders = love.filesystem.getDirectoryItems(renders_dir)
    local object = require(object_dir)()
    object.renders_count = #renders
    if loadAssets then
      object.renders = {}
      object.icons = {}
      for _,render in pairs(renders) do
        table.insert(object.renders,love.graphics.newImage(renders_dir.."/"..render))
        table.insert(object.icons,love.graphics.newImage(icons_dir.."/"..render))
      end
    end
    data[type] = object
  end
end

function objectrenderer.getType(type)
  if data[type] == nil then
    print("Type `"..tostring(type).."` does not exist.")
  end
  return data[type]
end

function objectrenderer.randomRenderIndex(type)
  return math.random(type.renders_count)
end

function objectrenderer.draw(object,objects,isSelected,time)

  local type = objectrenderer.getType(object.type)

  if isSelected then
    love.graphics.setColor(libs.net.getUser(object.user).selected_color)
  else
    love.graphics.setColor(libs.net.getUser(object.user).color)
  end

  love.graphics.circle("line",
    object.dx,
    object.dy,
    type.size
  )

  if object.health then
    local object_type = libs.objectrenderer.getType(object.type)
    local percent = object.health/object_type.health.max
    if percent < 1 or love.keyboard.isDown("lalt") then
      local bx,by,bw,bh = object.dx-32,object.dy+object_type.size,64,6
      love.graphics.setColor(0,0,0,127)
      love.graphics.rectangle("fill",bx,by,bw,bh)
      love.graphics.setColor(libs.healthcolor(percent))
      local bw = 64/object_type.health.max*5
      for i = 1,object_type.health.max/5*percent do
        love.graphics.rectangle("fill",bx+bw*(i-1)+1,by+1,bw-1,bh-2)
      end
    end
    local hue_change = 0.5
    if percent < hue_change then
      local hue = 255*percent/hue_change
      ship_color = {255,hue,hue}
    end
  end


  love.graphics.setColor(255,255,255)
  love.graphics.draw(
    type.renders[object.render],
    object.dx,
    object.dy,
    object.dangle,
    1,1,
    type.renders[object.render]:getWidth()/2,
    type.renders[object.render]:getHeight()/2)

  love.graphics.setColor(255,255,255)
  if debug_mode then

    if object.tx and object.ty then
      love.graphics.line(object.x,object.y,object.tx,object.ty)
      local cx,cy = libs.net.getCurrentLocation(object,time)
      love.graphics.circle('line',cx,cy,16)
    end
    local str = ""
    str = str .. "index: " .. object.index .. "\n"
    str = str .. "target: " .. tostring(object.target) .. "\n"
    str = str .. "user: " .. libs.net.getUser(object.user).name .. "["..tostring(object.user).."]\n"
    str = str .. "angle: " .. math.floor(object.angle*100)/100 .. "\n"
    str = str .. "dangle: " .. math.floor(object.dangle*100)/100 .. "\n"
    str = str .. "render: " .. math.floor(object.render) .. "\n"
    str = str .. "d: ["..math.floor(object.dx)..","..math.floor(object.dy).."]"
    love.graphics.printf(str,object.dx-64,object.dy,128,"center")
    love.graphics.setColor(0,255,0,63)
    for _,target in pairs(objects) do
      if target.index == object.target then
        love.graphics.line(
          object.dx,
          object.dy,
          target.dx,
          target.dy)
        break
      end
    end

  end
  love.graphics.setColor(255,255,255)

end

function objectrenderer.update(object,objects,dt,time)
  local cx,cy = libs.net.getCurrentLocation(object,time)
  object.dx = (object.dx or cx) + (cx-object.dx)/2
  object.dy = (object.dy or cy) + (cy-object.dy)/2

  if object.tx and object.ty then
    object.angle = libs.net.getAngle(object.x,object.y,object.tx,object.ty)
  end

  object.dangle = object.dangle + libs.net.shortestAngle(object.dangle,object.angle)*dt*4

end

return objectrenderer
