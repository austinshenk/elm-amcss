const puppeteer = require('puppeteer');
const fs = require('fs');
let _browser;
let _page;
let css;
puppeteer.launch()
.then(browser => _browser = browser)
.then(browser => _page = browser.newPage())
.then(page => page.goto(__dirname + '/css.html'))
.then(() => _page)
.then(page => {
  return page.evaluate(() => {
    return document.body.firstChild.nextSibling.textContent;
  })
})
.then(content => css = content)
.then(() => {
  fs.writeFile('build/index.css', css, (err) => {
    if (err) throw err;
  });
})
.then(() => _browser.close());
