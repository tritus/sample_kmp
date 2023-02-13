package com.electra.test.viewmodel

import com.electra.test.navigation.NavController
import com.electra.test.navigation.NavLink

class ThirdViewModel(
    private val navController: NavController
) {
    fun onClick() {
        navController.popTo(NavLink.FIRST)
    }
}