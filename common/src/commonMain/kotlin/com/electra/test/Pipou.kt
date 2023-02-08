package com.electra.test

class FirstViewModel(
    private val navController: NavController
) {
    fun onCLick() {
        navController.push(NavLink.SECOND)
    }
}

class SecondViewModel(
    private val navController: NavController
) {
    fun onCLick() {
        navController.push(NavLink.THIRD)
    }
}

class ThirdViewModel(
    private val navController: NavController
) {
    fun onCLick() {
        navController.popTo(NavLink.FIRST)
    }
}

enum class NavLink {
    FIRST,
    SECOND,
    THIRD
}

object AppConstants {
    val rootScreen = NavLink.FIRST
}

interface NavController {
    fun push(navLink: NavLink)
    fun popTo(navLink: NavLink)
}