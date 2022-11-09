package com.electra.mobile.config

import com.electra.mobile.config.data.Endpoint
import com.electra.mobile.config.data.State
import kotlinx.coroutines.flow.StateFlow

interface ConfigViewModel {
    val state: StateFlow<State>
    fun onEndpointSelected(endpoint: Endpoint)
    fun onCustomEndpointChanged(newValue: String)
    fun onContinueClicked()
}