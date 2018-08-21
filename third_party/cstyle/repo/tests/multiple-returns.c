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
struct _Unused1 {
    int mUnused;
};

typedef struct _Unused2
{
    int mUnused;
} Unused2;

static int sMoof;

static inline _mul(int bar) { return (bar * 3); }

int mul(int bar) { return _mul(bar); }

void baz(int bar)
{
    if (bar)
        sMoof += bar;
    else
        sMoof += mul(bar);

    return;
}

int foo(int bar) {
    if (bar)
        return (1);

    if (bar % 2)
        return (1 + bar);

    return 0;
}
