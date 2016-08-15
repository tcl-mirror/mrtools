set types {
    {int (*)()}
    {char (*)(int, int)}
    {char *const}
    {char *const*}
    {int **}
    {enum a}
    {struct a}
    {uint8_t}
    {const int *}
    {struct foo *}
    {MyType_t *}
    {typename(foo_bar)}
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
