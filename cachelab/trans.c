/**
 * @file trans.c
 * @brief Contains various implementations of matrix transpose
 *
 * Each transpose function must have a prototype of the form:
 *   void trans(size_t M, size_t N, double A[N][M], double B[M][N],
 *              double tmp[TMPCOUNT]);
 *
 * All transpose functions take the following arguments:
 *
 *   @param[in]     M    Width of A, height of B
 *   @param[in]     N    Height of A, width of B
 *   @param[in]     A    Source matrix
 *   @param[out]    B    Destination matrix
 *   @param[in,out] tmp  Array that can store temporary double values
 *
 * A transpose function is evaluated by counting the number of hits and misses,
 * using the cache parameters and score computations described in the writeup.
 *
 * Programming restrictions:
 *   - No out-of-bounds references are allowed
 *   - No alterations may be made to the source array A
 *   - Data in tmp can be read or written
 *   - This file cannot contain any local or global doubles or arrays of doubles
 *   - You may not use unions, casting, global variables, or
 *     other tricks to hide array data in other forms of local or global memory.
 *
 * TODO: fill in your name and Andrew ID below.
 * @author Sunny Wu <hanningw@andrew.cmu.edu>
 */

#include <assert.h>
#include <stdbool.h>
#include <stdio.h>

#include "cachelab.h"

/**
 * @brief Checks if B is the transpose of A.
 *
 * You can call this function inside of an assertion, if you'd like to verify
 * the correctness of a transpose function.
 *
 * @param[in]     M    Width of A, height of B
 * @param[in]     N    Height of A, width of B
 * @param[in]     A    Source matrix
 * @param[out]    B    Destination matrix
 *
 * @return True if B is the transpose of A, and false otherwise.
 */
#ifndef NDEBUG
static bool is_transpose(size_t M, size_t N, double A[N][M], double B[M][N]) {
    for (size_t i = 0; i < N; i++) {
        for (size_t j = 0; j < M; ++j) {
            if (A[i][j] != B[j][i]) {
                fprintf(stderr,
                        "Transpose incorrect.  Fails for B[%zd][%zd] = %.3f, "
                        "A[%zd][%zd] = %.3f\n",
                        j, i, B[j][i], i, j, A[i][j]);
                return false;
            }
        }
    }
    return true;
}
#endif

/*
 * You can define additional transpose functions here. We've defined
 * some simple ones below to help you get started, which you should
 * feel free to modify or delete.
 */

/**
 * @brief A simple baseline transpose function, not optimized for the cache.
 *
 * Note the use of asserts (defined in assert.h) that add checking code.
 * These asserts are disabled when measuring cycle counts (i.e. when running
 * the ./test-trans) to avoid affecting performance.
 */
