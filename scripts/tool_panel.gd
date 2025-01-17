extends Control

@onready var hat_card: VBoxContainer = $MarginContainer/OuterVBox/MainVBox/UpperHBox/Panel/hatCard
@onready var shirt_card: VBoxContainer = $MarginContainer/OuterVBox/MainVBox/UpperHBox/Panel2/shirtCard
@onready var pants_card: VBoxContainer = $MarginContainer/OuterVBox/MainVBox/LowerHBox/Panel/pantsCard
@onready var shoes_card: VBoxContainer = $MarginContainer/OuterVBox/MainVBox/LowerHBox/Panel2/shoesCard


func _ready() -> void:
	Manager.connect("hide_item_from_UI", hide_item_from_UI)
	Manager.connect("show_item_in_UI", show_item_in_UI)
	
	Manager.item_scene_access_paths["hat"] = $MarginContainer/OuterVBox/MainVBox/UpperHBox/Panel/hatCard/TextureRect
	Manager.item_scene_access_paths["shirt"] = $MarginContainer/OuterVBox/MainVBox/UpperHBox/Panel2/shirtCard/TextureRect
	Manager.item_scene_access_paths["pant"] = $MarginContainer/OuterVBox/MainVBox/LowerHBox/Panel/pantsCard/TextureRect
	Manager.item_scene_access_paths["shoes"] = $MarginContainer/OuterVBox/MainVBox/LowerHBox/Panel2/shoesCard/TextureRect


#signal functions to hide and show items in UI 
func hide_item_from_UI(item : String):
	if(item == "pant"):
		pants_card.visible = false
	elif(item == "hat"):
		hat_card.visible = false
	elif(item == "shoes"):
		shoes_card.visible = false
	elif(item == "shirt"):
		shirt_card.visible = false
	else:
		print("item not found to hide : ", item)

func show_item_in_UI(item : String):
	if(item == "pant"):
		pants_card.visible = true
	elif(item == "hat"):
		hat_card.visible = true
	elif(item == "shoes"):
		shoes_card.visible = true
	elif(item == "shirt"):
		shirt_card.visible = true
	else:
		print("item not found to hide : ", item)


# detecting clicks on UI : and launching the DragDrop on the same 
func _on_card_1_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Manager.drag_drop_launch("hat")

func _on_card_2_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Manager.drag_drop_launch("shirt")

func _on_card_3_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Manager.drag_drop_launch("pant")

func _on_card_4_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Manager.drag_drop_launch("shoes")


func _on_button_pressed() -> void:
	# restart the game 
	var current_scene = get_tree().current_scene  # Get the current scene
	get_tree().reload_current_scene()  # Reload the current scene
