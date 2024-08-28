package com.example.navigation_drawer_app

import android.os.Bundle

class LoginFragment : Fragment() {
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return
            inflater
                .inflate(
                    R.layout.fragment_login,
                    container,
                    false
                )
    }
}