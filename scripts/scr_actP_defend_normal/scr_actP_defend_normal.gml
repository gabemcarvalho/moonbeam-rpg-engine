/// @description scr_actA_defend_normal(return)
/// @param return
function scr_actP_defend_normal(argument0) {
	/*
		A party member defends themself
	*/

	// Set the properties of the action
	var act_name = "Defend";
	var act_cost = 0;
	var act_descrip = "Defend\nyourself";
	var act_target = TARGET_SELF;

	// Get the arguments
	var return_arg = argument0;

	if return_arg == ACT_NAME {
		return act_name;
	} else if return_arg == ACT_COST {
		return act_cost;
	} else if return_arg == ACT_DESCRIP {
		return act_descrip;
	} else if return_arg == ACT_TARGET {
		return act_target;
	} else if return_arg == ACT_RUN {
		// Execute the action
		acting.defending = true;
	
		// Display some text
		text_add(acting.name+" prepares for incoming attacks!");
	
		// Done
		act_done = true;
	}


}
