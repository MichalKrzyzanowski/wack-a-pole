extends Node2D

var coreManager

signal onBallPotted(ballData: PoolBall)

func _ready() -> void:
	onBallPotted.connect(Callable(self, "temp"))
	coreManager = get_parent()


func temp(ballData: PoolBall):
	prints("ball potted:", ballData.type)
