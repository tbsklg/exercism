module ComplexNumbers (
  Complex,
  conjugate,
  abs,
  exp,
  real,
  imaginary,
  mul,
  add,
  sub,
  div,
  complex,
) where

import Prelude hiding (abs, div, exp)
import qualified Prelude as P

-- Data definition -------------------------------------------------------------
data Complex a = Complex a a deriving (Show, Eq)

complex :: (a, a) -> Complex a
complex (a, b) = Complex a b

-- unary operators -------------------------------------------------------------
conjugate :: Num a => Complex a -> Complex a
conjugate (Complex a b) = Complex a (-b)

abs :: Floating a => Complex a -> a
abs (Complex a b) = sqrt $ a ^ 2 + b ^ 2

real :: Num a => Complex a -> a
real (Complex a _) = a 

imaginary :: Num a => Complex a -> a
imaginary (Complex _ b) = b

exp :: Floating a => Complex a -> Complex a
exp (Complex a b) = Complex (P.exp a * cos b) (P.exp a * sin b)

-- binary operators ------------------------------------------------------------
mul :: Num a => Complex a -> Complex a -> Complex a
mul (Complex a b) (Complex a' b') = Complex (a * a' - b * b') (a * b' + b * a') 

add :: Num a => Complex a -> Complex a -> Complex a
add (Complex a b) (Complex a' b') = Complex (a + a') (b + b')

sub :: Num a => Complex a -> Complex a -> Complex a
sub (Complex a b) (Complex a' b') = Complex (a - a') (b - b')

div :: Fractional a => Complex a -> Complex a -> Complex a
div (Complex a b) (Complex a' b') = Complex ((a * a' + b * b') / (a' ^ 2 + b' ^ 2)) ((b * a' - a * b') / (a' ^ 2 + b' ^ 2))
