extends Node
#this is a global file and it will store : 
# assets 
# any common variable
# intermediate communicating functions 
# default values , etc

signal item_selected(item : String)
signal hide_item_from_UI(item : String)

var grabbed : bool = false; 

var item_scenes = {
	"hat": "res://scenes/hat.tscn",
	"shoes": "res://scenes/shoe.tscn",
	"pant": "res://scenes/pant.tscn",
	"shirt": "res://scenes/shirt.tscn",
}

var current_dragged_scene_path: String = ""

func drag_drop_launch(item_type : String):
	print("drag drop launched for " , item_type)
	grabbed = true # now it can be turned off only by DragDrop
	
	# we need to hide this item from UI
	emit_signal("hide_item_from_UI", item_type)
	
	# emit the signal to DragDrop Scene 
	if item_scenes.has(item_type):
		current_dragged_scene_path = (item_scenes[item_type])
		emit_signal("item_selected", item_type, current_dragged_scene_path) 
	else:
		print("Invalid item type: ", item_type)
