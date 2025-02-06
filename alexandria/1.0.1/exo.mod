(
	:exo-version 1.0
	:description "Alexandria is a collection of portable public domain utilities"
	:module (
		:id :alexandria
		:version "1.0.1"
		:use (:cl)
		:require (:sb-rt)
		:signature (
			:key "RWR4D8s/solf7bEoPwXvsebrYebN+LLizUhK2BchkMj6PJ4apy7stzjb"
		)
	)
	:about (
		:author "Nikodemus Siivola and others."
		:licence "Public Domain / 0-clause MIT"
		:long-description "Alexandria is a project and a library.

As a project Alexandria's goal is to reduce duplication of effort and improve
portability of Common Lisp code according to its own idiosyncratic and rather
conservative aesthetic.

As a library Alexandria is one of the means by which the project strives for
its goals.

Alexandria is a collection of portable public domain utilities that meet
the following constraints:

 * Utilities, not extensions: Alexandria will not contain conceptual
   extensions to Common Lisp, instead limiting itself to tools and utilities
   that fit well within the framework of standard ANSI Common Lisp.
   Test-frameworks, system definitions, logging facilities, serialization
   layers, etc. are all outside the scope of Alexandria as a library, though
   well within the scope of Alexandria as a project.

 * Conservative: Alexandria limits itself to what project members consider
   conservative utilities. Alexandria does not and will not include anaphoric
   constructs, loop-like binding macros, etc.
   Also, its exported symbols are being imported by many other packages
   already, so each new export carries the danger of causing conflicts.

 * Portable: Alexandria limits itself to portable parts of Common Lisp. Even
   apparently conservative and useful functions remain outside the scope of
   Alexandria if they cannot be implemented portably. Portability is here
   defined as portable within a conforming implementation: implementation bugs
   are not considered portability issues.

 * Team player: Alexandria will not (initially, at least) subsume or provide
   functionality for which good-quality special-purpose packages exist, like
   split-sequence. Instead, third party packages such as that may be
   \"blessed\"."
   )
)