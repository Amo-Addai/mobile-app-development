package com.example.navigation_drawer_app

import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.app.ActionBarDrawerToggle
import android.os.Bundle

class MainActivity : AppCompatActivity() {

    lateinit var toggle: ActionBarDrawerToggle
    lateinit var drawerLayout: DrawerLayout

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        this.drawerLayout = findViewById(R.id.drawer_layout)
        val navView: NavigationView = findViewById(R.id.nav_view)

        this.toggle = ActionBarDrawerToggle(
            this@MainActivity,
            drawerLayout,
            R.string.open, // in resources - values/strings.xml
            R.string.close
        )

        this.drawerLayout.addDrawerListener(this.toggle)
        this.toggle.syncState()

        supportActionBar
            ?.setDisplayHomeAsUpEnabled(true)

        // navigation
        navView.setNavigationItemSelectedListener = navigation
        // { it.isChecked = true; .. } // TODO: confirm replacement with navView-selected-<item> == it scope

    }

    private val navigation = {
        it.isChecked = true // TODO: confirm it stil == navView-selected-<item> state
        when (it.itemId) {
            R.id.home -> {
                replaceFragment(
                    HomeFragment(),
                    it.title.toString()
                )
            }
            R.id.message -> {
                replaceFragment(
                    MessageFragment(),
                    it.title.toString()
                )
            }
            R.id.settings -> {
                replaceFragment(
                    SettingsFragment(),
                    it.title.toString()
                )
            }
            R.id.login -> {
                replaceFragment(
                    LoginFragment(),
                    it.title.toString()
                )
            }

            else -> replaceFragment(
                LoginFragment(),
                it.title.toString()
            )
        }
        true
    }

    private fun replaceFragment(
        fragment: Fragment,
        title: String
    ) {
        val fragmentManager = supportFragmentManager
        val fragmentTransaction = fragmentManager.beginTransaction()
        fragmentTransaction.replace(
            R.id.frame_layout,
            fragment
        )
        fragmentTransaction.commit()

        this.drawerLayout.closeDrawers()
        setTitle(title)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        if (
            toggle.onOptionsItemSelected(item)
        ) return true
        return super.onOptionsItemSelected(item)
    }

}