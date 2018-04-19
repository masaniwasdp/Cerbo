module cerbo.brainfxck.memory;

import cerbo.brainfxck.exception : MemoryOutException, OverflowException;

version (unittest) import fluent.asserts;

package class Memory
{
    void next(in uint time) pure @safe
    {
        if (memorySize - 1 - pointer_ < time)
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
        if (ubyte.max - buffer_[pointer_] < time)
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

    void store(in ubyte value) nothrow @nogc pure @safe
    {
        buffer_[pointer_] = value;
    }

    ubyte load() const nothrow @nogc pure @safe
    {
        return buffer_[pointer_];
    }

    private size_t pointer_;

    private ubyte[memorySize] buffer_;

    invariant
    {
        assert(pointer_ < memorySize);
    }
}

private enum memorySize = 0x01u << 0x0Fu;
