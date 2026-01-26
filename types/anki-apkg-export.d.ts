declare module 'anki-apkg-export' {
  export default class AnkiExport {
    constructor(deckName: string);
    addCard(front: string, back: string): void;
    addMedia(filename: string, data: Buffer | ArrayBuffer | Uint8Array): void;
    save(): Promise<ArrayBuffer | Buffer | Uint8Array | string>;
  }
}
