extends Control

#Demo Controls
@onready var accent_dropdown: RGDropDown = $"MarginContainer/VBoxContainer/Controls/RGDrop Down"
@onready var view_control: RGSegmentControl = $MarginContainer/VBoxContainer/HBoxContainer2/RGSegmentControl
@onready var prev_view: RGButton = $MarginContainer/VBoxContainer/HBoxContainer2/RGButton
@onready var next_view: RGButton = $MarginContainer/VBoxContainer/HBoxContainer2/RGButton2
@onready var view_scroll: ScrollContainer = $MarginContainer/VBoxContainer/ScrollContainer

#Buttons
@onready var button1: RGButton = $MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Buttons/Buttons/HBoxContainer2/_Control_39673
@onready var button2: RGButton = $MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Buttons/Buttons/HBoxContainer4/_Control_39673
@onready var button3: RGButton = $MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Buttons/Buttons/HBoxContainer3/_Control_39673
@onready var button4: RGButton = $MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Buttons/Buttons/HBoxContainer5/HBoxContainer3/RGButton
@onready var button5: RGButton = $MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Buttons/Buttons/HBoxContainer5/HBoxContainer3/RGButton2
@onready var button6: RGButton = $MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Buttons/Buttons/HBoxContainer5/HBoxContainer3/RGButton3

#Toggles
@onready var toggle1: RGToggle = $MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Toggles/Toggles/HBoxContainer/Toggle
@onready var toggle2: RGToggle = $MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Toggles/Toggles/HBoxContainer/Toggle2

#Segment Controls
@onready var sc1: RGSegmentControl = $"MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Segment Controls/Segment Controls/HBoxContainer/RGSegmentControl"
@onready var sc2: RGSegmentControlIcon = $"MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Segment Controls/Segment Controls/HBoxContainer/RGSegmentControlIcon"

#Donut Graphs
@onready var donut_graph1: RGDonutGraph = $"MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Donut Graphs/VBoxContainer/HBoxContainer/RGDonutGraph"
@onready var donut_graph2: RGDonutGraph = $"MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Donut Graphs/VBoxContainer/HBoxContainer2/RGDonutGraph"

#Text Fields
@onready var text_field_1: RGTextField = $"MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Text Fields/Text Fields/HBoxContainer/RGTextField2"
@onready var text_field_2: RGTextFieldIcon = $"MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Text Fields/Text Fields/HBoxContainer2/RGTextFieldIcon2"

#Misc
@onready var drop_down: RGDropDown = $"MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Drop Down/Drop Down/RGDrop Down"
@onready var section_view: RGSectionView = $"MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Section View/Section View/HBoxContainer/VBoxContainer/RGSectionView"
@onready var tag: RGTag = $MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Tags/Tags/HBoxContainer/VBoxContainer/RGTag
@onready var progress_bar: RGProgressBar = $"MarginContainer/VBoxContainer/ScrollContainer/HBoxContainer/Progress Bar/Progress Bar/HBoxContainer/RGProgressBar"


var view := 0
var views =["button","toggle","text_field","segment_control","drop_down","section_view","tag","rcm","progress_bar","donut_graph"]

var menu = RGmenu.new()
var submenu = RGmenu.new()
func _ready() -> void:
	accent_dropdown.add_item("Red",0)
	accent_dropdown.add_item("Orange",1)
	accent_dropdown.add_item("Yellow",2)
	accent_dropdown.add_item("Green",3)
	accent_dropdown.add_item("Teal",4)
	accent_dropdown.add_item("Blue",5)
	accent_dropdown.add_item("Pink",6)
	accent_dropdown.add_item("Purple",7)

	
	view_control.add_item("button","Button")
	view_control.add_item("toggle","Toggle")
	view_control.add_item("text_field"," Text Field")
	view_control.add_item("segment_control","Segment Control")
	view_control.add_item("drop_down","Drop Down")
	view_control.add_item("section_view","Section View")
	view_control.add_item("tag","Tag")
	view_control.add_item("rcm","Right Click Menu")
	view_control.add_item("progress_bar","Progress Bar")
	view_control.add_item("donut_graph","Donut Graph")
	
	#Segment Control
	sc1.add_item("option_1","Option 1")
	sc1.add_item("option_2","Option 2")
	sc1.add_item("option_3","Option 3")
	
	#Segment Control Icon
	sc2.add_item("home",RoseGarden.Icons.get_icon("Home"))
	sc2.add_item("book",RoseGarden.Icons.get_icon("Book"))
	sc2.add_item("checklist",RoseGarden.Icons.get_icon("Checklist"))
	
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


func _on_prev_view_pressed() -> void:
	view_control.select_prev()

func _on_next_view_pressed() -> void:
	view_control.select_next()


func _on_view_control_item_selected(item_name: String) -> void:
	view = _find_index(views,item_name)
	if view == 0:
		accent_dropdown.add_item("Tasker",8)
	else:
		accent_dropdown.remove_item(8)
	create_tween().tween_property(view_scroll,"scroll_horizontal",view*1476,0.3*int(!RoseGarden.Accessibility.disableAnimations)).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	

func _find_index(array:Array,item):
	var index = 0
	for i in array.size():
		if array[i] == item:
			index = i
	return index

func empty():
	pass


func _on_rcm_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_RIGHT and event.pressed:
		RoseGarden.create_rc_menu(menu,get_global_mouse_position())


func _on_accent_new_selection(selection: String) -> void:
	button1.set_color(selection)
	button2.set_color(selection)
	button3.set_color(selection)
	button4.set_color(selection)
	button5.set_color(selection)
	button6.set_color(selection)
	toggle1.set_color(selection)
	toggle2.set_color(selection)
	progress_bar.set_color(selection)
	tag.set_color(selection)
	donut_graph1.set_color(selection)
	donut_graph2.set_color(selection)


func _on_dg2_down_pressed() -> void:
	donut_graph2.tween_value(donut_graph2.value-10,0.3,donut_graph2.percentage-10)

func _on_dg2_up_pressed() -> void:
	donut_graph2.tween_value(donut_graph2.value+10,0.3,donut_graph2.percentage+10)

func _on_dg1_down_pressed() -> void:
	donut_graph1.tween_value(donut_graph1.value-10,0.3,donut_graph1.percentage-10)

func _on_dg1_up_pressed() -> void:
	donut_graph1.tween_value(donut_graph1.value+10,0.3,donut_graph1.percentage+10)

func _on_pb_down_pressed() -> void:
	progress_bar.tween_value(progress_bar.value-10,0.3)

func _on_pb_up_pressed() -> void:
	progress_bar.tween_value(progress_bar.value+10,0.3)

func _on_tag_name_text_changed(new_text: String) -> void:
	tag.set_text(new_text)

func _on_svless_pressed() -> void:
	section_view.select_prev()

func _on_svmore_pressed() -> void:
	section_view.select_next()

func _on_rg_text_field_1_text_submitted(_new_text: String) -> void:
	text_field_1.set_inccorrect(true)
	await get_tree().create_timer(1).timeout
	text_field_1.set_inccorrect(false)
	text_field_1.edit()

func _on_rg_text_field_2_text_submitted(_new_text: String) -> void:
	text_field_2.set_inccorrect(true)
	await get_tree().create_timer(1).timeout
	text_field_2.set_inccorrect(false)
	text_field_2.edit()

func _on_increase_contrast_toggled(toggled_on: bool) -> void:
	RoseGarden.Accessibility.set_increase_contrast(toggled_on)

func _on_disable_animations_toggled(toggled_on: bool) -> void:
	RoseGarden.Accessibility.set_disable_animations(toggled_on)
