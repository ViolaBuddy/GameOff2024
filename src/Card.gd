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
var isSelected := false

# Index into the ALL_CARDS array to determine the properties of this card
var cardIdx := 0
	
func _ready() -> void:
	flipFaceUp()

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
	
	if isSelected: 
		$CardSprite.scale *= 1.1
	else:
		$CardSprite.scale *= (1.0 / 1.1)
		
	return isSelected

func setText(newText:String) -> void:
	nameText = newText
	$CardSprite.get_node("TitleText").text = newText
