extends Node2D

@onready var ballSpawner := $BallSpawner

var coreSystems

signal onBallPotted(ballData: PoolBall)

func _ready() -> void:
	onBallPotted.connect(Callable(self, "temp"))
	coreSystems = get_parent()


func temp(ballData: PoolBall):
	prints("ball potted:", ballData.type)

func getBalls():
	return ballSpawner.get_children()
