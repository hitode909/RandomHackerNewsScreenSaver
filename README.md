# Random Hacker News ScreenSaver

- Open [Hacker News](https://news.ycombinator.com/) in WebView
- Visit random news
- Scroll the news to page button and back to Hacker News

# WHY THIS REPOSITORY IS USEFUL

This screensaver has very simple implementation. Main logic is executed with `WebView.evaluateJavaScript`.
You can fork this repository and customize for your favorite website.

- https://github.com/hitode909/RandomHackerNewsScreenSaver/blob/414b28747429efe9be4fad7cc5b8d86de83f1b14/RandomHackerNews/RandomHackerNewsView.swift#L26

```swift
    @objc func step() {
        let code: String = """
            (() => {
                const TOP_URI = 'https://news.ycombinator.com/';
                const pick = (list) => list[Math.floor(Math.random() * list.length)];
                const newsLinks = document.querySelectorAll('a.storylink');
                const visitTop = () => location.href = TOP_URI;
                // visit random news
                if (location.href === TOP_URI && newsLinks.length > 0) {
                    location.href = pick(newsLinks);
                }
                // scroll articles
                else {
                    const topBefore = window.scrollY;
                    window.scrollBy(0, window.innerHeight * 0.9);
                    setTimeout(() => {
                        const topAfter = window.scrollY;
                        // detect bottom
                        if (topBefore === topAfter) {
                            console.log('visitTop');
                            visitTop();
                        }
                    }, 100);
                }
            })()
            """
        self.webView.evaluateJavaScript(code, completionHandler: nil)
```