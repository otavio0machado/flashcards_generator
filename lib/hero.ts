export function getHeroHeadline(variant = 'A') {
  switch (variant) {
    case 'B':
      return 'Aprenda com flashcards inteligentes';
    case 'C':
      return 'Transforme textos em aprendizado ativo';
    default:
      return 'Aprenda mais focando no que importa';
  }
}

export function getHeroSubtitle(variant = 'A') {
  switch (variant) {
    case 'B':
      return 'Use IA para gerar flashcards prontos para Anki e Quizlet.';
    case 'C':
      return 'Crie revisões eficientes com poucos cliques.';
    default:
      return 'Cole textos e gere flashcards otimizados para memorização.';
  }
}
