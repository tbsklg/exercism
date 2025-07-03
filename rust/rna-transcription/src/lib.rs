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
        for (i, c) in dna.chars().enumerate() {
            match c {
                'A' | 'C' | 'G' | 'T' => continue,
                _ => return Err(i),
            }
        }

        Ok(Self {
            dna: dna.to_string(),
        })
    }

    pub fn into_rna(self) -> Rna {
        let to_rna = |nucleotide| match nucleotide {
            'C' => Some('G'),
            'G' => Some('C'),
            'T' => Some('A'),
            'A' => Some('U'),
            _ => None,
        };

        let rna: Result<String, usize> = self
            .dna
            .chars()
            .enumerate()
            .map(|(i, n)| to_rna(n).ok_or(i))
            .collect();

        let rna_string = rna.expect("Invalid nucleotide in DNA");

        Rna::new(&rna_string).expect("Failed to construct RNA")
    }
}

impl Rna {
    pub fn new(rna: &str) -> Result<Rna, usize> {
        for (i, c) in rna.chars().enumerate() {
            match c {
                'G' | 'C' | 'A' | 'U' => continue,
                _ => return Err(i),
            }
        }

        Ok(Self {
            rna: rna.to_string(),
        })
    }
}
