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

func handle_scale(item , dragged_item): # custom scale values , so that dress fits character
	if(item == "hat"):
		dragged_item.scale = Vector2(0.65, 0.65)
	elif(item == "shoes"):
		dragged_item.scale = Vector2(0.7, 0.6)
	elif(item == "shirt"):
		dragged_item.scale = Vector2(0.65, 0.8)
	elif(item == "pant"):
		dragged_item.scale = Vector2(0.65, 0.6)
	else:
		print("setting scale of invalid item")

func _process(delta):
	if dragged_item:
		dragged_item.global_position = get_global_mouse_position()  


func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		Manager.grabbed = false
		var temp_dragged_item = dragged_item # add this to parent element. 
		dragged_item = null # to stop the process function from updating it's position 
		
		# Notify the character scene about the release and check for overlaps
		var character = get_parent().get_node("Character")
		if character : 
			var correct_overlap = character.find_valid_overlap()
			if(correct_overlap == ""):
				# no valid overlap found , reset position 
				print("resetting position ")
				Manager.reset_position(dragged_item_name, temp_dragged_item)
			else:
				character.set_correct_position(dragged_item_name , temp_dragged_item)
		else:
			print("character not found !!")
