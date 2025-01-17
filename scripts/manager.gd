extends Node
#this is a global file and it will store : 
# assets, any common variable, intermediate communicating functions, default values

signal item_selected(item : String)
signal hide_item_from_UI(item : String)
signal show_item_in_UI(dragged_item_name : String)


var grabbed : bool = false; 
var dragged_item_name 
var dragged_item_instance

var lerp_speed_pos_reset: float = 0.1  
var moving_to_reset: bool = false


var item_scenes = {
	"hat": "res://scenes/hat.tscn",
	"shoes": "res://scenes/shoe.tscn",
	"pant": "res://scenes/pant.tscn",
	"shirt": "res://scenes/shirt.tscn",
}

var item_scene_access_paths = {
	"hat" : null,
	"shirt" : null,
	"pant" : null,
	"shoes" : null
}

var custom_scale_values = {
	"hat" : Vector2(0.65, 0.65),
	"shirt" : Vector2(0.65, 0.8),
	"pant" : Vector2(0.65, 0.6),
	"shoes" : Vector2(0.7, 0.7)
}


var current_dragged_scene_path: String = ""

var gameplay_layer_node : Node2D = null 
# this will keep reference to gameplay layer 
# we need this node to apply some transformations to fetch position of UI nodes 


func drag_drop_launch(item_name : String):
	grabbed = true # now it can be turned off only by DragDrop
	
	# we need to hide this item from UI
	emit_signal("hide_item_from_UI", item_name)
	
	# emit the signal to DragDrop Scene 
	if item_scenes.has(item_name):
		current_dragged_scene_path = (item_scenes[item_name])
		emit_signal("item_selected", item_name, current_dragged_scene_path) 
	else:
		print("Invalid item type: ", item_name)



func reset_position(dragged_item_Name , dragged_item_Instance):
	dragged_item_name = dragged_item_Name
	dragged_item_instance = dragged_item_Instance
	moving_to_reset = true



func _process(_delta: float) -> void:
	# resetting the position in this if condition
	if(moving_to_reset and dragged_item_instance): 
		var current_position = dragged_item_instance.global_position
		var canvas_layer_item = item_scene_access_paths[dragged_item_name]
		 
		var c_local_to_n_global = gameplay_layer_node.get_canvas_transform().affine_inverse() * canvas_layer_item.get_global_transform_with_canvas()
		var target_position: Vector2 = c_local_to_n_global * (canvas_layer_item.get_parent_area_size() / 2)
		
		dragged_item_instance.global_position = current_position.lerp(target_position, lerp_speed_pos_reset)
		
		# Stop moving when it's close enough to the target
		if current_position.distance_to(target_position) < 10:
			dragged_item_instance.queue_free()
			moving_to_reset = false
			emit_signal("show_item_in_UI" , dragged_item_name)
			dragged_item_name = ""
			dragged_item_instance = null
