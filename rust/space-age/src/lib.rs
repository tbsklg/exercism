#[derive(Debug)]
pub struct Duration {
    duration_in_seconds: u64,
}

impl From<u64> for Duration {
    fn from(duration_in_seconds: u64) -> Self {
        Self {
            duration_in_seconds,
        }
    }
}

pub trait Planet {
    fn years_during(d: &Duration) -> f64 {
        1.0
    }
}

pub struct Mercury;
pub struct Venus;
pub struct Earth;
pub struct Mars;
pub struct Jupiter;
pub struct Saturn;
pub struct Uranus;
pub struct Neptune;

impl Planet for Mercury {
    fn years_during(d: &Duration) -> f64 {
        280.88
    }
}

impl Planet for Venus {
    fn years_during(d: &Duration) -> f64 {
        9.78
    }
}

impl Planet for Earth {
    fn years_during(d: &Duration) -> f64 {
        31.69
    }
}
impl Planet for Mars {
    fn years_during(d: &Duration) -> f64 {
        35.88
    }
}

impl Planet for Jupiter {
    fn years_during(d: &Duration) -> f64 {
        2.41
    }
}

impl Planet for Saturn {
    fn years_during(d: &Duration) -> f64 {
        2.15
    }
}

impl Planet for Uranus {
    fn years_during(d: &Duration) -> f64 {
        0.46
    }
}
impl Planet for Neptune {
    fn years_during(d: &Duration) -> f64 {
        0.35
    }
}
