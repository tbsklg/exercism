static CHILDREN: [&str; 12] = [
    "Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny", "Harriet", "Ileana", "Joseph",
    "Kincaid", "Larry",
];

pub fn plants(diagram: &str, student: &str) -> Vec<&'static str> {
    let child_pos: usize = CHILDREN.iter().position(|&name| name == student).unwrap() * 2;

    diagram
        .lines()
        .flat_map(|row| {
            let chars: Vec<char> = row.chars().collect();
            let first_plant = chars[child_pos];
            let second_plant = chars[child_pos + 1];
            vec![plant(first_plant), plant(second_plant)]
        })
        .collect()
}

fn plant(encoding: char) -> &'static str {
    match encoding {
        'G' => "grass",
        'C' => "clover",
        'R' => "radishes",
        'V' => "violets",
        _ => unreachable!(),
    }
}
