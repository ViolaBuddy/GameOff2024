extends Node2D

var Card = load("res://src/Card.gd")

var full_deck = []
var player_hand: Array[Card] = []
var deck = range(len(Card.ALL_CARDS)) # array of indices into ALL_CARDS
var board_state = [] #2d array: board_state[row][column]

const HAND_SIZE = 3

const BOARD_WIDTH := 5
const BOARD_HEIGHT := 5
const CARD_WIDTH_PX := 240
const CARD_HEIGHT_PX := 336

const BOARD_SCALE := 0.5
const SPACE_BETWEEN_CARDS_PX := 10
const BOARD_OFFSET_X = -((CARD_WIDTH_PX*BOARD_SCALE+SPACE_BETWEEN_CARDS_PX)*BOARD_WIDTH) / 2  + CARD_WIDTH_PX*BOARD_SCALE/2
const BOARD_OFFSET_Y = -((CARD_HEIGHT_PX*BOARD_SCALE+SPACE_BETWEEN_CARDS_PX)*BOARD_HEIGHT) / 2 + CARD_HEIGHT_PX*BOARD_SCALE/2

@onready var instancedCard = preload("res://Card.tscn")
@onready var Hand = $Hand
@onready var Preview = $Preview

func _ready() -> void:
	print("Ready")
	# set up deck
	deck.shuffle()
	for i in range(HAND_SIZE):
		draw_from_deck()
		
	for i in range(HAND_SIZE):
		var card = instancedCard.instantiate()
		
		var card_offset_x = -((CARD_WIDTH_PX*BOARD_SCALE+SPACE_BETWEEN_CARDS_PX)*len(player_hand)) / 2  + CARD_WIDTH_PX*BOARD_SCALE/2
		
		player_hand.push_back(card)
		$Hand.add_child(card)
		card.position = Vector2(
			(CARD_WIDTH_PX*BOARD_SCALE+SPACE_BETWEEN_CARDS_PX)*i + card_offset_x,
		0)
		card.scale = Vector2(BOARD_SCALE, BOARD_SCALE)
	
	# set up preview
	var previewClickArea = Preview.get_node("ClickArea")
	Preview.remove_child(previewClickArea)
	previewClickArea.queue_free()
	Preview.flipFaceDown()
	
	# Initialize Board
	for r in range(BOARD_HEIGHT):
		board_state.append([])
		for c in range(BOARD_WIDTH):
			var myCard = instancedCard.instantiate()
			board_state[r].append(myCard)
			$Board.add_child(myCard)
			myCard.position = Vector2(
				(CARD_WIDTH_PX*BOARD_SCALE+SPACE_BETWEEN_CARDS_PX)*c + BOARD_OFFSET_X,
				(CARD_HEIGHT_PX*BOARD_SCALE+SPACE_BETWEEN_CARDS_PX)*r + BOARD_OFFSET_Y)
			myCard.scale = Vector2(1.0, 1.0) * BOARD_SCALE
	
func _process(delta: float) -> void:
	### Any game state updates go here
	if Globals.clickedCard:
		Globals.clickedCard.toggleSelect()
		Globals.clickedCard = null
		
	if Globals.unhoveredCard:
		Preview.flipFaceDown()
		Preview.setText("")
		Globals.unhoveredCard = null
		
	if Globals.hoveredCard:
		if Globals.hoveredCard.faceUp:
			Preview.flipFaceUp()
			Preview.setText(Globals.hoveredCard.nameText)
			Globals.hoveredCard = null
		else:
			Preview.flipFaceDown()
			Preview.setText("")
			Globals.unhoveredCard = null
			
	### Any display updates go here
	draw_board()
	draw_hand()
			
func draw_from_deck() -> void:
	var drawn_card = deck.pop_back()
	player_hand.push_back(drawn_card)

func draw_board() -> void:
	# create board
	for r in range(BOARD_HEIGHT):

		for c in range(BOARD_WIDTH):
			var myCard = board_state[r][c]
	
func draw_hand() -> void:
	for i in range(len(player_hand)):
		var card_offset_x = -((CARD_WIDTH_PX*BOARD_SCALE+SPACE_BETWEEN_CARDS_PX)*len(player_hand)) / 2  + CARD_WIDTH_PX*BOARD_SCALE/2
		
		var card = player_hand[i]
		card.position = Vector2(
			(CARD_WIDTH_PX*BOARD_SCALE+SPACE_BETWEEN_CARDS_PX)*i + card_offset_x,
		0)
	
