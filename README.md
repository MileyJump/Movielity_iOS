# 🍿무빌리티(Movielity) - 영화 검색 앱
![넷플릭스-리드미-사진-004](https://github.com/user-attachments/assets/594da009-7c38-4b76-8127-6232b1179daf)

**무빌리티 앱은 TMDB API를 사용해 사용자가 원하는 영화를 검색하고 보관함에 저장하는 영화 리스트 관리 앱입니다.**<br>
**사용자는 즐겨찾는 영화를 손쉽게 검색하고, 즐겨찾기 목록에 추가해 보관할 수 있습니다.**


## 주요 기능
- **TMDB API**를 통한 **영화 정보** 검색
- **검색 기능**: 원하는 영화의 제목이나 정보를 검색
- **즐겨찾기 기능**: 사용자가 좋아하는 영화를 즐겨찾기에 추가 및 관리

## 개발 환경
- **개발 기간**: 2024년 10월 8일 ~ 2024년 10월 14일
- **개발 인원**: 3명
- **개발 도구**:
    - **IDE**: Xcode
    - **버전 관리**: Git
 
## 기술 스택
- **UI**: `SnapKit` – 제약 조건 기반 인터페이스 구성
- **네트워크**: `Alamofire` – TMDB API와 네트워크 통신
- **데이터베이스**: `RealmSwift` – 즐겨찾기 데이터 저장
- **Reactive Programming**: `RxSwift`, `RxCocoa` – 반응형 데이터 처리 및 이벤트 바인딩

## 디렉토링 구조
```
Movielity
├── Application
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Base.lproj
│   └── LaunchScreen.storyboard
├── Global
│   ├── Components
│   ├── Extensions
│   ├── Protocols
│   ├── Realm
│   └── Resources
├── Info.plist
├── Network
│   ├── Base
│   ├── Credits
│   ├── Genre
│   ├── NetworkManager.swift
│   ├── Search
│   ├── Similar
│   └── Trending
└── Presentation
    ├── Base
    ├── Detail
    ├── Download
    ├── Home
    ├── Search
    ├── SearchResults
    └── TabBar
```

## 고민한 부분
- [3개의 API Response값을 갖고 있는 ViewModel](https://github.com/Movielity/Movielity_iOS/wiki/%EA%B3%A0%EB%AF%BC%ED%96%88%EB%8D%98-%EB%B6%80%EB%B6%84_3%EA%B0%9C%EC%9D%98-API-Response%EA%B0%92%EC%9D%84-%EA%B0%96%EA%B3%A0-%EC%9E%88%EB%8A%94-DetailViewModel)


## Github Convention
- **Commit**: `[FEAT/#33] 액션 버튼 구현`
- **Branch** : `feat/#33-main-view-ui`
- **Issue** : `[FEAT] 메인 뷰 UI 구현`
- **PR** : `[PR/#33] 메인 뷰 UI 구현`
- **Merge** : `[MERGE/#33(이슈 번호)] -> develop`

### Commit Message Convention
- [feat] 기능 추가
- [UI] : 화면 추가
- [Fix] : 버그 수정
- [Docs] : Read.me 수정
- [Refactor] : 코드 리팩토링
- [Test] : 테스트 코드 추가
- [Chore] : 빌드 미니멈 수정, 팟파일 수정 등 잡스러운..
