
import geni.portal as portal
import geni.rspec.pg as rspec

# Create a Request object to start building the RSpec.
request = portal.context.makeRequestRSpec()

prefixForIP = "192.168.1."
link = request.LAN("lan")

#Create a XenVM
for i in range(2):
  if i == 0:
    node = request.XenVM("control")
  else:
    node = request.XenVM("host")

  node.routable_control_ip = "true"
  node.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops:UBUNTU20-64-STD"
  iface = node.addInterface("if" + str(1))
  iface.component_id = "eth1"
  iface.addAddress(rspec.IPv4Address(prefixForIP + str(i + 1), "255.255.255.0"))
  link.addInterface(iface)

# Print the RSpec to the enclosing page.
portal.context.printRequestRSpec()
