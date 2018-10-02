const puppeteer = require('puppeteer');
const fs = require('fs');

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto('file:///D:/documents/github/elm-amcss/build/css.html');

  const css = await page.evaluate(() => {
    return document.body.firstChild.nextSibling.textContent;
  });

  await browser.close();

  fs.writeFile('build/index.css', css, (err) => {
    if (err) throw err;
  });
})();
