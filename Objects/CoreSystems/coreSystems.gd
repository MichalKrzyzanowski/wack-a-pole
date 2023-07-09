extends Node2D

@onready var ballManager := $BallManager
@onready var playerManager := $PlayerManager

func _ready() -> void:
	ballManager.onBallPotted.connect(Callable(playerManager, "actOnBallPot"))
	ballManager.onBallPotted.connect(Callable(self, "test"))

func getPlayerManager():
	return playerManager

func getBallManager():
	return ballManager

func test(ballData: PoolBall):
	print("hello")
