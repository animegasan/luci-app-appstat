local a, t, e
a = Map("appstat", translate("Application Status Service"))
a.description = translate(
    "Shows status application information in Overview LuCI") ..
                    [[<br/><br/><a href="https://github.com/animegasan" target="_blank">Powered by animegasan</a>]]

t = a:section(NamedSection, "config", "appstat")
t.anonymous = true
t.addremove = false
--- tunnels application
t:tab("ta", translate("Tunnels Apps"))
---- cloudflared
e = t:taboption("ta", Flag, "cloudflared", translate("Cloudflare"))
e.default = 0
e.rmempty = false
---- ngrok
e = t:taboption("ta", Flag, "ngrok", translate("Ngrok"))
e.default = 0
e.rmempty = false
---- zerotier
e = t:taboption("ta", Flag, "zerotier", translate("ZeroTier"))
e.default = 0
e.rmempty = false
--- firewall application
--t:tab("fa", translate("Firewall Apps"))
---- adguardhome
--e = t:taboption("fa", Flag, "adguardhome", translate("AdGuard Home"))
--e.default = 0
--`e.rmempty = false
--- proxy application
t:tab("pa", translate("Proxy Apps"))
---- passwall
--e = t:taboption("pa", Flag, "passwall", translate("Passwall"))
--e.default = 0
--e.rmempty = false
---- clash
e = t:taboption("pa", Flag, "clash", translate("OpenClash"))
e.default = 0
e.rmempty = false
--- other application
t:tab("oa", translate("Other Apps"))
---- dockerd
e = t:taboption("oa", Flag, "dockerd", translate("Docker"))
e.default = 0
e.rmempty = false
---- samba
e = t:taboption("oa", Flag, "smbd", translate("Samba"))
e.default = 0
e.rmempty = false
return a
