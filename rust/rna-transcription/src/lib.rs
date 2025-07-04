#[derive(Debug, PartialEq, Eq)]
pub struct Dna {
    dna: String,
}

#[derive(Debug, PartialEq, Eq)]
pub struct Rna {
    rna: String,
}

impl Dna {
    pub fn new(dna: &str) -> Result<Self, usize> {
        dna.chars()
            .enumerate()
            .find(|(_, c)| !matches!(c, 'A' | 'C' | 'G' | 'T'))
            .map_or_else(|| Ok(Self { dna: dna.to_string() }), |(i, _)| Err(i))
    }

    pub fn into_rna(self) -> Rna {
        let to_rna = |nucleotide| match nucleotide {
            'C' => 'G',
            'G' => 'C',
            'T' => 'A',
            'A' => 'U',
            _ => unreachable!(), // already validated in Dna::new
        };

        let rna_string: String = self.dna.chars().map(to_rna).collect();

        Rna::new(&rna_string).unwrap() // safe due to known valid output
    }
}

impl Rna {
    pub fn new(rna: &str) -> Result<Self, usize> {
        rna.chars()
            .enumerate()
            .find(|(_, c)| !matches!(c, 'G' | 'C' | 'A' | 'U'))
            .map_or_else(|| Ok(Self { rna: rna.to_string() }), |(i, _)| Err(i))
    }
}
