/*
 *
 *    Copyright (c) 2016-2018 Nest Labs, Inc.
 *    All rights reserved.
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */
namespace _TestNS
{

// This is a test class.
//
// class _Test1 { ... };
//
class _Test1
{
public:
    _Test1(void) { return; }
    ~Test1(void) { return; }

    int Mul(int bar) { return (bar * 3); }

    static void Baz(int bar)
    {
        if (bar)
            sMoof += bar;
        else
            sMoof += mul(bar);

        return;
    }

    int Foo(int bar) {
        if (bar)
            return (1);

        if (bar % 2) {
            return (1 + bar);
        }

        return 0;
    }

    bool Bar(int bar) const
    {
        if (bar % 2 == 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

private:
    static int sMoof;
};

}; // namespace _TestNS
