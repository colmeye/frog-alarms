function FrogAlarms() constructor {
	alarms = {};
	default_idx = 50000;
	
	
	run = function() {
		var keys = variable_struct_get_names(alarms);
		
		// Loop through all keys in alarms, decrement time
		for (var i = array_length(keys)-1; i >= 0; --i) {
			var key = keys[i];
			var _alarm = alarms[$ key];
			
			// Don't use alarms that were removed or aren't running
			if (_alarm == undefined) { continue; }
			if (!_alarm.running) { continue; }
			
			_alarm.time -= 1;
			
			// Run the action if time reaches 0, and remove from struct
			if (_alarm.time < 1) {
				_alarm.action();
				variable_struct_remove(alarms, key);
			}
		}
	}

	
	start = function(_function, _time, _idx = default_idx) {
		idx = string(_idx);
		
		// Don't allow duplicates if an idx is specified
		if (variable_struct_exists(alarms, idx)) {
			return;
		}
		
		// Add alarm to the running alarms
		alarms[$ idx] = {
			running: true,
			action: _function,
			initial_time: _time,
			time: _time,
		}
		
		default_idx++;
	}
	
	
	reset = function(_idx) {
		check_idx_exists(_idx);
		alarms[$ _idx].time = alarms[$ _idx].initial_time;
	}
	
	
	pause = function(_idx) {
		check_idx_exists(_idx);
		alarms[$ _idx].running = false;
	}
	
	
	resume = function(_idx) {
		check_idx_exists(_idx);
		alarms[$ _idx].running = true;
	}
	
	
	remove = function(_idx) {
		check_idx_exists(_idx);
		variable_struct_remove(alarms, _idx);
	}
	
	
	check_idx_exists = function(_idx) {
		if (variable_struct_exists(alarms, _idx)) {
			return true;	
		} else {
			// throw("FrogAlarm idx " + string(_idx) + " not found.");
			return false;
		}
	}
	
	
}