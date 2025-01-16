extends Control
@onready var hat_card: VBoxContainer = $MarginContainer/OuterVBox/MainVBox/UpperHBox/Panel/hatCard
@onready var shirt_card: VBoxContainer = $MarginContainer/OuterVBox/MainVBox/UpperHBox/Panel2/shirtCard
@onready var pants_card: VBoxContainer = $MarginContainer/OuterVBox/MainVBox/LowerHBox/Panel/pantsCard
@onready var shoes_card: VBoxContainer = $MarginContainer/OuterVBox/MainVBox/LowerHBox/Panel2/shoesCard


func _ready() -> void:
	Manager.connect("hide_item_from_UI", hide_item_from_UI)
	

func _process(delta: float) -> void:
	pass

func hide_item_from_UI(item : String):
	print("hiding : ", item)
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

func _on_card_1_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("hat clicked in UI")
		Manager.drag_drop_launch("hat")

func _on_card_2_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("shirt clicked in UI")
		Manager.drag_drop_launch("shirt")

func _on_card_3_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("pant clicked in UI")
		Manager.drag_drop_launch("pant")
		
func _on_card_4_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("shoes clicked in UI")
		Manager.drag_drop_launch("shoes")
		
