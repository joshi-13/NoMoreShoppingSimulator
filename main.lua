

local decks_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/keybinds")
for _, file in ipairs(decks_src) do
    assert(SMODS.load_file("src/keybinds/" .. file))()
end
