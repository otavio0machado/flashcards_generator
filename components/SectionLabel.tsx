export default function SectionLabel({ text, className }: { text: string; className?: string }) {
    return (
        <p className={`text-[11px] font-black uppercase tracking-widest text-brand mb-3${className ? ` ${className}` : ''}`}>
            {text}
        </p>
    );
}
