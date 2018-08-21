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
extern void describe(const char *aDescription);

void test_1(int aArgument)
{
    switch(aArgument) {

    case 0:
        describe("The value is zero");
        break;

    case 1:
        describe("The value is odd");
        break;
        
    case 2:
        describe("The value is even");
        break;

    }
}

void test_2(int aArgument)
{
    switch(aArgument)
    {

    case 0:
        describe("The value is zero");
        break;

    case 1:
        describe("The value is odd");
        break;
        
    case 2:
        describe("The value is even");
        break;

    }
}

void test_3(int aArgument)
{
    switch(aArgument) { case 0: describe("The value is zero"); break;
                        case 1: describe("The value is odd");  break;
                        case 2: describe("The value is even"); break; }
}
