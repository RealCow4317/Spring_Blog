<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" data-bs-theme="light"> <!-- Removed height: 100% -->
<head>
    <title>캘린더</title>
    <%@ include file="/WEB-INF/views/common/userHead.jsp" %>
    <!-- FullCalendar CSS -->
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css' rel='stylesheet' />
    <style>
        body {
            font-family: 'Pretendard', sans-serif;
            padding-top: 60px; /* Keep this for navbar spacing */
            /* Removed all flex properties from body */
        }
        #calendar-container { /* New, simple container */
            max-width: 1100px; /* Reference example doesn't fill extreme width */
            margin: 0 auto; /* Center it */
            padding: 1rem; /* Some padding around the calendar */
        }
        
        /* Minimal Custom styles for calendar events/days - ONLY related to content/background */
        .fc-daygrid-day {
            position: relative;
            min-height: 100px; /* Ensure a minimum height for cells */
            overflow: hidden; /* Ensure image stays within cell */
        }
        .fc-daygrid-day.diary-with-image {
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        .fc-daygrid-day.diary-with-image .fc-daygrid-day-frame {
            position: relative;
            z-index: 1;
        }
        .fc-daygrid-day-frame .fc-daygrid-day-top {
            position: relative;
            z-index: 3; /* Keep date text above image */
            background-color: rgba(255, 255, 255, 0.7); /* Make it more visible */
            padding: 3px 5px;
            border-radius: 3px;
            display: inline-block;
            margin: 2px;
        }
        .fc-daygrid-event {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            width: 100%;
            padding: 4px;
            background-color: rgba(0, 0, 0, 0.5);
            color: white;
            font-size: 0.85em;
            z-index: 2;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            box-sizing: border-box;
        }
        /* Hide event text when image exists */
        .fc-daygrid-day.diary-with-image .fc-daygrid-event {
            display: none !important;
        }
        .fc-daygrid-event-dot {
            display: none; /* Hide default event dot */
        }
        .fc-daygrid-day.fc-day-today {
            border: 2px solid #007bff; /* Highlight today's date */
            box-sizing: border-box;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

<div id="calendar-container"> <!-- Simpler container -->
    <div id='calendar'></div>
</div>

<!-- Diary Entry Modal -->
<div class="modal fade" id="diaryModal" tabindex="-1" aria-labelledby="diaryModalLabel">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="diaryForm" action="${pageContext.request.contextPath}/calendar/diary" method="post" enctype="multipart/form-data">
                <div class="modal-header">
                    <h5 class="modal-title" id="diaryModalLabel">오늘의 일기 작성</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="diaryDate" id="modalDiaryDate">
                    <div class="mb-3" id="existingImagePreviewContainer" style="display: none;">
                        <label class="form-label">기존 이미지:</label>
                        <img id="existingImagePreview" src="" alt="Existing Image" class="img-fluid mb-2">
                        <small class="form-text text-muted">새로운 이미지를 업로드하면 기존 이미지가 교체됩니다.</small>
                    </div>
                    <div class="mb-3">
                        <label for="diaryContent" class="form-label">한 줄 일기:</label>
                        <input type="text" class="form-control" id="diaryContent" name="content" required>
                    </div>
                    <div class="mb-3">
                        <label for="diaryImage" class="form-label">사진 업로드:</label>
                        <input type="file" class="form-control" id="diaryImage" name="imageFile" accept="image/*"> <!-- Removed 'required' here -->
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="submit" class="btn btn-primary">저장</button>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- FullCalendar JS -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales/ko.js'></script> <!-- Korean locale -->

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // JSP EL을 JavaScript 변수로 저장
        var contextPath = '${pageContext.request.contextPath}';
        
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth', // Display a month view
            locale: 'ko', // Set locale to Korean
            height: 'auto', // Let FullCalendar determine height naturally
            dayMaxEvents: true, // Allow "more" link when too many events
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth' // Removed week and day view buttons
            },
            dateClick: function(info) {
                const clickedDate = new Date(info.dateStr);
                clickedDate.setHours(0, 0, 0, 0);

                const today = new Date();
                today.setHours(0, 0, 0, 0);

                if (clickedDate.getTime() <= today.getTime()) {
                    // Clear previous content before fetching
                    document.getElementById('diaryForm').reset();
                    document.getElementById('existingImagePreviewContainer').style.display = 'none'; // Hide image preview by default
                    document.getElementById('existingImagePreview').src = ''; // Clear image src

                    // Fetch existing entry
                    fetch('${pageContext.request.contextPath}/calendar/diary-entry?date=' + info.dateStr)
                        .then(response => {
                            if (!response.ok) {
                                // If response is not OK (e.g., 404), it means no entry exists.
                                // We proceed to show an empty modal.
                                if (response.status === 404) return null;
                                throw new Error('Network response was not ok.');
                            }
                            return response.json();
                        })
                        .then(data => {
                            var modal = new bootstrap.Modal(document.getElementById('diaryModal'));
                            document.getElementById('modalDiaryDate').value = info.dateStr;
                            document.getElementById('diaryModalLabel').innerText = info.dateStr + ' 일기 작성';

                            if (data) { // If data exists, pre-fill
                                document.getElementById('diaryContent').value = data.content;
                                if (data.imagePath) {
                                    document.getElementById('existingImagePreview').src = '${pageContext.request.contextPath}' + data.imagePath;
                                    document.getElementById('existingImagePreviewContainer').style.display = 'block';
                                }
                            }
                            modal.show();
                        })
                        .catch(error => {
                            console.error('Error fetching diary entry:', error);
                            // Even if fetching fails, still open the modal, but alert the user
                            alert('일기 정보를 불러오는데 실패했습니다. 새로운 일기를 작성해주세요.');
                            var modal = new bootstrap.Modal(document.getElementById('diaryModal'));
                            document.getElementById('modalDiaryDate').value = info.dateStr;
                            document.getElementById('diaryModalLabel').innerText = info.dateStr + ' 일기 작성';
                            modal.show();
                        });
                } else {
                    alert('미래 날짜에는 일기를 작성할 수 없습니다.');
                }
            },
            events: {
                url: '${pageContext.request.contextPath}/calendar/events',
                method: 'GET',
                failure: function() {
                    alert('일기 데이터를 불러오지 못했습니다!');
                },
                extraParams: function() {
                    return {
                        memberNo: ${loginUser.memberNo}
                    };
                }
            },
            eventContent: function(arg) {
                 // For events without an image, display just the title
                if (!arg.event.extendedProps.imagePath) {
                    var contentEl = document.createElement('div');
                    contentEl.innerHTML = arg.event.title;
                    return { domNodes: [contentEl] };
                }
                 // For events with an image, return empty content (text will be hidden)
                return { html: '' };
            },
            eventDidMount: function(info) {
                console.log('eventDidMount triggered for event:', info.event.title);
                console.log('Event extendedProps:', info.event.extendedProps);

                 // Set image as background for the day cell
                if (info.event.extendedProps && info.event.extendedProps.imagePath) {
                    const dayEl = info.el.closest('.fc-daygrid-day');
                    console.log('Day element found:', dayEl);
                    const imagePath = contextPath + info.event.extendedProps.imagePath;
                    console.log('Image path:', imagePath);

                    if (dayEl) {
                        dayEl.style.backgroundImage = 'url(' + imagePath + ')';
                        dayEl.style.backgroundSize = 'cover';
                        dayEl.style.backgroundPosition = 'center';
                        dayEl.style.backgroundRepeat = 'no-repeat';
                        dayEl.classList.add('diary-with-image');
                        console.log('Background image applied to day element.');
                    } else {
                        console.warn('Could not find .fc-daygrid-day element for event:', info.event.title);
                    }
                    // Hide the entire event element (text) when image exists
                    if (info.el) {
                        info.el.style.display = 'none';
                    }
                } else {
                    console.log('No imagePath found for event:', info.event.title);
                }
                // Check if it's the current date for highlighting
                const today = new Date();
                today.setHours(0, 0, 0, 0);
                const eventDate = info.event.start;
                eventDate.setHours(0, 0, 0, 0);

                if (eventDate.getTime() === today.getTime()) {
                    info.el.closest('.fc-daygrid-day').classList.add('fc-day-today');
                }
            }
        });
        calendar.render();

        var diaryModalEl = document.getElementById('diaryModal');
        diaryModalEl.addEventListener('hidden.bs.modal', function (event) {
            calendar.refetchEvents();
            document.getElementById('diaryForm').reset();
        });
    });
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
