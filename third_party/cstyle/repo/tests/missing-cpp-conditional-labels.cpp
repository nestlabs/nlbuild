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
#define CPP_CONDITIONAL_LABELS 1
#define NO_CPP_CONDITIONAL_LABELS 0

// Negative tests: these should not generate a violation

// #if ... #else ... #endif

#if CPP_CONDITIONAL_LABELS
void test_1(void)
{

}
#else // !CPP_CONDITIONAL_LABELS
void test_1(void)
{

}
#endif // CPP_CONDITIONAL_LABELS

#if CPP_CONDITIONAL_LABELS
void test_2(void)
{

}
#else /* !CPP_CONDITIONAL_LABELS */
void test_2(void)
{

}
#endif /* CPP_CONDITIONAL_LABELS */

#if CPP_CONDITIONAL_LABELS
void test_3(void)
{

}
#endif // CPP_CONDITIONAL_LABELS

#if CPP_CONDITIONAL_LABELS
void test_4(void)
{

}
#endif /* CPP_CONDITIONAL_LABELS */

#if defined(CPP_CONDITIONAL_LABELS) && CPP_CONDITIONAL_LABELS == 1
void test_5(void)
{

}
#endif // defined(CPP_CONDITIONAL_LABELS) && CPP_CONDITIONAL_LABELS == 1

#if defined(CPP_CONDITIONAL_LABELS) && CPP_CONDITIONAL_LABELS == 1
void test_6(void)
{

}
#endif /* defined(CPP_CONDITIONAL_LABELS) && CPP_CONDITIONAL_LABELS == 1 */

// #if ... #elif ... #else ... #endif

#if CPP_CONDITIONAL_LABELS
void test_7(void)
{

}
#elif NO_CPP_CONDITIONAL_LABELS
void test_7(void)
{

}
#else // !CPP_CONDITIONAL_LABELS
void test_7(void)
{

}
#endif // CPP_CONDITIONAL_LABELS

#if CPP_CONDITIONAL_LABELS
void test_8(void)
{

}
#elif NO_CPP_CONDITIONAL_LABELS
void test_8(void)
{

}
#else /* !CPP_CONDITIONAL_LABELS */
void test_8(void)
{

}
#endif /* CPP_CONDITIONAL_LABELS */

// Positive tests: these should generate a violation

// #if ... #else ... #endif

#if CPP_CONDITIONAL_LABELS
void test_9_1(void)
{

}
#else
void test_9_1(void)
{

}
#endif

# if CPP_CONDITIONAL_LABELS
void test_9_2(void)
{

}
# else
void test_9_2(void)
{

}
# endif

 #if CPP_CONDITIONAL_LABELS
void test_9_3(void)
{

}
 #else
void test_9_3(void)
{

}
 #endif

#	if CPP_CONDITIONAL_LABELS
void test_9_4(void)
{

}
#	else
void test_9_4(void)
{

}
#	endif

	#if CPP_CONDITIONAL_LABELS
void test_9_5(void)
{

}
	#else
void test_9_5(void)
{

}
	#endif

#if	CPP_CONDITIONAL_LABELS
void test_9_6(void)
{

}
#else
void test_9_6(void)
{

}
#endif

# if	CPP_CONDITIONAL_LABELS
void test_9_7(void)
{

}
# else
void test_9_7(void)
{

}
# endif

 #if	CPP_CONDITIONAL_LABELS
void test_9_8(void)
{

}
 #else
void test_9_8(void)
{

}
 #endif

#	if	CPP_CONDITIONAL_LABELS
void test_9_9(void)
{

}
#	else
void test_9_9(void)
{

}
#	endif

	#if	CPP_CONDITIONAL_LABELS
void test_9_10(void)
{

}
	#else
void test_9_10(void)
{

}
	#endif

// #if ... #elif ... #else ... #endif

#if CPP_CONDITIONAL_LABELS
void test_10_1(void)
{

}
#elif NO_CPP_CONDITIONAL_LABELS
void test_10_1(void)
{

}
#else
void test_10_1(void)
{

}
#endif

# if CPP_CONDITIONAL_LABELS
void test_10_2(void)
{

}
# elif NO_CPP_CONDITIONAL_LABELS
void test_10_2(void)
{

}
# else
void test_10_2(void)
{

}
# endif

 #if CPP_CONDITIONAL_LABELS
void test_10_3(void)
{

}
 #elif NO_CPP_CONDITIONAL_LABELS
void test_10_3(void)
{

}
 #else
void test_10_3(void)
{

}
 #endif

#	if CPP_CONDITIONAL_LABELS
void test_10_5(void)
{

}
#	elif NO_CPP_CONDITIONAL_LABELS
void test_10_5(void)
{

}
#	else
void test_10_5(void)
{

}
#	endif

	#if CPP_CONDITIONAL_LABELS
void test_10_6(void)
{

}
	#elif NO_CPP_CONDITIONAL_LABELS
void test_10_6(void)
{

}
	#else
void test_10_6(void)
{

}
	#endif

#if	CPP_CONDITIONAL_LABELS
void test_10_7(void)
{

}
#elif	NO_CPP_CONDITIONAL_LABELS
void test_10_7(void)
{

}
#else
void test_10_7(void)
{

}
#endif

# if	CPP_CONDITIONAL_LABELS
void test_10_8(void)
{

}
# elif	NO_CPP_CONDITIONAL_LABELS
void test_10_8(void)
{

}
# else
void test_10_8(void)
{

}
# endif

 #if	CPP_CONDITIONAL_LABELS
void test_10_9(void)
{

}
 #elif	NO_CPP_CONDITIONAL_LABELS
void test_10_9(void)
{

}
 #else
void test_10_9(void)
{

}
 #endif

#	if	CPP_CONDITIONAL_LABELS
void test_10_10(void)
{

}
#	elif	NO_CPP_CONDITIONAL_LABELS
void test_10_10(void)
{

}
#	else
void test_10_10(void)
{

}
#	endif

	#if	CPP_CONDITIONAL_LABELS
void test_10_11(void)
{

}
	#elif	NO_CPP_CONDITIONAL_LABELS
void test_10_11(void)
{

}
	#else
void test_10_11(void)
{

}
	#endif
