local swaying = false
local sway = 0
local swayDir = 0

function start(gah)
    print('we up in here')
end

function update(elapsed)

end

function stepHit(step)
    if step == 2426 then
        swaying = true
    end

    if step == 2427 then
        tweenFadeOut('dad',0.8, 0.4)
    end

    if step == 2943 then
        tweenFadeOut('dad',0,0.4)
    end
end