static void trans_basic(size_t M, size_t N, double A[N][M], double B[M][N],
                        double tmp[TMPCOUNT]) {
    assert(M > 0);
    assert(N > 0);

    for (size_t i = 0; i < N; i += 8) {
        for (size_t j = 0; j < M; j += 8) {
            for (size_t k = i; k < i + 8 && k < N; k++) {
                if ((M - j) >= 8) {
                    double a0 = A[k][j];
                    double a1 = A[k][j + 1];
                    double a2 = A[k][j + 2];
                    double a3 = A[k][j + 3];
                    double a4 = A[k][j + 4];
                    double a5 = A[k][j + 5];
                    double a6 = A[k][j + 6];
                    double a7 = A[k][j + 7];

                    B[j][k] = a0;
                    B[j + 1][k] = a1;
                    B[j + 2][k] = a2;
                    B[j + 3][k] = a3;
                    B[j + 4][k] = a4;
                    B[j + 5][k] = a5;
                    B[j + 6][k] = a6;
                    B[j + 7][k] = a7;
                } else if ((M - j) == 7) {
                    double a0 = A[k][j];
                    double a1 = A[k][j + 1];
                    double a2 = A[k][j + 2];
                    double a3 = A[k][j + 3];
                    double a4 = A[k][j + 4];
                    double a5 = A[k][j + 5];
                    double a6 = A[k][j + 6];

                    B[j][k] = a0;
                    B[j + 1][k] = a1;
                    B[j + 2][k] = a2;
                    B[j + 3][k] = a3;
                    B[j + 4][k] = a4;
                    B[j + 5][k] = a5;
                    B[j + 6][k] = a6;
                } else if ((M - j) == 6) {
                    double a0 = A[k][j];
                    double a1 = A[k][j + 1];
                    double a2 = A[k][j + 2];
                    double a3 = A[k][j + 3];
                    double a4 = A[k][j + 4];
                    double a5 = A[k][j + 5];

                    B[j][k] = a0;
                    B[j + 1][k] = a1;
                    B[j + 2][k] = a2;
                    B[j + 3][k] = a3;
                    B[j + 4][k] = a4;
                    B[j + 5][k] = a5;
                } else if ((M - j) == 5) {
                    double a0 = A[k][j];
                    double a1 = A[k][j + 1];
                    double a2 = A[k][j + 2];
                    double a3 = A[k][j + 3];
                    double a4 = A[k][j + 4];

                    B[j][k] = a0;
                    B[j + 1][k] = a1;
                    B[j + 2][k] = a2;
                    B[j + 3][k] = a3;
                    B[j + 4][k] = a4;
                } else if ((M - j) == 4) {
                    double a0 = A[k][j];
                    double a1 = A[k][j + 1];
                    double a2 = A[k][j + 2];
                    double a3 = A[k][j + 3];

                    B[j][k] = a0;
                    B[j + 1][k] = a1;
                    B[j + 2][k] = a2;
                    B[j + 3][k] = a3;
                } else if ((M - j) == 3) {
                    double a0 = A[k][j];
                    double a1 = A[k][j + 1];
                    double a2 = A[k][j + 2];

                    B[j][k] = a0;
                    B[j + 1][k] = a1;
                    B[j + 2][k] = a2;
                } else if ((M - j) == 2) {
                    double a0 = A[k][j];
                    double a1 = A[k][j + 1];

                    B[j][k] = a0;
                    B[j + 1][k] = a1;
                } else if ((M - j) == 1) {
                    double a0 = A[k][j];

                    B[j][k] = a0;
                }
            }
        }
    }

    assert(is_transpose(M, N, A, B));
}

/**
 * @brief A contrived example to illustrate the use of the temporary array.
 *
 * This function uses the first four elements of tmp as a 2x2 array with
 * row-major ordering.
 */
static void trans_tmp(size_t M, size_t N, double A[N][M], double B[M][N],
                      double tmp[TMPCOUNT]) {
    assert(M > 0);
    assert(N > 0);

    for (size_t i = 0; i < N; i += 8) {
        for (size_t j = 0; j < M; j += 8) {
            for (size_t k = i; k < i + 8; k++) {
                size_t dk = k % 8;
                size_t index = dk * 8;

                tmp[index] = A[k][j];
                tmp[index + 1] = A[k][j + 1];
                tmp[index + 2] = A[k][j + 2];
                tmp[index + 3] = A[k][j + 3];
                tmp[index + 4] = A[k][j + 4];
                tmp[index + 5] = A[k][j + 5];
                tmp[index + 6] = A[k][j + 6];
                tmp[index + 7] = A[k][j + 7];

                B[j][k] = tmp[index];
                B[j + 1][k] = tmp[index + 1];
                B[j + 2][k] = tmp[index + 2];
                B[j + 3][k] = tmp[index + 3];
                B[j + 4][k] = tmp[index + 4];
                B[j + 5][k] = tmp[index + 5];
                B[j + 6][k] = tmp[index + 6];
                B[j + 7][k] = tmp[index + 7];
            }
        }
    }

    assert(is_transpose(M, N, A, B));
}

/**
 * @brief The solution transpose function that will be graded.
 *
 * You can call other transpose functions from here as you please.
 * It's OK to choose different functions based on array size, but
 * this function must be correct for all values of M and N.
 */
static void transpose_submit(size_t M, size_t N, double A[N][M], double B[M][N],
                             double tmp[TMPCOUNT]) {
    // if (M == N)
    //     trans_basic(M, N, A, B, tmp);
    // else
    //     trans_tmp(M, N, A, B, tmp);
    trans_basic(M, N, A, B, tmp);
}

/**
 * @brief Registers all transpose functions with the driver.
 *
 * At runtime, the driver will evaluate each function registered here, and
 * and summarize the performance of each. This is a handy way to experiment
 * with different transpose strategies.
 */
void registerFunctions(void) {
    // Register the solution function. Do not modify this line!
    registerTransFunction(transpose_submit, SUBMIT_DESCRIPTION);

    // Register any additional transpose functions
    registerTransFunction(trans_basic, "Basic transpose");
    registerTransFunction(trans_tmp, "Transpose using the temporary array");
}
