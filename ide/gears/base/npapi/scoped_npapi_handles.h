// Copyright 2007, Google Inc.
//
// Redistribution and use in source and binary forms, with or without 
// modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, 
//     this list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other materials provided with the distribution.
//  3. Neither the name of Google Inc. nor the names of its contributors may be
//     used to endorse or promote products derived from this software without
//     specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
// WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
// EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
// OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR 
// OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF 
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// Scoped objects for the various NPAPI handle types.
// Destructor implementation must be provided for each type.

#ifndef GEARS_BASE_NPAPI_SCOPED_NPAPI_HANDLES_H__
#define GEARS_BASE_NPAPI_SCOPED_NPAPI_HANDLES_H__

#include "gears/base/common/scoped_token.h"

#ifdef BROWSER_WEBKIT
#include <WebKit/npapi.h>
#else
#include "npapi.h"
#include "npruntime.h"
#endif

// ScopedNPObject: automatically call NPN_ReleaseObject()
typedef DECLARE_SCOPED_TRAITS(NPObject*, NPN_ReleaseObject, NULL)
    NPObjectTraits;
typedef scoped_token<NPObject*, NPObjectTraits> ScopedNPObject;

#endif // GEARS_BASE_NPAPI_SCOPED_NPAPI_HANDLES_H__