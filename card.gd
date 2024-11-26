extends Node2D

var faceUp := true
var nameText := ""

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

func setText(newText:String) -> void:
	nameText = newText
	$CardSprite.get_node("TitleText").text = newText
