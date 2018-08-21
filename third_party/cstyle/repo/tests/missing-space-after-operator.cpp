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
#include <stddef.h>

// Positive tests: these should generate a violation

class test_5;

extern void *operatornew(size_t);
extern void operatordelete(void *);

extern int operator+(test_5 a, test_5 b);
extern int operator-(test_5 a, test_5 b);
extern int operator*(test_5 a, test_5 b);
extern int operator/(test_5 a, test_5 b);
extern int operator%(test_5 a, test_5 b);
extern int operator^(test_5 a, test_5 b);
extern int operator&(test_5 a, test_5 b);
extern int operator|(test_5 a, test_5 b);

extern int operator&&(test_5 a, test_5 b);
extern int operator||(test_5 a, test_5 b);

extern int operator~(test_5 a);
extern int operator!(test_5 a);

extern int operator<(test_5 a, test_5 b);
extern int operator>(test_5 a, test_5 b);
extern int operator==(test_5 a, test_5 b);
extern int operator!=(test_5 a, test_5 b);
extern int operator<=(test_5 a, test_5 b);
extern int operator>=(test_5 a, test_5 b);

extern int operator+=(test_5 a, test_5 b);
extern int operator-=(test_5 a, test_5 b);
extern int operator*=(test_5 a, test_5 b);
extern int operator/=(test_5 a, test_5 b);
extern int operator%=(test_5 a, test_5 b);
extern int operator^=(test_5 a, test_5 b);
extern int operator&=(test_5 a, test_5 b);
extern int operator|=(test_5 a, test_5 b);
extern int operator<<(test_5 a, test_5 b);
extern int operator>>(test_5 a, test_5 b);
extern int operator>>=(test_5 a, test_5 b);
extern int operator<<=(test_5 a, test_5 b);

extern int operator++(test_5 a);
extern int operator--(test_5 a);

extern int operator,(test_5 a, test_5 b);
extern int operator->*(test_5 a, test_5 b);

class test_5
{
    int operator=(test_5 a);
    test_5 &operator->(void);
    int operator()(int a);
    int operator[](size_t a);
};

// Negative tests: these should not generate a violation

class test_6;

extern void *operator new(size_t);
extern void operator delete(void *);

extern void *operator new [](size_t);
extern void operator delete [](void *);

extern int operator +(test_6 a, test_6 b);
extern int operator -(test_6 a, test_6 b);
extern int operator *(test_6 a, test_6 b);
extern int operator /(test_6 a, test_6 b);
extern int operator %(test_6 a, test_6 b);
extern int operator ^(test_6 a, test_6 b);
extern int operator &(test_6 a, test_6 b);
extern int operator |(test_6 a, test_6 b);

extern int operator &&(test_6 a, test_6 b);
extern int operator ||(test_6 a, test_6 b);

extern int operator ~(test_6 a);
extern int operator !(test_6 a);

extern int operator <(test_6 a, test_6 b);
extern int operator >(test_6 a, test_6 b);
extern int operator ==(test_6 a, test_6 b);
extern int operator !=(test_6 a, test_6 b);
extern int operator <=(test_6 a, test_6 b);
extern int operator >=(test_6 a, test_6 b);

extern int operator +=(test_6 a, test_6 b);
extern int operator -=(test_6 a, test_6 b);
extern int operator *=(test_6 a, test_6 b);
extern int operator /=(test_6 a, test_6 b);
extern int operator %=(test_6 a, test_6 b);
extern int operator ^=(test_6 a, test_6 b);
extern int operator &=(test_6 a, test_6 b);
extern int operator |=(test_6 a, test_6 b);
extern int operator <<(test_6 a, test_6 b);
extern int operator >>(test_6 a, test_6 b);
extern int operator >>=(test_6 a, test_6 b);
extern int operator <<=(test_6 a, test_6 b);

extern int operator ++(test_6 a);
extern int operator --(test_6 a);

extern int operator ,(test_6 a, test_6 b);
extern int operator ->*(test_6 a, test_6 b);

class test_6
{
    int operator =(test_6 a);
    test_6 &operator ->(void);
    int operator ()(int a);
    int operator [](size_t a);
};








