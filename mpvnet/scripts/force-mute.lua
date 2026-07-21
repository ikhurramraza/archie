-- mpv.net persists mute in settings.xml and restores it on launch even with
-- remember-volume=no, so force the configured startup mute state on each file.
mp.add_hook("on_load", 50, function()
    mp.set_property_bool("mute", true)
end)
