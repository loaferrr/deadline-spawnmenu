on_client_event:Connect(function(playername, args)
    player = players.get(playername)
    if args[1] == "wepnames" then
        return config.weapon_names
    end
    if args[1] == "giveweapon" then
        player.set_weapon(args[2], args[3], "[]")
        player.equip_weapon(args[2])
    end
    if args[1] == "spawnbot" then
        --2: dummy. 3: health. 4: kick on death 5: Vector3 Position
        --fire_server("spawnbot", true, 200, true, Vector3.new(227.2373504638672, 220.5233917236328, -409.4911193847656))

        local bot_name = spawning.bot()
        local bot = players.get(bot_name)
        if args[2] == true then --dummy
            bot.set_speed(0)
            if args[5] then
                local connection
                connection = on_player_spawned:Connect(function(name)
                    if name == bot_name then
                        bot.set_position(args[5])
                        connection = nil
                    end
                end)
            end
        end
        bot.set_health(args[3] or 100)
        bot.set_initial_health(args[3] or 100)
        if args[4] == true then
            local connection
            connection = on_player_died:Connect(function(name, position, killer_data, stats_counted)
                if name == bot_name then
                    bot.kick()
                    connection = nil
                end
            end)
        end
        if args[5] then
            bot.set_position(args[5])
        end

        return bot_name
    end
end)
