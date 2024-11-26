class_name Card extends Node2D

enum CardType { Agent, Gadget, Structure, Espionage }
static var ALL_CARDS = [
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

var faceUp := true
var nameText := ""
var type : CardType
var isSelected := false

# Index into the ALL_CARDS array to determine the properties of this card
var cardIdx := 0
	
func _ready() -> void:
	flipFaceUp()
	
func initFromIndex(card_idx: int):
	setText(ALL_CARDS[card_idx]["Name"])
	type = ALL_CARDS[card_idx]["Type"]

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

func setText(newText:String) -> void:
	nameText = newText
	$CardSprite.get_node("TitleText").text = newText
