SMODS.Keybind {
    key = 'imrich',
    key_pressed = 'm',
    held_keys = { 'lctrl' }, -- other key(s) that need to be held

    action = function(self)
        G.GAME.dollars = 1000000
        sendInfoMessage("money set to 1 million", "CustomKeybinds")
    end,
}