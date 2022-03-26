![Frog Alarms Cover Image](cover.jpg?raw=true)

# FrogAlarms

FrogAlarms is a GameMaker Studio 2 asset that provides a simple and easy-to-use alternative to alarms.

## Why Use FrogAlarms?

Easily delay the execution of code wherever you need!

```js
// Create event
fa.create(
    function() {
        show_debug_message("Ribbit");
    },
    60
);

// Outputs `Ribbit` after 60 frames.
```

Add an index to an alarm to access it later and prevent it from restarting itself.

```js
// Create event
fa.create(
    function() {
        fa.pause("my_frog_alarm");
    },
    room_speed * 10
);

// Step event
fa.create(
    function() {
        show_debug_message("Ribbit");
    },
    room_speed,
    "my_frog_alarm"
);

// Outputs `Ribbit` ONCE every second, until paused at ten seconds.
```

## Documentation
Check out the [Wiki](https://github.com/colmeye/FrogAlarms/wiki/Documentation) for more details!


## License
[MIT](https://choosealicense.com/licenses/mit/)
