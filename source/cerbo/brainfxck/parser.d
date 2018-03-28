module cerbo.brainfxck.parser;

import cerbo.brainfxck.operator : Operator, OperatorType;
import std.algorithm : filter, group, map, uniq;
import std.array : array;
import std.conv : to;
import std.exception : assumeWontThrow;

version (unittest) import fluent.asserts;

class Parser
{
    this(in dstring mapping = defaultMapping) nothrow pure @safe
    in
    {
        assert(mapping.length == defaultMapping.length, `The mapping is incomplete.`);

        assert(mapping.uniq.array == mapping, `The mapping has duplicate elements.`);
    }
    do
    {
        foreach (ubyte i, dchar c; mapping)
        {
            mapping_[c] = i.to!OperatorType.assumeWontThrow;
        }
    }

    Operator[] opCall(in dstring code) const nothrow pure @safe
    {
        return code
            .filter!(c => c in mapping_)
            .group
            .map!(v => Operator(mapping_[v[0]], v[1]))
            .array
            .assumeWontThrow;
    }

    private OperatorType[dchar] mapping_;

    invariant
    {
        assert(mapping_);
    }
}

unittest
{
    immutable parser = new Parser;

    parser(`>><<+++---..,,[]`).should.equal([
        Operator(OperatorType.pInc, 2),
        Operator(OperatorType.pDec, 2),
        Operator(OperatorType.vInc, 3),
        Operator(OperatorType.vDec, 3),
        Operator(OperatorType.vPut, 2),
        Operator(OperatorType.vGet, 2),
        Operator(OperatorType.pJmp, 1),
        Operator(OperatorType.pEnd, 1)
    ]);

    parser(`>,<.++!++"[][]><`).should.equal([
        Operator(OperatorType.pInc, 1),
        Operator(OperatorType.vGet, 1),
        Operator(OperatorType.pDec, 1),
        Operator(OperatorType.vPut, 1),
        Operator(OperatorType.vInc, 4),
        Operator(OperatorType.pJmp, 1),
        Operator(OperatorType.pEnd, 1),
        Operator(OperatorType.pJmp, 1),
        Operator(OperatorType.pEnd, 1),
        Operator(OperatorType.pInc, 1),
        Operator(OperatorType.pDec, 1)
    ]);
}

unittest
{
    immutable parser = new Parser(`!"#$%&'(`);

    parser(`>><<+++---..,,[]`).should.equal([]);

    parser(`>,<.++!++"[][]><`).should.equal([
        Operator(OperatorType.pInc, 1),
        Operator(OperatorType.pDec, 1)
    ]);
}

private enum defaultMapping = `><+-.,[]`;
