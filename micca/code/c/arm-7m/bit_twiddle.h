/*
 */
#ifndef BIT_TWIDDLE_H_
#define BIT_TWIDDLE_H_

/*
 * MACRO DEFINITIONS
 */

/*
 * Generate a bit mask with "n" contiguous 1 bits starting at "o" bit position.
 */
#define MASK(n, o)  (((1 << (n)) - 1) << (o))
/*
 * Generate a single bit mask. This is common enough to deserve its own macro.
 */
#define BITMASK(o)  MASK(1, o)
/*
 * Clear a single bit in "r" at offset, "o".
 */
#define BITCLEAR(r,o)   ((r) & BITMASK(o))
/*
 * Set a single bit in "r" at offset, "o".
 */
#define BITSET(r,o)     ((r) | BITMASK(o))
/*
 * Toggle a single bit in "r" at offset, "o".
 */
#define BITTOGGLE(r,o)   ((r) ^ BITMASK(o))
/*
 * Shift and mask a value into its position within a bit field.
 * N.B. that "v" is truncated to fit the bit field definition.
 */
#define FIELD_VALUE(v, n, o)  (((v) << (o)) & MASK(n, o))
/*
 * Set the "n" contiguous bits at offset "o" in "r" to zero.
 */
#define FIELD_CLEAR(r, n, o) ((r) & ~MASK(n, o))
/*
 * Set the "n" contiguous bits at offset "o" in "r" to one.
 */
#define FIELD_SET(r, n, o)  ((r) | MASK(n, o))
/*
 * Change the "n" contiguous bits at offset "o" in "r" to their opposite value.
 */
#define FIELD_TOGGLE(r, n, o)  ((r) ^ MASK(n, o))
/*
 * Insert into "r" the field value, "v", that resides at "o" bit position and
 * is "n" bits wide.
 */
#define FIELD_INSERT(r, v, n, o)   (FIELD_CLEAR(r, n, o) | FIELD_VALUE(v, n, o))
/*
 * Extract the field value in "r" that is "n" bits wide and begins at offset
 * "o".
 */
#define FIELD_EXTRACT(r, n, o)      (((r) & MASK(n, o)) >> (o))

/*
 * The following macros are useful with some vendor supplied header files.
 * Some times bit fields in those files are oriented toward defining masks and
 * shifts rather than explicit definitions of the bit fields.
 */

/*
 * Shift and mask a value into the position it properly within a bit field.
 * "v" is the unshifted value, "m" is a mask, "o is the shift offset.
 * N.B. that "v" is truncated to fit the bit field definition.
 */
#define MSKSHFT_FIELD_VALUE(v, m, o)  (((v) << (o)) & (m))
/*
 * Extract the field value in "r" using mask "m" that is at offset "o".
 * This assumes that "m" is a mask containing 1 bits in all the bit
 * positions of the field.
 */
#define FIELD_EXTRACT_MASK(r, m, o) (((r) & (m)) >> (o))
/*
 * Insert into "r" the field value "v" that is masked by "m".
 * This assumes that "v" is shifted to the correct offset in the field
 * and that "m" has 1 bits in all the bit positions of the field.
 */
#define MASKED_FIELD_INSERT(r, v, m)    (((r) & ~(m)) | (v))
/*
 * Insert into "r" the value "v" that is masked by "m" and shifted
 * into position "s" bits. Here, "v" is shifted to the correct
 * position in the bit field and OR'ed into the cleared bit field slot.
 */
#define MSKSHFT_FIELD_INSERT(r, v, m, s)    (((r) & ~(m)) | MSKSHFT_FIELD_VALUE(v, m, s))

#endif /* BIT_TWIDDLE_H_ */
