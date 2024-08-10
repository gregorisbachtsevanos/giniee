#!/usr/bin/env node
const { spawn } = require('child_process');
const path = require('path');
const fs = require('fs');

// Absolute path to the script
const script = path.join(__dirname, './giniee.sh');

// Check if the script exists
if (!fs.existsSync(script)) {
    console.error(`Script not found: ${script}`);
    process.exit(1);
}

// Determine the appropriate shell based on the platform
const isWindows = process.platform === 'win32';
const shell = isWindows ? 'C:\\Windows\\System32\\cmd.exe' : '/bin/sh';
const shellArgs = isWindows ? ['/c', script] : [script];

console.log(`Executing script at: ${script}`);
console.log(`Shell: ${shell}`);
console.log(`Shell Arguments: ${shellArgs.join(' ')}`);

// Spawn a child process to execute the script
const child = spawn(shell, shellArgs, { stdio: 'inherit' });

child.on('exit', (code) => {
    console.log(`Child process exited with code ${code}`);
    process.exit(code);
});

child.on('error', (err) => {
    console.error('Failed to start subprocess.');
    console.error(err);
    process.exit(1);
});
