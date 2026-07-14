![yea](https://raw.githubusercontent.com/loaferrr/deadline-spawnmenu/refs/heads/lol/image.png)

# deadline-spawnmenu
poorly made* mod menu for deadline using [deadlines scripting api](https://recoil-group.github.io/deadline-modding/making-mods/scripting/api/) & [Iris](https://sirmallard.github.io/Iris/)

## run server.luau first

### if your lazy to open the files & copy it, then deal with this possibly outdated crap 

#### v paste this ultra compressed script into the client luau thingy v
```
local w={"AK12","AK308","AK_545","AK_545_Carbine","AK_762","AK_9","AUG_A3","Crayon","EDC_X9","F1","G3","KF416","M11_EOD","M4A1","M67","M84","M8HC","M9","Makarov","MK9","Molotov","MosinNagant","MP133","MP5","P320","PlacingTool","PSRL","QBZ95","Remington700","Remington870","RGD2","RPG7","SA58","SCAR47","SCARH","SCARL","StarterCharacter","TT33","UMP","Turret","Vector","Zarya3"}iris:Connect(function()iris.Window({"spawnlist"})local s,d,k,p,v,h=iris.State("primary"),iris.State(false),iris.State(true),iris.State("player"),iris.State(Vector3.new()),iris.State(100)iris.Text({`<font size="18">weapons</font>`,false,nil,true})iris.Table({3,true,true,true})for _,n in ipairs(w)do if iris.SmallButton({n}).clicked()then fire_server("giveweapon",s.value,n)end;iris.NextColumn()end;iris.End()iris.SameLine()for _,r in ipairs({{"primary","primary"},{"secondary","secondary"},{"utility1","throwable1"},{"utility2","throwable2"}})do iris.RadioButton(r,{index=s})end;iris.End()iris.Separator()iris.Text({`<font size="18">bots</font>`,false,nil,true})iris.Checkbox({"dummy"},{isChecked=d})iris.Checkbox({"delete on death"},{isChecked=k})iris.RadioButton({"spawn on player","player"},{index=p})iris.RadioButton({"spawn at position","v3"},{index=p})if p.value=="v3"then iris.Indent()iris.InputVector3({"Vector3"},{number=v})iris.End()end;iris.SliderNum({"health",1,0,1000},{number=h})if iris.Button({"spawn bot"}).clicked()then fire_server("spawnbot",d.value,h.value,k.value,p.value=="v3"and v.value or framework.character.get_position())end;iris.End()end)
```
#### v paste this ultra compressed script into the server luau thingy v
```
on_client_event:Connect(function(p,a)local pl=players.get(p)if a[1]=="giveweapon"then pl.set_weapon(a[2],a[3],"[]")pl.equip_weapon(a[2])end;if a[1]=="spawnbot"then local bn=spawning.bot()local b=players.get(bn)if a[2]then b.set_speed(0)if a[5]then local c;c=on_player_spawned:Connect(function(n)if n==bn then b.set_position(a[5])c:Disconnect()end end)end end;b.set_health(a[3] or 100)b.set_initial_health(a[3] or 100)if a[4]then local c;c=on_player_died:Connect(function(n)if n==bn then b.kick()c:Disconnect()end end)end;if a[5]then b.set_position(a[5])end;return bn end end)
```
