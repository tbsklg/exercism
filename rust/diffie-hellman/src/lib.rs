use rand::Rng;

pub fn private_key(p: u64) -> u64 {
    rand::rng().random_range(2..p)
}

pub fn public_key(p: u64, g: u64, a: u64) -> u64 {
    mod_pow(g, a, p)
}

pub fn secret(p: u64, b_pub: u64, a: u64) -> u64 {
    mod_pow(b_pub, a, p)
}

fn mod_pow(base: u64, exp: u64, modulus: u64) -> u64 {
    if modulus == 1 {
        return 0;
    }

    fn mod_pow_helper(base: u64, exp: u64, modulus: u64, result: u64) -> u64 {
        if exp == 0 {
            return result;
        }

        let new_result = if exp % 2 == 1 {
            (result * base) % modulus
        } else {
            result
        };

        mod_pow_helper((base * base) % modulus, exp / 2, modulus, new_result)
    }

    mod_pow_helper(base % modulus, exp, modulus, 1)
}
