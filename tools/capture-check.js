const { app, desktopCapturer } = require('electron');

app.whenReady().then(async () => {
  console.log(`Electron ${process.versions.electron}, session ${process.env.XDG_SESSION_TYPE || 'unknown'}`);
  try {
    const sources = await desktopCapturer.getSources({ types: ['screen', 'window'] });
    console.log(`Capture sources returned: ${sources.length}`);
    for (const source of sources) {
      console.log(`- ${source.id}: ${source.name}`);
    }
  } catch (error) {
    console.error('Capture failed:', error);
    process.exitCode = 1;
  } finally {
    app.quit();
  }
});
