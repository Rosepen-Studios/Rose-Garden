@tool
extends EditorPlugin

const AUTOLOADS = {
	"RoseGarden": "res://addons/RoseGarden/globals/RoseGarden.gd",
	"Icons": "res://addons/RoseGarden/globals/Icons.gd",
	"Colors": "res://addons/RoseGarden/globals/Colors.gd",
}

const DialogScene = preload("res://addons/RoseGarden/editor/RGcomponent_dialogue.tscn")

var _toolbar_button: Button
var _dialog: Window

func _enter_tree() -> void:
	for name in AUTOLOADS:
		add_autoload_singleton(name, AUTOLOADS[name])

	_dialog = DialogScene.instantiate()
	
	# Attach to the editor's base control so it renders over the viewport
	EditorInterface.get_base_control().add_child(_dialog)
	_dialog.component_selected.connect(_on_component_selected)

	_toolbar_button = Button.new()
	_toolbar_button.icon = load("res://addons/RoseGarden/Icon"+str(randi_range(1,3))+".svg")
	_toolbar_button.tooltip_text = "Add RG Component"
	_toolbar_button.pressed.connect(_on_toolbar_button_pressed)
	add_control_to_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU, _toolbar_button)
	_dialog.hide()

func _exit_tree() -> void:
	for name in AUTOLOADS:
		remove_autoload_singleton(name)

	if _toolbar_button:
		remove_control_from_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU, _toolbar_button)
		_toolbar_button.queue_free()

	if _dialog:
		_dialog.queue_free()

func _on_toolbar_button_pressed() -> void:
	_dialog.popup_centered()

func _on_component_selected(scene_path: String) -> void:
	var edited_scene_root := EditorInterface.get_edited_scene_root()
	if not edited_scene_root:
		push_warning("RoseGarden: No scene is currently open.")
		return

	var packed: PackedScene = load(scene_path)
	var instance := packed.instantiate()

	# Use undo/redo so the action integrates with Ctrl+Z like native operations
	var undo := get_undo_redo()
	undo.create_action("Add RG Component")
	undo.add_do_method(edited_scene_root, "add_child", instance)
	undo.add_do_method(instance, "set_owner", edited_scene_root)
	undo.add_undo_method(edited_scene_root, "remove_child", instance)
	undo.commit_action()

	# Select the new node in the editor's Scene panel
	EditorInterface.get_selection().clear()
	EditorInterface.get_selection().add_node(instance)
