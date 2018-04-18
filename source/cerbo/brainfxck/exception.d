module cerbo.brainfxck.exception;

import std.exception : basicExceptionCtors;

class MachineException : Exception
{
    mixin basicExceptionCtors;
}

class MemoryOutException : MachineException
{
    mixin basicExceptionCtors;
}
