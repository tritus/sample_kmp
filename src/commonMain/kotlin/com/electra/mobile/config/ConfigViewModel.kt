package com.electra.mobile.config

import com.electra.mobile.config.data.Endpoint
import com.electra.mobile.config.data.State
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow

class ConfigViewModel {
    private var customEndpointState = ""
    private val mutableState = MutableStateFlow(
        State(selectedEndpoint = Endpoint.STAGING)
    )
    val state: StateFlow<State> = mutableState

    fun onEndpointSelected(endpoint: Endpoint) {
        mutableState.value = mutableState.value.copy(selectedEndpoint = endpoint)
    }

    fun onCustomEndpointChanged(newValue: String) {
        customEndpointState = newValue
    }

    fun onContinueClicked() {
        // TODO
    }

}