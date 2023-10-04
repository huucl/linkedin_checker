function sendMessage(message) {
  chrome.tabs.query({active: true, currentWindow: true}, function(tabs) {
            console.log(tabs[0].id);

     chrome.tabs.sendMessage( tabs[0].id, { "type": "notifications", "data": message });
       });

}

chrome.runtime.onMessage.addListener(async function (message, sender, sendResponse) {
    console.log("WTF1");
    console.log(message.data);

      if (message.type === "counter") {
        sendMessage(message.data);
      }
});