module("luci.controller.appstat", package.seeall)

function index()
    entry({"admin", "services", "appstat"}, cbi("appstat"), _("App Status"), 13)
    entry({"admin", "services", "appstat", "appstatus"}, call("act_status"))
end

function act_status()
    local status = {}
    local apps_to_check = {
        "zerotier-one",
        "cloudflared",
        "clash",
        "dockerd",
        "ngrok",
        "smbd",
        -- Add other apps here if needed
    }
    for _, app_name in ipairs(apps_to_check) do
        local is_running = luci.sys.call("pidof " .. app_name .. " >/dev/null") == 0
        status[app_name] = is_running and "Running" or "Stopped"
    end
    
    luci.http.prepare_content("application/json")
    luci.http.write_json(status)
end
