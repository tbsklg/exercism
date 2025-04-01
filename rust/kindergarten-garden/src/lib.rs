static CHILDREN: [&str; 12] = [
    "Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny", "Harriet", "Ileana", "Joseph",
    "Kincaid", "Larry",
];

type Student = &'static str;
type Plant = &'static str;
type Garden = &'static str;

pub fn plants(diagram: Garden, student: Student) -> Vec<Plant> {
    let find_student_columns = |student: Student| -> Option<usize> {
        CHILDREN.iter()
            .position(|&name| name == student)
            .map(|pos| pos * 2)
    };
    
    let plant_from_char = |c: char| -> Plant {
        match c {
            'G' => "grass",
            'C' => "clover",
            'R' => "radishes",
            'V' => "violets",
            _ => unreachable!(),
        }
    };
    
    let extract_student_plants = |diagram: Garden, column: usize| -> Vec<Plant> {
        diagram
            .lines()
            .flat_map(|line| 
                line.chars()
                    .skip(column)
                    .take(2)
                    .map(plant_from_char)
            )
            .collect()
    };
    
    match find_student_columns(student) {
        Some(column) => extract_student_plants(diagram, column),
        None => panic!("Student {} not found in garden", student)
    }
}
