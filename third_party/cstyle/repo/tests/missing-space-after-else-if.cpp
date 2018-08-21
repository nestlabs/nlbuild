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
extern void bar(void);

void test_1(int aArgument)
{
    if(aArgument % 2 != 0) foo(); else if(aArgument == 0) bar();
}

void test_2(int aArgument)
{
    if(aArgument % 2 != 0) { foo(); } else if(aArgument == 0) { bar(); }
}

void test_3(int aArgument)
{
    if(aArgument % 2 != 0) {
        foo();
    } else if(aArgument == 0) {
        bar();
    }
}

void test_4(int aArgument)
{
    if(aArgument % 2 != 0)
    {
        foo();
    }
    else if(aArgument == 0)
    {
        bar();
    }
}
