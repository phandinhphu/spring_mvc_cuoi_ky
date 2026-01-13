// Background Service Worker
// Handles extension lifecycle and background tasks

chrome.runtime.onInstalled.addListener(() => {
    console.log('Japanese Learning Extension installed');

    // Set default settings
    chrome.storage.sync.get(['serverUrl'], (result) => {
        if (!result.serverUrl) {
            chrome.storage.sync.set({
                serverUrl: 'http://localhost:8080/cuoi_ky',
                enabled: true
            });
        }
    });
});

// Listen for messages from content script (if needed in future)
chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
    if (request.action === 'translate') {
        // Handle translation request if needed
        handleTranslation(request.text)
            .then(response => sendResponse(response))
            .catch(error => sendResponse({ success: false, error: error.message }));
        return true; // Keep message channel open for async response
    }
});

async function handleTranslation(text) {
    const result = await chrome.storage.sync.get(['serverUrl']);
    const serverUrl = result.serverUrl || 'http://localhost:8080/cuoi_ky';

    try {
        const response = await fetch(`${serverUrl}/api/translate`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ text: text })
        });

        return await response.json();
    } catch (error) {
        throw new Error('Failed to connect to server');
    }
}

// Log background script loaded
console.log('Japanese Learning Extension background script loaded');
