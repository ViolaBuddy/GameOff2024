extends Node2D

var full_deck = []
var player_hand = []
var board_state = [] #2d array: board_state[row][column]
const BOARD_WIDTH = 5
const BOARD_HEIGHT = 5
const CARD_WIDTH = 240
const CARD_HEIGHT = 336
const BOARD_SCALE = 0.5
const SPACE_BETWEEN_CARDS = 10
const BOARD_OFFSET_X = -((CARD_WIDTH*BOARD_SCALE+SPACE_BETWEEN_CARDS)*BOARD_WIDTH) / 2  + CARD_WIDTH*BOARD_SCALE/2
const BOARD_OFFSET_Y = -((CARD_HEIGHT*BOARD_SCALE+SPACE_BETWEEN_CARDS)*BOARD_HEIGHT) / 2 + CARD_HEIGHT*BOARD_SCALE/2

@onready var instancedCard = preload("res://Card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for r in BOARD_HEIGHT:
		board_state.append([])
		for c in BOARD_WIDTH:
			var myCard = instancedCard.instantiate()
			board_state[r].append(myCard)
			$Board.add_child(myCard)
			myCard.position = Vector2(
				(CARD_WIDTH*BOARD_SCALE+SPACE_BETWEEN_CARDS)*c + BOARD_OFFSET_X,
				(CARD_HEIGHT*BOARD_SCALE+SPACE_BETWEEN_CARDS)*r + BOARD_OFFSET_Y)
			myCard.scale = Vector2(BOARD_SCALE, BOARD_SCALE)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
