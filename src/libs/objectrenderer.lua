local objectrenderer = {}

local data = {}

function objectrenderer.load(loadAssets)
  for _,type in pairs(love.filesystem.getDirectoryItems("assets/mp_objects")) do
    local dir = "assets/mp_objects/"..type
    local object_dir = dir.."/object"
    local renders_dir = dir.."/renders"
    local subrenders_dir = dir.."/subrenders"
    local icons_dir = dir.."/icons"

    local object = require(object_dir)()
    if loadAssets then

      objectrenderer.chevron = love.graphics.newImage("assets/hud/chevron.png")

      local po_file = dir.."/en.po"
      if love.filesystem.exists(po_file) then
        local po_raw = love.filesystem.read(po_file)

        object.loc = {}
        for _,entry in pairs(libs.gettext.decode(po_raw)) do
          object.loc[entry.id] = entry.str
        end
        for _,post in pairs({"name","info","build"}) do
          local id = "mission.object."..type.."."..post
          object.loc[post] = object.loc[id]
          if object.loc[id] == nil then
            print("warning: missing gettext id: "..id)
          end
        end
      else
        print("warning: missing file `"..po_file.."`")
      end
    end

    local renders = love.filesystem.getDirectoryItems(renders_dir)
    object.renders_count = #renders
    if loadAssets then
      object.renders = {}
      object.icons = {}
      for _,render in pairs(renders) do
        local renderdata = {}
        renderdata.main = love.graphics.newImage(renders_dir.."/"..render)
        if love.filesystem.exists(subrenders_dir.."/"..render) then
          renderdata.sub = love.graphics.newImage(subrenders_dir.."/"..render)
        end
        table.insert(object.renders,renderdata)
        table.insert(object.icons,love.graphics.newImage(icons_dir.."/"..render))
      end
    end
    data[type] = object
  end
end

function objectrenderer.init(object)
  object.dangle = object.angle
  object.subdangle = object.angle
  if object.health then
    local object_type = libs.objectrenderer.getType(object.type)
    object.healthbar = libs.healthbar.new{
      maxHealth = object_type.health.max
    }
  end
end

function objectrenderer.getType(type)
  if data[type] == nil then
    print("Type `"..tostring(type).."` does not exist.")
  end
  return data[type]
end

function objectrenderer.getTypes()
  return data
end

function objectrenderer.randomRenderIndex(type)
  return math.random(type.renders_count)
end

function objectrenderer.randomNameIndex(type)
  if type.names then
    return math.random(#type.names)
  end
end

function objectrenderer.draw(object,objects,isSelected,time)

  local type = objectrenderer.getType(object.type)

  if object.anim then
    love.graphics.setColor(255,255,255,127)
    love.graphics.circle("line",
      object.dx,
      object.dy,
      type.size+math.sin(object.anim*math.pi)*4
    )
  end

  if isSelected then
    love.graphics.setColor(libs.net.getUser(object.user).selected_color)
  else
    love.graphics.setColor(libs.net.getUser(object.user).color)
  end

  love.graphics.draw(objectrenderer.chevron,
    object.dx,object.dy,0,1,1,
    objectrenderer.chevron:getWidth()/2,objectrenderer.chevron:getHeight()/2)

  if isSelected then
    love.graphics.circle("line",
      object.dx,
      object.dy,
      type.size
    )

    if type.shoot then
      libs.ring.draw(object.dx,object.dy,type.shoot.range)
    end

  end

  if object.health then
    local object_type = libs.objectrenderer.getType(object.type)
    if object.health then
      object.healthbar:draw(
        object.dx-object_type.size,
        object.dy+object_type.size,
        object_type.size*2
      )
    end
  end

  if object.build_t and object.build_dt then
    love.graphics.setColor(0,255,255,isSelected and 127 or 63)
    local object_type = libs.objectrenderer.getType(object.type)
    local percent = 1-object.build_dt/object.build_t
    libs.pcb(object.dx,object.dy,object_type.size*1.5,0.75,percent,0)
  end

  love.graphics.setColor(255,255,255)

  if type.renders[object.render].sub then
    love.graphics.draw(
      type.renders[object.render].sub,
      object.dx,
      object.dy,
      object.subdangle,
      1,1,
      type.renders[object.render].sub:getWidth()/2,
      type.renders[object.render].sub:getHeight()/2)
  end

  love.graphics.draw(
    type.renders[object.render].main,
    object.dx,
    object.dy,
    object.dangle,
    1,1,
    type.renders[object.render].main:getWidth()/2,
    type.renders[object.render].main:getHeight()/2)

  love.graphics.setColor(255,255,255)
  if debug_mode then

    if object.tx and object.ty then
      love.graphics.line(object.x,object.y,object.tx,object.ty)
      local cx,cy = libs.net.getCurrentLocation(object,time)
      love.graphics.circle('line',cx,cy,8)
    end

    if type.shoot then
      love.graphics.circle('line',object.dx,object.dy,type.shoot.range)
    end

    local str = ""
    str = str .. "index: " .. object.index .. "\n"
    str = str .. "target: " .. tostring(object.target) .. "\n"
    str = str .. "user: " .. libs.net.getUser(object.user).name .. "["..tostring(object.user).."]\n"
    str = str .. "angle: " .. math.floor(object.angle*100)/100 .. "\n"
    str = str .. "dangle: " .. math.floor(object.dangle*100)/100 .. "\n"
    str = str .. "render: " .. math.floor(object.render) .. "\n"
    str = str .. "name: " .. tostring(object.name) .. "\n"
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

function objectrenderer.update(object,objects,dt,time,user)

  local cx,cy = libs.net.getCurrentLocation(object,time)
  object.dx = (object.dx or cx) + (cx-object.dx)/2
  object.dy = (object.dy or cy) + (cy-object.dy)/2

  local object_type = objectrenderer.getType(object.type)

  if object.health then
    object.healthbar:update(dt)
    object.healthbar:setPercent(object.health/object_type.health.max)
  end

  if object_type.rotate then
    object.angle = object.angle + object_type.rotate*dt
  end

  if object.tx and object.ty then
    object.angle = libs.net.getAngle(object.x,object.y,object.tx,object.ty)
  elseif object.target then
    local target = libs.net.findObject(objects,object.target)
    if target then
      object.angle = libs.net.getAngle(object.dx,object.dy,target.dx,target.dy)
    end
  end

  object.dangle = object.dangle + libs.net.shortestAngle(object.dangle,object.angle)*dt*(object_type.dangle_speed or 4)
  object.subdangle = object.subdangle + libs.net.shortestAngle(object.subdangle,object.angle)*dt*(object_type.subdangle_speed or 4)

  if object.anim then
    object.anim = object.anim - dt*4
    if object.anim < 0 then
      object.anim = nil
    end
  end

  if object.build_t then
    object.build_dt = (object.build_dt or object.build_t) - dt
    if object.build_dt <= 0 then
      if user and user.id == object.user then
        libs.sfx.play("action.build.end")
      end
      object.build_t = nil
      object.build_dt = nil
    end
  end

end

return objectrenderer
