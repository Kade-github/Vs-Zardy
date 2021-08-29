local swaying = false
local sway = 0
local swayDir = 0

function start(gah)
    print('we up in here')
end

function update(elapsed)

end

function stepHit(step)
    if step == 2427 then
        dad:tweenAlpha(0.8,0.4)
    end

    if step == 2943 then
        dad:tweenAlpha(0,0.4)
    end
end