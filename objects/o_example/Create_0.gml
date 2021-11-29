fa = new FrogAlarms();

fa.create(
	function() {
		show_debug_message("Ribbit " + string(frame_count));
	},
	200,
);
