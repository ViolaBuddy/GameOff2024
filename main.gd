extends Node2D

enum CardType { Agent, Gadget, Structure, Espionage }
const ALL_CARDS = [
	{"Name": "Orange Cat", "Type": CardType.Agent},
	{"Name": "Smith", "Type": CardType.Agent},
	{"Name": "The Bomb", "Type": CardType.Gadget},
	{"Name": "Candle", "Type": CardType.Gadget},
	{"Name": "Suspicious Amount of Candles", "Type": CardType.Gadget},
	{"Name": "HQ", "Type": CardType.Structure},
	{"Name": "Airport", "Type": CardType.Structure},
	{"Name": "Convenient Accident", "Type": CardType.Espionage},
	{"Name": "Windfall", "Type": CardType.Espionage},
]

var full_deck = []
var player_hand = []
var deck = range(len(ALL_CARDS)) # array of indices into ALL_CARDS
var board_state = [] #2d array: board_state[row][column]

const HAND_SIZE = 3

const BOARD_WIDTH = 5
const BOARD_HEIGHT = 5
const CARD_WIDTH = 240
const CARD_HEIGHT = 336
const BOARD_SCALE = 0.5
const SPACE_BETWEEN_CARDS = 10
const BOARD_OFFSET_X = -((CARD_WIDTH*BOARD_SCALE+SPACE_BETWEEN_CARDS)*BOARD_WIDTH) / 2  + CARD_WIDTH*BOARD_SCALE/2
const BOARD_OFFSET_Y = -((CARD_HEIGHT*BOARD_SCALE+SPACE_BETWEEN_CARDS)*BOARD_HEIGHT) / 2 + CARD_HEIGHT*BOARD_SCALE/2

@onready var instancedCard = preload("res://Card.tscn")
@onready var Hand = $Hand
@onready var Preview = $Preview

func _ready() -> void:
	# create board
	for r in range(BOARD_HEIGHT):
		board_state.append([])
		for c in range(BOARD_WIDTH):
			var myCard = instancedCard.instantiate()
			board_state[r].append(myCard)
			$Board.add_child(myCard)
			myCard.position = Vector2(
				(CARD_WIDTH*BOARD_SCALE+SPACE_BETWEEN_CARDS)*c + BOARD_OFFSET_X,
				(CARD_HEIGHT*BOARD_SCALE+SPACE_BETWEEN_CARDS)*r + BOARD_OFFSET_Y)
			myCard.scale = Vector2(BOARD_SCALE, BOARD_SCALE)
			myCard.flipFaceDown()
	
	# set up deck
	deck.shuffle()
	for i in range(HAND_SIZE):
		draw_card()
	update_hand_visualization()
	
	# set up preview
	var previewClickArea = Preview.get_node("ClickArea")
	Preview.remove_child(previewClickArea)
	previewClickArea.queue_free()
	Preview.flipFaceDown()
	
func _process(delta: float) -> void:
	if Globals.clickedCard:
		Globals.clickedCard.flip()
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
			
	
func draw_card() -> void:
	var drawn_card = deck.pop_back()
	player_hand.push_back(drawn_card)

func update_hand_visualization() -> void:
	# TODO: there's surely a better way to do this than deleting and re-creating them all
	for child in Hand.get_children():
		Hand.remove_child(child)
		child.queue_free()
		
	var card_offset_x = -((CARD_WIDTH*BOARD_SCALE+SPACE_BETWEEN_CARDS)*len(player_hand)) / 2  + CARD_WIDTH*BOARD_SCALE/2

	for i in range(len(player_hand)):
		var myCard = instancedCard.instantiate()
		Hand.add_child(myCard)
		myCard.position = Vector2(
			(CARD_WIDTH*BOARD_SCALE+SPACE_BETWEEN_CARDS)*i + card_offset_x,
			0)
		myCard.scale = Vector2(BOARD_SCALE, BOARD_SCALE)
		
		myCard.setText(ALL_CARDS[player_hand[i]]["Name"])
