# FrogAlarms

FrogAlarms is a GameMaker Studio 2 asset that makes alarms easier to create, use, and manage.

## Installation

Download the release, and drag it into your GMS2 IDE window

## Setup
First you'll need to initialize the FrogAlarms. Add the following code to the `Create` event of an object.
```js
// Create
fa = new FrogAlarms();
```
To run the frog alarms within the struct, call their `run()` function in the `Step` event
```js
// Step
fa.run();
```

## Usage

### .start(function, time, index `optional`)

| Argument | Type | Description |
| --- | --- | --- |
| function | Function | A function that will run when the alarm is finished. |
| time | Integer | How long the alarm should run in frames |
| index | any | Optional. Adding an index to an alarm allows it to be referenced after it has started. Alarms with the same index will not be restarted or recreated. |

A basic FrogAlarm can be created using the `start()` function.

```js
// Create
fa.start(
  function() {
	  show_debug_message("Ribbit");
  },
  60
);

// Outputs `Ribbit` after 60 frames.
```

Adding an index prevents starting duplicate alarms

```js
// Step
fa.start(
  function() {
	  show_debug_message("Ribbit");
  },
  room_speed,
  "my_frog_alarm"
);

// Outputs `Ribbit` ONCE every second.
```

### .pause(index)
### .remove(index) `FrogAlarms are auto-removed once they finish`
### .restart(index)
### .resume(index)

| Argument | Type | Description |
| --- | --- | --- |
| index | any | The previously set index of the FrogAlarm |

These functions can be used to alter an alarm that was started with an index

```js
enum MyAlarms {
  RIBBIT_ALARM
}

// Create
fa.start(
  function() {
	  show_debug_message("Ribbit");
  },
  room_speed * 5,
  MyAlarms.RIBBIT_ALARM
);

fa.start(
  function() {
	  fa.pause(MyAlarms.RIBBIT_ALARM);
  },
  room_speed * 2,
);

fa.start(
  function() {
	  fa.resume(MyAlarms.RIBBIT_ALARM);
  },
  room_speed * 4,
);


// Starts MyAlarm.RIBBIT_ALARM. Pauses it after two seconds. Resumes it after another two. MyAlarm.RIBBIT_ALARM goes off after another three seconds.
```


## License
[MIT](https://choosealicense.com/licenses/mit/)
