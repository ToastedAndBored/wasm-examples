(module
    ;; You can import functions from external world.
    ;; They must be provided by caller side (JS test in our case)
    (import "import" "seti32" (func $seti32 (param i32)))

    (global $global (export "global") (mut i32) (i32.const 404))

    ;; You can return multiple values from function
    (func (export "div") (param i32 i32) (result i32 i32)
        local.get 0
        local.get 1
        i32.div_s ;; Integer result
        local.get 0
        local.get 1
        i32.rem_s ;; Modulo
    )

    ;; You can define function signature in separated expression
    (type $myFunctionType
        (func (param i32 i32) (result i32))
    )
    ;; And then reuse it in multiple function definitions
    (func (export "add") (type $myFunctionType)
        local.get 0
        local.get 1
        i32.add
    )
    (func (export "sub") (type $myFunctionType)
        local.get 0
        local.get 1
        i32.sub
    )

    (func $unexported (param i32 i32) (result i32)
        local.get 0
        local.get 1
        i32.mul
    )

    (func (export "mul") (param i32 i32) (result i32)
        ;; You can call one function from other by it's id
        (call $unexported (local.get 0) (local.get 1))
    )

    (func (export "callseti32") (param i32)
        ;; You can call imported functions just like regular ones
        (call $seti32 (local.get 0))
    )

    (func $initfunc
        i32.const 42
        global.set $global
    )

    ;; With `start` expression you can define function that should be executed
    ;; when module loaded.
    ;; This fucntion must have no args and no return values.
    (start $initfunc)
)