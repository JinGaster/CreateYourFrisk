function EventPage0() 
    if Event.GetAnimHeader("Player") ~= "Asriel" then
        Event.Remove(Event.GetName() .. " (1)")
        Event.Remove(Event.GetName())
    end
end

function EventPage1()
    local playerSprite = Event.GetSprite("Player")
    local friskSprite = Event.GetSprite("68302eae")
    local blackSprite = Event.GetSprite("68302eae (1)")
    Event.MoveToPoint("Player", 440, 201, true)
    Event.SetDirection("Player", 4)
    Event.SetDirection("68302eae", 6)
    General.SetDialog({"[noskip][voice:v_asriel](There's a human here, [w:15]all alone...)",
                       "[noskip][voice:v_asriel]Howdy! [w:25]Do you need any help?", 
                       "[noskip]..."}, true, 
                      {"Asriel/normal", 
                       {"Asriel/happyT", "Asriel/happy", 0.2},
                       "Asriel/frisknormal"})
    General.SetChoice({"Help", "Don't help"})
    if lastChoice == 0 then
        NewAudio.CreateChannel("Appear")
        Event.IgnoreCollision("68302eae", true)
        friskSprite.loopmode = "ONESHOT"
        Event.MoveToPoint("Player", 409, 200.4, true)
        General.Wait(30)
        Event.SetAnimHeader("68302eae", "Huggu")
        Event.Teleport("68302eae", 403, 200)
        playerSprite.alpha = 0
        General.Wait(1)
        while not friskSprite.animcomplete do
            General.Wait(1)
        end
        General.Wait(30)
        friskSprite.loopmode = "LOOP"
        Event.SetAnimHeader("68302eae", "Huggu2")
        General.Wait(30)
        General.SetDialog({"[noskip][voice:v_asriel]Don't worry, [w:15]everything is going to be okay..."}, true, {{"Asriel/sadT", "Asriel/sad", 0.2}})
        General.Wait(90)
        local playerPos = Event.GetPosition("Player")
        Event.Teleport("68302eae (1)", playerPos[1] < 320 and 320 or playerPos[1], playerPos[2] < 240 and 0 or playerPos[2] - 240)
        friskSprite.loopmode = "ONESHOT"
        Event.SetAnimHeader("68302eae", "Huggu3")
        local appeared = false
        Audio.Stop()
        for i = 1, 5 do
            if not appeared then
                --friskSprite.Set("AsrielOW/Huggu/h9")
                blackSprite.alpha = 1
                NewAudio.PlaySound("Appear", "BeginBattle2")
            else
                --friskSprite.Set("AsrielOW/Huggu/h8")
                blackSprite.alpha = 0
            end
            appeared = not appeared
            General.Wait(12)
        end
        General.Wait(18)
        Screen.SetTone(true, true, 0, 0, 0, 255)
        General.Wait(30)
        Event.Remove(Event.GetName())
        SetAlMightyGlobal("CYFInternalCross5", true)
        SetAlMightyGlobal("CYFInternalCharacterSelected", false)
        Player.Teleport("test2", 320, 200, 2, false)
    else 
        General.SetDialog({"[noskip][voice:v_asriel](I hope he'll be fine...)"}, true, {"Asriel/verySad"})
        Event.SetDirection("68302eae", 4)
    end
end