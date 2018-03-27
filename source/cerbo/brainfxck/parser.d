module cerbo.brainfxck.parser;

import cerbo.brainfxck.operator : Operator, OperatorType;
import std.algorithm : filter, group, map;
import std.array : array;
import std.conv : to;
import std.exception : assumeWontThrow;

class Parser
{
    this(in string mapping = defaultMapping) nothrow pure @safe
    in
    {
        assert(mapping.length == defaultMapping.length, `The mapping is incomplete.`);
    }
    do
    {
        foreach (int i, char c; mapping)
        {
            mapping_[c] = i.to!OperatorType.assumeWontThrow;
        }
    }

    Operator[] opCall(in string code) pure @safe
    {
        return code
            .group
            .filter!(v => v[0] in mapping_)
            .map!(v => Operator(mapping_[v[0]], v[1]))
            .array;
    }

    private OperatorType[dchar] mapping_;

    invariant
    {
        assert(mapping_);
    }
}

private enum defaultMapping = `><+-.,[]`;
