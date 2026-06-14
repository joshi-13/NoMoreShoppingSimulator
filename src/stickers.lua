SMODS.Atlas({
    key = "Selected_sticker",
    path = "Selected_sticker.png",
    px = 71,
    py = 95,
})

SMODS.Sticker {
    key = "selected",
    Atlas = "Selected_sticker",

    pos = { x = 1, y = 1},
    default_compat = false,
    needs_enable_flag = true,
    hide_badge = false,

}
