
for x = 1, 7 do
table.insert(ctrls, {
  Name = "snd" .. string.format("%d",x),
  ControlType = "Button",
  ButtonType = "Trigger",
  Count = 1
})
table.insert(ctrls, {
  Name = "idx" .. string.format("%d",x),
  ControlType = "Text",
  DefaultValue = "1",
  Count = 1
})
table.insert(ctrls, {
  Name = "snd" .. string.format("%d",x),
  ControlType = "Button",
  ButtonType = "Trigger",
  Count = 1
  })
end