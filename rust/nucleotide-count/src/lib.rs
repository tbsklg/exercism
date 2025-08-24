use std::collections::HashMap;

pub fn count(nucleotide: char, dna: &str) -> Result<usize, char> {
    if !matches!(nucleotide, 'A' | 'C' | 'G' | 'T') {
        return Err(nucleotide);
    }

    let mut count = 0;
    for c in dna.chars() {
        match c {
            'A' | 'C' | 'G' | 'T' => {
                if c == nucleotide {
                    count += 1;
                }
            }
            invalid => return Err(invalid),
        }
    }

    Ok(count)
}

pub fn nucleotide_counts(dna: &str) -> Result<HashMap<char, usize>, char> {
    let mut counts = HashMap::from([('A', 0), ('C', 0), ('G', 0), ('T', 0)]);

    for c in dna.chars() {
        match c {
            'A' | 'C' | 'G' | 'T' => {
                *counts
                    .get_mut(&c)
                    .expect("Valid nucleotide should exist in map") += 1;
            }
            invalid => return Err(invalid),
        }
    }

    Ok(counts)
}
