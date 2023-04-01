-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Load Debian menu entries
local has_fdo, freedesktop = pcall(require, "freedesktop")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

terminal = "st"
editor = "nvim"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

awful.layout.layouts = { awful.layout.suit.max }

mymainmenu = freedesktop.menu.build()
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

awful.screen.connect_for_each_screen(function(screen)
    -- Wallpaper
    gears.wallpaper.maximized("/home/elwynj/wallpapers/lilacblue.png", screen, false)
    -- Each screen has its own tag table.
    awful.tag({ "q", "w", "e", "r", "a", "s", "d", "f" }, screen, awful.layout.layouts[1])
end)

globalkeys = gears.table.join(
    awful.key({ modkey,           }, "h",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
--[[
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.cycle(true, awful.screen.focused(), true)
            local selected_tag = awful.screen.focused().selected_tag
            local clients = selected_tag:clients()
            for i = 1, #clients, 1 do
              if clients[i] == client.focus then
                if i < #clients then
                  clients[i+1]:emit_signal("request::activate", {raise = true})
                else
                  clients[1]:emit_signal("request::activate", {raise = true})
                end
              end
            end
        end,
        {description = "go back", group = "client"}),
]]

    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey }, "l", function () awful.spawn(terminal.." -e nvim .config/awesome/rc.lua") end,
              {description = "open awesome config"}),
    awful.key({ modkey }, "k",
              function ()
                awful.spawn("qutebrowser")
                awful.spawn(terminal)
                awful.spawn(terminal)
              end,
              {description = "open dev environment"}),
    awful.key({ modkey }, "j", function () awful.spawn("qutebrowser") end,
              {description = "open qutebrowser"}),
    awful.key({ modkey }, "g", function () awful.spawn("discord") end,
              {description = "open discord"}),

    awful.key({ modkey, "Control"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey, "Control" }, "w", function () awesome.exec("awesome --config /home/elwynj/.config/awesome/stablerc.lua") end,
              {description = "reload awesome with stable config", group = "awesome"}),
    awful.key({ modkey, "Control" }, "e", function () awesome.exec("awesome --config /home/elwynj/.config/awesome/rc.lua") end,
              {description = "reload awesome with my config", group = "awesome"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),

    awful.key({ modkey },            "x",     function () awful.spawn("rofi -show run") end,
              {description = "run prompt", group = "launcher"}),
    awful.key({ modkey,           }, "m", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),
    awful.key({ modkey }, "z",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"})
)

keys = {"q", "w", "e", "r", "a", "s", "d", "f"}
for i = 1, 8 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, keys[i],
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        awful.key({ modkey, "Shift" }, keys[i],
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"})
    )
end

root.keys(globalkeys)

clientkeys = gears.table.join(
    awful.key({ modkey }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"})
)

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { keys = clientkeys, } },
    { rule = { class = "qutebrowser" },
       properties = { screen = 1, tag = "w" } },
    { rule = { class = "discord" },
       properties = { screen = 1, tag = "e" } },
    { rule = { class = "St" },
      callback =
      function (c)
        local tags = awful.screen.focused().tags
        if #tags[5]:clients() == 0 or tags[5]:clients()[1] == c then
          c:move_to_tag(tags[5])
          return end
        if #tags[6]:clients() == 0 or tags[6]:clients()[1] == c then
          c:move_to_tag(tags[6])
          return end
        c:move_to_tag(tags[8])
      end },
    { rule = { class = "elwyn" },
      callback =
      function (c)
        local tags = awful.screen.focused().tags
        c:move_to_tag(tags[7])
      end },
}
