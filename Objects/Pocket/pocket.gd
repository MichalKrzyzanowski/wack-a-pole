extends Area2D

"""
connect signal that checks if ball hit the pocket
"""
func _ready() -> void:
	connect("body_entered", Callable(self, "on_body_entered"))
	
"""
delete the ball and check in offs
"""
func on_body_entered(body: Node2D):
	remove_from_group("balls")
	body.checkInOff()
	body.queue_free()
