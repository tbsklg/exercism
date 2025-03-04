#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub enum Allergen {
    Eggs,
    Peanuts,
    Shellfish,
    Strawberries,
    Tomatoes,
    Chocolate,
    Pollen,
    Cats,
}

pub struct Allergies {
    score: u32,
}

impl Allergies {
    pub fn new(score: u32) -> Self {
        Self { score }
    }

    pub fn is_allergic_to(&self, allergen: &Allergen) -> bool {
        let allergen_bit = *allergen as u32;
        self.score & (1 << allergen_bit) != 0
    }

    pub fn allergies(&self) -> Vec<Allergen> {
        [
            Allergen::Eggs,
            Allergen::Peanuts,
            Allergen::Shellfish,
            Allergen::Strawberries,
            Allergen::Tomatoes,
            Allergen::Chocolate,
            Allergen::Pollen,
            Allergen::Cats,
        ]
        .iter()
        .filter(|&allergen| self.is_allergic_to(allergen))
        .cloned()
        .collect()
    }
}
