#[derive(Debug, PartialEq, Eq)]
pub struct Dna {
    dna: String,
}

#[derive(Debug, PartialEq, Eq)]
pub struct Rna {
    rna: String,
}

impl Dna {
    pub fn new(dna: &str) -> Result<Dna, usize> {
        Ok(Self {
            dna: dna.to_string(),
        })
    }

    pub fn into_rna(self) -> Rna {
        let to_rna = |nucleotide| match nucleotide {
            'C' => 'G',
            'G' => 'C',
            'T' => 'A',
            'A' => 'U',
            _ => panic!("Invalid nucleotide: {}", nucleotide),
        };

        let rna: String = self.dna.chars().map(to_rna).collect();
        Rna::new(&rna).unwrap()
    }
}

impl Rna {
    pub fn new(rna: &str) -> Result<Rna, usize> {
        Ok(Self {
            rna: rna.to_string(),
        })
    }
}
