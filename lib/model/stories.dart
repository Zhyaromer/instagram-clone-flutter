class Stories {
  final String id;
  final String username;
  final String imageUrl;
  final String storieUrl;
  final bool isLiked;
  final bool isVerified;
  final String date;
  final String song;

  Stories({
    required this.id,
    required this.username,
    required this.imageUrl,
    required this.storieUrl,
    required this.date,
    this.isVerified = false,
    this.song = '',
    this.isLiked = false,
  });
}

List<Stories> storyData = [
  Stories(
    id: "1",
    username: "przhekareem",
    isVerified: true,
    song: "the winner takes it all",
    imageUrl: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400",
    storieUrl: "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800",
    date: "2h",
  ),
  Stories(
    id: "2",
    username: "nature_lover",
    song: "Sonne",
    isLiked: true,
    imageUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400",
    storieUrl: "https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800",
    date: "3h",
  ),
  Stories(
    id: "3",
    username: "urban_vibe",
    imageUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400",
    storieUrl: "https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=800",
    date: "5h",
  ),
  Stories(
    id: "4",
    username: "chef_mariana",
    isLiked: true,
    imageUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400",
    storieUrl: "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800",
    date: "6h",
  ),
  Stories(
    id: "5",
    username: "fitness_pro",
    imageUrl: "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=400",
    storieUrl: "https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=800",
    date: "8h",
  ),
  Stories(
    id: "6",
    username: "coffee_cat",
    imageUrl: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=400",
    storieUrl: "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800",
    date: "10h",
  ),
  Stories(
    id: "7",
    username: "art_by_leo",
    isLiked: true,
    imageUrl: "https://images.unsplash.com/photo-1488161628813-04466f872be2?w=400",
    storieUrl: "https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?w=800",
    date: "12h",
  ),
  Stories(
    id: "8",
    username: "tech_guy_99",
    imageUrl: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400",
    storieUrl: "https://images.unsplash.com/photo-1518770660439-4636190af475?w=800",
    date: "14h",
  ),
  Stories(
    id: "9",
    username: "sara_styles",
    isLiked: true,
    imageUrl: "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=400",
    storieUrl: "https://images.unsplash.com/photo-1483985988355-763728e1935b?w=800",
    date: "16h",
  ),
  Stories(
    id: "10",
    username: "wanderlust",
    imageUrl: "https://images.unsplash.com/photo-1463453091185-61582044d556?w=400",
    storieUrl: "https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800",
    date: "18h",
  ),
  Stories(
    id: "11",
    username: "hiking_fan",
    imageUrl: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400",
    storieUrl: "https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800",
    date: "20h",
  ),
  Stories(
    id: "12",
    username: "city_lights",
    imageUrl: "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=400",
    storieUrl: "https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=800",
    date: "22h",
  ),
  Stories(
    id: "13",
    username: "pet_world",
    imageUrl: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400",
    storieUrl: "https://images.unsplash.com/photo-1517849845537-4d257902454a?w=800",
    date: "1 day ago",
  ),
  Stories(
    id: "14",
    username: "music_vibes",
    imageUrl: "https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?w=400",
    storieUrl: "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=800",
    date: "1 day ago",
  ),
  Stories(
    id: "15",
    username: "yoga_soul",
    imageUrl: "https://images.unsplash.com/photo-1534751516642-a1af1ef26a56?w=400",
    storieUrl: "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=800",
    date: "1 day ago",
  ),
  Stories(
    id: "16",
    username: "ocean_child",
    imageUrl: "https://images.unsplash.com/photo-1504257432389-52343af06ae3?w=400",
    storieUrl: "https://images.unsplash.com/photo-1505118380757-91f5f5632de0?w=800",
    date: "2 days ago",
  ),
  Stories(
    id: "17",
    username: "baker_boy",
    imageUrl: "https://images.unsplash.com/photo-1521119989659-a83eee4882b2?w=400",
    storieUrl: "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800",
    date: "2 days ago",
  ),
  Stories(
    id: "18",
    username: "desert_rose",
    imageUrl: "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=400",
    storieUrl: "https://images.unsplash.com/photo-1473580044384-7ba9967e16a0?w=800",
    date: "2 days ago",
  ),
  Stories(
    id: "19",
    username: "retro_gamer",
    imageUrl: "https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?w=400",
    storieUrl: "https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=800",
    date: "3 days ago",
  ),
  Stories(
    id: "20",
    username: "snow_fox",
    imageUrl: "https://images.unsplash.com/photo-1530268729831-4b0b9e170218?w=400",
    storieUrl: "https://images.unsplash.com/photo-1478719059408-592965723cbc?w=800",
    date: "3 days ago",
  ),
  Stories(
    id: "21",
    username: "architect_X",
    imageUrl: "https://images.unsplash.com/photo-1463453091185-61582044d556?w=400",
    storieUrl: "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=800",
    date: "4 days ago",
  ),
  Stories(
    id: "22",
    username: "silent_reader",
    imageUrl: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400",
    storieUrl: "https://images.unsplash.com/photo-1512820790803-83ca734da794?w=800",
    date: "4 days ago",
  ),
  Stories(
    id: "23",
    username: "car_enthusiast",
    imageUrl: "https://images.unsplash.com/photo-1519345182560-3f2917c472ef?w=400",
    storieUrl: "https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=800",
    date: "5 days ago",
  ),
  Stories(
    id: "24",
    username: "street_cat",
    imageUrl: "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=400",
    storieUrl: "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=800",
    date: "5 days ago",
  ),
  Stories(
    id: "25",
    username: "star_gazer",
    imageUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400",
    storieUrl: "https://images.unsplash.com/photo-1506318129721-4648382c1294?w=800",
    date: "6 days ago",
  ),
];
