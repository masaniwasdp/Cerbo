module cerbo.brainfxck.operator;

package enum OperatorType : ubyte
{
    pInc, pDec, vInc, vDec, vPut, vGet, pJmp, pEnd
}

package struct Operator
{
    OperatorType type;

    uint time;
}
