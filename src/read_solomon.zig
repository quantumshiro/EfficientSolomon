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

    pub fn pow(a: GF, x: i32) GF {
        var res: u8 = 1;
        var cur = a;
        while (x > 0) {
            if (x & 1 != 0) {
                res = mul(res, cur);
            }
            cur = mul(cur, cur);
            x >>= 1;
        }
        return res;
    }

    pub fn inv(a: GF) GF {
        if (a == 0) {
            @panic("division by zero");
        }
        return pow(a, 254);
    }

    pub fn xor(a: []GF, b: []GF) []GF {
        var x = a;
        var y = b;
        if (a.len < b.len) {
            x = b;
            y = a;
        }

        var res: [x.len]GF = a;

        for (y) |i| {
            res[i] = x[i] ^ y[i];
        }

        return res;
    }
};
