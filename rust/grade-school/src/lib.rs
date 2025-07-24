pub struct School {
    grade: u8,
}

impl School {
    pub fn new() -> School {
        Self {
            grade: 1,
        }
    }

    pub fn add(&mut self, grade: u32, student: &str) {
    }

    pub fn grades(&self) -> Vec<u32> {
        todo!()
    }

    // If `grade` returned a reference, `School` would be forced to keep a `Vec<String>`
    // internally to lend out. By returning an owned vector of owned `String`s instead,
    // the internal structure can be completely arbitrary. The tradeoff is that some data
    // must be copied each time `grade` is called.
    pub fn grade(&self, grade: u32) -> Vec<String> {
        vec![]
    }
}
