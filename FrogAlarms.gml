function FrogAlarms() constructor {
	frog_alarms = {};
	default_idx = 0;
	
	
	#region Frog Alarm Actions
	
		
		 function list( _function = function(_alarm_idx) { return true; } ) {
			var keys = variable_struct_get_names(frog_alarms);
			if (array_length(keys) < 1) { return; }
			
			var filtered_alarms = [];
			for (var i = 0; i < array_length(keys); i++) {
				var key = keys[i];
				if ( _function(key) ) {
					array_push(filtered_alarms, key);
				}
			}
			
			return filtered_alarms;			
		}
		
	
		function create( _function, _duration, _idx = ("__default_" + string(default_idx)) ) {
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
		
		
		function run() {
			var keys = variable_struct_get_names(frog_alarms);
			if (array_length(keys) < 1) { return; }
		
			// Loop through all keys in frog_alarms, decrement time
			for (var i = 0; i < array_length(keys); i++) {
			
				var key = keys[i];
				var frog_alarm = frog_alarms[$ key];
			
				if (frog_alarm == undefined || !frog_alarm.running) { continue; }
			
				frog_alarm.time -= 1;
			
				// Run the action if time reaches 0, and remove from struct
				if (frog_alarm.time < 1) {
					frog_alarm.action();
					variable_struct_remove(frog_alarms, key);
				}
			}
		}
	
	
		function restart(_idx) {
			var idx_array = make_array_of_strings(_idx);
			for_each(idx_array, function(idx) {
				if (!idx_exists(idx)) { return; }
				frog_alarms[$ idx].time = frog_alarms[$ idx].duration;
			});
		}
	
	
		function pause(_idx) {
			var idx_array = make_array_of_strings(_idx);
			for_each(idx_array, function(idx) {
				if (!idx_exists(idx)) { return; }
				frog_alarms[$ idx].running = false;
			});
		}
	
	
		function resume(_idx) {
			var idx_array = make_array_of_strings(_idx);
			for_each(idx_array, function(idx) {
				if (!idx_exists(idx)) { return; }
				frog_alarms[$ idx].running = true;
			});
		}
	
		
		function remove(_idx) {
			var idx_array = make_array_of_strings(_idx);
			for_each(idx_array, function(idx) {
				if (!idx_exists(idx)) { return; }
				variable_struct_remove(frog_alarms, idx);
			});
		}
	
	
	#endregion
	#region Getters and Setters
	
	
		function get_time(_idx) {
			var idx = string(_idx);
			return idx_exists(idx) ? frog_alarms[$ idx].time : undefined;
		}
	
	
		function set_time(_idx, _time) {
			var idx = string(_idx);
			if (!idx_exists(idx)) { return; }
		
			frog_alarms[$ idx].time = _time;
			if (_time > frog_alarms[$ idx].duration) {
				frog_alarms[$ idx].duration = _time;
			}
		}
	
	
		function get_duration(_idx) {
			var idx = string(_idx);
			return idx_exists(idx) ? frog_alarms[$ idx].duration : undefined;
		}
	
	
		function set_duration(_idx, _duration) {
			var idx = string(_idx);
			if (!idx_exists(idx)) { return; }
			frog_alarms[$ idx].duration = _duration;
		}
	
	
		function is_running(_idx) {
			var idx = string(_idx);
			return idx_exists(idx) ? frog_alarms[$ idx].running : false;
		}
		
		
		function exists(_idx) {
			var idx = string(_idx);
			return variable_struct_exists(frog_alarms, idx) ? true : false;
		}
	
	
	#endregion
	#region Utils
	
	
		function idx_exists(_idx) {
			if (!variable_struct_exists(frog_alarms, _idx)) {
				show_debug_message("FrogAlarm: '" + string(_idx) + "' not found!");
				return false;
			}
			return true;
		}
		
		
		function make_array_of_strings(_input) {
			// If only one input, put it into an array
			var input_array = is_array(_input) ? _input : [_input];
			
			// Convert all array elements to strings
			var array = [];
			for (var i = 0; i < array_length(input_array); i++) {
				array_push( array, string(input_array[i]) );
			}
			
			return array;
		}
		
		
		function for_each( _array, _function ) {
			for (var i = 0; i < array_length(_array); i++) {
				_function(_array[i]);	
			}
		}
	
	
	#endregion
}
