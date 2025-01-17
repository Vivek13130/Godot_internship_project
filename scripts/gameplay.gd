extends Node2D
@onready var character: Node2D = $Character
@onready var drag_drop: Node2D = $DragDrop

var viewport : Vector2 # to store the viewport size 
# all main component positions will be set via code to handle all type of devices 

func _ready() -> void:
	handle_character_position()
	Manager.gameplay_layer_node = $"." 

func _input(event):
	if event.is_action_pressed("exit"):
		get_tree().quit()


func handle_character_position():
	# this function will make sure our character stay in center of screen
	var viewport_size = get_viewport().size
	var screen_width : float = viewport_size.x
	var screen_height : float = viewport_size.y

	character.global_position.x = screen_width * 2.0 / 3 
	character.global_position.y = (screen_height * 5.5) / 10
