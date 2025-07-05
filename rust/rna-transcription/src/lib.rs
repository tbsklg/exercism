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
        Rna::new(&self.dna).unwrap()
    }
}

impl Rna {
    pub fn new(rna: &str) -> Result<Rna, usize> {
        Ok(Self {
            rna: rna.to_string(),
        })
    }
}
