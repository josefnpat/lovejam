local barlib = {}

barlib.img = {
  corner = love.graphics.newImage("assets/hud/bar_corner.png"),
  horizontal = love.graphics.newImage("assets/hud/bar_horizontal.png"),
}

function barlib.new(init)
  init = init or {}
  local self = {}
  self._text = init.text or "Bar Lib"
  self._hoverText = init.hoverText or "Bar Lib Hover"
  self._x = init.x or 32
  self._y = init.y or 32
  self._padding = init.padding or 8
  self._width = init.width or 256
  self._height = init.height or barlib.img.corner:getHeight()+self._padding*2
  self._color = init.color or {0,255,255}
  self._barColor = init.color or {246,197,42}
  self._textColor = init.textColor or {0,0,0}
  self._textInverseColor = init.textInverseColor or {255,255,255}
  self._icon = init.icon
  self._iconPadding = init.iconPadding or 8
  self._barValue = init.barValue or 0.5
  self._barHeight = init.barHeight or 2
  self._barWidth = init.barWidth or 2
  self._hover = false
  self.draw = barlib.draw
  self.update = barlib.update
  self.setText = barlib.setText
  self.setHoverText = barlib.setHoverText
  self.setX = barlib.setX
  self.setY = barlib.setY
  self.setPadding = barlib.setPadding
  self.setWidth = barlib.setWidth
  self.setHeight = barlib.setHeight
  self.setColor = barlib.setColor
  self.setBarColor = barlib.setBarColor
  self.setTextColor = barlib.setTextColor
  self.setTextInverseColor = barlib.setTextInverseColor
  self.setIcon = barlib.setIcon
  self.setIconPadding = barlib.setIconPadding
  self.setBarValue = barlib.setBarValue
  self.setBarHeight = barlib.setBarHeight
  self.setBarWidth = barlib.setBarWidth

  return self
end

function barlib:draw()
  local old_color = {love.graphics.getColor()}
  tooltipbg(self._x,self._y,self._width,self._height)
  if debug_mode then
    love.graphics.rectangle("line",self._x,self._y,self._width,self._height)
  end
  if self._icon then
    love.graphics.draw(self._icon,
      self._x+self._width-self._icon:getWidth()-self._padding,
      self._y+self._height-self._icon:getHeight()-self._padding
    )
  end
  local iconw = self._icon and self._icon:getWidth() or 32
  local iconh = self._icon and self._icon:getWidth() or 32
  love.graphics.setColor(self._color)
  love.graphics.draw(barlib.img.corner,
    self._x+self._width-iconw-barlib.img.corner:getWidth()-self._padding-self._iconPadding,
    self._y+self._height-barlib.img.corner:getHeight()-self._padding)
  love.graphics.draw(barlib.img.horizontal,
    self._x+self._padding,
    self._y+self._height-self._padding-self._barHeight,
    0,
    (self._width-iconw-self._padding*2-self._iconPadding)/barlib.img.horizontal:getWidth(),self._barHeight)
  local tx = self._x+self._padding
  local ty = self._y+self._padding
  local tw = self._width-self._padding*2-barlib.img.corner:getWidth()-self._barWidth-self._iconPadding
  local th = self._height-self._padding*2
  local thoff = (th-love.graphics.getFont():getHeight())/2
  local ttext = self._hover and self._hoverText or self._text  local bx,by = tx,ty
  local bw = (tw)*self._barValue
  local bh = self._height-self._padding*2-self._barHeight

  love.graphics.setColor(self._textInverseColor)
  love.graphics.printf(ttext,tx,ty+thoff,tw,"center")
  love.graphics.setColor(self._barColor)
  love.graphics.rectangle("fill",bx,by,bw,bh)
  love.graphics.setScissor(bx,by,bw,bh)
  love.graphics.setColor(self._textColor)
  love.graphics.printf(ttext,tx,ty+thoff,tw,"center")
  love.graphics.setScissor()
  love.graphics.setColor(old_color)
end

function barlib:update(dt)
  local mx,my = love.mouse.getPosition()
  self._hover = mx >= self._x and my >= self._y and
    mx <= self._x + self._width and my <= self._y + self._height
end

function barlib:setText(text)
  self._text = text
end

function barlib:setHoverText(hoverText)
  self._hoverText = hoverText
end

function barlib:setX(x)
  self._x = x
end

function barlib:setY(y)
  self._y = y
end

function barlib:setPadding(padding)
  self._padding = padding
end

function barlib:setWidth(width)
  self._width = width
end

function barlib:setHeight(height)
  self._height = height
end

function barlib:setColor(color)
  self._color = color
end

function barlib:setBarColor(barColor)
  self._barColor = barColor
end

function barlib:setTextColor(textColor)
  self._textColor = textColor
end

function barlib:setIcon(icon)
  self._icon = icon
end

function barlib:setIconPadding(iconPadding)
  self._iconPadding = iconPadding
end

function barlib:setBarValue(barValue)
  self._barValue = barValue
end

function barlib:setBarHeight(barHeight)
  self._barHeight = barHeight
end

function barlib:setBarWidth(barWidth)
  self._barWidth = barWidth
end

return barlib