package com.electra.mobile.config

import com.electra.mobile.adapter.toEndpoint
import com.electra.mobile.config.data.Endpoint
import com.electra.mobile.config.data.State
import com.electra.mobile.data.EndpointSelection
import com.electra.mobile.network.ElectraBackend
import com.electra.mobile.storage.DebugConfigPrefs
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow

internal class ConfigViewModelImpl(
    private val prefs: DebugConfigPrefs,
    private val client: ElectraBackend,
    private val actions: Actions
): ConfigViewModel {
    private val previousEndpointSelection = prefs.getEndpointSelection()
    private var customEndpointState = ""
    private val mutableState = MutableStateFlow(
        State(selectedEndpoint = previousEndpointSelection.toEndpoint())
    )
    override val state: StateFlow<State> = mutableState

    override fun onEndpointSelected(endpoint: Endpoint) {
        mutableState.value = mutableState.value.copy(selectedEndpoint = endpoint)
    }

    override fun onCustomEndpointChanged(newValue: String) {
        customEndpointState = newValue
    }

    override fun onContinueClicked() {
        val newEndpoint = state.value.selectedEndpoint.toEndpointSelection()

        prefs.storeEndpointSelection(newEndpoint)
        if (newEndpoint.value != previousEndpointSelection.value) {
            client.clearCache()
        }

        actions.onConfirmClicked()
    }

    private fun Endpoint.toEndpointSelection() = when (state.value.selectedEndpoint) {
        Endpoint.CUSTOM -> EndpointSelection.Custom(customEndpointState)
        Endpoint.LOCAL -> EndpointSelection.Local
        Endpoint.STAGING -> EndpointSelection.Staging
    }
}

fun provideConfigViewModel(): ConfigViewModel = ConfigViewModelImpl(
    prefs = ,
    client = ,
    actions = Actions(
        onConfirmClicked = {
            // TODO()
        }
    )
)