use std::collections::{HashMap, HashSet};

pub struct School {
    grades: HashMap<u32, HashSet<String>>,
}

impl School {
    pub fn new() -> School {
        Self {
            grades: HashMap::new(),
        }
    }

    pub fn add(&mut self, grade: u32, student: &str) {
        let already_in_grade = self
            .grades
            .values()
            .any(|students| students.contains(student));
        
        if already_in_grade {
            return; // Student already in this grade, do nothing
        }

        self.grades
            .entry(grade)
            .or_default()
            .insert(student.to_string());
    }

    pub fn grades(&self) -> Vec<u32> {
        let mut grades: Vec<u32> = self.grades.keys().cloned().collect();
        grades.sort();
        grades
    }

    // If `grade` returned a reference, `School` would be forced to keep a `Vec<String>`
    // internally to lend out. By returning an owned vector of owned `String`s instead,
    // the internal structure can be completely arbitrary. The tradeoff is that some data
    // must be copied each time `grade` is called.
    pub fn grade(&self, grade: u32) -> Vec<String> {
        self.grades
            .get(&grade)
            .map(|students| {
                let mut sorted_students: Vec<String> = students.iter().cloned().collect();
                sorted_students.sort();
                sorted_students
            })
            .unwrap_or_default()
    }
}
