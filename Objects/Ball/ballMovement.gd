extends RigidBody2D

@export var animationSpeedScale := 6.0
@export var ballData : PoolBall

@onready var sprite := $Sprite2D
@onready var collider := $CollisionShape2D

var maxVelocityLength := 100.0
var previousPos := Vector2()
var angle : float
# ball has collided wih another ball
var marked := 0
# special marked used to determine cannon
var markedByWhite := 0

"""
add ball to group.
setup color
"""
func _ready() -> void:
	add_to_group("balls")
	if ballData: ballData.setColor(material as ShaderMaterial)
	GameState.onAllBallsSleeping.connect(Callable(self, "resetMarks"))

"""
turn off ball rotation without losing
physics precision
"""
func _process(delta: float) -> void:
	sprite.global_rotation = 0.0
	
"""
apply impulse force to the ball
"""
func applyForce(force: Vector2):
	if force.length() > maxVelocityLength:
		force = force.normalized() * maxVelocityLength
	apply_impulse(force)

# check canons too!

	
"""
check in offs.
occurs when a white ball is potted after colliding with another ball
"""
func checkInOff():
	if ballData.checkType(ballData.BallType.WHITE)  and marked == 1:
		print("in off")

"""
reset all marks
"""
func resetMarks():
	marked = 0
	markedByWhite = 0

"""
mark ball if it collided with another ball.
used to check for in offs and cannons
"""
func _on_body_entered(body: Node) -> void:
	if body.name.begins_with("Ball"):
		body.marked += 1
		print(body.name + " marked: " + str(body.marked))
