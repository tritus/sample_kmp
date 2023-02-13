package com.electra.test.viewmodel

import com.electra.test.navigation.NavController
import com.electra.test.navigation.NavLink

class SecondViewModel(
    private val navController: NavController
) {
    fun onClick() {
        navController.push(NavLink.THIRD)
    }

    fun onGoBackClicked() {
        navController.pop()
    }
}