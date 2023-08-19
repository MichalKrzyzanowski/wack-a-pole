extends Node2D

@export var playerList : Array[PlayerData]

@onready var playerLabel := $MarginContainer/PlayerLabel
@onready var labelMarginContainer := $MarginContainer
@onready var player := $Player

var currentPlayer := 0
var coreSystems
var switchPlayer := false

func _ready() -> void:
	coreSystems = get_parent()
	print(coreSystems.ballManager)
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
	if switchPlayer: return
	currentPlayer = (currentPlayer + 1) % playerList.size()

"""
performs actions based on potting the ball
actions include changing player, adding score, etc.
"""
func actOnBallPot(ballData: PoolBall):
	if ballData.checkType(ballData.BallType.WHITE): return
	prints(ballData.type)
	switchPlayer = true

"""
update position and text of player label
"""
func updatePlayerLabel(setVisible: bool = true) -> void:
	if player.isPlayerBallPotted(): return
	labelMarginContainer.global_position = player.playerBall.global_position
	playerLabel.text = playerList[currentPlayer].name
	playerLabel.visible = setVisible

"""
move to next player and update label
"""
func updatePlayer(labelVisible: bool = true) -> void:
	nextPlayer()
	updatePlayerLabel(labelVisible)
	switchPlayer = false
