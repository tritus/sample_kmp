package com.electra.test

import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.update

class FirstViewModel(
    private val navController: NavController
) {
    val _state = MutableStateFlow(0)
    val state: StateFlow<Int>
        get() = _state

    fun onCLick() {
        navController.push(NavLink.SECOND)
    }

    fun onOpenSecondWithModalClicked() {
        navController.pushModaly(NavLink.SECOND)
    }

    fun onIncrementClicked() {
        _state.update { it + 1 }
    }
}

class SecondViewModel(
    private val navController: NavController
) {
    fun onCLick() {
        navController.push(NavLink.THIRD)
    }

    fun onGoBackClicked() {
        navController.pop()
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
    fun pop()
    fun pushModaly(navLink: NavLink)
}