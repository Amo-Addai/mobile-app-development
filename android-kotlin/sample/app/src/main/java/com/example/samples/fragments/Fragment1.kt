package com.example.samples.fragments

import android.os.Bundle

class Fragment1 : Fragment() {
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return
            inflater
                .inflate(
                    R.layout.fragments.fragment_1,
                    container,
                    false
                )
    }
}