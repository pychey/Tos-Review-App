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

export function formatPost(post: any, requestingUserId?: string) {
  const { ratings, ...rest } = post;
  const avgUserRating =
    ratings.length > 0
      ? ratings.reduce((sum: number, r: { value: number }) => sum + r.value, 0) / ratings.length
      : null;

  const isOwner = requestingUserId === post.authorId;
  const author = post.isAnonymous && !isOwner
    ? { id: null, name: 'Anonymous', profileSrc: null }
    : rest.author;

  return { ...rest, author, avgUserRating };
}