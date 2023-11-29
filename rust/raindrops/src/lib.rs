struct Raindrop {
    n: u32,
    sound: String,
}

impl Raindrop {
    fn from(n: u32, sound: &str) -> Self {
        Self {
            n,
            sound: sound.to_string(),
        }
    }
}

pub fn raindrops(n: u32) -> String {
    let raindrop_sounds = [
        Raindrop::from(3, "Pling"),
        Raindrop::from(5, "Plang"),
        Raindrop::from(7, "Plong"),
    ];

    let sound = raindrop_sounds
        .iter()
        .fold(String::new(), |acc, curr| match n % curr.n == 0 {
            true => acc + &curr.sound,
            false => acc,
        });

    match sound.is_empty() {
        true => n.to_string(),
        false => sound,
    }
}
