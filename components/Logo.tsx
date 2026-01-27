import Image from 'next/image';

type LogoProps = {
  className?: string;
  imageClassName?: string;
  priority?: boolean;
  alt?: string;
};

const getClassNames = (...names: Array<string | undefined>) =>
  names.filter(Boolean).join(' ');

export default function Logo({
  className = 'h-10 w-[160px]',
  imageClassName,
  priority = false,
  alt = 'Flashcards Generator',
}: LogoProps) {
  const imageClasses = getClassNames('object-contain', imageClassName);

  return (
    <div
      className={getClassNames('relative', className)}
      style={{ background: 'transparent', boxShadow: 'none' }}
    >
      <Image
        src="/logo-dark.png"
        alt={alt}
        fill
        sizes="(max-width: 768px) 140px, 160px"
        className={getClassNames(imageClasses, 'block', 'dark:hidden')}
        priority={priority}
      />
      <Image
        src="/logo.png"
        alt={alt}
        fill
        sizes="(max-width: 768px) 140px, 160px"
        className={getClassNames(imageClasses, 'hidden', 'dark:block')}
        priority={priority}
      />
    </div>
  );
}
