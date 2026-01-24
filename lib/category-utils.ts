export type Category = {
    id: string;
    name: string;
    parent_id: string | null;
    slug?: string | null;
};

const MAX_CATEGORY_DEPTH = 10;

export const buildCategoryLabelMap = (categories: Category[]) => {
    const byId = new Map(categories.map((category) => [category.id, category]));
    const cache = new Map<string, string>();

    const buildLabel = (categoryId: string) => {
        const cached = cache.get(categoryId);
        if (cached) return cached;

        const parts: string[] = [];
        let current = byId.get(categoryId);
        let depth = 0;

        while (current && depth < MAX_CATEGORY_DEPTH) {
            parts.push(current.name);
            current = current.parent_id ? byId.get(current.parent_id) : undefined;
            depth += 1;
        }

        const label = parts.reverse().join(' / ');
        cache.set(categoryId, label);
        return label;
    };

    const labels: Record<string, string> = {};
    categories.forEach((category) => {
        labels[category.id] = buildLabel(category.id);
    });

    return labels;
};

export const buildCategoryOptions = (categories: Category[], onlyLeaf = true) => {
    const childrenCount = new Map<string, number>();
    categories.forEach((category) => {
        if (category.parent_id) {
            childrenCount.set(category.parent_id, (childrenCount.get(category.parent_id) ?? 0) + 1);
        }
    });

    const labels = buildCategoryLabelMap(categories);
    const filtered = onlyLeaf
        ? categories.filter((category) => !childrenCount.has(category.id))
        : categories;

    return filtered
        .map((category) => ({
            id: category.id,
            label: labels[category.id] || category.name,
        }))
        .sort((a, b) => a.label.localeCompare(b.label));
};
