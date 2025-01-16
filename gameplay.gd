extends Node2D
@onready var character: Node2D = $Character
@onready var drag_drop: Node2D = $DragDrop

var viewport : Vector2 # to store the viewport size 
# all main component positions will be set via code to handle all type of devices 

func _ready() -> void:
	handle_character_position()


func _process(delta: float) -> void:
	if(get_viewport().size.x != viewport.x || get_viewport().size.y != viewport.y):
		# if viewport changes , recalculate the position 
		handle_character_position()


func handle_character_position():
	# this function will make sure our character stay in center of screen
	viewport = get_viewport().size
	character.global_position.x = (viewport.x * 2) / 3
	character.global_position.y = (viewport.y * 5.5) / 10
