use std::fmt;

#[derive(Debug, Eq, PartialEq)]
pub struct Clock {
    hours: i32,
    minutes: i32,
}

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        if hours < 0 {
            return Clock::new(hours + 24, minutes);
        }

        if minutes < 0 {
            return Clock::new(hours - 1, minutes + 60);
        }

        Clock {
            hours: (hours + minutes / 60) % 24,
            minutes: minutes % 60,
        }
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        let hours = (self.hours + (self.minutes + minutes) / 60) % 24;
        let minutes = (self.minutes + minutes) % 60;

        Clock::new(hours, minutes)
    }
}

impl fmt::Display for Clock {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{:02}:{:02}", self.hours, self.minutes)
    }
}
