pub fn translate(rna: &str) -> Option<Vec<&'static str>> {
    let mut proteins = Vec::new();
    let mut i = 0;

    while i + 3 <= rna.len() {
        let codon = &rna[i..i + 3];
        match to_protein(codon) {
            Some("STOP") => return Some(proteins),
            Some(protein) => proteins.push(protein),
            None => return None,
        }
        i += 3;
    }

    if i < rna.len() {
        None
    } else {
        Some(proteins)
    }
}

fn to_protein(rna: &str) -> Option<&'static str> {
    match rna {
        "AUG" => Some("Methionine"),
        "UUU" | "UUC" => Some("Phenylalanine"),
        "UUA" | "UUG" => Some("Leucine"),
        "UCU" | "UCC" | "UCA" | "UCG" => Some("Serine"),
        "UAU" | "UAC" => Some("Tyrosine"),
        "UGU" | "UGC" => Some("Cysteine"),
        "UGG" => Some("Tryptophan"),
        "UAA" | "UAG" | "UGA" => Some("STOP"),
        _ => None,
    }
}
