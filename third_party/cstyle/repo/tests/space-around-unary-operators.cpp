// Positive Tests: Things that should be flagged as violations

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

extern void foo(void);

void test_1_1(void)
{
    int a = 0;

    a ++;
    ++ a;
}

void test_1_2(void)
{
    int a = 0;

    (a) ++;
    ++ (a);
}

void test_2_1(int n)
{
    for (int a = 0; a < n; a ++)
    {
        foo();
    }

    for (int a = 0; a < n; ++ a)
    {
        foo();
    }
}

void test_2_2(int n)
{
    for (int a = 0; a < n; (a) ++)
    {
        foo();
    }

    for (int a = 0; a < n; ++ (a))
    {
        foo();
    }
}

void test_3_1(void)
{
    int a = 0;

    a --;
    a-- ;
    -- a;
}

void test_3_2(void)
{
    int a = 0;

    (a) --;
    (a)-- ;
    -- (a);
}

void test_4_1(int n)
{
    for (int a = 0; a < n; a --)
    {
        foo();
    }

    for (int a = 0; a < n; -- a)
    {
        foo();
    }
}

void test_4_2(int n)
{
    for (int a = 0; a < n; (a) --)
    {
        foo();
    }

    for (int a = 0; a < n; -- (a))
    {
        foo();
    }
}

int test_5_1(void)
{
    int a, b;

    a = 0xa5;
    b = ~ a;

    return ~ b;
}

int test_5_2(void)
{
    int a, b;

    a = 0xa5;
    b = ~ (a);

    return ~ (b);
}


bool test_6_1(void)
{
    bool a, b;

    a = false;
    b = ! a;

    return ! b;
}

bool test_6_2(void)
{
    bool a, b;

    a = false;
    b = ! (a);

    return ! (b);
}

// Negative Tests: Things that shouldn't be flagged as violations

void test_1_1n(void)
{
    int a = 0;

    a++;
    a++ ;
    ++a;
}

void test_1_2n(void)
{
    int a = 0;

    (a)++;
    (a)++ ;
    ++(a);
}

void test_2_1n(int n)
{
    for (int a = 0; a < n; a++)
    {
        foo();
    }

    for (int a = 0; a < n; a++ )
    {
        foo();
    }

    for (int a = 0; a < n; ++a)
    {
        foo();
    }
}

void test_2_2n(int n)
{
    for (int a = 0; a < n; (a)++)
    {
        foo();
    }

    for (int a = 0; a < n; (a)++ )
    {
        foo();
    }

    for (int a = 0; a < n; ++(a))
    {
        foo();
    }
}

void test_3_1n(void)
{
    int a = 0;

    a--;
    a-- ;
    --a;
}

void test_3_2n(void)
{
    int a = 0;

    (a)--;
    (a)-- ;
    --(a);
}

void test_4_1n(int n)
{
    for (int a = 0; a < n; a--)
    {
        foo();
    }

    for (int a = 0; a < n; a-- )
    {
        foo();
    }

    for (int a = 0; a < n; --a)
    {
        foo();
    }
}

void test_4_2n(int n)
{
    for (int a = 0; a < n; (a)--)
    {
        foo();
    }

    for (int a = 0; a < n; (a)-- )
    {
        foo();
    }

    for (int a = 0; a < n; --(a))
    {
        foo();
    }
}

int test_5_1n(void)
{
    int a, b;

    a = 0xa5;
    b = ~a;

    return ~b;
}

int test_5_2n(void)
{
    int a, b;

    a = 0xa5;
    b = ~(a);

    return ~(b);
}


bool test_6_1n(void)
{
    bool a, b;

    a = false;
    b = !a;

    return !b;
}

bool test_6_2n(void)
{
    bool a, b;

    a = false;
    b = !(a);

    return !(b);
}

