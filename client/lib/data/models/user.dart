class User {
  final String name;
  final String username;
  final String phoneNumber;
  final String email;
  final String password;
  final List<User> followers = [];
  final List<User> followings = [];

  User({
    required this.name, 
    required this.username, 
    required this.phoneNumber, 
    required this.email, 
    required this.password, 
  });

  void addFollower(User follower){
    followers.add(follower);
  }

  void addFollowing(User following){
    followings.add(following);
  }
}