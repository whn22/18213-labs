/*
 * CS:APP Data Lab
 *
 * <Please put your name and userid here>
 *
 * bits.c - Source file with your solutions to the Lab.
 *          This is the file you will hand in to your instructor.
 */

/* Instructions to Students:

You will provide your solution to the Data Lab by
editing the collection of functions in this source file.

INTEGER CODING RULES:

  Replace the "return" statement in each function with one
  or more lines of C code that implements the function. Your code
  must conform to the following style:

  long Funct(long arg1, long arg2, ...) {
      // brief description of how your implementation works
      long var1 = Expr1;
      ...
      long varM = ExprM;

      varJ = ExprJ;
      ...
      varN = ExprN;
      return ExprR;
  }

  Each "Expr" is an expression using ONLY the following:
  1. (Long) integer constants 0 through 255 (0xFFL), inclusive. You are
      not allowed to use big constants such as 0xffffffffL.
  2. Function arguments and local variables (no global variables).
  3. Local variables of type int and long
  4. Unary integer operations ! ~
     - Their arguments can have types int or long
     - Note that ! always returns int, even if the argument is long
  5. Binary integer operations & ^ | + << >>
     - Their arguments can have types int or long
  6. Casting from int to long and from long to int

  Some of the problems restrict the set of allowed operators even further.
  Each "Expr" may consist of multiple operators. You are not restricted to
  one operator per line.

  You are expressly forbidden to:
  1. Use any control constructs such as if, do, while, for, switch, etc.
  2. Define or use any macros.
  3. Define any additional functions in this file.
  4. Call any functions.
  5. Use any other operations, such as &&, ||, -, or ?:
  6. Use any form of casting other than between int and long.
  7. Use any data type other than int or long.  This implies that you
     cannot use arrays, structs, or unions.

  You may assume that your machine:
  1. Uses 2s complement representations for int and long.
  2. Data type int is 32 bits, long is 64.
  3. Performs right shifts arithmetically.
  4. Has unpredictable behavior when shifting if the shift amount
     is less than 0 or greater than 31 (int) or 63 (long)

EXAMPLES OF ACCEPTABLE CODING STYLE:
  //
  // pow2plus1 - returns 2^x + 1, where 0 <= x <= 63
  //
  long pow2plus1(long x) {
     // exploit ability of shifts to compute powers of 2
     // Note that the 'L' indicates a long constant
     return (1L << x) + 1L;
  }

  //
  // pow2plus4 - returns 2^x + 4, where 0 <= x <= 63
  //
  long pow2plus4(long x) {
     // exploit ability of shifts to compute powers of 2
     long result = (1L << x);
     result += 4L;
     return result;
  }

NOTES:
  1. Use the dlc (data lab checker) compiler (described in the handout) to
     check the legality of your solutions.
  2. Each function has a maximum number of operations (integer, logical,
     or comparison) that you are allowed to use for your implementation
     of the function.  The max operator count is checked by dlc.
     Note that assignment ('=') is not counted; you may use as many of
     these as you want without penalty.
  3. Use the btest test harness to check your functions for correctness.
  4. Use the BDD checker to formally verify your functions
  5. The maximum number of ops for each function is given in the
     header comment for each function. If there are any inconsistencies
     between the maximum ops in the writeup and in this file, consider
     this file the authoritative source.

CAUTION:
  Do not add an #include of <stdio.h> (or any other C library header)
  to this file.  C library headers almost always contain constructs
  that dlc does not understand.  For debugging, you can use printf,
  which is declared for you just below.  It is normally bad practice
  to declare C library functions by hand, but in this case it's less
  trouble than any alternative.

  dlc will consider each call to printf to be a violation of the
  coding style (function calls, after all, are not allowed) so you
  must remove all your debugging printf's again before submitting your
  code or testing it with dlc or the BDD checker.  */

extern int printf(const char *, ...);

/* Edit the functions below.  Good luck!  */
// 1
/*
 * bitXor - x^y using only ~ and &
 *   Example: bitXor(4L, 5L) = 1L
 *   Legal ops: ~ &
 *   Max ops: 14
 *   Rating: 1
 */
long bitXor(long x, long y) {
    return ~((~x) & (~y)) & ~(x & y);
}
/*
 * tmin - return minimum two's complement long integer
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 4
 *   Rating: 1
 */
long tmin(void) {
    return 1L << 63;
}
/*
 * isTmax - returns 1 if x is the maximum, two's complement number,
 *     and 0 otherwise
 *   Legal ops: ! ~ & ^ | +
 *   Max ops: 10
 *   Rating: 1
 */
