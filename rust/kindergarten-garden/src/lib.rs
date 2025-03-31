static CHILDREN: [&str; 12] = [
    "Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny", "Harriet", "Ileana", "Joseph",
    "Kincaid", "Larry",
];

pub fn plants(diagram: &str, student: &str) -> Vec<&'static str> {
    let student_idx = CHILDREN
        .iter()
        .position(|&name| name == student)
        .map(|pos| pos * 2)
        .unwrap_or_else(|| panic!("Student not found"));

    diagram
        .lines()
        .flat_map(|row| {
            row.chars().skip(student_idx).take(2).map(|c| match c {
                'G' => "grass",
                'C' => "clover",
                'R' => "radishes",
                'V' => "violets",
                _ => unreachable!(),
            })
        })
        .collect()
}
