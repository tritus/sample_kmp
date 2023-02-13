package com.electra.test.viewmodel

import com.electra.test.navigation.NavController
import com.electra.test.navigation.NavLink
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.update

class FirstViewModel(
    private val navController: NavController
) {
    private val _state = MutableStateFlow(0)
    val state: StateFlow<Int>
        get() = _state

    fun onClick() {
        navController.push(NavLink.SECOND)
    }

    fun onOpenSecondWithModalClicked() {
        navController.pushModal(NavLink.SECOND)
    }

    fun onIncrementClicked() {
        _state.update { it + 1 }
    }
}