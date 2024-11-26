class_name Card extends Node2D

enum CardType { Blank, Agent, Gadget, Structure, Espionage }
static var ALL_CARDS = [
	# Used as a signifier for a blank space and a default initialization value
	{"Title": "BLANK", "Type": CardType.Blank},
	{"Title": "Orange Cat", "Type": CardType.Agent},
	{"Title": "Smith", "Type": CardType.Agent},
	{"Title": "The Bomb", "Type": CardType.Gadget},
	{"Title": "Candle", "Type": CardType.Gadget},
	{"Title": "Suspicious Amount of Candles", "Type": CardType.Gadget},
	{"Title": "HQ", "Type": CardType.Structure},
	{"Title": "Airport", "Type": CardType.Structure},
	{"Title": "Convenient Accident", "Type": CardType.Espionage},
	{"Title": "Windfall", "Type": CardType.Espionage},
]

var faceUp := true
var title: String = ALL_CARDS[0]["Title"]
var type : CardType = ALL_CARDS[0]["Type"]
var isSelected := false

# Index into the ALL_CARDS array to determine the properties of this card
var cardIdx := 0
	
func _ready() -> void:
	flipFaceUp()
	initFromIndex(cardIdx)
	
func initFromIndex(card_idx: int):
	cardIdx = card_idx
	title = ALL_CARDS[card_idx]["Title"]
	type = ALL_CARDS[card_idx]["Type"]
	$CardSprite.get_node("TitleText").text = title

func flip() -> void:
	if faceUp:
		flipFaceDown()
	else:
		flipFaceUp()

func flipFaceUp() -> void:
	faceUp = true
	$CardSprite.z_index = 1
	$CardBackSprite.z_index = -1
	
func flipFaceDown() -> void:
	faceUp = false
	$CardSprite.z_index = -1
	$CardBackSprite.z_index = 1
	
func toggleSelect() -> bool:
	isSelected = !isSelected	
	return isSelected