long isTmax(long x) {
    return !(~(x ^ (x + 1))) & !!(x + 1);
}
// 2
/*
 * allOddBits - return 1 if all odd-numbered bits in word set to 1
 *   where bits are numbered from 0 (least significant) to 63 (most significant)
 *   Examples: allOddBits(0xFFFFFFFDFFFFFFFDL) = 0L,
 *             allOddBits(0xAAAAAAAAAAAAAAAAL) = 1L
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 14
 *   Rating: 2
 */
long allOddBits(long x) {
    x = (x >> 32) & x;
    x = (x >> 16) & x;
    x = (x >> 8) & x;
    x = (x >> 4) & x;
    x = (x >> 2) & x;
    return !!(x & 2L);
}
/*
 * negate - return -x
 *   Example: negate(1L) = -1L.
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 5
 *   Rating: 2
 */
long negate(long x) {
    return ~x + 1L;
}
// 3
/*
 * conditional - same as x ? y : z
 *   Example: conditional(2,4L,5L) = 4L
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 16
 *   Rating: 3
 */
long conditional(long x, long y, long z) {
    long c = !!x;
    long mask = (c << 63) >> 63;
    return (y & mask) | (z & ~mask);
}
/*
 * rotateLeft - Rotate x to the left by n
 *   Can assume that 0 <= n <= 63
 *   Examples:
 *      rotateLeft(0x8765432187654321L,4L) = 0x7654321876543218L
 *   Legal ops: ~ & ^ | + << >> !
 *   Max ops: 25
 *   Rating: 3
 */
long rotateLeft(long x, long n) {
    long left = x << n;
    long right = x >> (64 + (~n + 1));
    long mask = ~0L << n;
    return left + (right & ~mask);
}
/*
 * isLessOrEqual - if x <= y  then return 1, else return 0
 *   Example: isLessOrEqual(4L,5L) = 1L.
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 24
 *   Rating: 3
 */
long isLessOrEqual(long x, long y) {
    long diff = y + (~x + 1);
    long sX = (x >> 63) & 1;
    long sY = (y >> 63) & 1;
    long sD = (diff >> 63) & 1;
    return (sX & !sY) | (!(sX ^ sY) & !sD);
}
// 4
/*
 * allAsciiDigits - return 1 if each byte b in x satisfies
 *   0x30 <= b <= 0x39 (ASCII codes for characters '0' to '9')
 *   Example: allAsciiDigits(0x3031323536373839L) = 1L.
 *            allAsciiDigits(0x4031323536373839L) = 0L.
 *            allAsciiDigits(0x0031323536373839L) = 0L.
 *   Legal ops: ! ~ & ^ | << >>
 *   Max ops: 30
 *   Rating: 4
 */

long allAsciiDigits(long x) {
    long mask1 = 0x30L;
    long mask2 = 0x0EL;

    mask1 = mask1 << 8 ^ mask1;
    mask1 = mask1 << 16 ^ mask1;
    mask1 = mask1 << 32 ^ mask1;

    mask2 = mask2 << 8 ^ mask2;
    mask2 = mask2 << 16 ^ mask2;
    mask2 = mask2 << 32 ^ mask2;

    long mask3 = mask2 ^ (mask1 >> 3);
    long mask4 = (mask3 << 4) ^ (mask2 << 3);
    long res1 = (x & mask4) ^ mask1;
    long res2 = x & mask2;
    long res3 = res2 & mask3;
    long mask5 = (res3 >> 1) ^ (res3 >> 2);
    long res4 = res2 & mask5;
    return !(res1 | res4);
}
/*
 * bitParity - returns 1 if x contains an odd number of 0's
 *   Examples: bitParity(5L) = 0L, bitParity(7L) = 1L
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 22
 *   Rating: 4
 */
long bitParity(long x) {
    x = x ^ x >> 32;
    x = x ^ x >> 16;
    x = x ^ x >> 8;
    x = x ^ x >> 4;
    x = x ^ x >> 2;
    x = x ^ x >> 1;
    return x & 1;
}
/*
 * logicalNeg - implement the ! operator, using all of
 *              the legal operators except !
 *   Examples: logicalNeg(3L) = 0L, logicalNeg(0L) = 1L
 *   Legal ops: ~ & ^ | + << >>
 *   Max ops: 12
 *   Rating: 4
 */
