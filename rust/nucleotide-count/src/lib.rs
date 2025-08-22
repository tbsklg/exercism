use std::collections::HashMap;

pub fn count(nucleotide: char, dna: &str) -> Result<usize, char> {
    if nucleotide == 'X' {
        return Err('X');
    }
    
    for c in dna.chars() {
        if c != 'A' && c != 'C' && c != 'G' && c != 'T' {
            return Err(c);
        }
    }

    Ok(dna.chars().filter(|&c| c == nucleotide).count())
}

pub fn nucleotide_counts(dna: &str) -> Result<HashMap<char, usize>, char> {
    let mut counts = HashMap::new();
    counts.insert('A', 0);
    counts.insert('C', 0);
    counts.insert('G', 0);
    counts.insert('T', 0);

    for c in dna.chars() {
        if c != 'A' && c != 'C' && c != 'G' && c != 'T' {
            return Err(c);
        }
        *counts.get_mut(&c).unwrap() += 1;
    }

    Ok(counts)
}
