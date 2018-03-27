module cerbo.brainfxck.operator;

package enum OperatorType { pInc, pDec, vInc, vDec, put, get, jmp, end };

package struct Operator
{
    OperatorType type;

    uint time;
}
