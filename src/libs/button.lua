local button = {}

function button.new(init)
  init = init or {}
  local self = libs.drawable.new(init)

  self._width = init.width or 256
  self._height = init.height or 40
  self._draw = init.draw or button._default_draw_rcs
  self._text = init.text or ""
  self._tooltip = init.tooltip
  self._onClick = init.onClick or button._default_onClick
  self._onHoverIn = init.onHoverIn or function()
    libs.sfx.play("widget.hover")
  end
  self._onHoverOut = init.onHoverOut or function() end
  self._disabled = init.disabled or false
  self._dir = init.dir or 1
  self._font = init.font or fonts.menu
  self._icon = init.icon
  self._stroke = init.stroke

  self._hover = false
  self._depress = false

  self.update = button.update
  self.mouseInside = button.mouseInside
  self.draw = button.draw
  self.getDisabled = button.getDisabled
  self.setDisabled = button.setDisabled
  self.setText = button.setText
  self.setIcon = button.setIcon
  self.setOnClick = button.setOnClick
  self.setFont = button.setFont

  return self
end

function button:update(dt)
  self:updateHint(dt)
  local new_hover = self:mouseInside()
  if self._hover == false and new_hover == true then
    self._onHoverIn()
  end
  if self._hover == true and new_hover == false then
    self._onHoverOut()
  end
  local new_depress = new_hover and love.mouse.isDown(1)
  if new_hover and self._hover and not new_depress and self._depress and not self._disabled then
    libs.sfx.play("widget.click")
    self._onClick(self._dir)
  end
  self._hover = new_hover
  self._depress = new_depress
  if self._hover then
    libs.tooltip.set(
      self._tooltip,
      self._x+self._width-4,
      self._y+self._height-4)
  end
end

function button:mouseInside()
  local mx,my = love.mouse.getPosition()
  return mx >= self._x and mx < self._x + self._width and
    my >= self._y and my < self._y + self._height
end

function button:draw()
  if debug_hide_hud then
    return
  end
  self._draw(
    type(self._text)=="function" and self._text() or self._text,
    self._icon,
    self._x,self._y,
    self._width,self._height,
    self._hover,self._depress,self._disabled,
    self._font,
    self._stroke)
  if self._hint then
    self:drawHint()
  end
end

function button._default_onClick()
  print('button pressed')
end

function button._default_draw_rcs(text,icon,x,y,width,height,hover,depress,disabled,font,stroke)
  local old_color = {love.graphics.getColor()}
  local old_font = love.graphics.getFont()
  local bg,fg
  if disabled then
    bg = {63,63,63,255*7/8}
    fg = {127,127,127,255*7/8}
  else
    bg = hover and {127,127,127,256*7/8} or nil
    fg = depress and {255,255,255} or nil
  end
  tooltipbg(x,y,width,height,bg,fg)
  love.graphics.setColor(255,255,255)
  local offset = (height-font:getHeight())/2
  love.graphics.setColor(fg or {0,255,255})
  if icon then
    local icon_image = type(icon) == "function" and icon() or icon
    local icon_padding = (height - icon_image:getHeight()) / 2
    love.graphics.draw(icon_image,x+icon_padding,y+icon_padding)
  end
  love.graphics.setFont(font)
  if not fg then
    dropshadowf(text,x,y+offset,width,"center")
  else
    love.graphics.printf(text,x,y+offset,width,"center")
  end

  if stroke then
    local stroke_color = stroke()
    if stroke_color then
      love.graphics.setColor(stroke_color)
      love.graphics.rectangle("line",x+0.5,y+0.5,width-1,height-1)
    end
  end

  love.graphics.setColor(old_color)
  love.graphics.setFont(old_font)
end

function button._default_draw(text,icon,x,y,width,height,hover,depress,disabled,font)
  local old_color = {love.graphics.getColor()}
  love.graphics.setColor(hover and {255,255,255} or {191,191,191})
  love.graphics.rectangle("fill",x,y,width,height)
  if depress then
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("line",x,y,width,height)
  end
  love.graphics.setColor(0,0,0)
  local offset = (height-love.graphics.getFont():getHeight())/2
  love.graphics.printf(text,x,y+offset,width,"center")
  love.graphics.setColor(old_color)
end

function button:getDisabled()
  return self._disabled
end

function button:setDisabled(val)
  self._disabled = val
end

function button:setText(val)
  self._text = val
end

function button:setIcon(val)
  self._icon = val
end

function button:setOnClick(val)
  self._onClick = val
end

function button:setFont(val)
  self._font = val
end

return button
