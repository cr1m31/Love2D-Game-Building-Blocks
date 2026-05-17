local ball = {
    x = 200,
    y = 100,
    diameter = 30,
    mass = 30,
}

function love.update(dt)

    -- Le 'return' bloque l'update si dt (delta time) est trop grand.
    -- Ceci empêche les problèmes de physique (ex: collisions manquées, objets qui traversent les murs)
    -- lorsque le jeu est mis en pause ou lag (dt > 0.1s).
    local max_dt = 0.1
    
    if dt > max_dt then
        return
    end

    ball.y = ball.y + ball.mass * dt
end

function love.draw()
    love.graphics.circle("line", ball.x, ball.y, ball.diameter)
end