long logicalNeg(long x) {
    long neg = ((~x + 1) | x) >> 63;
    return neg + 1;
}
// float
/*
 * floatIsLess - Compute f < g for floating point arguments f and g.
 *   Both the arguments are passed as unsigned int's, but
 *   they are to be interpreted as the bit-level representations of
 *   single-precision floating point values.
 *   If either argument is NaN, return 0.
 *   +0 and -0 are considered equal.
 *   Legal ops: Any integer/unsigned operations incl. ||, &&. also if, while
 *   Max ops: 30
 *   Rating: 3
 */
int floatIsLess(unsigned uf, unsigned ug) {
    int sMask = 0x80000000;
    unsigned eMask = 0x7F800000;
    unsigned fMask = 0x007FFFFF;

    int s1 = uf & sMask;
    int s2 = ug & sMask;

    unsigned e1 = uf & eMask;
    unsigned e2 = ug & eMask;

    unsigned f1 = uf & fMask;
    unsigned f2 = ug & fMask;

    if (e1 == eMask && f1 != 0)
        return 0;

    if (e2 == eMask && f2 != 0)
        return 0;

    if ((uf << 1) == 0 && (ug << 1) == 0)
        return 0;

    if (s1 != s2)
        return s1 < s2;

    if (s1 == 0) {
        if (e1 < e2)
            return 1;
        if (e1 == e2 && f1 < f2)
            return 1;
    } else {
        if (e1 > e2)
            return 1;
        if (e1 == e2 && f1 > f2)
            return 1;
    }
    return 0;
}
/*
 * floatScale1d2 - Return bit-level equivalent of expression 0.5*f for
 *   floating point argument f.
 *   Both the argument and result are passed as unsigned int's, but
 *   they are to be interpreted as the bit-level representation of
 *   single-precision floating point values.
 *   When argument is NaN, return argument
 *   Legal ops: Any integer/unsigned operations incl. ||, &&. also if, while
 *   Max ops: 30
 *   Rating: 4
 */
unsigned floatScale1d2(unsigned uf) {
    unsigned sMask = 0x80000000;
    unsigned eMask = 0x7F800000;
    unsigned fMask = 0x007FFFFF;
    unsigned specialmask = 0x00FFFFFF;

    unsigned sF = uf & sMask;
    unsigned eF = uf & eMask;
    unsigned fF = uf & fMask;

    if (eF == eMask) {
        return uf;
    }

    if (eF > 0x00800000) {
        eF -= 1;
        eF = eF & eMask;
    } else if (eF == 0x00800000) {
        unsigned backup = uf & specialmask;
        fF = backup >> 1;
        unsigned remain = backup - (fF << 1);
        if (remain == 1) {
            if (((backup + 1) & 2) == 0) {
                fF += 1;
            }
        }
        eF = 0;
    } else {
        unsigned backup = fF;
        fF = fF >> 1;
        unsigned remain = backup - (fF << 1);
        if (remain == 1) {
            if (((backup + 1) & 2) == 0) {
                fF += 1;
            }
        }
    }
    return sF + eF + fF;
}
/*
 * floatUnsigned2Float - Return bit-level equivalent of expression (float) u
 *   Result is returned as unsigned int, but
 *   it is to be interpreted as the bit-level representation of a
 *   single-precision floating point values.
 *   Legal ops: Any integer/unsigned operations incl. ||, &&. also if, while
 *   Max ops: 30
 *   Rating: 4
 */
unsigned floatUnsigned2Float(unsigned u) {
    unsigned exp = 0x0;
    unsigned e = 0x0;
    unsigned frac = 0x0;
    unsigned c = u;
    unsigned mask = 0xFFFFFFFF;

    if (u == 0) {
        return 0;
    }

    while ((c != 1) && (exp != 31)) {
        c = c >> 1;
        exp += 1;
        mask = mask << 1;
    }

    int diff = 32 - (int)exp;
    e = exp + 127;
    frac = u & (~mask);

    int gap = 9 - diff;
    if (gap < 0) {
        frac = frac << (diff - 9);
    } else {
        unsigned backup = frac;
        frac = frac >> gap;
        unsigned remain = backup - (frac << gap);
        unsigned compare = 1 << (8 - diff);
        if (remain > compare) {
            frac += 1;
        } else if (remain == compare) {
            if ((backup + compare) & (compare << 1)) {
                frac = frac;
            } else {
                frac += 1;
            }
        }
    }

    return ((e << 23) + frac) & 0x7FFFFFFF;
}
