#manages the runtime debug menu with object inspectors
extends CanvasLayer

# Stores Debug Inspectors by category tab.
var categories := {}

# Tracks Inspectors already in scene
var inspected_objects := {}

# Tab Container that holds individual debug panels
@export var tab_container:TabContainer

#Signals to emit when Challenge Mode is switched on and off
signal challenge_enabled
signal challenge_disabled

func _ready():
	#Ensure the tab container is assigned and hide it
	assert(tab_container, "Debug Menu has no Tab Container assigned!")
	set_process_unhandled_input(true)
	tab_container.visible = false
	
func _unhandled_input(event: InputEvent) -> void:
	#Toggle the debug menu when button is pressed
	if(event.is_action_pressed("debug_menu")):
		toggle_menu()

#Helper function to toggle the menu and pause the game.
func toggle_menu() -> void:
	tab_container.visible = !tab_container.visible
	get_tree().paused = tab_container.visible

#Builds a new tab to hold inspectors
func _create_panel(panel_name:String):
	var panel := PanelContainer.new()
	panel.name = panel_name
	tab_container.add_child(panel)
	
	var scroll := ScrollContainer.new()
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	scroll.name = "Scroll"
	
	panel.add_child(scroll)
	
	var grid := GridContainer.new()
	grid.owner = panel
	grid.name = "InspectorGrid"
	grid.columns = 4
	grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	grid.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	scroll.add_child(grid)
	
	categories[panel.name] = panel

#Adds an inspector under the requested category
func _add_inspector(inspector:Object, category:String):
	var id := inspector.get_instance_id()
	if(inspected_objects.has(id)):
		return
	var new_inspector = Inspector.new()
	new_inspector.set_object(inspector)

	if !categories.has(category):
		_create_panel(category)
	var this_panel:PanelContainer = categories[category]
	var grid = this_panel.find_child("InspectorGrid", true, false)
	if(grid == null):
		push_warning("InspectorGrid missing in panel %s" % category)
		return
	new_inspector.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	new_inspector.size_flags_vertical = Control.SIZE_EXPAND_FILL
	grid.add_child(new_inspector)
	inspected_objects[id] = new_inspector

#Emits a signal based on the state of the challenge toggle.
func _on_challenge_toggled(toggled_on):
	if(toggled_on):
		challenge_enabled.emit()
	else:
		challenge_disabled.emit()
		
