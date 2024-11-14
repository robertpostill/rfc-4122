#lang scribble/doc

@require[scribble/manual
         @for-label[racket/base]]

@title{rfc-4122}
@author{robertpostill}

@defmodule[rfc-4122]

rfc-4122 generates ids.  Speicifically UUIDs that adhere to the @link["https://datatracker.ietf.org/doc/html/rfc4122"]{RFC-4122 standard}.

If you haven't had the warnings about UUIDs let me spell them out for you now:
@itemize[
@item{They're not private, especially the ones based on MAC addresses}

@item{They're not easy to validate.  In that I can tell you it looks like a UUID, but is it a fake?  I can't easlily define that.}

@item{You can generate collisions, especially if you are a bad actor}
]

@table-of-contents[]

@history[#:changed "0.1" "Initial implementation, will generate an RFC 4122 UUID and test for one."]

@section[#:tag "generating-uuids"]{Generating UUIDs}
There are two things that  are important about generting UUIDs.  The first is correctness, the second is performance.  Where there's a choice between the two correctness will be favoured.

@section[#:tag "design-decisions"]{Design Decisions}
@subsection[#:tag "global-lock"]{System Wide Global Lock}
The RFC 4122 documentation defines a Basic Algorithm in @hyperlink["https://datatracker.ietf.org/doc/html/rfc4122#section-4.2.1"]{Section 4.2.1} that calls for a "system-wide global lock".  Generating such a lock is sort of weird. I've gone for a file wrapped in a system lock. You could do this with shared memory or something else.  But this is simple enough that other people can get it and robust enough that the problems with it are well understood.

So first question, where do you put a file that all users of the cimputer can see it and therefore when you lock it, it's system-wide?

For Mac OS the answer is you put it in a shared location.  According to @hyperlink["https://support.apple.com/en-au/guide/mac-help/mchlp1122/mac"]{this Apple support post} one place that works is /Users/Shared.  /etc would have been a good choice, but for the fact you need adminstrative access to mess with it, and this isn't that library.

