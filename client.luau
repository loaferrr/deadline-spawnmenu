local weapon_names = {
    "AK12", "AK308", "AK_545", "AK_545_Carbine", "AK_762", "AK_9", "AUG_A3", 
    "Crayon", "EDC_X9", "F1", "G3", "KF416", "M11_EOD", "M4A1", "M67", "M84", 
    "M8HC", "M9", "Makarov", "MK9", "Molotov", "MosinNagant", "MP133", "MP5", 
    "P320", "PlacingTool", "PSRL", "QBZ95", "Remington700", "Remington870", 
    "RGD2", "RPG7", "SA58", "SCAR47", "SCARH", "SCARL", "StarterCharacter", 
    "TT33", "UMP", "Turret", "Vector", "Zarya3"
}

iris:Connect(function()
    iris.Window({"spawnlist"})

        local slotstate = iris.State("primary")

        iris.Text({`<font size="18">weapons</font>`, false, nil, true})

        iris.Table({3, true, true, true})
            for _, name in ipairs(weapon_names) do
                if iris.SmallButton({name}).clicked() then
                    fire_server("giveweapon", slotstate.value, name)
                end
                iris.NextColumn()
            end
        iris.End()

        iris.SameLine()
            iris.RadioButton({"primary", "primary"}, {index = slotstate})
            iris.RadioButton({"secondary", "secondary"}, {index = slotstate})
            iris.RadioButton({"utility1", "throwable1"}, {index = slotstate})
            iris.RadioButton({"utility2", "throwable2"}, {index = slotstate})
        iris.End()

        iris.Separator()
        iris.Text({`<font size="18">bots</font>`, false, nil, true})

        local dummy = iris.State(false)
        local kickondeath = iris.State(true)
        local spawnposState = iris.State("player")
        local customV3 = iris.State(Vector3.new())
        local healthState = iris.State(100)

        iris.Checkbox({"dummy"}, {isChecked = dummy})
        iris.Checkbox({"delete on death"}, {isChecked = kickondeath})
        
        iris.RadioButton({"spawn on player", "player"}, {index = spawnposState})
        iris.RadioButton({"spawn at position", "v3"}, {index = spawnposState})
        
        if spawnposState.value == "v3" then
            iris.Indent()
                iris.InputVector3({ "Vector3" }, {number = customV3})
            iris.End()
        end
        
        iris.SliderNum({"health", 1, 0, 1000}, {number = healthState})
        
        if iris.Button({"spawn bot"}).clicked() then
            local targetPos = framework.character.get_position()
            if spawnposState.value == "v3" then
                targetPos = customV3.value
            end
            
            fire_server(
                "spawnbot", 
                dummy.value, 
                healthState.value, 
                kickondeath.value, 
                targetPos
            )
        end
        
    iris.End()
end)
