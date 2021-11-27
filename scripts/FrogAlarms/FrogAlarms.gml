function FrogAlarms() constructor {
	alarms = {};
	default_idx = 50000;
	
	static run = function() {
		// Loop through all keys in alarms, decrement time
		var keys = variable_struct_get_names(alarms);
		for (var i = array_length(keys)-1; i >= 0; --i) {
			var key = keys[i];
			var _alarm = alarms[$ key];
			
			if (!_alarm.running) {
				continue;	
			}
			
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
	
	
}