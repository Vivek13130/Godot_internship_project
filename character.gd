extends Node2D

# Dictionary mapping valid item types to their target areas
var valid_areas = {
	"hat": "HeadDetectionArea",
	"pants": "LegsDetectionArea",
	"shirt" : "BodyDetectionArea",
	"shoes" : "FeetDetectionArea"
}

#these will check if dropable items are inside their correct detection area 
var is_hat_inside : bool = false
var is_pant_inside : bool = false
var is_shirt_inside : bool = false
var is_shoe_inside : bool = false

@onready var marker_head: Marker2D = $Sprite2D/head/MarkerHead
@onready var marker_body: Marker2D = $Sprite2D/body/MarkerBody
@onready var marker_legs: Marker2D = $Sprite2D/legs/MarkerLegs
@onready var marker_feet: Marker2D = $Sprite2D/feet/MarkerFeet


# will return the name of dropable in it's correct area 
func find_valid_overlap() -> String:
	if(is_hat_inside):
		is_hat_inside = false
		return "hat"
	elif is_pant_inside:
		is_pant_inside = false
		return "pant"
	elif is_shirt_inside:
		is_shirt_inside = false
		return "shirt"
	elif is_shoe_inside:
		is_shoe_inside = false
		return "shoe"
	else:
		return ""

func set_correct_position(dragged_item_name : String , dragged_item_instance ) :
	var correct_pos : Vector2 = Vector2.INF
	if(dragged_item_name == "hat"):
		correct_pos = marker_head.global_position
	elif(dragged_item_name == "shirt"):
		correct_pos = marker_body.global_position
	elif(dragged_item_name == "pant"):
		correct_pos = marker_legs.global_position
	elif(dragged_item_name == "shoes"):
		correct_pos = marker_feet.global_position
	else:
		print("no correct position found !! ")
	
	# animate the movement to correct position 
	if(correct_pos != Vector2.INF):
		
		if dragged_item_instance.get_parent():
			dragged_item_instance.get_parent().remove_child(dragged_item_instance)
			# remove this node from DragDrop and add this to DroppedItems instead
		get_parent().get_node("DroppedItems").add_child(dragged_item_instance)
		dragged_item_instance.global_position = correct_pos
		

# area names are : hatArea, pantArea, shoeArea, shirtArea 
#( these names are of dropable items ) 

# signals to check if a dropable is inside a valid area or not 
func _on_head_detection_area_area_entered(area: Area2D) -> void:
	if(area.name == "hatArea"):
		is_hat_inside = true

func _on_head_detection_area_area_exited(area: Area2D) -> void:
	if(area.name == "hatArea"):
		is_hat_inside = false

func _on_body_detection_area_area_entered(area: Area2D) -> void:
	if(area.name == "shirtArea"):
		is_shirt_inside = true

func _on_body_detection_area_area_exited(area: Area2D) -> void:
	if(area.name == "shirtArea"):
		is_shirt_inside = false

func _on_legs_detection_area_area_entered(area: Area2D) -> void:
	if(area.name == "pantArea"):
		is_pant_inside = true

func _on_legs_detection_area_area_exited(area: Area2D) -> void:
	if(area.name == "pantArea"):
		is_pant_inside = false

func _on_feet_detection_area_area_entered(area: Area2D) -> void:
	if(area.name == "shoeArea"):
		is_shoe_inside = true

func _on_feet_detection_area_area_exited(area: Area2D) -> void:
	if(area.name == "shoeArea"):
		is_shoe_inside = false
