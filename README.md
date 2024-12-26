# Bloggy

This project is a modern **Flutter** application developed following the **Clean Architecture** principles. It includes features for creating blog posts and user authentication, offering a reliable, flexible, and scalable structure.

## Key Features

- **Clean Architecture**: The code structure is divided into core and feature modules.
- **State Management**: Managed efficiently using **flutter_bloc**.
- **Error Handling**: Handled securely with **fp_dart**.
- **Dependency Injection**: Centralized dependency management using **get_it**.
- **Database**: **Supabase** ensures secure and fast data handling.
- **Local Storage**: Implemented with **Hive** and **Isar** for performant and flexible data storage solutions.
- **Image Processing**: Supported with **image_picker** for user image uploads.
- **Internationalization**: Handled date and time formatting using **intl**.

## Architecture

### Core

- **Base Classes**: Shared services, error handling classes, and utility functions.
- **Utilities**: Constants and theme settings used across the application.

### Features

#### Auth Feature

- User registration, login, and session management.
- Integrated with Supabase authentication API.

#### Blog Feature

- Create, edit, and delete blog posts.
- List blog posts and display post details.

## Packages Used

- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [fp_dart](https://pub.dev/packages/fp_dart)
- [get_it](https://pub.dev/packages/get_it)
- [supabase_flutter](https://pub.dev/packages/supabase_flutter)
- [image_picker](https://pub.dev/packages/image_picker)
- [intl](https://pub.dev/packages/intl)
- [hive](https://pub.dev/packages/hive)
- [isar](https://pub.dev/packages/isar)

## Installation and Usage

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/alinahmettekin/bloggy.git
   cd blog_application
   ```

2. **Install Dependencies**:

   ```bash
   flutter pub get
   ```

3. **Configure Supabase**:

   - Add your `API URL` and `API KEY` from your Supabase project to the `lib/core/secrets/app_secrets.dart` file.

4. **Run the Application**:
   ```bash
   flutter run
   ```

## Screenshots

> Coming soon.

## Development Process

1. Core and feature modules were separated.
2. Error handling was integrated using fp_dart and get_it.
3. User authentication and data management were implemented with Supabase.
4. Pages for managing blog posts were created.

---

Feel free to contact me for any questions or suggestions!
