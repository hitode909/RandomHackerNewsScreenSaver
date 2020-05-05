import ScreenSaver
import WebKit

class RandomHackerNewsView: ScreenSaverView {
    var webView: WKWebView!
    var timer: Timer!

    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        
        self.animationTimeInterval = 999.0

        let webConfiguration = WKWebViewConfiguration()
        self.webView = WKWebView(frame: self.bounds, configuration: webConfiguration)
        self.addSubview(self.webView)
        
        self.timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.step), userInfo: nil, repeats: true)
        self.timer.fire()
    }

    @available(*, unavailable)
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    }
}
