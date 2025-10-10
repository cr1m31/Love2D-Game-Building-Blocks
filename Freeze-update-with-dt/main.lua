local ball = {
	x = 200,
	y = 100,
	diameter = 30,
  mass = 30,
}

function love.update(dt)
  
  -- code pour sortir de la fonction update si le delta time est trop grand
  -- l'effet est que le jeu freeze si dt dépasse la valeur max
  -- utile pour la physique des jeux car lorsque l'on bouge la fenêtre de love 2d
    -- les objets physiques continuent leur mouvement mais l'affichage ne se met pas à jour
    -- par exemple si le joueur entre en collisions avec le sol et que l'on bouge la fenêtre de love 2d,
    -- le joueur passe à travers le sol...
	local max_dt = 0.1
	
	if dt > max_dt then
		return
	end
  
  ball.y = ball.y + ball.mass * dt
end

function love.draw()
	love.graphics.circle("line", ball.x, ball.y, ball.diameter)
end