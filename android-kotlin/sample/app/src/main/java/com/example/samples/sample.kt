package com.example.sample


////////////////////////////////////////
//  SORTING ALGO'S
////////////////////////////////////////

class Sorting {

    private var prop: Any? = null

}


////////////////////////////////////////
//  SEARCHING ALGO'S
////////////////////////////////////////

class Searching {

    private var i: Int = 0

    fun linearSearch(a: Array<Int>, x: Int): Int? {
        for (i in 0..a.size-1) if (x == a[i]) return i // index
        return -1
    }

    fun binarySearch(arr: Array<Int>, num: Int): Int? {
        if (arr.size == 0) return null

        arr.sort()

        /*
         * With Recursive lambdas (like Java's recursive lambdas for Functional Interfaces), define function var (not val) before assigning the lambda value
         * defined function var must initialized before being invoked recursively too, so should be assigned a null value
         * this means that it's overall function data type definition should also be Optional
         * to invoke (or re-invoke - recursively) call the ?.invoke() method
         */

        /* // todo: Similar to Java's new Functional Interfaces
         * Sample:
         Function<ArrayList<Integer>, Integer, Integer>[] meth = new Function[1]; // * should be defined as a array when required for recursive-calls, because the 1st item is held in memory during the lambda's implementation as it's being assigned to the same 1st item
         meth[0] = (x, y) -> { ... meth[0].apply(..); ... }; meth[0].apply(..);
         * NB: ?.invoke(..) works similar to Java's .apply(..) .accept(..) , etc invoke-methods for its Functional Interfaces
        */

        var rBinarySearch: ((Array<Int>, Int) -> Int?)? = null // * use var in this case (val cannot be reassigned)
        rBinarySearch = { a, x ->
            if (a.size == 0) null // return keyword is optional in lambda expressions and single-expression functions
            val m = floor((a.size / 2) as Double) as Int // tdoo: type-castings
            // * Optional / "Safe" call reference is required in the recursive calls, because rBinarySearch may be null
            if (x == a[m]) a[m] // * return keyword can be omitted in lambda implementations
            else if (x < a[m]) rBinarySearch?.invoke(a.sliceArray(0..m-1), x) // * slice endIndex is inclusive
            else rBinarySearch?.invoke(a.sliceArray(m+1..a.size - 1), x) // * cannot auto-slice to end of array (specify .size - 1 inclusive last-item index)
        }

        // * Lambda with the run keyword - scope
        val rBinarySearch2p: (Array<Int>, Int, Int, Int) -> Int? = run {
            fun rbs2p(a: Array<Int>, x: Int, f: Int, l: Int): Int? {
                if (a.size == 0) return null
                val m = floor((f + (l - f) / 2) as Double) as Int
                if (x == a[m]) return m
                else if (x < a[m]) return rbs2p(a, x, f, m - 1)
                else return rbs2p(a, x, m + 1, l)
            }
            ::rbs2p
        }//() // todo: test instant-exec


        var f: Int = 0
        var l: Int = arr.size - 1

        // * Optional / "Safe" call reference is not totally necessary in these outer calls,
        // because rBinarySearch (even though Optional, so may be null) has been assigned a lambda function value
        rBinarySearch.invoke(arr, 7)
        rBinarySearch2p(arr, 7, f, l) // * this version of lambda function doesn't require .invoke()

        var m: Int

        while (f < l) {
            m = floor((f + (l - f) / 2) as Double) as Int
            if (num == arr[m]) return m
            else if (num < arr[m]) l = m - 1
            else f = m + 1
        }

        return null
    }

}

