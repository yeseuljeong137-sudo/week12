import 'package:flutter/material.dart';

void main() {
  runApp(const FirstWindowApp());
}

class FirstWindowApp extends StatelessWidget {
  const FirstWindowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '온디바이스 스마트 약 복용 알리미',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB), // 신뢰감 있는 헬스케어 블루
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        fontFamily: 'Pretendard',
      ),
      home: const FirstWindowPage(),
    );
  }
}

class FirstWindowPage extends StatelessWidget {
  const FirstWindowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.medication_rounded,
                color: Color(0xFF2563EB),
                size: 24,
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '스마트 약 알리미',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                Text(
                  '100% 온디바이스 안심 보관',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF10B981),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF475569)),
            tooltip: '알림 목록',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline_rounded, color: Color(0xFF475569)),
            tooltip: '내 정보',
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 날짜 및 인사말 헤더 (50~60대 사용자 친화형 큰 글씨)
            _buildGreetingHeader(),
            const SizedBox(height: 16),

            // 2. [핵심 CTA] 처방전/약봉투 촬영하기 버튼 배너 (P0 핵심 기능)
            _buildScanHeroBanner(context),
            const SizedBox(height: 20),

            // 3. 오늘 복약 현황 게이지 요약 카드
            _buildTodaySummaryCard(),
            const SizedBox(height: 24),

            // 4. 오늘 복용 체크리스트 (아침 / 점심 / 저녁)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '오늘의 복약 일정',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_month_outlined, size: 18),
                  label: const Text('전체 일정'),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 아침 약 카드 (복용 완료 예시)
            _buildPillCard(
              timeLabel: '아침 복용',
              timeText: '오전 08:30 (식후 30분)',
              pillTitle: '혈압약 (암로디핀 5mg) 외 1종',
              status: PillStatus.completed,
              badges: [
                _buildBadge('공복 주의', const Color(0xFFFEF3C7), const Color(0xFF92400E)),
                _buildBadge('물 충분히', const Color(0xFFE0F2FE), const Color(0xFF0369A1)),
              ],
            ),
            const SizedBox(height: 12),

            // 점심 약 카드 (복용 예정 / 현재 시간대 예시)
            _buildPillCard(
              timeLabel: '점심 복용',
              timeText: '오후 12:30 (식전 30분)',
              pillTitle: '위장약 (라니티딘정) 외 1종',
              status: PillStatus.pendingNow,
              badges: [
                _buildBadge('식전 30분 복용', const Color(0xFFEDE9FE), const Color(0xFF6D28D9)),
              ],
            ),
            const SizedBox(height: 12),

            // 저녁 약 카드 (주의사항 경고 배지 포함 예시)
            _buildPillCard(
              timeLabel: '저녁 복용',
              timeText: '오후 07:00 (식후 30분)',
              pillTitle: '고지혈증약 (아토르바스타틴) 외 1종',
              status: PillStatus.upcoming,
              badges: [
                _buildBadge('🚗 운전·졸음 주의', const Color(0xFFFEE2E2), const Color(0xFFB91C1C)),
                _buildBadge('🍺 음주 절대 금지', const Color(0xFFFEE2E2), const Color(0xFFB91C1C)),
              ],
            ),
            const SizedBox(height: 24),

            // 5. 온디바이스 복약 안전 가이드 안내 배너
            _buildSafetyGuideCard(),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        backgroundColor: Colors.white,
        elevation: 3,
        indicatorColor: const Color(0xFFDBEAFE),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: Color(0xFF2563EB)),
            label: '홈',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today, color: Color(0xFF2563EB)),
            label: '복용 일정',
          ),
          NavigationDestination(
            icon: Icon(Icons.medical_services_outlined),
            selectedIcon: Icon(Icons.medical_services, color: Color(0xFF2563EB)),
            label: '내 약 보관함',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings, color: Color(0xFF2563EB)),
            label: '설정',
          ),
        ],
      ),
    );
  }

  // 1. 인사말 및 날짜 헤더
  Widget _buildGreetingHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '2026년 11월 23일 (월요일)',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '김영수 님,\n오늘도 건강한 하루 되세요! 🌿',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  // 2. [핵심 액션] 처방전 / 약봉투 촬영하기 배너 (고령층 맞춤 큰 버튼)
  Widget _buildScanHeroBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1D4ED8), Color(0xFF2563EB), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // 화면 레이아웃 확인용 (기능 미구현)
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.document_scanner_rounded,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '사진 촬영 한 번으로 끝!',
                            style: TextStyle(
                              color: Color(0xFFBFDBFE),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '처방전 / 약봉투 찍기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '복용 일정과 알림이 자동으로 맞춰집니다',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // 하단 보조 안내 칩
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.lock_outline_rounded, color: Colors.white70, size: 14),
                          SizedBox(width: 4),
                          Text(
                            '인터넷 없이 기기 내 안전 처리 (OCR)',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.camera_alt_rounded, size: 16, color: Color(0xFF1D4ED8)),
                          SizedBox(width: 4),
                          Text(
                            '촬영 시작',
                            style: TextStyle(
                              color: Color(0xFF1D4ED8),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 3. 오늘 복약 현황 요약 카드
  Widget _buildTodaySummaryCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.check_circle_outline_rounded, color: Color(0xFF2563EB), size: 22),
                  SizedBox(width: 8),
                  Text(
                    '오늘 복약 달성도',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: '1',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                    TextSpan(
                      text: ' / 3회 복용',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const LinearProgressIndicator(
              value: 0.33,
              minHeight: 10,
              backgroundColor: Color(0xFFE2E8F0),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
            ),
          ),
        ],
      ),
    );
  }

  // 4. 복용 카드 (아침, 점심, 저녁)
  Widget _buildPillCard({
    required String timeLabel,
    required String timeText,
    required String pillTitle,
    required PillStatus status,
    required List<Widget> badges,
  }) {
    final isDone = status == PillStatus.completed;
    final isNow = status == PillStatus.pendingNow;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isNow
              ? const Color(0xFF2563EB)
              : (isDone ? const Color(0xFFE2E8F0) : const Color(0xFFCBD5E1)),
          width: isNow ? 2.0 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isNow
                ? const Color(0xFF2563EB).withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 시간 표시 태그
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDone
                          ? const Color(0xFFF1F5F9)
                          : (isNow ? const Color(0xFFEFF6FF) : const Color(0xFFF8FAFC)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      timeLabel,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isDone
                            ? const Color(0xFF64748B)
                            : (isNow ? const Color(0xFF2563EB) : const Color(0xFF475569)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    timeText,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDone ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              // 상태 뱃지
              if (isDone)
                const Row(
                  children: [
                    Icon(Icons.check_circle, color: Color(0xFF10B981), size: 18),
                    SizedBox(width: 4),
                    Text(
                      '복용 완료',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 12),

          // 약 이름 (고령층 맞춤 큰 폰트)
          Text(
            pillTitle,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: isDone ? const Color(0xFF94A3B8) : const Color(0xFF1E293B),
              decoration: isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          const SizedBox(height: 10),

          // 주의사항 및 부작용 뱃지 목록
          if (badges.isNotEmpty) ...[
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: badges,
            ),
            const SizedBox(height: 14),
          ],

          // 원터치 복용 체크 버튼 (큰 터치 영역)
          SizedBox(
            width: double.infinity,
            height: 48,
            child: isDone
                ? OutlinedButton.icon(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.refresh, size: 18, color: Color(0xFF64748B)),
                    label: const Text(
                      '복용 취소하기',
                      style: TextStyle(color: Color(0xFF64748B), fontSize: 15),
                    ),
                  )
                : FilledButton.icon(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor:
                          isNow ? const Color(0xFF2563EB) : const Color(0xFF475569),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.check, size: 20),
                    label: Text(
                      isNow ? '지금 복용 완료' : '복용 완료하기',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // 뱃지 컴포넌트
  Widget _buildBadge(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textCol,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // 5. 온디바이스 복약 안전 가이드 안내 배너
  Widget _buildSafetyGuideCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.shield_outlined, color: Color(0xFF2563EB), size: 26),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '병용 금기 및 안전 검사 안내',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '새로운 약을 스캔하면 현재 복용 중인 약과의 상호작용 및 충돌 위험을 로컬 DB에서 즉시 분석해 드립니다.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF3B82F6),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum PillStatus {
  completed,
  pendingNow,
  upcoming,
}
