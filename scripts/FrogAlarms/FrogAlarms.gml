function FrogAlarms() constructor {
	frog_alarms = {};
	default_idx = 0;
	
	
	run = function() {
		var keys = variable_struct_get_names(frog_alarms);
		if (array_length(keys) < 1) { return; }
		
		// Loop through all keys in frog_alarms, decrement time
		for (var i = 0; i < array_length(keys); i++) {
			
			var key = keys[i];
			var frog_alarm = frog_alarms[$ key];
			if (!frog_alarm.running) { continue; }
			
			frog_alarm.time -= 1;
			
			// Run the action if time reaches 0, and remove from struct
			if (frog_alarm.time < 1) {
				frog_alarm.action();
				variable_struct_remove(frog_alarms, key);
			}
		}
	}

	
	start = function(_function, _time, _idx = ("__default_" + string(default_idx))) {
		var idx = string(_idx);
		
		// Don't allow duplicates if an idx is specified
		if (variable_struct_exists(frog_alarms, idx)) {
			return;
		}
		
		// Add alarm to the running frog_alarms
		frog_alarms[$ idx] = {
			running: true,
			action: _function,
			initial_time: _time,
			time: _time,
		}
		
		default_idx++;
	}
	
	
	restart = function(_idx) {
		var idx = string(_idx);
		if (!idx_exists(idx)) { return; }
		frog_alarms[$ idx].time = frog_alarms[$ idx].initial_time;
	}
	
	
	pause = function(_idx) {
		var idx = string(_idx);
		if (!idx_exists(idx)) { return; }
		frog_alarms[$ idx].running = false;
	}
	
	
	resume = function(_idx) {
		var idx = string(_idx);
		if (!idx_exists(idx)) { return; }
		frog_alarms[$ idx].running = true;
	}
	
	
	remove = function(_idx) {
		var idx = string(_idx);
		if (!idx_exists(idx)) { return; }
		variable_struct_remove(frog_alarms, idx);
	}
	
	idx_exists = function(_idx) {
		if (!variable_struct_exists(frog_alarms, _idx)) {
			show_debug_message("FrogAlarm: '" + string(_idx) + "' not found!");
			return false;
		}
		return true;
	}
	
	
}