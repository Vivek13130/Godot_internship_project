extends Node2D

# Dictionary mapping valid item types to their target areas
var valid_areas = {
	"hat": "HeadArea",
	"pants": "LegsArea"
}

#func check_valid_overlap(dropped_item: Node2D) -> bool:
	#for area_name in valid_areas.values():
		#var area = $[area_name]  # Assuming "HeadArea" and "LegsArea" are children of this node
		#if area and area.get_overlapping_bodies().has(dropped_item):
			#if dropped_item.name == valid_areas.find(area_name):
				#return true  # Valid placement
	#return false


func _on_head_area_area_entered(area: Area2D) -> void:
	print(area.name)
