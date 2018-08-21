// Positive Tests: test that should generate a violation

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

namespace a { namespace b { namespace c { };};};

extern void foo(void);

void test_1_p(int n)
{
    const int m = n;

    for (int i = 0;i < m;i++)
    {
        foo();
    }

    foo();foo();foo();
}

// Negative Tests: test that should not generate a violation

namespace a { namespace b { namespace c { }; }; };

extern void foo(void);

void test_1_n(int n)
{
    const int m = n;

    for (int i = 0; i < m; i++)
    {
        foo();
    }

    foo(); foo(); foo();
}

// Single-quoted semicolons should not generate a violation

static char semicolon_char_1 = ';';

// Double-quoted semicolons should not generate a violation

static const char * const semicolon_string_1 = ";";
static const char * const semicolon_string_2 = "first;second;";
static const char * const semicolon_string_5 = "\"first\",\"second\";";
static const char * const semicolon_string_3 = "\"first\";\"second\";";
static const char * const semicolon_string_4 = "\'first\',\'second\';";
static const char * const semicolon_string_6 = "\'first\';\'second\';";
static const char * const semicolon_string_7 = "size=\"17;11\";";
