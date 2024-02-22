const std = @import("std");
const testing = std.testing;

const GF = u8;

const Poly = 0x1d;

const poly = struct {
    pub fn mul(a: GF, b: GF) GF {
        var res: GF = undefined;
        while (b != 0) {
            if ((b & 1) != 0) {
                res ^= a;
            }

            if (a & 0x80) {
                a = (a << 1) ^ Poly;
            } else {
                a <<= 1;
            }
            b >>= 1;
        }
        return res;
    }
};
