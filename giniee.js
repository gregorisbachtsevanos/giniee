#!/usr/bin/env node
const { spawn } = require('child_process');
const path = require('path');

const script = path.join(__dirname, 'scripts/index.sh');
const isWindows = process.platform === 'win32';
const shell = isWindows ? 'cmd.exe' : 'sh';
const shellArgs = isWindows ? ['/c', script] : [script];

console.log(`Executing script at: ${script}`);

const child = spawn(shell, shellArgs, { stdio: 'inherit', shell: true });

child.on('exit', (code) => {
    process.exit(code);
});

child.on('error', (err) => {
    console.error('Failed to start subprocess.');
    console.error(err);
    process.exit(1);
});
