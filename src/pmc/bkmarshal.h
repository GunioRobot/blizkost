/*
Copyright (C) 2009-2010, Jonathan Worthington and friends
$Id$

=head1 NAME

src/pmc/bkmarshal.h - wrap P5 and Parrot calling conventions

=head1 DESCRIPTION

=cut

*/

#ifndef BLIZKOST_MARSHAL_H_GUARD
#define BLIZKOST_MARSHAL_H_GUARD

PARROT_WARN_UNUSED_RESULT
PARROT_CANNOT_RETURN_NULL
SV *blizkost_marshal_arg(PARROT_INTERP, PMC *p5i, PMC *arg);

PARROT_WARN_UNUSED_RESULT
PARROT_CANNOT_RETURN_NULL
PMC *blizkost_wrap_sv(PARROT_INTERP, PMC *p5i, SV *sv);

PARROT_WARN_UNUSED_RESULT
PARROT_CANNOT_RETURN_NULL
opcode_t *blizkost_return_from_invoke(PARROT_INTERP, void *next);

int blizkost_slurpy_to_stack(PARROT_INTERP, PMC *p5i, PerlInterpreter *my_perl,
        PMC *positional, PMC *named);

void blizkost_call_in(PARROT_INTERP, PMC *p5i, SV *what, U32 mode,
        PMC *positp, PMC *namedp, PMC **retp);

void blizkost_bind_pmc_to_sv(PerlInterpreter *my_perl, SV *sv,
        PARROT_INTERP, PMC *p5i, PMC *target);

void blizkost_get_bound_pmc(PerlInterpreter *my_perl, SV *sv,
        Parrot_Interp *interpr, PMC **p5ir, PMC **targetr);

#endif
