extends Node2D

var dragged_item_name : String = ""; 
var dragged_item = null # this will be an instance of the dragged item 

func _ready():
	Manager.connect("item_selected", _on_item_selected)


func _on_item_selected(item_name, item_scene_path):
	dragged_item_name = item_name
	dragged_item = load(item_scene_path).instantiate()
	handle_scale(item_name , dragged_item)
	add_child(dragged_item)  # this is neccessary to make it visible
	# if it is not added to scene tree, then it will not be visible


func handle_scale(item_name , _dragged_item_inst): # custom scale values , so that dress fits character
	if(Manager.custom_scale_values[item_name]):
		dragged_item.scale = Manager.custom_scale_values[item_name]
	else:
		print("setting scale of invalid item : " , item_name)


func _process(_delta):
	if dragged_item:
		dragged_item.global_position = get_global_mouse_position()  


func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed and Manager.grabbed:
		Manager.grabbed = false
		var temp_dragged_item = dragged_item # add this to parent element. 
		dragged_item = null # to stop the process function from updating it's position 
		
		# notify the character scene about the release and check for overlaps
		var character = get_parent().get_node("Character")
		if character : 
			var correct_overlap = character.find_valid_overlap()
			if(correct_overlap == ""):
				# no valid overlap found , reset position 
				Manager.reset_position(dragged_item_name, temp_dragged_item)
			else:
				character.set_correct_position(dragged_item_name , temp_dragged_item)
		else:
			print("character not found !!")
