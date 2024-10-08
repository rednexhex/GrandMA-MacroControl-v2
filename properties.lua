
table.insert(props, {
  Name = "IP Host",
  Type = "string",
  Value = "127.0.0.1"
})

table.insert(props, {
  Name = "IP Port",
  Type = "integer",
  Value = 8000,
  Min = 80,
  Max = 65535
})

table.insert(props, {
  Name = "localip",
  Type = "string",
  Value = "192.168.232.232"
})

table.insert(props, {
  Name = "Multicast Address",
  Type = "string",
  Value = "224.0.23.175"
})

--[[
table.insert(props, {
  Name = "Username",
  Type = "string",
  Value = ""
})

table.insert(props, {
  Name = "Password",
  Type = "string",
  Value = ""
})
]]--


table.insert(props, {
  Name = "Debug Print",
  Type = "enum",
  Choices = {"None", "Tx/Rx", "Tx", "DietCoke", "Rx", "Function Calls", "All"},
  Value = "All"
})