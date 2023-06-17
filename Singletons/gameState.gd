extends Node

signal onAllBallsSleeping

"""
checks if all balls are sleeping.
if all the balls are sleeping, the player can shoot
"""
func areAllBallsSleeping():
	var balls = get_tree().get_nodes_in_group("balls")
	for ball in balls:
		if !ball.sleeping:
			return false
	emit_signal("onAllBallsSleeping")
	return true
