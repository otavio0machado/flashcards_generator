const crypto = require('crypto');
console.log('\n🔑 CRON_SECRET Generated!\n');
console.log('Add this to your .env.local file:\n');
console.log(`CRON_SECRET=${crypto.randomBytes(32).toString('hex')}`);
console.log('\n');
