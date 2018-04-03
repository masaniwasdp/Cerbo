module cerbo.brainfxck.machine;

import cerbo.brainfxck.operator : Operator, OperatorType;

version (unittest) import fluent.asserts;

class Machine
{
    private void pInc(in uint time) @nogc nothrow pure @safe
    {
        pointer_ += time;
    }

    private void pDec(in uint time) @nogc nothrow pure @safe
    {
        pointer_ -= time;
    }

    private void vInc(in uint time) @nogc nothrow pure @safe
    {
        memory_[pointer_] += time;
    }

    private void vDec(in uint time) @nogc nothrow pure @safe
    {
        memory_[pointer_] -= time;
    }

    private ubyte depth_;

    private size_t pointer_;

    private ubyte[memorySize] memory_;
}

private enum memorySize = 30000;

private enum operations = [
    OperatorType.pInc: &Machine.pInc,
    OperatorType.pDec: &Machine.pDec,
    OperatorType.vInc: &Machine.vInc,
    OperatorType.vDec: &Machine.vDec
];
