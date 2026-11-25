#!/bin/bash
# 코오롱디지털타워발란트1,2차 점심매뉴 자동 수집기
# 이 파일은 코오롱 디지털타워발란트 1차 2차 구내식당 정보를 자동 수집 제공 스크립트 입니다

# 1차
# 한끼: 매일 10시 갱신
# https://구로.kr/b/%EC%BD%94%EC%98%A4%EB%A1%B1%EB%B9%8C%EB%9E%80%ED%8A%B81%EC%B0%A8?tab=cafeteria&caf=1
# 이서명가: 9시 30분 갱신
# https://구로.kr/b/%EC%BD%94%EC%98%A4%EB%A1%B1%EB%B9%8C%EB%9E%80%ED%8A%B81%EC%B0%A8?tab=cafeteria&caf=170

# 2차
# 푸드포커스: 매일 11시30분 갱신
# https://구로.kr/b/%EB%B9%8C%EB%9E%80%ED%8A%B82%EC%B0%A8?tab=cafeteria

# 구로.kr 에서 메뉴를 공개하기는 하나 이미지형식이며,
# 텍스트형식제공 식당은 한끼 한곳이다

cat << 'EOF'
======================================================================
코오롱디지털타워발란트1,2차 점심매뉴 자동 수집기

코오롱빌란트 구내식당 정보
======================================================================
EOF

# 구로.kr 퓨니코드(xn--9n3b19n.kr) 적용 URL 변수 설정
# URL_HANKKI="https://xn--9n3b19n.kr"
# URL_ISEO="https://xn--9n3b19n.kr70"
# URL_FOODFOCUS="https://xn--9n3b19n.kr"
URL_HANKKI="https://구로.kr/b/%EC%BD%94%EC%98%A4%EB%A1%B1%EB%B9%8C%EB%9E%80%ED%8A%B81%EC%B0%A8?tab=cafeteria&caf=1"
URL_ISEO="# https://구로.kr/b/%EC%BD%94%EC%98%A4%EB%A1%B1%EB%B9%8C%EB%9E%80%ED%8A%B81%EC%B0%A8?tab=cafeteria&caf=170"
URL_FOODFOCUS="https://구로.kr/b/%EB%B9%8C%EB%9E%80%ED%8A%B82%EC%B0%A8?tab=cafeteria"

# 오늘 날짜 출력
TODAY=$(date "+%Y-%m-%d (%a)")
echo ""
echo "[$TODAY 코오롱빌란트 1·2차 점심 안내]"
echo "----------------------------------------------------------------------"

# 1. 한끼 (텍스트 메뉴 파싱)
# caf-menu-text 클래스 다음 줄의 div 태그 내 텍스트 추출
# -s -L 로 변수 제거 하고 A로 매누만 뽑아감 sS
HANKKI_MENU=$(curl -s -L -A "Mozilla/5.0" "$URL_HANKKI" | \
  grep -A 1 "caf-menu-text" | \
  tail -n 1 | \
  sed -e 's/<[^>]*>//g' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

echo "[1차] 한끼 (7,500원 / 10:00 갱신)"
if [ -n "$HANKKI_MENU" ]; then
  echo "  - 오늘의 메뉴: $HANKKI_MENU"
else
  echo "  - 메뉴 텍스트를 불러오지 못했습니다. (갱신 전이거나 페이지 구조 확인 필요)"
fi
echo "  - 상세보기: $URL_HANKKI"
echo ""

# 2. 이서명가 (이미지 제공 식당 안내)
echo "[1차] 이서명가 (7,500원 / 09:30 갱신)"
echo "  - 안내: 이미지 형식으로 제공됩니다. 아래 링크에서 식단표를 확인하세요."
echo "  - 식단표 보기: $URL_ISEO"
echo ""

# 3. 푸드포커스 (이미지 제공 식당 안내)
echo "[2차] 푸드포커스 (7,500원 / 11:30 갱신)"
echo "  - 안내: 이미지 형식으로 제공됩니다. 아래 링크에서 식단표를 확인하세요."
echo "  - 식단표 보기: $URL_FOODFOCUS"
echo "----------------------------------------------------------------------"
