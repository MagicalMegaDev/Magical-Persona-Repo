extends Control

var categories := {}
var inspected_objects := {}

@export var tab_container:TabContainer

signal challenge_enabled
signal challenge_disabled

func _ready():
	visible = false
	
func _process(delta):
	if(Input.is_action_just_pressed("debug_menu")):
		visible = !visible
		get_tree().paused = visible


func _create_panel(panel_name:String):
	var panel := PanelContainer.new()
	panel.name = panel_name
	assert(tab_container, "Debug Menu has No Tab Container assigned!")
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
	new_inspector.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	new_inspector.size_flags_vertical = Control.SIZE_EXPAND_FILL
	grid.add_child(new_inspector)
	inspected_objects[id] = new_inspector


func _on_challenge_toggled(toggled_on):
	if(toggled_on):
		challenge_enabled.emit()
	else:
		challenge_disabled.emit()
		
