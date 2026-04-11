extends Control

@onready var accent_dropdown: RGDropDown = $"MarginContainer/HBoxContainer/Accent Selection/RGDrop Down"
@onready var text_field_secret: RGTextField = $"MarginContainer/HBoxContainer/Text Fields/HBoxContainer/RGTextField2"
@onready var segment_control: RGSegmentControl = $"MarginContainer/HBoxContainer/Segment Controls/HBoxContainer/RGSegmentControl"
@onready var segment_control_icon: RGSegmentControlIcon = $"MarginContainer/HBoxContainer/Segment Controls/HBoxContainer/RGSegmentControlIcon"
@onready var drop_down: RGDropDown = $"MarginContainer/HBoxContainer/Drop Down/RGDrop Down"

#Colorful Components
@onready var button_text: RGButton = $"MarginContainer/HBoxContainer/Buttons/HBoxContainer2/@Control@39673"
@onready var button_icon: RGButton = $MarginContainer/HBoxContainer/Buttons/HBoxContainer4/_Control_39673
@onready var button_ti: RGButton = $MarginContainer/HBoxContainer/Buttons/HBoxContainer3/_Control_39673
@onready var button_connected1: RGButton = $MarginContainer/HBoxContainer/Buttons/HBoxContainer5/HBoxContainer3/RGButton
@onready var button_connected2: RGButton = $MarginContainer/HBoxContainer/Buttons/HBoxContainer5/HBoxContainer3/RGButton2
@onready var button_connected3: RGButton = $MarginContainer/HBoxContainer/Buttons/HBoxContainer5/HBoxContainer3/RGButton3
@onready var toggle: RGToggle = $MarginContainer/HBoxContainer/Toggles/HBoxContainer/Toggle
@onready var toggle_acc: RGToggle = $MarginContainer/HBoxContainer/Toggles/HBoxContainer/Toggle2

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
	segment_control_icon.add_item("home",RoseGarden.CustomIcons.get_icon("Home"))
	segment_control_icon.add_item("book",RoseGarden.CustomIcons.get_icon("Book"))
	segment_control_icon.add_item("checklist",RoseGarden.CustomIcons.get_icon("Checklist"))
	
	#Drop Down 
	drop_down.add_item("Option 1",0)
	drop_down.add_item("Option 2",1)
	drop_down.add_item("Option 3",2)
	
	#Right Click Menu Creation
	RoseGarden.set_menu_layer($CanvasLayer)
	menu.add_action("Home",Icons.HOME,empty)
	menu.add_menu("Menu",Icons.CHECKLIST,submenu)
	menu.add_seperator()
	menu.add_action("Delete",Icons.TRASH,empty,[],true)
	submenu.add_action("Test",Icons.HOME,empty)
	submenu.add_action("Test2",Icons.HOME,empty)
	submenu.add_action("Test3",Icons.HOME,empty)

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

func _on_text_field_secret_text_submitted(_new_text: String) -> void:
	text_field_secret.set_inccorrect(true)
	await get_tree().create_timer(1).timeout
	text_field_secret.set_inccorrect(false)
	text_field_secret.edit()
