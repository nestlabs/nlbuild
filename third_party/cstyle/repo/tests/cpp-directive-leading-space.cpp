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
#define CPP_DIRECTIVE_LEADING_SPACE 1

// Negative tests: these should not generate a violation

#if CPP_DIRECTIVE_LEADING_SPACE

#endif

# if CPP_DIRECTIVE_LEADING_SPACE

#endif

#	if CPP_DIRECTIVE_LEADING_SPACE

#endif

// Positive tests: these should generate a violation

 #if CPP_DIRECTIVE_LEADING_SPACE

 #endif

	#if CPP_DIRECTIVE_LEADING_SPACE

	#endif

 	#if CPP_DIRECTIVE_LEADING_SPACE

 	#endif

	 #if CPP_DIRECTIVE_LEADING_SPACE

	 #endif

 	 #if CPP_DIRECTIVE_LEADING_SPACE

 	 #endif

	 	#if CPP_DIRECTIVE_LEADING_SPACE

	 	#endif

