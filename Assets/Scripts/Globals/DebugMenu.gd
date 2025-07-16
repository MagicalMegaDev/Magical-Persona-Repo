extends Control

var panel_list: Array[PanelContainer] = []
@onready var tab := $TabContainer 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

##  Called by whoever is gathering runtime variables
##  `variable_list` = [
##     { "Name": "", "Value": any, "Category": "Panel-Name",
##       "Sub-Category": "Optional Sub" }
##  ]
func _on_variables_gathered(variable_list:Array) -> void:
	
	#Make a map of the panels currently in the Tab Container
	var panel_map: Dictionary = {}
	for p in panel_list:
		panel_map[p.name] = p

	for entry:Dictionary in variable_list:
		var panel_name:String = entry["Category"]
		if panel_name.is_empty():
			panel_name = "General"
		
		var panel = panel_map[panel_name]
		if(panel == null):
			#panel = create_panel(panel_name)
			panel_map[panel_name] = panel
			panel_list.append(panel)
			tab.add_child(panel)
			#_sort_panels(tab)
			
		#if panel doesn't have category
		#_create_category(category_name, panel)
		#Alpha sort the categories if a new one was made
		#Somehow figure out a way to find which GridContainer belongs to which Category
		#Make a new DebugVariable and set it's name and value to the entry's name and value
		#Attach the DebugVariable to the GridContainer.
		#Alpha sort the variables in the Grid Container by name

func _create_panel(panel_name:String) -> PanelContainer:
	for panel in panel_list:
		if panel.name == panel_name:
			print("DebugMenu: %s Panel already exists!" % panel_name)
			return panel
		
	var new_panel := PanelContainer.new()
	new_panel.name = name
	
	#Structure should be Margin Container -> Scroll Container -> VBox -> Label: CategoryName, HSeperator, GridContainer-> Variables
	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 30)
	margin.add_theme_constant_override("margin_top", 10)
	new_panel.add_child(margin)
	#Add Scroll Container
	#Add VBoxContainer
	
	return new_panel
	
func _create_category(category_name:String, panel:PanelContainer):
	#If the panel contains category, return and print that category already exists
	#Else
	#Make a label and set it's text to the category
	#make an HSeperator
	#Add Grid Container
	
	return
