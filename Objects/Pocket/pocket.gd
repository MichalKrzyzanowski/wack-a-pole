extends Area2D

var ballManager

"""
connect signal that checks if ball hit the pocket
"""
func _ready() -> void:
	connect("body_entered", Callable(self, "on_body_entered"))
	ballManager = get_node("/root/Root/CoreSystems").getBallManager()
	assert(ballManager != null, "ball manager is null when initialize pocket!") 

"""
delete the ball and check in offs
"""
func on_body_entered(body: Node2D):
	if ballManager: ballManager.onBallPotted.emit(body.ballData)
	remove_from_group("balls")
	body.checkInOff()
	body.queue_free()
