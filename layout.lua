
table.insert(graphics,{
  Type="Image",
  Image=sig,
  Position={0,140},
  Size={20,23}
})

table.insert(graphics,{
  Type = "Text",
  Text = "Build Info",
  FontSize = 12,
  HTextAlign = "Left",
  Position = {0, 160},
  Size = {62, 20}
})
table.insert(graphics,{
  Type = "Text",
  Text = "v" .. PluginInfo.BuildVersion,
  FontSize = 12,
  HTextAlign = "Left",
  Position = {0, 180},
  Size = {62, 20}
})

table.insert(graphics,{
  Type="Image",
  Image=malogo,
  Position={10,10},
  Size={75,75}
})


for x = 1, 7 do
  table.insert(graphics, {
    Type = "Text",
    Text = "Macro#:",
    Position = {200, 0 + 20 * x},
    Size = {50, 16},
    FontSize = 10,
    HTextAlign = "Right"
  })
  layout["idx".. string.format("%d",x)] = {
    PrettyName = "q"..string.format("%d",x),
    Legend = ""..string.format("%d",x),
    Style = "ComboBox",
    Position = {260, 0 + 20 * x},
    Size = {40, 16}
  }
  layout["snd".. string.format("%d",x)] = {
    PrettyName = "snd"..string.format("%d",x),
    Style = "Button",
    Legend = "Send",
    Position = {300, 0 + 20 * x},
    Size = {30, 16}
  }
  end