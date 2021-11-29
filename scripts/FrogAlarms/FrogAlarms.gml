function FrogAlarms() constructor {
	frog_alarms = {};
	default_idx = 0;
	
	
	#region Frog Alarm Actions
	
	
		create = function(_function, _duration, _idx = ("__default_" + string(default_idx))) {
			var idx = string(_idx);
		
			// Don't allow duplicates if an idx is specified
			if (variable_struct_exists(frog_alarms, idx)) { return; }
		
			// Add alarm to the running frog_alarms
			frog_alarms[$ idx] = {
				running: true,
				action: _function,
				duration: _duration,
				time: _duration,
			}
		
			default_idx++;
		}
		
		
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
	
	
		restart = function(_idx) {
			var idx = string(_idx);
			if (!idx_exists(idx)) { return; }
			frog_alarms[$ idx].time = frog_alarms[$ idx].duration;
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
	
	
	#endregion
	#region Getters and Setters
	
	
		get_time = function(_idx) {
			var idx = string(_idx);
			if (!idx_exists(idx)) { return undefined; }
			return frog_alarms[$ idx].time;
		}
	
	
		set_time = function(_idx, _time) {
			var idx = string(_idx);
			if (!idx_exists(idx)) { return; }
		
			frog_alarms[$ idx].time = _time;
			if (_time > frog_alarms[$ idx].duration) {
				frog_alarms[$ idx].duration = _time;
			}
		}
	
	
		get_duration = function(_idx) {
			var idx = string(_idx);
			if (!idx_exists(idx)) { return undefined; }
			return frog_alarms[$ idx].duration;
		}
	
	
		set_duration = function(_idx, _duration) {
			var idx = string(_idx);
			if (!idx_exists(idx)) { return; }
			frog_alarms[$ idx].duration = _duration;
		}
	
	
		is_running = function(_idx) {
			var idx = string(_idx);
			if (!idx_exists(idx)) { return; }
			return frog_alarms[$ idx].running;
		}
	
	
	#endregion
	#region Utils
	
	
		idx_exists = function(_idx) {
			if (!variable_struct_exists(frog_alarms, _idx)) {
				show_debug_message("FrogAlarm: '" + string(_idx) + "' not found!");
				return false;
			}
			return true;
		}
	
	
	#endregion
}