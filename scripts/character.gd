extends Node2D

# Dictionary mapping valid item types to their info
var drop_item_info = {
	"hat" = {
		"validAreaName" : "HeadDetectionArea",
		"item_inside_area" : false , 
		"marker" : null ,
		"placed" : false , # to check if it's already placed or not  
	},
	"shirt" = {
		"validAreaName" : "BodyDetectionArea",
		"item_inside_area" : false , 
		"marker" : null , 
		"placed" : false , # to check if it's already placed or not
	},
	"pant" = {
		"validAreaName" : "LegsDetectionArea",
		"item_inside_area" : false , 
		"marker" : null , 
		"placed" : false , # to check if it's already placed or not
	},
	"shoes" = {
		"validAreaName" : "FeetDetectionArea",
		"item_inside_area" : false , 
		"marker" : null , 
		"placed" : false , # to check if it's already placed or not
	}
}

func _ready() -> void:
	drop_item_info["hat"]["marker"] = $Sprite2D/head/MarkerHead
	drop_item_info["shirt"]["marker"] = $Sprite2D/body/MarkerBody
	drop_item_info["pant"]["marker"] = $Sprite2D/legs/MarkerLegs
	drop_item_info["shoes"]["marker"] = $Sprite2D/feet/MarkerFeet


# will return the name of dropable in it's correct area 
func find_valid_overlap() -> String:
	for item_name in drop_item_info.keys():
		if (drop_item_info[item_name]["item_inside_area"] and not drop_item_info[item_name]["placed"]):
			drop_item_info[item_name]["placed"] = true
			return item_name
	return ""

func check_overall_placement():
	var count = 0 
	for item_name in drop_item_info.keys():
		if (drop_item_info[item_name]["placed"]):
			count += 1
	
	if(count == drop_item_info.size()):
		$overall.emitting = true
	return count


func set_correct_position(dragged_item_name : String , dragged_item_instance ) :
	drop_item_info[dragged_item_name]["placed"] = true
	
	# particle logic : 
	if(check_overall_placement() < drop_item_info.size()):
		# overall particles are differnt than normal ones
		# so not emitting both together when all clothes are placed
		match dragged_item_name:
			"hat":
				$head.emitting = true
			"shirt":
				$body.emitting = true
			"pant":
				$leg.emitting = true
			"shoes":
				$feet.emitting = true
			_:
				print("Unknown item")
	
	# setting at correct position 
	var correct_pos : Vector2 = Vector2.INF
	if(drop_item_info[dragged_item_name]):
		correct_pos = drop_item_info[dragged_item_name]["marker"].global_position
	else:
		print("no correct position found !! ")
	
	# animate the movement to correct position 
	if(correct_pos != Vector2.INF):
		
		if dragged_item_instance:
			dragged_item_instance.get_parent().remove_child(dragged_item_instance)
			# remove this node from DragDrop and add this to DroppedItems instead
		get_parent().get_node("DroppedItems").add_child(dragged_item_instance)
		dragged_item_instance.global_position = correct_pos
		

# area names are : hatArea, pantArea, shoeArea, shirtArea 
#( these names are of dropable items ) 

# signals to check if a dropable is inside a valid area or not 
func _on_head_detection_area_area_entered(area: Area2D) -> void:
	if(area.name == "hatArea"):
		drop_item_info["hat"]["item_inside_area"] = true

func _on_head_detection_area_area_exited(area: Area2D) -> void:
	if(area.name == "hatArea"):
		#if(drop_item_info["hat"]["placed"] == false):
		drop_item_info["hat"]["item_inside_area"] = false

func _on_body_detection_area_area_entered(area: Area2D) -> void:
	if(area.name == "shirtArea"):
		drop_item_info["shirt"]["item_inside_area"] = true

func _on_body_detection_area_area_exited(area: Area2D) -> void:
	if(area.name == "shirtArea"):
		drop_item_info["shirt"]["item_inside_area"] = false

func _on_legs_detection_area_area_entered(area: Area2D) -> void:
	if(area.name == "pantArea"):
		drop_item_info["pant"]["item_inside_area"] = true

func _on_legs_detection_area_area_exited(area: Area2D) -> void:
	if(area.name == "pantArea"):
		drop_item_info["pant"]["item_inside_area"] =  false

func _on_feet_detection_area_area_entered(area: Area2D) -> void:
	if(area.name == "shoeArea"):
		drop_item_info["shoes"]["item_inside_area"] = true

func _on_feet_detection_area_area_exited(area: Area2D) -> void:
	if(area.name == "shoeArea"):
		drop_item_info["shoes"]["item_inside_area"] = false
