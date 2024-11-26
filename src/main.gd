extends Node2D

var Card = load("res://src/Card.gd")

# Every card is in one of the deck, hand, board, or discard
var deck: Array[Card] = []
var player_hand: Array[Card] = []
var board_state = [] #2d array: board_state[row][column]
var discard: Array[Card] = []

const HAND_SIZE = 7
const DECK_SIZE = 64

const BOARD_WIDTH := 5
const BOARD_HEIGHT := 5
const CARD_WIDTH_PX := 240
const CARD_HEIGHT_PX := 336

const BOARD_SCALE := 0.5
const SPACE_BETWEEN_CARDS_PX := 10
const BOARD_OFFSET_X = -((CARD_WIDTH_PX*BOARD_SCALE+SPACE_BETWEEN_CARDS_PX)*BOARD_WIDTH) / 2  + CARD_WIDTH_PX*BOARD_SCALE/2
const BOARD_OFFSET_Y = -((CARD_HEIGHT_PX*BOARD_SCALE+SPACE_BETWEEN_CARDS_PX)*BOARD_HEIGHT) / 2 + CARD_HEIGHT_PX*BOARD_SCALE/2

var rng = RandomNumberGenerator.new()

@onready var instancedCard = preload("res://Card.tscn")
@onready var Hand = $Hand
@onready var Preview = $Preview

func _ready() -> void:
	populate_deck()
	
	for i in range(HAND_SIZE):
		draw_from_deck()
		
	print("Initialized hand with ", len(player_hand), " cards")
	
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
		if Globals.selectedCard != null:
			if Globals.selectedCard.cardIdx != 0 && Globals.clickedCard.cardIdx == 0:
				Globals.clickedCard.initFromIndex(Globals.selectedCard.cardIdx)
		Globals.selectedCard = Globals.clickedCard
		Globals.clickedCard = null
		
	if Globals.unhoveredCard:
		Preview.flipFaceDown()
		Globals.unhoveredCard = null
		
	if Globals.hoveredCard:
		if Globals.hoveredCard.faceUp:
			Preview.initFromIndex(Globals.hoveredCard.cardIdx)
			Preview.flipFaceUp()
			Globals.hoveredCard = null
		else:
			Preview.initFromIndex(Globals.hoveredCard.cardIdx)
			Preview.flipFaceDown()
			Globals.unhoveredCard = null
			
	### Any display updates go here
	draw_board()
	draw_hand()
			
func populate_deck() -> void:
	for i in range(DECK_SIZE):
		# Select a random card entry in the list
		var card_idx = rng.randi_range(1, len(Card.ALL_CARDS) - 1)
		var card = instancedCard.instantiate()
		card.initFromIndex(card_idx)
		
		deck.push_back(card)
		
	# set up deck
	deck.shuffle()
	
	print("Created deck with ", len(deck), " cards")
	
func draw_from_deck() -> void:
	if deck.size() > 0:
		var drawn_card = deck.pop_back()
		
		# TODO: We should be able to consolidate this so we don't have two different hands to update?
		player_hand.push_back(drawn_card)
		$Hand.add_child(drawn_card)
		
		print("Drew the card ", drawn_card.title, " and added it to the hand")
	else:
		print("No cards in deck, can't draw into the hand!")

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
		
		card.scale = Vector2(1.0, 1.0)
		if card == Globals.selectedCard:
			card.scale *= 1.1 * BOARD_SCALE
		else:
			card.scale *= 1.0 * BOARD_SCALE

	
