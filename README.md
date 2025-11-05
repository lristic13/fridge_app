# Fridge App

A Flutter application for tracking food items in your fridge, managing expiry dates, and sharing fridges with family members.

## Features

### Authentication
- **User Registration & Login** - Authentication by Firebase Auth
- **Email & Password Login** - Simple and secure access to your account
- **Persistent Sessions** - Stay logged in across app restarts

### Fridge Management
- **Multiple Fridges** - Create and manage multiple fridges 
- **Fridge Sharing** - Invite members by email to collaborate on shared fridges
- **Switch Fridges** - Switch between different fridges from settings
- **Rename Fridges** - Update fridge names 

### Product Tracking
- **Add Products** - Add items with name, type, and expiry date
- **Product Types** - Categorize items (Vegetables, Fruits, Dairy, Meat, Beverages, etc.)
- **Edit Products** - Update product details 
- **Delete Products** - Remove items 
- **Duplicate Products** - Quickly add similar items using the duplicate 

### Expiry Management
- **Color-Coded Badges** - Visual indicators for product freshness:
  - 🔴 Red: Expired items
  - 🟡 Yellow: Expiring soon (within 3 days)
  - 🟢 Green: Fresh items
- **Days Remaining** - See exactly how many days until expiry
- **Automatic Updates** - Real-time calculation of expiry status

### Search & Filter
- **Search by Name** - Quickly find products by searching their name
- **Filter by Type** - View only specific categories (e.g., only dairy products)
- **Combined Filters** - Search and filter simultaneously

### Sorting Options
- **Sort by Time Stored** - See newest or oldest items first
- **Sort by Expiry Date** - Prioritize items expiring soonest
- **Sort by Name** - Alphabetical organization
- **Sort by Type** - Group items by category


## Technologies Used

- **Flutter** - Cross-platform mobile framework
- **Firebase Authentication** - User authentication and management
- **Cloud Firestore** - Real-time NoSQL database
- **Riverpod** - State management
- **GoRouter** - Declarative routing and navigation
- **Freezed** - Code generation for immutable models
- **SharedPreferences** - Local storage for user preferences
- **Shimmer** - Loading skeleton screens
- **Intl** - Date formatting and localization

## Project Structure

```
lib/
├── core/
│   ├── constants/        # App colors, strings, and constants
│   ├── providers/        # Global Riverpod providers
│   ├── router/          # GoRouter configuration
│   └── utils/           # Utility classes and helpers
├── features/
│   ├── auth/            # Authentication (login/register)
│   ├── fridges/         # Fridge data models and repositories
│   ├── fridge_selection/ # Fridge selection and creation
│   ├── home/            # Main home screen with product list
│   ├── products/        # Product management (add/edit)
│   ├── settings/        # Settings and user preferences
│   └── users/           # User data management
└── widgets/             # Reusable UI components
```


## Firestore Data Structure

### Users Collection
```
users/{userId}
  - email: string
  - createdAt: timestamp
```

### Fridges Collection
```
fridges/{fridgeId}
  - name: string
  - ownerId: string
  - memberIds: array<string>
  - createdAt: timestamp
```

### Products Collection
```
products/{productId}
  - name: string
  - type: string (enum)
  - quantity: number
  - expiryDate: timestamp
  - timeStored: timestamp
  - fridgeId: string
```

## Usage

1. **First Time Setup**
   - Register a new account or login with existing credentials
   - Create your first fridge
   - Start adding products

2. **Adding Products**
   - Tap the floating action button (+) on the home screen
   - Fill in product details (name, type, quantity, expiry date)
   - Save to add the item to your fridge

3. **Managing Products**
   - Tap any product to view details and edit
   - Use the action button (⋮) to delete or duplicate
   - Search or filter to find specific items quickly

4. **Sharing Fridges**
   - Go to Settings → Invite Member
   - Enter the email of the person you want to invite
   - They'll see the shared fridge once they log in

5. **Multiple Fridges**
   - Go to Settings → Switch Fridge
   - Create a new fridge or select an existing one
   - Each fridge has its own set of products and members

## Future Improvements & Ideas

### Barcode Scanning
- **Quick Add via Barcode** - Scan product barcodes to automatically pull product information
- **Product Database Integration** - Connect to product databases (Open Food Facts, UPC Database, etc.)
- **Auto-fill Product Details** - Automatically populate name, type, and typical expiry information
- **Camera Integration** - Use device camera for barcode scanning

### Food Delivery Integration
- **Automatic Reordering** - Automatically order expired or soon-to-expire items from integrated delivery services
- **Delivery Service Connections** - Integration with popular food delivery platforms
- **Smart Shopping Lists** - Generate shopping lists based on expiring items
- **One-Click Reorder** - Quick reorder functionality for frequently used items
- **Scheduled Deliveries** - Set up recurring orders for items that expire regularly

### Notifications
- **Expiry Alerts** - Push notifications for products expiring soon
- **Customizable Reminder Times** - Set notification preferences (1 day, 3 days, 1 week before expiry)
- **Member Notifications** - Alert all fridge members about critically expiring items
- **Notification Settings** - Granular control over notification types and frequency

### Restocking Tracker
- **Claim to Restock** - Mark expiring/expired products that you'll restock to prevent duplicate purchases
- **Restock Status Visibility** - Show which member claimed to restock an item
- **Claim Notifications** - Notify other members when someone claims an item for restocking
- **Unclaim Option** - Remove claim if plans change
- **Collaborative Shopping** - Prevent duplicate purchases in shared fridges


