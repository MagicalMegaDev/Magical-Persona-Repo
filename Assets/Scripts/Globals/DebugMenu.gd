extends Control

var categories := {}
@export var tab_container:TabContainer

func _create_panel(panel_name:String) -> PanelContainer:
	var panel := PanelContainer.new()
	panel.name = panel_name
	assert(tab_container, "Debug Menu has No Tab Container assigned!")
	tab_container.add_child(panel)
	
	var scroll := ScrollContainer.new()
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	
	panel.add_child(scroll)
	
	var grid := GridContainer.new()
	grid.name = "InspectorGrid"
	grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	grid.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	scroll.add_child(grid)
	
	categories[panel.name] = panel
	return panel

func _add_inspector(inspector:Object, category:String):
	var new_inspector = Inspector.new()
	new_inspector.set_object(inspector)

	if !categories.has(category):
		_create_panel(category)
	var this_panel:PanelContainer = categories[category]
	var grid = this_panel.find_child("InspectorGrid")
	grid.add_child(new_inspector)
