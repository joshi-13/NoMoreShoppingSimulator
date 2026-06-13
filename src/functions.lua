local AutoShop = {
    active = false,
    target = nil,
    found = false,
    rerolls = 0,
    max_rerolls = 1000,
}

function start_shop_search(target)
    AutoShop.active = true
    AutoShop.target = target
    AutoShop.found = false
    AutoShop.rerolls = 0
end

local old_create_card = create_card

create_card = function(...)
    local card = old_create_card(...)

    -- print(card.config.center.key or "unknown")


    local key = card.config.center.key

    if AutoShop.active then
        if key == AutoShop.target then
            AutoShop.found = true
            AutoShop.active = false

            print("FOUND " .. key, "AutoShop")
        end
    end

    return card
end



local function queue_reroll()
    if not AutoShop.active or AutoShop.found or AutoShop.rerolls >= AutoShop.max_rerolls or G.GAME.dollars <= G.GAME.current_round.reroll_cost then
        return
    end

    G.E_MANAGER:add_event(Event({
        trigger = "immediate",
        func = function()
            if not AutoShop.active or AutoShop.found or AutoShop.rerolls >= AutoShop.max_rerolls or G.GAME.dollars <= G.GAME.current_round.reroll_cost then
                return true
            end

            AutoShop.rerolls = AutoShop.rerolls + 1

            G.FUNCS.reroll_shop()


            queue_reroll()

            return true
        end
    }))
end

local function get_hovered_card()
    local hover = G.CONTROLLER and G.CONTROLLER.hovering and G.CONTROLLER.hovering.target
    if hover and hover.config and hover.config.center then
        return hover
    end
    return nil
end

SMODS.Keybind {
    key = 'findCard',
    key_pressed = 'f',
    held_keys = { 'lctrl', 'lshift' }, -- other key(s) that need to be held

    action = function(self)
        start_shop_search(get_hovered_card().config.center.key)

        print("starting search for", AutoShop.target)
        queue_reroll()
    end,
}
