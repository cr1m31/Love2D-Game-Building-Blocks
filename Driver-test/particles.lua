local particles = {}

math.randomseed(os.time())


function particles.create(pX, pY, pScale, pImage)
    local particle = {
        x = pX,
        y = pY,
        scale = pScale,
        image = pImage,
        lifeTime = math.random(0.1, 1),
        
        rndDir = math.random(0, 2 * math.pi),
        speed = math.random(50, 200)
    }
    table.insert(particles, particle)
    return particle
end

function particles.loopCreate(numberOfParticles, pX, pY, pScale, pImage)
    for i = 1, numberOfParticles do
        particles.create(pX, pY, pScale / math.random(1, 5), pImage)
    end 
end

function particles.destroy(list, number)
    table.remove(list, number)
end

function particles.spread(dt)
    for i, v in ipairs(particles) do 
        v.x = v.x + math.cos(v.rndDir)  * v.speed * dt
        v.y = v.y + math.sin(v.rndDir) * v.speed * dt

        v.lifeTime = v.lifeTime - dt
        if(v.lifeTime <= 0) then
            particles.destroy(particles, i)
        end
    end
end
    

function particles.draw()
    if(#particles > 0) then
        for i, v in ipairs(particles) do
            love.graphics.draw(v.image, v.x, v.y, 0, v.scale, v.scale)
        end
    end
end

return particles