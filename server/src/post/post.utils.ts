export const postInclude = {
  author: {
    select: { id: true, name: true, profileSrc: true },
  },
  _count: {
    select: { likes: true, comments: true, saves: true, ratings: true },
  },
  ratings: {
    select: { value: true },
  },
};

export function formatPost(post: any) {
  const { ratings, ...rest } = post;
  const avgUserRating =
    ratings.length > 0
      ? ratings.reduce((sum: number, r: { value: number }) => sum + r.value, 0) / ratings.length
      : null;
  return { ...rest, avgUserRating };
}