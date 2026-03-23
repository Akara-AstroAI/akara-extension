// Proxy requests to avoid Mixed Content issues (HTTPS page -> HTTP localhost)
chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
    if (request.action === "checkText") {

        // Try fetching with the slash first
        fetch("https://keyez.tech/api/spell-check/", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Accept": "application/json"
            },
            body: JSON.stringify({ text: request.text })
        })
            .then(async (response) => {
                if (!response.ok) {
                    const errorText = await response.text();
                    console.error("API Error Response:", errorText);
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                console.log("API Success:", data);
                sendResponse({ success: true, data: data });
            })
            .catch(error => {
                console.error("Fetch Error:", error);
                sendResponse({ success: false, error: error.toString() });
            });

        return true; // Keep the message channel open for async response
    }
});
