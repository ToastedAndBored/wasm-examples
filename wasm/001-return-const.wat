(module
  (func $get42 (result i32)
    ;; There is no explicit return operation in wasm
    ;; All data leaved on stack of function at it's execution end is it's ret value
    i32.const 42 ;; put 42 on stack
  )
  ;; Entities that are not explicitly export are not visible to execution env
  (export "get42" (func $get42))
)