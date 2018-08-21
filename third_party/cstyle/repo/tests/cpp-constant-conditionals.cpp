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
#if 1
int FunctionToInclude_1(void)
{
    return 1;
}
#endif

# if 1
int FunctionToInclude_2(void)
{
    return 1;
}
#endif

 #if 1
int FunctionToInclude_3(void)
{
    return 1;
}
#endif

 # if 1
int FunctionToInclude_4(void)
{
    return 1;
}
#endif

#if (1)
int FunctionToInclude_5(void)
{
    return 1;
}
#endif

#if ((1))
int FunctionToInclude_6(void)
{
    return 1;
}
#endif

#if ( (1))
int FunctionToInclude_7(void)
{
    return 1;
}
#endif

#if ( (1) )
int FunctionToInclude_8(void)
{
    return 1;
}
#endif

#if ( ( 1) )
int FunctionToInclude_9(void)
{
    return 1;
}
#endif

#if ( ( 1 ) )
int FunctionToInclude_10(void)
{
    return 1;
}
#endif

#if 0
int FunctionToExclude_1(void)
{
    return 0;
}
#endif

# if 0
int FunctionToExclude_2(void)
{
    return 0;
}
#endif

 #if 0
int FunctionToExclude_3(void)
{
    return 0;
}
#endif

 # if 0
int FunctionToExclude_4(void)
{
    return 0;
}
#endif

#if (0)
int FunctionToExclude_5(void)
{
    return 0;
}
#endif

#if ((0))
int FunctionToExclude_6(void)
{
    return 0;
}
#endif

#if ( (0))
int FunctionToExclude_7(void)
{
    return 0;
}
#endif

#if ( (0) )
int FunctionToExclude_8(void)
{
    return 0;
}
#endif

#if ( ( 0) )
int FunctionToExclude_9(void)
{
    return 0;
}
#endif

#if ( ( 0 ) )
int FunctionToExclude_10(void)
{
    return 0;
}
#endif

