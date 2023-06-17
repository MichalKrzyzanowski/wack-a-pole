extends Node2D

@export var playerList : Array[playerData]

@onready var playerLabel := $MarginContainer/PlayerLabel
@onready var labelMarginContainer := $MarginContainer
@onready var player := $Player

var currentPlayer := 0

func _ready() -> void:
	GameState.onAllBallsSleeping.connect(Callable(self, "updatePlayer").bind(true))
	player.onShoot.connect(Callable(self, "updatePlayerLabel").bind(false))
	updatePlayerLabel()
#func _process(delta: float) -> void:
#	playerLabel.global_position = player.playerBall.global_position

"""
selects the next player from the list
if current player is the last player, cycle back to first player
"""
func nextPlayer() -> void:
	currentPlayer = (currentPlayer + 1) % playerList.size()

"""
update position and text of player label
"""
func updatePlayerLabel(visible: bool = true) -> void:
	if player.isPlayerBallPotted(): return
	labelMarginContainer.global_position = player.playerBall.global_position
	playerLabel.text = playerList[currentPlayer].name
	playerLabel.visible = visible

"""
move to next player and update label
"""
func updatePlayer(labelVisible: bool = true) -> void:
	nextPlayer()
	updatePlayerLabel(labelVisible)
