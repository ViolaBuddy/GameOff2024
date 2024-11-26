class_name Card extends Node2D

var faceUp := true
var nameText := ""
var isSelected := false

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
		print("Increasing scale")
	else:
		$CardSprite.scale *= (1.0 / 1.1)
		print("Decreasing scale")
		
	return isSelected

func setText(newText:String) -> void:
	nameText = newText
	$CardSprite.get_node("TitleText").text = newText
