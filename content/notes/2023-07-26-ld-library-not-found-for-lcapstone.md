+++
date = "2023-07-26T17:31:28-07:00"
title = "ld: library not found for -lcapstone"
draft = false

tags = ["rbenv", "ruby", "devops"]
+++

When compiling and install Ruby using rbenv

```
rbenv install 3.1.0
```

I got this error:


```
Last 10 log lines:
linking shared-library libruby.3.1.dylib
ld: library not found for -lcapstone
clang-11: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [libruby.3.1.dylib] Error 1
make: *** Waiting for unfinished jobs....
transdb.h updated
transform_mjit_header: making external definition static inline: rb_vm_lvar_exposed, Init_vm_stack_canary, rb_vm_opt_cfunc_p, rb_vm_opt_mod, rb_vm_ic_hit_p, rb_vm_splat_array, rb_vm_defined, rb_vm_cc_general, rb_aliased_callable_method_entry, rb_find_defined_class_by_owner, rb_vm_call_ivar_attrset_p, rb_iseq_only_kwparam_p, rb_iseq_only_optparam_p, rb_vm_set_ivar_idx, rb_vm_setinstancevariable, rb_vm_setclassvariable, rb_vm_getclassvariable, rb_vm_rewrite_cref, rb_vm_get_cref, rb_vm_block_ep_update, rb_vm_cref_new_toplevel, rb_vm_cref_dup_without_refinements, rb_vm_frame_block_handler, rb_vm_cframe_keyword_p, rb_vm_ep_local_ep
transform_mjit_header: making declaration static inline: rb_vm_lvar_exposed, rb_vm_lvar_exposed, Init_vm_stack_canary, rb_vm_rewrite_cref, rb_vm_frame_block_handler, rb_vm_block_ep_update, rb_vm_ep_local_ep
transform_mjit_header: SKIPPED to transform: __sigbits, isspecial, isrune, isphonogram, isnumber, isideogram, ishexnumber, digittoint, toupper, tolower, toascii, isxdigit, isupper, isspace, ispunct, isprint, islower, isgraph, isdigit, iscntrl, isblank, isalpha, isalnum, __wcwidth, __isctype, __istype, isascii, __sincospi, __sincospif, __sincos, __sincosf, __inline_isnormall, __inline_isnormald, __inline_isnormalf, __inline_signbitl, __inline_signbitd, __inline_signbitf, __inline_isnanl, __inline_isnand, __inline_isnanf, __inline_isinfl, __inline_isinfd, __inline_isinff, __inline_isfinitel, __inline_isfinited, __inline_isfinitef, __darwin_fd_clr, __darwin_fd_set, __darwin_fd_isset, __darwin_check_fd_set, __sputc
ln -sf ../../../.ext/include/arm64-darwin22/rb_mjit_min_header-3.1.0.h include/ruby-3.1.0/arm64-darwin22/rb_mjit_min_header-3.1.0.h
```

The gist is this line:

```
ld: library not found for -lcapstone
```

To fix this you woud need to install capstone and point to it:


```
brew install capstone

export LDFLAGS="-L/opt/homebrew/opt/capstone/lib"
export CPPFLAGS="-I/opt/homebrew/opt/capstone/include"
```