pub fn recite(start_bottles: u32, take_down: u32) -> String {
    (start_bottles - take_down + 1..=start_bottles)
        .rev()
        .map(|bottles| {
            let (current, next, next_count) = match bottles {
                1 => ("One", "no", 0),
                2 => ("Two", "one", 1),
                3 => ("Three", "two", 2),
                4 => ("Four", "three", 3),
                5 => ("Five", "four", 4),
                6 => ("Six", "five", 5),
                7 => ("Seven", "six", 6),
                8 => ("Eight", "seven", 7),
                9 => ("Nine", "eight", 8),
                10 => ("Ten", "nine", 9),
                _ => unreachable!(),
            };

            format!(
                "{current} green bottle{} hanging on the wall,\n\
                 {current} green bottle{} hanging on the wall,\n\
                 And if one green bottle should accidentally fall,\n\
                 There'll be {next} green bottle{} hanging on the wall.",
                if bottles == 1 { "" } else { "s" },
                if bottles == 1 { "" } else { "s" },
                if next_count == 1 { "" } else { "s" }
            )
        })
        .collect::<Vec<_>>()
        .join("\n\n")
}
