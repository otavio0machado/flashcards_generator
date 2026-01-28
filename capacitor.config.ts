import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.flashcards.generator',
  appName: 'Flashcards',
  webDir: 'public',
  server: {
    url: 'https://keeperless-unfittingly-bristol.ngrok-free.dev',
    cleartext: true
  }
};

export default config;
