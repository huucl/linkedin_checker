chrome.runtime.onMessage.addListener(async function (message, sender, sendResponse) {
    sendResponse({ title: document.body.innerHTML });
});