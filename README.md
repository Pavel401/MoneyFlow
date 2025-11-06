# Money Tracker App

A Flutter application that automatically reads SMS messages to track financial transactions using AI-powered parsing with Google's Gemini API.

## Features

### Core Functionality
- 📱 **SMS Reading**: Automatically reads banking SMS messages from your phone
- 🤖 **AI-Powered Parsing**: Uses Google Gemini API to extract transaction details from SMS
- 💰 **Transaction Management**: Add, edit, delete, and categorize transactions
- 📊 **Visual Analytics**: View spending by category and transaction types
- 📸 **Photo Attachments**: Add photos to transactions for receipts and documentation
- 🎨 **Clean UI**: Black and white minimalist design for better focus

### Technical Features
- **Clean Architecture**: Well-structured codebase with separation of concerns
- **State Management**: GetX for reactive state management
- **Local Database**: Drift for efficient local data storage
- **Responsive Design**: Sizer package for responsive layouts
- **SMS Permissions**: Proper permission handling for SMS access

## Setup Instructions

### 1. Prerequisites
- Flutter SDK (latest version)
- Android Studio / VS Code with Flutter extensions
- A device or emulator for testing

### 2. Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd moneyapp
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code (for Drift database)**
   ```bash
   dart run build_runner build
   ```

### 3. API Configuration

1. **Get Google Gemini API Key**
   - Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
   - Create a new API key
   - Copy the API key

2. **Configure API Key**
   - Open `lib/core/constants/app_constants.dart`
   - Replace `YOUR_GEMINI_API_KEY_HERE` with your actual API key:
   ```dart
   static const String geminiApiKey = 'your_actual_api_key_here';
   ```

3. **Update Dependency Injection**
   - Open `lib/core/dependencies/dependency_injection.dart`
   - Update the Gemini service initialization:
   ```dart
   Get.lazyPut<GeminiService>(() => GeminiService(AppConstants.geminiApiKey), fenix: true);
   ```

### 4. Permissions Setup

The app requires SMS and storage permissions. These are already configured in the Android manifest, but you may need to manually grant them:

1. **Android Permissions** (already added to `android/app/src/main/AndroidManifest.xml`)
   - READ_SMS
   - RECEIVE_SMS
   - READ_EXTERNAL_STORAGE
   - WRITE_EXTERNAL_STORAGE
   - CAMERA

2. **Grant Permissions**
   - The app will request permissions at runtime
   - You can also manually grant them in device settings

### 5. Running the App

```bash
flutter run
```

## Usage Guide

### First Launch
1. **Grant Permissions**: Allow SMS, storage, and camera permissions when prompted
2. **Scan SMS**: Tap "Scan SMS" to process banking messages from the last 30 days
3. **Review Transactions**: AI-parsed transactions will appear in your transaction list

### Adding Manual Transactions
1. Tap "Add Manual" button
2. Fill in transaction details:
   - **Type**: Credit or Debit
   - **Title**: Transaction name
   - **Amount**: Transaction amount
   - **Description**: Additional details
   - **Category**: Select from predefined categories
   - **Location**: Optional location information
   - **Photos**: Add receipt photos using camera or gallery

### Managing Transactions
- **View Details**: Tap on any transaction to see full details
- **Edit**: Use the edit button to modify transaction information
- **Delete**: Remove unwanted transactions
- **Filter**: Use filters to find transactions by type, category, or date
- **Search**: Search transactions by title or description

### Categories Available
- Food
- Grocery
- Transport
- Entertainment
- Shopping
- Healthcare
- Education
- Utilities
- Fuel
- Other

## Architecture

The app follows Clean Architecture principles:

```
lib/
├── core/
│   ├── constants/     # App constants and configurations
│   ├── theme/         # UI theme and styling
│   └── utils/         # Utility classes and helpers
├── data/
│   ├── datasources/   # SMS service, Gemini API service
│   ├── models/        # Database models and mappers
│   └── repositories/  # Repository implementations
├── domain/
│   ├── entities/      # Business entities
│   ├── repositories/  # Repository interfaces
│   └── usecases/      # Business logic use cases
└── presentation/
    ├── controllers/   # GetX controllers
    ├── views/         # Screen widgets
    └── widgets/       # Reusable UI components
```

## Key Technologies

- **Flutter**: Cross-platform mobile development
- **GetX**: State management and dependency injection
- **Drift**: Type-safe SQL database
- **Sizer**: Responsive design
- **Google Gemini**: AI-powered text parsing
- **SMS Advanced**: SMS reading capabilities
- **Image Picker**: Photo functionality
- **Permission Handler**: Runtime permissions

## Important Notes

### SMS Processing
- The app only reads SMS messages containing banking keywords
- All processing is done locally except for AI parsing
- SMS content is sent to Gemini API for transaction extraction
- Confidence threshold is set to 70% to ensure accuracy

### Privacy & Security
- SMS data is only used for transaction parsing
- No personal data is stored externally
- All transactions are stored locally on your device
- API calls to Gemini only include SMS text content

### Limitations
- Currently optimized for English banking SMS formats
- Requires internet connection for AI parsing
- SMS reading permission must be granted for automatic processing

## Troubleshooting

### Common Issues

1. **SMS Permission Denied**
   - Go to app settings and manually grant SMS permission
   - Restart the app after granting permission

2. **No Transactions Found**
   - Ensure you have banking SMS messages in your inbox
   - Check if SMS contains transaction-related keywords
   - Try processing older messages by adjusting the date range

3. **Gemini API Errors**
   - Verify your API key is correct and active
   - Check internet connection
   - Ensure you haven't exceeded API quotas

4. **Database Issues**
   - Clear app data and restart
   - Run `dart run build_runner build --delete-conflicting-outputs`

## Future Enhancements

- **Analytics Dashboard**: Detailed spending analytics and charts
- **Budget Planning**: Set and track monthly budgets
- **Export Functionality**: Export transactions to CSV/PDF
- **Cloud Sync**: Backup and sync across devices
- **Multiple Languages**: Support for regional language SMS
- **Bank Integration**: Direct bank API integration
- **Recurring Transactions**: Automatic detection and categorization

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues and questions:
- Create an issue in the repository
- Check the troubleshooting section
- Review the Flutter and package documentation

---

**Note**: Remember to keep your Gemini API key secure and never commit it to version control. Consider using environment variables for production deployments.
