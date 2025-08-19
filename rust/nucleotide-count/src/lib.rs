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
    todo!("How much of every nucleotide type is contained inside DNA string '{dna}'?");
}
