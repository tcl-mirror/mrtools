set types {
    {int (*)()}
    {int (*)(void)}
    {char (*)(int, int)}
    {char *const}
    {char *const*}
    {int **}
    {enum a}
    {struct a}
    {uint8_t}
    {uint64_t}
    {int32_t}
    {int_least64_t}
    {const int *}
    {struct foo *}
    {MyType_t *}
    {void (*)(int, ...)}
    {struct foo * const (*)(void)}
    {enum b {foo = 1, bar, baz}}
    {enum {foo, bar} *}
    {char []}
    {char [32]}
    {char [*]}
    {char [sizeof(char)]}
    {struct a {int *a ;} *}
    {struct a {int a ;}}
    {int * int (*)()}
}
