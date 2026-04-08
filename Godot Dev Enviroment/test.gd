extends Control


var menu = RGmenu.new()
var submenu = RGmenu.new()

func _ready() -> void:
	RoseGarden.set_menu_layer($CanvasLayer)
	menu.add_action("Home",Icons.HOME,empty)
	menu.add_menu("Menu",Icons.CHECKLIST,submenu)
	menu.add_seperator()
	menu.add_action("Delete",Icons.TRASH,empty,[],true)
	
	submenu.add_action("Test",Icons.HOME,empty)
	submenu.add_action("Test2",Icons.HOME,empty)
	submenu.add_action("Test3",Icons.HOME,empty)

func empty():
	pass


func _on_rg_progress_bar_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MASK_RIGHT and event.pressed:
			RoseGarden.create_rc_menu(menu,get_global_mouse_position())
