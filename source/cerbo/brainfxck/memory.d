module cerbo.brainfxck.memory;

import cerbo.brainfxck.exception : MemoryOutException, OverflowException;

version (unittest) import fluent.asserts;

package alias DataType = ubyte;

package class Memory
{
    void next(in uint time) pure @safe
    {
        if (maxPointer - pointer_ < time)
        {
            throw new MemoryOutException(`The pointer pointed out of memory.`);
        }

        pointer_ += time;
    }

    void prev(in uint time) pure @safe
    {
        if (pointer_ < time)
        {
            throw new MemoryOutException(`The pointer pointed out of memory.`);
        }

        pointer_ -= time;
    }

    void inc(in uint time) pure @safe
    {
        if (DataType.max - buffer_[pointer_] < time)
        {
            throw new OverflowException(`The value overflowed.`);
        }

        buffer_[pointer_] += time;
    }

    void dec(in uint time) pure @safe
    {
        if (buffer_[pointer_] < time)
        {
            throw new OverflowException(`The value overflowed.`);
        }

        buffer_[pointer_] -= time;
    }

    void store(in DataType value) nothrow @nogc pure @safe
    {
        buffer_[pointer_] = value;
    }

    DataType load() const nothrow @nogc pure @safe
    {
        return buffer_[pointer_];
    }

    private size_t pointer_;

    private DataType[memorySize] buffer_;

    invariant
    {
        assert(pointer_ <= maxPointer);
    }
}

private enum memorySize = 0x01u << 0x0Fu;

private enum maxPointer = memorySize - 1;
