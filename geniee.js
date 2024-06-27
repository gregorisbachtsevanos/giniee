#!/usr/bin/env node
import { spawn } from 'child_process';
import { join } from 'path';

const script = join(__dirname, './scripts/index.sh');
const child = spawn(script, { stdio: 'inherit', shell: true });

child.on('exit', (code) => {
    process.exit(code);
});

child.on('error', (err) => {
    console.error('Failed to start subprocess.');
    process.exit(1);
});
