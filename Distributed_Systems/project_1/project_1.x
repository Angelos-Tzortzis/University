struct arrays {
    int x<>;
    int y<>;
};

struct arrays_float {
    int x<>;
    int y<>;
    float r;
};

struct output_2 {
    float out[2];
};

struct output_n {
    float out<>;
};

program FIND_INNER_PRODUCT {
    version IP_VERS {
        int IP(arrays) = 1;
    } = 1;
} = 0x00000001;

program FIND_AVERAGE {
    version A_VERS {
        output_2 A(arrays) = 1;
    } = 1;
} = 0x00000002;

program FIND_PRODUCT {
    version P_VERS {
        output_n P(arrays_float) = 1;
    } = 1;
} = 0x00000003;
