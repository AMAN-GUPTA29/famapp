# Flutter Assignment: Contextual Cards Container

This repository contains the implementation of a **Contextual Cards Container** as described in the assignment requirements. The container is a dynamic, reusable component designed to render contextual cards based on an API response, adhering to the provided design specifications.

---

## Features

1. **Dynamic Cards Rendering**: Cards are generated dynamically based on the API response. Each card's properties (text, colors, buttons, images, etc.) are backend-controlled.
2. **Reusable Component**: The container is a plug-and-play component that can be integrated into any Flutter application screen. which is page/contextualcard.dart
3. **Deeplink Handling**: Supports actions triggered by deeplinks for cards, CTAs, and formatted text entities.
4. **Interactive Cards**:
   - Long-press functionality for Big Display Cards (HC3):
     - **Remind Later**: Removes the card temporarily and displays it on the next app launch.
     - **Dismiss Now**: Removes the card permanently.
5. **Pull-to-Refresh**: Implements a swipe-down-to-refresh feature.
6. **Error and Loading States**: Gracefully handles loading and error scenarios. Made seperate animation page for data loading and error handling on network failure.
7. **Design Adherence**: Matches design specifications as closely as possible, ensuring responsiveness and usability.
8. **Formatted Text Parsing**:
   - Handles text substitution  and applies styles (e.g., color, underline, italic).
9. **Gradient and Image Support**:
   - Supports background gradients, colors, and external/asset-based images.
10. **State Management**:
   
11. **Smooth User Experience**:
   - Swipe-to-refresh for updated API responses.
   - Error and loading states to ensure usability.

---

## API and Design References

- **API**: [Card API](https://polyjuice.kong.fampay.co/mock/famapp/feed/home_section/?slugs=famx-paypage)
- **Design Specifications**: [Figma Design](https://www.figma.com/file/AvK2BRGwMTv4kQab5ymJ0K/AAL3-Android-assignment-Design-Specs)

---

## Implementation Details

### Card Types and Features

The container supports the following card types:

- **HC1**: Small Display Card
- **HC3**: Big Display Card (with long-press actions)
- **HC5**: Image Card
- **HC6**: Small Card with Arrow
- **HC9**: Dynamic Width Card (width determined by `bg_image`)



---

## Prerequisites

- Flutter SDK (v3.x or later)
- Dart SDK (v2.19 or later)

---

## Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/flutter-contextual-cards.git
   cd flutter-contextual-cards.

2. **flutter pub get**

3. **flutter run**

4. **flutter build apk --release**


## File Structure

lib/<br>
├── main.dart           # Entry point <br>
├── contextualcardcomponent/   # Contains different components of contextualcard <br>
├── controller/         # Contains the API call controller<br>
└── screens/            # Contains all the pages required for the app.<br>


**As in the hc3 component we have 2 button remind later and dismiss now but we can't implement dismiss now as we can not change the backend data and everytime the app refresh that card will be loaded back so currently its functionality is same as remind later which will make the hc3 componet to load when the app is restarted or when refreshed also by swipe down (it was mention to only render the componet again on restart but i am rendering on refresh too cause there wont be use of refreshing other case).**

