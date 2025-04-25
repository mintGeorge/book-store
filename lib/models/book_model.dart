class BookModel {
  String title;
  String author;
  String coverImagePath;
  String genre;
  String description;
  String pages;
  bool isFavorite;

  BookModel({
    required this.title,
    required this.author,
    required this.coverImagePath,
    required this.genre,
    required this.description,
    required this.pages,
    required this.isFavorite,
  });

  static List<BookModel> getPopularBooks() {
    return [
      BookModel(
        title: 'The Midnight Library',
        author: 'Matt Haig',
        coverImagePath: 'assets/images/themidnightlibrary.jpg',
        genre: 'Fiction',
        description: 'A woman explores different versions of her life through a mystical library.',
        pages: '304 pages',
        isFavorite: true,
      ),
      BookModel(
        title: 'Atomic Habits',
        author: 'James Clear',
        coverImagePath: 'assets/images/atomichabits.jpg',
        genre: 'Self-help',
        description: 'A guide to building good habits and breaking bad ones through small changes.',
        pages: '320 pages',
        isFavorite: false,
      ),
      BookModel(
        title: '1984',
        author: 'George Orwell',
        coverImagePath: 'assets/images/1984.jpg',
        genre: 'Dystopian',
        description: 'A chilling vision of a totalitarian regime that uses surveillance to control citizens.',
        pages: '328 pages',
        isFavorite: true,
      ),
      BookModel(
        title: 'To Kill a Mockingbird',
        author: 'Harper Lee',
        coverImagePath: 'assets/images/tokillamockingbird.jpg',
        genre: 'Classic',
        description: 'A story of racial injustice and childhood innocence in the American South.',
        pages: '281 pages',
        isFavorite: false,
      ),
      BookModel(
        title: 'The Alchemist',
        author: 'Paulo Coelho',
        coverImagePath: 'assets/images/thealchemist.jpg',
        genre: 'Adventure',
        description: 'A shepherd travels in search of treasure and discovers his personal legend.',
        pages: '208 pages',
        isFavorite: true,
      ),
      BookModel(
        title: 'Sapiens',
        author: 'Yuval Noah Harari',
        coverImagePath: 'assets/images/sapiens.jpg',
        genre: 'History',
        description: 'A brief history of humankind from the Stone Age to the modern era.',
        pages: '498 pages',
        isFavorite: false,
      ),
      BookModel(
        title: 'The Book Thief',
        author: 'Markus Zusak',
        coverImagePath: 'assets/images/thebookthief.jpg',
        genre: 'Historical Fiction',
        description: 'A young girl finds solace in books during Nazi Germany, narrated by Death.',
        pages: '552 pages',
        isFavorite: true,
      ),
      BookModel(
        title: 'The Hobbit',
        author: 'J.R.R. Tolkien',
        coverImagePath: 'assets/images/thehobbit.jpg',
        genre: 'Fantasy',
        description: 'Bilbo Baggins sets out on an epic journey to reclaim a treasure from a dragon.',
        pages: '310 pages',
        isFavorite: false,
      ),
      BookModel(
        title: 'The Catcher in the Rye',
        author: 'J.D. Salinger',
        coverImagePath: 'assets/images/thecatcherintherye.jpg',
        genre: 'Coming-of-age',
        description: 'Holden Caulfield’s raw and honest take on adolescence and alienation.',
        pages: '214 pages',
        isFavorite: true,
      ),
      BookModel(
        title: 'Rich Dad Poor Dad',
        author: 'Robert Kiyosaki',
        coverImagePath: 'assets/images/richdadpoordad.jpg',
        genre: 'Finance',
        description: 'Lessons on wealth and financial independence through two father figures.',
        pages: '336 pages',
        isFavorite: true,
      ),
      BookModel(
        title: 'Dune',
        author: 'Frank Herbert',
        coverImagePath: 'assets/images/dune.jpg',
        genre: 'Sci-Fi',
        description: 'A prince becomes a messiah on a desert planet, fighting for control and survival.',
        pages: '688 pages',
        isFavorite: false,
      ),
      BookModel(
        title: 'The Subtle Art of Not Giving a F*ck',
        author: 'Mark Manson',
        coverImagePath: 'assets/images/thesubtleartofnotgivingafck.jpg',
        genre: 'Self-help',
        description: 'A raw approach to living a meaningful life by embracing life’s struggles.',
        pages: '224 pages',
        isFavorite: true,
      ),
      BookModel(
        title: 'Crime and Punishment',
        author: 'Fyodor Dostoevsky',
        coverImagePath: 'assets/images/crimeandpunishment.jpg',
        genre: 'Philosophical Fiction',
        description: 'A man grapples with guilt after committing murder in search of meaning.',
        pages: '671 pages',
        isFavorite: false,
      ),
      BookModel(
        title: 'The Power of Now',
        author: 'Eckhart Tolle',
        coverImagePath: 'assets/images/thepowerofnow.jpg',
        genre: 'Spirituality',
        description: 'A guide to spiritual awakening through the practice of present moment awareness.',
        pages: '236 pages',
        isFavorite: true,
      ),
    ];
  }
}
  