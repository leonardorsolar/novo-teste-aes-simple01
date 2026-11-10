const { test } = require('node:test');
const assert = require('node:assert');
const app = require('../src/app');

test('GET / responds 200 with Hello World', async () => {
  const server = app.listen(0);
  await new Promise((resolve) => server.once('listening', resolve));
  try {
    const { port } = server.address();
    const res = await fetch(`http://localhost:${port}/`);
    assert.strictEqual(res.status, 200);
    assert.strictEqual(await res.text(), 'Hello World');
  } finally {
    await new Promise((resolve) => server.close(resolve));
  }
});
