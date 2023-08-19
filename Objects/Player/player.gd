extends Node2D

@onready var line := $Line2D
@onready var guideLine := $GuideLine
@onready var shapeCast := $ShapeCast2D
@onready var timer := $Timer
@onready var ballOutline := $Sprite2D

signal onShoot

var playerBall : Node2D
var ballCheckInterval := 0.5
var readyToShoot := true
# extra scaling applied to force appiled by user
var forceScalar := 1.5
var guideLineLength := 500.0
var ballOutlineWidth : float
var ballsPotted := 0

"""
initialize objects
"""
func _ready() -> void:
	connect("onShoot", Callable(self, "setGuideVisiblity").bind(false))
	GameState.onAllBallsSleeping.connect(Callable(self, "setGuideVisiblity").bind(true))
	
	# temp line for cue power
	line.add_point(Vector2(), 0)
	line.add_point(Vector2(), 1)
	
	guideLine.add_point(Vector2(), 0)
	guideLine.add_point(Vector2(), 1)
	timer.wait_time = ballCheckInterval
	
	# setup ball outline
	playerBall = get_node("/root/Root/CoreSystems/BallManager/BallSpawner/BallWhite")
	assert(playerBall, "player has no assigned ball")
	ballOutlineWidth = playerBall.collider.shape.radius
	
"""
update guideline and it's relevant shapecast
handle player shoot event
"""
func _process(delta: float) -> void:
	# stop processing if player is not ready to shoot
	if !isPlayerReadyToShoot(): return
	
	updateGuideLine()
	
	shoot(delta)

"""
calculate and apply force to the player ball
"""
func shoot(delta: float):
	if Input.is_action_just_pressed("hit"):
		var dir = (line.get_point_position(0) - line.get_point_position(1))
		dir.normalized()
		var dist = floor((line.get_point_position(0) - line.get_point_position(1)).length())
		playerBall.applyForce(dir * dist * delta * forceScalar)
		readyToShoot = false
		timer.start()
		onShoot.emit()

"""
updates the guideline direction
and ball outline position using shapecast
"""
func updateGuideLine():
	line.set_point_position(0, playerBall.global_position)
	line.set_point_position(1, get_global_mouse_position())
	shapeCast.global_position = playerBall.global_position
	
	var guideLineDir = line.get_point_position(1).direction_to(
		line.get_point_position(0))
	shapeCast.target_position = guideLineDir * guideLineLength
	var guideLineTarget = playerBall.global_position + shapeCast.target_position
	
	if(shapeCast.is_colliding()):
		var length = line.get_point_position(0).distance_to(
			shapeCast.get_collision_point(0)) - ballOutlineWidth
		guideLineTarget = guideLineDir * length + playerBall.global_position
		
		
	ballOutline.position = guideLineTarget
	
	guideLine.set_point_position(0, playerBall.global_position)
	guideLine.set_point_position(1, guideLineTarget)
	
"""
checks if player ball is available
"""
func isPlayerBallPotted():
	if !playerBall: return true
	return false
	
"""
checks if player is ready to shoot
"""
func isPlayerReadyToShoot() -> bool:
	if isPlayerBallPotted(): return false
	
	if !guideLine.visible: return false
	return true

"""
checks if all balls stopped moving
in order to allow the player to play shoot
"""
func _on_timer_timeout() -> void:
	if readyToShoot:
		timer.stop()
		return
	readyToShoot = GameState.areAllBallsSleeping()

"""
sets the visibility of guide objects such as
guide line and guide ball outline
"""
func setGuideVisiblity(visibility: bool) -> void:
	if isPlayerBallPotted(): return
	
	line.visible = visibility
	guideLine.visible = visibility
	ballOutline.visible = visibility
