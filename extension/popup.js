// Popup Script - Handles extension settings UI

document.addEventListener('DOMContentLoaded', () => {
    loadSettings();

    // Event listeners
    document.getElementById('saveBtn').addEventListener('click', saveSettings);
    document.getElementById('testBtn').addEventListener('click', testConnection);
    document.getElementById('toggleEnable').addEventListener('click', toggleExtension);
});

function loadSettings() {
    chrome.storage.sync.get(['serverUrl', 'enabled'], (result) => {
        document.getElementById('serverUrl').value = result.serverUrl || 'http://localhost:8080/cuoi_ky';

        const enabled = result.enabled !== false; // Default to true
        updateToggleSwitch(enabled);
    });
}

function saveSettings() {
    const serverUrl = document.getElementById('serverUrl').value.trim();

    if (!serverUrl) {
        showStatus('Please enter a server URL', 'error');
        return;
    }

    // Validate URL format
    try {
        new URL(serverUrl);
    } catch (e) {
        showStatus('Invalid URL format', 'error');
        return;
    }

    chrome.storage.sync.set({
        serverUrl: serverUrl
    }, () => {
        showStatus('Settings saved successfully!', 'success');
    });
}

function testConnection() {
    const serverUrl = document.getElementById('serverUrl').value.trim();

    if (!serverUrl) {
        showStatus('Please enter a server URL first', 'error');
        return;
    }

    showStatus('Testing connection...', 'info');

    fetch(`${serverUrl}/api/translate/health`)
        .then(response => {
            if (response.ok) {
                return response.json();
            }
            throw new Error('Server responded with error');
        })
        .then(data => {
            showStatus('✓ Connection successful! Server is online.', 'success');
        })
        .catch(error => {
            showStatus('✗ Connection failed. Please check the URL and make sure the server is running.', 'error');
        });
}

function toggleExtension() {
    chrome.storage.sync.get(['enabled'], (result) => {
        const newState = !(result.enabled !== false);

        chrome.storage.sync.set({
            enabled: newState
        }, () => {
            updateToggleSwitch(newState);
            showStatus(
                newState ? 'Extension enabled' : 'Extension disabled',
                newState ? 'success' : 'info'
            );
        });
    });
}

function updateToggleSwitch(enabled) {
    const switchElement = document.getElementById('enableSwitch');
    if (enabled) {
        switchElement.classList.add('active');
    } else {
        switchElement.classList.remove('active');
    }
}

function showStatus(message, type) {
    const statusEl = document.getElementById('status');
    statusEl.textContent = message;
    statusEl.className = `status ${type}`;
    statusEl.classList.remove('hidden');

    // Auto-hide after 3 seconds for success/info messages
    if (type === 'success' || type === 'info') {
        setTimeout(() => {
            statusEl.classList.add('hidden');
        }, 3000);
    }
}
