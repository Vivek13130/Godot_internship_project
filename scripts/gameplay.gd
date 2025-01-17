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


func _process(_delta: float) -> void:
	if(get_viewport().size.x != viewport.x || get_viewport().size.y != viewport.y):
		# if viewport changes , recalculate the position 
		handle_character_position()


func handle_character_position():
	# this function will make sure our character stay in center of screen
	var viewport_size = get_viewport().size
	var screen_width : float = viewport_size.x
	var screen_height : float = viewport_size.y
	var new_x 
	var new_y
	
	if(screen_width / screen_height > 16.0 / 9):
		new_x = screen_width / 2 
	else : 
		new_x = (screen_width * 2) / 3 * scale  # Position on the x-axis
	
	new_y = (screen_height * 5.5) / 10 * scale  # Position on the y-axis

	character.global_position.x = new_x
	character.global_position.y = new_y
