chrome.runtime.onMessage.addListener(async function (message, sender, sendResponse) {
    console.log("WTF1");
    console.log(message.data);

      if (message.type === "counter") {
        sendMessage(message.data);
      }
    sendResponse({ title: "document.body.innerHTML" });
});