extends Node2D

@onready var playerManager := $PlayerManager
@onready var ballManager := $BallManager

func _ready() -> void:
	ballManager.onBallPotted.connect(Callable(playerManager, "actOnBallPot"))
	ballManager.onBallPotted.connect(Callable(self, "test"))

func getPlayerManager():
	return playerManager

func getBallManager():
	return ballManager

func getBalls():
	return getBallManager().getBalls()
