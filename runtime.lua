--Variables
IPAddress = Properties["IP Host"].Value 
Port      = Properties["IP Port"].Value
LocalIPAddress = Properties["localip"].String
LocalPort = 10001
LocalNICName = "LAN A"
MulticastAddress = Properties["Multicast Address"].Value


-- Sockets
UDP = UdpSocket.New()  -- Create new UdpSocket object
UDPSocketOpen = false


-- Setup Debug Print statements
DebugTx,DebugRx,DebugFunction = false, false, false
DebugPrint = Properties["Debug Print"].Value
if DebugPrint=="Tx/Rx" then
  DebugTx,DebugRx=true,true
elseif DebugPrint=="Tx" then
  DebugTx=true
elseif DebugPrint=="Rx" then
  DebugRx=true
elseif DebugPrint=="Function Calls" then
  DebugFunction=true
elseif DebugPrint=="All" then
  DebugTx,DebugRx,DebugFunction=true,true,true
end


-- Functions

-- If a NIC is specified by name, bind LocalIPAddress to it
function SelectNIC()
  if DebugFunction then print("SelectNIC() Called") end
  if LocalNICName ~= nil then
    -- Detect the local IP address of LAN A
    local nics = Network.Interfaces()
    for i,nic in ipairs(nics) do
      if nic.Interface == LocalNICName then
        LocalIPAddress = nic.Address
      end
    end
  end
end

-- When the UDP Socket is created run these setup functions
function Connected()
  if DebugFunction then print("Connected() Called") end
  print("UDP Socket Opened")
  UDPSocketOpen = true
  
  -- Start any initial data requests or polling loops here

end

-- Wrapper for safely binding local address
function OpenPorts(ip, port)
  --if DebugFunction then print("OpenPorts() Called: " .. ip .. ":" .. port) end
  UDP:Open(ip, port)
end

-- Opens a local UDP socket for use
function OpenSocket()
  if DebugFunction then print("OpenSocket() Called") end  
  -- If a local address has been chosen, open a UDP socket for use
  if LocalIPAddress ~= nil then
    print("Opening: " .. LocalIPAddress .. ":" .. LocalPort)
    -- pcall will prevent down interfaces from causing script errors
    local portGood, err = pcall(OpenPorts, LocalIPAddress, LocalPort)
    if not portGood then
      print("Error opening UDP Socket: " .. err)
    else
      Connected()
    end

  -- Let the core choose the address and port of the UDP socket automatically
  else
    OpenPorts(nil,nil)
    Connected()
  end
end

-- Join the open UDPSocket to a multicast network
-- Datagrams on the address
function JoinMulticast(address)
  if DebugFunction then print("JoinMulticast() Called: " .. address) end
  if UDPSocketOpen then
    UDP:JoinMulticast(address)
  else
    print("Error joining multicast network: Local Socket Closed")
  end
end

-- Use the open UDPSocket to send a UDP datagram of the string (command) to the IPAddress and Port defined
function Send(command)
  if DebugFunction then print("Send() Called") end
  if UDPSocketOpen then
    --if DebugTx then print("Sending " .. IPAddress .. ":" .. Port .. " datagram: " .. command) end
    UDP:Send(IPAddress, Port, command)  -- Write command to the UDP socket
  else
    --If the socket is closed, open it and try again
    OpenSocket()
    Send(command)
  end
end

-- Handle cleanup when closing the UDP port
function Close()
  if DebugFunction then print("Close() Called") end
  UDP:Close()
  UDPSocketOpen=false

  -- Stop any timers and clear data here

end

-- Parsers
-- UDP Data event is called when data is received on the port, either targeted at the local address or from a multicast network.
UDP.Data = function(socket, packet)
  if DebugFunction then print("UDP Data Eventhandler Called") end
  if DebugRx then print("Address: " .. packet.Address, "Port: " .. packet.Port, "Rx: " .. packet.Data)  end
  
  -- Handle response data here

end

--Setup the UDP sockets to be used 
function Initialize()
    if DebugFunction then print("Initialize() Called") end
    SelectNIC()                      -- Choose the correct NIC for communication
    OpenSocket()                     -- Create the local UDP Socket for use
    JoinMulticast(MulticastAddress)  -- Join the specified multicast 
    local ni = Network.Interfaces()
    for _, item in ipairs(ni) do
    localip = item.Address
  end
end


-------    Logic   -------

numlist = {}
cmndary  = {}
data = {}
tog = 0

for i = 1, 30 do   
  numlist[i]=tostring(i)
end 

for x = 1, 7 do
Controls["idx"..x].Choices = numlist
end

for cmd = 1, 7 do
Controls["idx"..cmd].EventHandler = function (ctl)
  for i,v in ipairs (numlist)do
    if v == ctl.String then
      cmndary[cmd] = numlist[i]
      break
     end
    end
  end
end    


for snd = 1, 7 do
Controls["snd"..snd].EventHandler = function()
  print("/cmd\x00\x00\x00\x00,s\x00\x00macro "..cmndary[snd].."\x00")
  Send("/cmd\x00\x00\x00\x00,s\x00\x00macro "..cmndary[snd].."\x00")
  end
end

--Setup the UDP sockets to be used 
function Initialize()
  if DebugFunction then print("Initialize() Called") end
  SelectNIC()                      -- Choose the correct NIC for communication
  OpenSocket()                     -- Create the local UDP Socket for use
  --JoinMulticast(MulticastAddress)  -- Join the specified multicast 
  local ni = Network.Interfaces()
  for _, item in ipairs(ni) do
  localip = item.Address
  Controls.localIP = localip.String
  end
end

-- Run at start
Initialize()