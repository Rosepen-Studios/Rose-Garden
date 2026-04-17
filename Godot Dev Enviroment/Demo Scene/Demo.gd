extends Control

@onready var accent_dropdown: RGDropDown = $"MarginContainer/VBoxContainer/Accent Selection/RGDrop Down"
@onready var text_field: RGTextField = $"MarginContainer/VBoxContainer/Text Fields/HBoxContainer/RGTextField2"
@onready var segment_control: RGSegmentControl = $"MarginContainer/VBoxContainer/Segment Controls/HBoxContainer/RGSegmentControl"
@onready var segment_control_icon: RGSegmentControlIcon = $"MarginContainer/VBoxContainer/Segment Controls/HBoxContainer/RGSegmentControlIcon"
@onready var drop_down: RGDropDown = $"MarginContainer/VBoxContainer/Drop Down/RGDrop Down"
@onready var text_field_icon: RGTextFieldIcon = $"MarginContainer/VBoxContainer/Text Fields/HBoxContainer2/RGTextFieldIcon2"
@onready var section_view: RGSectionView = $"MarginContainer/VBoxContainer/Section View/HBoxContainer/VBoxContainer/RGSectionView"

#Colorful Components
@onready var button_text: RGButton = $"MarginContainer/VBoxContainer/Buttons/HBoxContainer2/@Control@39673"
@onready var button_icon: RGButton = $MarginContainer/VBoxContainer/Buttons/HBoxContainer4/_Control_39673
@onready var button_ti: RGButton = $MarginContainer/VBoxContainer/Buttons/HBoxContainer3/_Control_39673
@onready var button_connected1: RGButton = $MarginContainer/VBoxContainer/Buttons/HBoxContainer5/HBoxContainer3/RGButton
@onready var button_connected2: RGButton = $MarginContainer/VBoxContainer/Buttons/HBoxContainer5/HBoxContainer3/RGButton2
@onready var button_connected3: RGButton = $MarginContainer/VBoxContainer/Buttons/HBoxContainer5/HBoxContainer3/RGButton3
@onready var toggle: RGToggle = $MarginContainer/VBoxContainer/Toggles/HBoxContainer/Toggle
@onready var toggle_acc: RGToggle = $MarginContainer/VBoxContainer/Toggles/HBoxContainer/Toggle2
@onready var progress_bar: RGProgressBar = $"MarginContainer/VBoxContainer/Progress Bar/HBoxContainer/RGProgressBar"
@onready var tag: RGTag = $MarginContainer/VBoxContainer/Tags/HBoxContainer/VBoxContainer/RGTag

var menu = RGmenu.new()
var submenu = RGmenu.new()

func _ready() -> void:
	#Accent Selection Options
	accent_dropdown.add_item("Red",0)
	accent_dropdown.add_item("Orange",1)
	accent_dropdown.add_item("Yellow",2)
	accent_dropdown.add_item("Green",3)
	accent_dropdown.add_item("Teal",4)
	accent_dropdown.add_item("Blue",5)
	accent_dropdown.add_item("Pink",6)
	accent_dropdown.add_item("Purple",7)
	accent_dropdown.add_item("Tasker",8)#Easter Egg

	#Segment Control
	segment_control.add_item("option_1","Option 1")
	segment_control.add_item("option_2","Option 2")
	segment_control.add_item("option_3","Option 3")

	#Segment Control Icon
	segment_control_icon.add_item("home",RoseGarden.Icons.get_icon("Home"))
	segment_control_icon.add_item("book",RoseGarden.Icons.get_icon("Book"))
	segment_control_icon.add_item("checklist",RoseGarden.Icons.get_icon("Checklist"))

	#Drop Down
	drop_down.add_item("Option 1",0)
	drop_down.add_item("Option 2",1)
	drop_down.add_item("Option 3",2)

	#Right Click Menu Creation
	RoseGarden.set_menu_layer($CanvasLayer)
	menu.add_action("Home",RoseGarden.Icons.HOME,empty)
	menu.add_menu("Menu",RoseGarden.Icons.CHECKLIST,submenu)
	menu.add_seperator()
	menu.add_action("Delete",RoseGarden.Icons.TRASH,empty,[],true)
	submenu.add_action("Test",RoseGarden.Icons.HOME,empty)
	submenu.add_action("Test2",RoseGarden.Icons.HOME,empty)
	submenu.add_action("Test3",RoseGarden.Icons.HOME,empty)

func empty():#Just an empty function for the rcm to call
	pass

func _on_rg_drop_down_new_selection(selection: String) -> void:
	button_text.set_color(selection)
	button_icon.set_color(selection)
	button_ti.set_color(selection)
	button_connected1.set_color(selection)
	button_connected2.set_color(selection)
	button_connected3.set_color(selection)
	toggle.set_color(selection)
	toggle_acc.set_color(selection)
	progress_bar.set_color(selection)
	tag.set_color(selection)

func _on_text_field_secret_text_submitted(_new_text: String) -> void:
	text_field.set_inccorrect(true)
	await get_tree().create_timer(1).timeout
	text_field.set_inccorrect(false)
	text_field.edit()

func _on_text_field_icon_secret_text_submitted(_new_text: String) -> void:
	text_field_icon.set_inccorrect(true)
	await get_tree().create_timer(1).timeout
	text_field_icon.set_inccorrect(false)
	text_field_icon.edit()

func _on_pbless_pressed() -> void:
	progress_bar.tween_value(progress_bar.value-10,0.3)


func _on_pbmore_pressed() -> void:
	progress_bar.tween_value(progress_bar.value+10,0.3)


func _on_svless_pressed() -> void:
	section_view.select_prev()


func _on_svmore_pressed() -> void:
	section_view.select_next()


func _on_tag_name_text_changed(new_text: String) -> void:
	tag.set_text(new_text)


func _on_right_click_menu_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_RIGHT and event.pressed:
		RoseGarden.create_rc_menu(menu,get_global_mouse_position())
