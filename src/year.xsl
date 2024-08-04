<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8" indent="yes"></xsl:output>
	<xsl:template match="/">

		<html lang="de">

			<head>
				<meta name="viewport" content="initial-scale=1, width=device-width"></meta>

				<link rel="stylesheet" type="text/css" href="src/calendar.css"></link>
				<link rel="stylesheet" type="text/css" href="src/content_year.css"></link>
				<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@500&amp;display=swap"></link>

				<script>
					document.addEventListener('DOMContentLoaded', function() {
						var script = document.createElement('script');
						script.src = 'src/init.js';
						document.head.appendChild(script);
					});
				</script>

				<title>Vereinskalender</title>
			</head>

			<body class="layout-body">
				<div class="header">
					<xsl:variable name="userLoggedIn" select="document('../xml/calendar.xml')/calendar/userLoggedIn"></xsl:variable>
					<xsl:choose>
						<xsl:when test="$userLoggedIn = 'false'">
							<div class="login-logout">
								<div class="login">
									<div class="login-btn">
										<button onclick="showPopup('login_popup')">Login
										</button>
									</div>
									<div class="login_popup" id="login_popup">
										<div class="background" onclick="hidePopup('login_popup')">
											<div class="popup" onclick="event.stopPropagation()">
												<div class="close_btn" onclick="hidePopup('login_popup')"></div>
												<div class="content">
													<h1>Login</h1>
													<form method="post" id="login-form">
														<xsl:attribute name="action">
															<xsl:value-of select="calendar/current_path"></xsl:value-of>
														</xsl:attribute>
														<div class="login_form">
															<xsl:variable name="failedLogin" select="document('../xml/calendar.xml')/calendar/failedLogin"></xsl:variable>
															<xsl:if test="$failedLogin = 'true'">
																<div class="login-failed" id="login-failed">Passwort und/oder Username falsch.</div>
															</xsl:if>
															<div class="username">Username:</div>
															<div class="username-input">
																<input type="text" name="username" id="username-input" required="required"></input>
															</div>
															<div class="password">Password:</div>
															<div class="password-input">
																<input type="password" name="password" id="password-input" required="required"></input>
															</div>
															<div class="submit-btn">
																<input type="submit" value="" name="login"></input>
															</div>
														</div>
													</form>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</xsl:when>
						<xsl:otherwise>
							<div class="login-logout">
								<div class="logout">
									<div class="logout-btn">
										<button onclick="showPopup('logout_popup')">Logout
										</button>
									</div>
									<div class="logout_popup" id="logout_popup">
										<div class="background" onclick="hidePopup('logout_popup')">
											<div class="popup" onclick="event.stopPropagation()">
												<div class="close_btn" onclick="hidePopup('logout_popup')"></div>
												<div class="content">
													<h1>Logout</h1>
													<div class="logout_form">
														<div class="question">Möchten sie sich ausloggen?</div>
														<form method="post">
															<xsl:attribute name="action">
																<xsl:value-of select="calendar/current_path"></xsl:value-of>
															</xsl:attribute>
															<div class="yes-btn yes">
																<input type="submit" name="logout" value="Ja"></input>
															</div>
														</form>
														<button onclick="hidePopup('logout_popup')" class="no">Nein</button>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="$userLoggedIn = 'true'">
						<div class="new-event" id="new-event">
							<div class="new-event-btn">
								<button onclick="showPopup('new-event-popup')">Event erstellen
								</button>
							</div>
							<div class="new-event-popup" id="new-event-popup">
								<div class="background" onclick="hidePopup('new-event-popup')">
									<div class="popup" onclick="event.stopPropagation()">
										<div class="close_btn" onclick="hidePopup('new-event-popup')"></div>
										<div class="content">
											<h1>Event erstellen</h1>
											<div class="new-event-form popup-body">
												<div class="new-event-btns-area">
													<div class="new-event-btns">
														<button class="left" id="match-btn" onclick="showNewEventFormMatch()">Fußballspiel</button>
														<button class="right" id="club-events-btn" onclick="showNewEventFormClubEvents()">Veranstaltung</button>
													</div>
												</div>
												<div class="new-event-form-content">
													<form method="post" class="new-event-form-match" id="match-content">
														<xsl:attribute name="action">
															<xsl:value-of select="calendar/current_path"></xsl:value-of>
														</xsl:attribute>
														<xsl:variable name="newEventType" select="calendar/newEventType"></xsl:variable>
														<div class="name">Name*:</div>
														<div class="name-input">
															<input type="text" name="name" id="new-match-name-input">
																<xsl:if test="$newEventType = 'match'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/name"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
														</div>
														<xsl:if test="$newEventType = 'match'">
															<xsl:variable name="dateWrong" select="calendar/dateWrong"></xsl:variable>
															<xsl:if test="$dateWrong = '1'">
																<div class="date-warning" id="date-warning-match">
																Das Datumsformat wurde nicht eingehalten. (TT.MM.JJJJ)
																</div>
															</xsl:if>
														</xsl:if>
														<div class="date">Datum*:</div>
														<div class="date-input">
															<input type="text" name="date-day" id="new-match-date-input-0" class="placeholder=TT">
																<xsl:if test="$newEventType = 'match'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/date_day"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
																.
															<input type="text" name="date-month" id="new-match-date-input-1" class="placeholder=MM">
																<xsl:if test="$newEventType = 'match'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/date_month"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
																.
															<input type="text" name="date-year" id="new-match-date-input-2" class="placeholder=JJJJ">
																<xsl:if test="$newEventType = 'match'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/date_year"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
														</div>
														<xsl:if test="$newEventType = 'match'">
															<xsl:variable name="timeWrong" select="calendar/timeWrong"></xsl:variable>
															<xsl:if test="$timeWrong = '1'">
																<div class="time-warning" id="time-warning-match">
																Das Zeitformat wurde nicht eingehalten.
																</div>
															</xsl:if>
														</xsl:if>
														<div class="time-period">Zeitraum*:</div>
														<div class="time-period-input">
															<input type="text" name="time-period-beginn" id="new-match-time-period-beginn" class="placeholder=MM:HH">
																<xsl:if test="$newEventType = 'match'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/time_period_beginn"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
																Uhr bis
															<input type="text" name="time-period-ende" class="placeholder=MM:HH">
																<xsl:if test="$newEventType = 'match'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/time_period_ende"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
																Uhr
														</div>
														<div class="place">Ort*:</div>
														<div class="place-input">
															<input type="text" name="place" id="new-match-place-input">
																<xsl:if test="$newEventType = 'match'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/place"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
														</div>
														<div class="type">Art*:</div>
														<div class="type-input">
															<input type="text" name="type" id="new-match-type-input">
																<xsl:if test="$newEventType = 'match'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/type"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
														</div>
														<div class="clubs">Vereine*:</div>
														<div class="clubs-input">
															<input type="text" name="clubs0" id="new-match-clubs0-input">
																<xsl:if test="$newEventType = 'match'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/clubs0"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
																v.s.
															<input type="text" name="clubs1" id="new-match-clubs1-input">
																<xsl:if test="$newEventType = 'match'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/clubs1"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
														</div>
														<div class="points">Ergebnis:</div>
														<div class="points-input">
															<input type="number" name="points0" min="0" max="99">
																<xsl:if test="$newEventType = 'match'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/points0"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
																:
															<input type="number" name="points1" min="0" max="99">
																<xsl:if test="$newEventType = 'match'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/points1"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
														</div>
														<div class="info-text">Info:</div>
														<div class="info-text-input">

															<textarea name="info-text" rows="4" cols="1" class="textarea">
																<xsl:if test="$newEventType = 'match'">
																	<xsl:value-of select="calendar/info_text"></xsl:value-of>
																</xsl:if>
															</textarea>
														</div>
														<div class="notice">Hinweis:</div>
														<div class="notice-input">
															<textarea name="notice" rows="2" cols="1" class="textarea">
																<xsl:if test="$newEventType = 'match'">
																	<xsl:value-of select="calendar/notice"></xsl:value-of>
																</xsl:if>
															</textarea>
														</div>
														<div class="incomplete-warning" id="new-match-incomplete-warning">
															<p>Bitte fülle alle benötigten Felder aus.</p>
														</div>
														<div class="submit-btn">
															<input type="submit" value="" name="new-match"></input>
														</div>
													</form>
													<form method="post" class="new-event-form-club-events" id="club-events-content">
														<xsl:attribute name="action">
															<xsl:value-of select="calendar/current_path"></xsl:value-of>
														</xsl:attribute>
														<xsl:variable name="newEventType" select="calendar/newEventType"></xsl:variable>
														<div class="name">Name*:</div>
														<div class="name-input">
															<input type="text" name="name" id="new-club-event-name-input">
																<xsl:if test="$newEventType = 'club-event'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/name"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
														</div>
														<xsl:if test="$newEventType = 'club-event'">
															<xsl:variable name="dateWrong" select="calendar/dateWrong"></xsl:variable>
															<xsl:if test="$dateWrong = '1'">
																<div class="date-warning" id="date-warning-club-event">
																Das Datumsformat wurde nicht eingehalten. (TT.MM.JJJJ)
																</div>
															</xsl:if>
														</xsl:if>
														<div class="date">Datum*:</div>
														<div class="date-input">
															<input type="text" name="date-day" id="new-club-event-date-input-0" class="placeholder=TT">
																<xsl:if test="$newEventType = 'club-event'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/date_day"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
																.
															<input type="text" name="date-month" id="new-club-event-date-input-1" class="placeholder=MM">
																<xsl:if test="$newEventType = 'club-event'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/date_month"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
																.
															<input type="text" name="date-year" id="new-club-event-date-input-2" class="placeholder=JJJJ">
																<xsl:if test="$newEventType = 'club-event'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/date_year"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
														</div>
														<xsl:if test="$newEventType = 'club-event'">
															<xsl:variable name="timeWrong" select="calendar/timeWrong"></xsl:variable>
															<xsl:if test="$timeWrong = '1'">
																<div class="time-warning" id="time-warning-club-event">
																Das Zeitformat wurde nicht eingehalten.
																</div>
															</xsl:if>
														</xsl:if>
														<div class="time-period">Zeitraum*:</div>
														<div class="time-period-input">
															<input type="text" name="time-period-beginn" id="new-club-event-time-period-beginn" class="placeholder=MM:HH">
																<xsl:if test="$newEventType = 'club-event'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/time_period_beginn"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
																Uhr bis
															<input type="text" name="time-period-ende" class="placeholder=MM:HH">
																<xsl:if test="$newEventType = 'club-event'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/time_period_ende"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
																Uhr
														</div>
														<div class="place">Ort*:</div>
														<div class="place-input">
															<input type="text" name="place" id="new-club-event-place-input">
																<xsl:if test="$newEventType = 'club-event'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/place"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
														</div>
														<div class="type">Art*:</div>
														<div class="type-input">
															<input type="text" name="type" id="new-club-event-type-input">
																<xsl:if test="$newEventType = 'club-event'">
																	<xsl:attribute name="value">
																		<xsl:value-of select="calendar/type"></xsl:value-of>
																	</xsl:attribute>
																</xsl:if>
															</input>
														</div>
														<div class="info-text">Info:</div>
														<div class="info-text-input">
															<textarea name="info-text" rows="4" cols="1" class="textarea">
																<xsl:if test="$newEventType = 'club-event'">
																	<xsl:value-of select="calendar/info_text"></xsl:value-of>
																</xsl:if>
															</textarea>
														</div>
														<div class="notice">Hinweis:</div>
														<div class="notice-input">
															<textarea name="notice" rows="2" cols="1" class="textarea">
																<xsl:if test="$newEventType = 'club-event'">
																	<xsl:value-of select="calendar/notice"></xsl:value-of>
																</xsl:if>
															</textarea>
														</div>
														<div class="incomplete-warning" id="new-club-event-incomplete-warning">
															<p>Bitte fülle alle benötigten Felder aus.</p>
														</div>
														<div class="submit-btn">
															<input type="submit" value="" name="new-club-event"></input>
														</div>
													</form>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</xsl:if>
					<xsl:variable name="isAdmin" select="document('../xml/calendar.xml')/calendar/isAdmin"></xsl:variable>
					<xsl:if test="$isAdmin = 'true'">
						<div class="user-management" id="user-management">
							<div class="user-management-btn">
								<button onclick="showPopup('user-management-popup')">User Management
								</button>
							</div>
							<div class="user-management-popup" id="user-management-popup">
								<div class="background" onclick="hidePopup('user-management-popup')">
									<div class="popup" onclick="event.stopPropagation()">
										<div class="close_btn" onclick="hidePopup('user-management-popup')"></div>
										<div class="content">
											<h1>User Management</h1>
											<div class="user-management-body popup-body">
												<div class="new-user">
													<form method="post" class="new-user-form" id="new-user-form">
														<xsl:attribute name="action">
															<xsl:value-of select="calendar/current_path"></xsl:value-of>
														</xsl:attribute>
														<div class="title">Neuen User erstellen</div>
														<div class="name">Name:</div>
														<div class="name-input">
															<input type="text" name="username" id="new-username-input"></input>
														</div>
														<div class="password">Passwort:</div>
														<div class="password-input">
															<input type="password" name="password" id="new-password-input"></input>
														</div>
														<div class="confirm-password">Passwort bestätigen:</div>
														<div class="confirm-password-input">
															<input type="password" name="confirm-password" id="confirm-new-password-input"></input>
														</div>
														<div class="admin">Admin:</div>
														<div class="admin-input">
															<input type="checkbox" name="admin" id="new-admin-input" value="1"></input>
														</div>
														<div class="error-message" id="new-user-password-error-message">Passwörter stimmen nicht überein.</div>
														<div class="incomplete-message" id="new-user-password-incomplete-message">Bitte fülle alle benötigten Felder aus.</div>
														<div class="submit-btn">
															<input type="submit" value="" name="create-new-user"></input>
														</div>
													</form>
												</div>
												<div class="current-user-list">
													<xsl:for-each select="document('../xml/users.xml')/users/user">
														<div class="user-row">
															<div class="user-row-title">
																<xsl:value-of select="name" class="user-name"></xsl:value-of>
																<div>
																	<xsl:if test="isAdmin = '1'">
																	Admin
																	</xsl:if>
																</div>
																<button class="expand-btn">
																	<xsl:attribute name="id">
																		<xsl:text>expand-btn-</xsl:text>
																		<xsl:value-of select="id"></xsl:value-of>
																	</xsl:attribute>
																</button>
															</div>
															<div class="user-row-content">
																<xsl:attribute name="id">
																	<xsl:text>user-row-content-</xsl:text>
																	<xsl:value-of select="id"></xsl:value-of>
																</xsl:attribute>
																<form method="post" class="set-new-username">
																	<xsl:attribute name="action">
																		<xsl:value-of select="document('../xml/calendar.xml')/calendar/current_path"></xsl:value-of>
																	</xsl:attribute>
																	<div class="text">Neuer Name:</div>
																	<div class="input-username">
																		<input type="text" name="new-username" required="required"></input>
																	</div>
																	<div>
																		<input type="hidden" name="id">
																			<xsl:attribute name="value">
																				<xsl:value-of select="id"></xsl:value-of>
																			</xsl:attribute>
																		</input>
																	</div>
																	<div class="confirm-username">
																		<input type="submit" value="" name="users-set-new-username"></input>
																	</div>
																</form>
																<form method="post" class="set-new-password">
																	<xsl:attribute name="action">
																		<xsl:value-of select="document('../xml/calendar.xml')/calendar/current_path"></xsl:value-of>
																	</xsl:attribute>
																	<div class="text">Neues Passwort:</div>
																	<div class="input-password">
																		<input type="password" name="new-password" required="required"></input>
																	</div>
																	<div>
																		<input type="hidden" name="id">
																			<xsl:attribute name="value">
																				<xsl:value-of select="id"></xsl:value-of>
																			</xsl:attribute>
																		</input>
																	</div>
																	<div class="confirm-password">
																		<input type="submit" value="" name="users-set-new-password"></input>
																	</div>
																</form>
																<div class="delete-user">
																	<form method="post" class="delete-user-form">
																		<xsl:attribute name="action">
																			<xsl:value-of select="document('../xml/calendar.xml')/calendar/current_path"></xsl:value-of>
																		</xsl:attribute>
																		<input type="hidden" name="id">
																			<xsl:attribute name="value">
																				<xsl:value-of select="id"></xsl:value-of>
																			</xsl:attribute>
																		</input>
																		<input type="submit" name="users-delete-user" class="delete-user-btn" value="Löschen"></input>
																	</form>
																</div>
															</div>
														</div>
													</xsl:for-each>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</xsl:if>
					<xsl:variable name="editEvent" select="document('../xml/calendar.xml')/calendar/editEvent"></xsl:variable>
					<xsl:if test="$editEvent = '1'">
						<div class="edit-event-popup" id="edit-event-popup">
							<div class="background" onclick="hidePopup('edit-event-popup')">
								<div class="popup" onclick="event.stopPropagation()">
									<div class="close_btn" onclick="hidePopup('edit-event-popup')"></div>
									<div class="content">
										<h1>Event bearbeiten</h1>
										<div class="popup-body">
											<form method="post" class="edit-event-form" id="edit-event-form">
												<xsl:attribute name="action">
													<xsl:value-of select="calendar/current_path"></xsl:value-of>
												</xsl:attribute>
												<div class="name">Name*:</div>
												<div class="name-input">
													<input type="text" name="name" id="edit-event-name">
														<xsl:attribute name="value">
															<xsl:value-of select="calendar/name"></xsl:value-of>
														</xsl:attribute>
													</input>
												</div>
												<xsl:variable name="dateWrong" select="calendar/dateWrong"></xsl:variable>
												<xsl:if test="$dateWrong = '1'">
													<div class="date-warning" id="date-warning-edit">
														Das Datumsformat wurde nicht eingehalten. (TT.MM.JJJJ)
													</div>
												</xsl:if>
												<div class="date">Datum*:</div>
												<div class="date-input">
													<input type="text" name="date-day" id="edit-event-date-0" class="placeholder=TT">
														<xsl:attribute name="value">
															<xsl:value-of select="calendar/date_day"></xsl:value-of>
														</xsl:attribute>
													</input>
														.
													<input type="text" name="date-month" id="edit-event-date-1" class="placeholder=MM">
														<xsl:attribute name="value">
															<xsl:value-of select="calendar/date_month"></xsl:value-of>
														</xsl:attribute>
													</input>
														.
													<input type="text" name="date-year" id="edit-event-date-2" class="placeholder=JJJJ">
														<xsl:attribute name="value">
															<xsl:value-of select="calendar/date_year"></xsl:value-of>
														</xsl:attribute>
													</input>
												</div>
												<xsl:variable name="timeWrong" select="calendar/timeWrong"></xsl:variable>
												<xsl:if test="$timeWrong = '1'">
													<div class="time-warning" id="time-warning-edit">
														Das Zeitformat wurde nicht eingehalten.
													</div>
												</xsl:if>
												<div class="time-period">Zeitraum*:</div>
												<div class="time-period-input">
													<input type="text" name="time-period-beginn" id="edit-event-time-period-beginn" class="placeholder=MM:HH">
														<xsl:attribute name="value">
															<xsl:value-of select="calendar/time_period_beginn"></xsl:value-of>
														</xsl:attribute>
													</input>
														Uhr bis
													<input type="text" name="time-period-ende" class="placeholder=MM:HH">
														<xsl:attribute name="value">
															<xsl:value-of select="calendar/time_period_ende"></xsl:value-of>
														</xsl:attribute>
													</input>
														Uhr
												</div>
												<div class="place">Ort*:</div>
												<div class="place-input">
													<input type="text" name="place" id="edit-event-place-input">
														<xsl:attribute name="value">
															<xsl:value-of select="calendar/place"></xsl:value-of>
														</xsl:attribute>
													</input>
												</div>
												<div class="type">Art*:</div>
												<div class="type-input">
													<input type="text" name="type" id="edit-event-type-input">
														<xsl:attribute name="value">
															<xsl:value-of select="calendar/type"></xsl:value-of>
														</xsl:attribute>
													</input>
												</div>
												<xsl:variable name="id" select="calendar/id"></xsl:variable>
												<xsl:if test="substring($id, 1, 5) = 'match'">
													<div class="clubs">Vereine*:</div>
													<div class="clubs-input">
														<input type="text" name="clubs0" id="edit-event-clubs0-input">
															<xsl:attribute name="value">
																<xsl:value-of select="calendar/clubs0"></xsl:value-of>
															</xsl:attribute>
														</input>
														v.s.
														<input type="text" name="clubs1" id="edit-event-clubs1-input">
															<xsl:attribute name="value">
																<xsl:value-of select="calendar/clubs1"></xsl:value-of>
															</xsl:attribute>
														</input>
													</div>
													<div class="points">Ergebnis:</div>
													<div class="points-input">
														<input type="number" name="points0" min="0" max="99">
															<xsl:attribute name="value">
																<xsl:value-of select="calendar/points0"></xsl:value-of>
															</xsl:attribute>
														</input>
														:
														<input type="number" name="points1" min="0" max="99">
															<xsl:attribute name="value">
																<xsl:value-of select="calendar/points1"></xsl:value-of>
															</xsl:attribute>
														</input>
													</div>
												</xsl:if>
												<div class="info-text">Info:</div>
												<div class="info-text-input">
													<textarea name="info-text" rows="4" cols="1" class="textarea">
														<xsl:value-of select="calendar/info_text"></xsl:value-of>
													</textarea>
												</div>
												<div class="notice">Hinweis:</div>
												<div class="notice-input">
													<textarea name="notice" rows="2" cols="1" class="textarea">
														<xsl:value-of select="calendar/notice"></xsl:value-of>
													</textarea>
												</div>
												<div>
													<input type="hidden" name="id">
														<xsl:attribute name="value">
															<xsl:value-of select="calendar/id"></xsl:value-of>
														</xsl:attribute>
													</input>
												</div>
												<div class="incomplete-warning" id="edit-event-incomplete-warning">
													<p>Bitte fülle alle benötigten Felder aus.</p>
												</div>
												<div class="submit-btn">
													<input type="submit" value="" name="edit-event-submitted"></input>
													<form method="post">
														<xsl:attribute name="action">
															<xsl:value-of select="calendar/current_path"></xsl:value-of>
														</xsl:attribute>
														<div>
															<input type="hidden" name="id">
																<xsl:attribute name="value">
																	<xsl:value-of select="calendar/id"></xsl:value-of>
																</xsl:attribute>
															</input>
														</div>
														<input type="submit" value="Löschen" name="delete-event-submitted" class="delete-btn"></input>
													</form>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</xsl:if>
				</div>
				<div class="main">
					<div class="option-bar">
						<div class="home-btn option-bar-0">
							<button>
								<xsl:attribute name="onclick">
									<xsl:text>window.location.href = '</xsl:text>
									<xsl:value-of select="document('../xml/calendar.xml')/calendar/home_path"></xsl:value-of>
									<xsl:text>'</xsl:text>
								</xsl:attribute>
							</button>
						</div>
						<div class="option-view-btn option-bar-1">
							<button class="left">
								<xsl:attribute name="onclick">
									<xsl:text>window.location.href = '</xsl:text>
									<xsl:value-of select="document('../xml/calendar.xml')/calendar/path_month"></xsl:value-of>
									<xsl:text>'</xsl:text>
								</xsl:attribute>
								Monat
							</button>
							<button class="current right">
								<xsl:attribute name="onclick">
									<xsl:text>window.location.href = '</xsl:text>
									<xsl:value-of select="document('../xml/calendar.xml')/calendar/path_year"></xsl:value-of>
									<xsl:text>'</xsl:text>
								</xsl:attribute>
								Jahr
							</button>
						</div>
						<div class="date-btn option-bar-2" id="date-btn">
							<button class="drop-btn drop-btn-year">
								<div>
									<xsl:value-of select="document('../xml/calendar.xml')/calendar/year"></xsl:value-of>
								</div>
							</button>
							<div class="dropdown-content" id="dropdown-content">
								<div class="submit-btn-structure">
									<div class="input">
										<div class="year_input">
											<button class="up" onclick="addToYearInput(1)"></button>
											<input type="text" id="year_input" class="year_input_year">
												<xsl:attribute name="name">
													<xsl:value-of select="document('../xml/calendar.xml')/calendar/year"></xsl:value-of>
												</xsl:attribute>
											</input>
											<button class="down" onclick="addToYearInput(-1)"></button>
										</div>
									</div>
									<div class="submit">
										<button>
											<xsl:attribute name="onclick">
												<xsl:text>yearBtnClick('</xsl:text>
												<xsl:value-of select="document('../xml/calendar.xml')/calendar/path_year_btn"></xsl:value-of>
												<xsl:text disable-output-escaping="yes">')</xsl:text>
											</xsl:attribute>
										</button>
									</div>
								</div>
							</div>
						</div>
						<div class="arrows-btn option-bar-3">
							<button class="left" id="left_btn">
								<xsl:attribute name="onclick">
									<xsl:text>location.href='</xsl:text>
									<xsl:value-of select="document('../xml/calendar.xml')/calendar/new_path_left"></xsl:value-of>
									<xsl:text>'</xsl:text>
								</xsl:attribute>
							</button>
							<button class="today" id="today_btn">
								<xsl:attribute name="onclick">
									<xsl:text>location.href='</xsl:text>
									<xsl:value-of select="document('../xml/calendar.xml')/calendar/new_path_today"></xsl:value-of>
									<xsl:text>'</xsl:text>
								</xsl:attribute>
							</button>
							<button class="right" id="right_btn">
								<xsl:attribute name="onclick">
									<xsl:text>location.href='</xsl:text>
									<xsl:value-of select="document('../xml/calendar.xml')/calendar/new_path_right"></xsl:value-of>
									<xsl:text>'</xsl:text>
								</xsl:attribute>
							</button>
						</div>
					</div>
					<div class="content">
						<div id="content-calendar" class="content-calendar">
							<xsl:for-each select="document('../xml/calendar.xml')/calendar/month">
								<div>
									<xsl:attribute name="class">
										<xsl:text>title title-</xsl:text>
										<xsl:value-of select="index"></xsl:value-of>
									</xsl:attribute>
									<xsl:variable name="todayMonth" select="substring(document('../xml/calendar.xml')/calendar/date_today, 1, 7)"></xsl:variable>
									<xsl:if test="substring(date, 1, 7) = $todayMonth">
										<xsl:attribute name="id">
											<xsl:text>month_today</xsl:text>
										</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="month_name"></xsl:value-of>
								</div>
							</xsl:for-each>
							<xsl:for-each select="document('../xml/calendar.xml')/calendar/month">
								<div>
									<xsl:attribute name="class">
										<xsl:text>month-</xsl:text>
										<xsl:value-of select="index"></xsl:value-of>
										<xsl:text> calendar-body </xsl:text>
									</xsl:attribute>
									<div class="events">
										<xsl:variable name="currentMonth">
											<xsl:value-of select="substring(date, 1, 7)"/>
										</xsl:variable>
										<xsl:for-each select="document('../xml/events.xml')/events/event[substring(date, 1, 7) = $currentMonth]">
											<button class="event_btn">
												<xsl:attribute name="onclick">
													<xsl:text>showPopup('p</xsl:text>
													<xsl:value-of select="index"></xsl:value-of>
													<xsl:text>')</xsl:text>
												</xsl:attribute>
												<div class="text">
													<div class="name">
														<xsl:value-of select="name"></xsl:value-of>
													</div>
													<div class="date">
														<xsl:text> - </xsl:text>
														<div class="date-number">
															<xsl:value-of select="substring(date, string-length(date) - 1)"/>
														</div>
														<xsl:text>.</xsl:text>
													</div>
												</div>
											</button>
											<div class="event_popup">
												<xsl:attribute name="id">
													<xsl:text>p</xsl:text>
													<xsl:value-of select="index"></xsl:value-of>
												</xsl:attribute>
												<div class="background">
													<xsl:attribute name="onclick">
														<xsl:text>hidePopup('p</xsl:text>
														<xsl:value-of select="index"></xsl:value-of>
														<xsl:text>')</xsl:text>
													</xsl:attribute>
													<div class="popup" onclick="event.stopPropagation()">
														<button class="close_btn">
															<xsl:attribute name="onclick">
																<xsl:text>hidePopup('p</xsl:text>
																<xsl:value-of select="index"></xsl:value-of>
																<xsl:text>')</xsl:text>
															</xsl:attribute>
														</button>
														<div class="content">
															<h1>
																<xsl:value-of select="name"></xsl:value-of>
															</h1>
															<table>
																<tbody>
																	<tr>
																		<td>Wann:</td>
																		<td>
																			<xsl:variable name="original_date" select="date"></xsl:variable>
																			<xsl:value-of select="substring($original_date, 9, 2)"></xsl:value-of>
																			<xsl:text>.</xsl:text>
																			<xsl:value-of select="substring($original_date, 6, 2)"></xsl:value-of>
																			<xsl:text>.</xsl:text>
																			<xsl:value-of select="substring($original_date, 1, 4)"></xsl:value-of>
																			<xsl:variable name="original_time_period" select="time_period"></xsl:variable>
																			<xsl:choose>
																				<xsl:when test="string-length($original_time_period) = 5">
																					<xsl:text>,  </xsl:text>
																					<xsl:value-of select="$original_time_period"></xsl:value-of>
																					<xsl:text> Uhr</xsl:text>
																				</xsl:when>
																				<xsl:otherwise>
																					<xsl:text> von </xsl:text>
																					<xsl:value-of select="substring($original_time_period, 1, 5)"></xsl:value-of>
																					<xsl:text> bis </xsl:text>
																					<xsl:value-of select="substring($original_time_period, 7, 5)"></xsl:value-of>
																					<xsl:text> Uhr</xsl:text>
																				</xsl:otherwise>
																			</xsl:choose>
																		</td>
																	</tr>
																	<tr>
																		<td>Wo:</td>
																		<td>
																			<xsl:value-of select="place"></xsl:value-of>
																		</td>
																	</tr>
																	<tr>
																		<td>Was:</td>
																		<td>
																			<xsl:value-of select="type"></xsl:value-of>
																		</td>
																	</tr>
																	<xsl:variable name="event_type" select="event_type"></xsl:variable>
																	<xsl:if test="contains($event_type, 'match')">
																		<tr>
																			<td>Wer:</td>
																			<td>
																				<xsl:value-of select="club0"></xsl:value-of>
																				<xsl:text> v.s. </xsl:text>
																				<xsl:value-of select="club1"></xsl:value-of>
																			</td>
																		</tr>
																		<!-- check if the result is
																		already set -->
																		<xsl:variable name="points_set" select="points0"></xsl:variable>
																		<xsl:if test="string-length($points_set) &gt; 0">
																			<tr>
																				<td>Ergebnis:</td>
																				<td>
																					<xsl:value-of select="points0"></xsl:value-of>
																					<xsl:text> : </xsl:text>
																					<xsl:value-of select="points1"></xsl:value-of>
																				</td>
																			</tr>
																		</xsl:if>
																	</xsl:if>
																	<xsl:variable name="info_text_set" select="info_text"></xsl:variable>
																	<xsl:if test="string-length($info_text_set) &gt; 0">
																		<tr>
																			<td>Info:</td>
																			<td>
																				<xsl:value-of select="info_text"></xsl:value-of>
																			</td>
																		</tr>
																	</xsl:if>
																	<xsl:variable name="notice_set" select="notice"></xsl:variable>
																	<xsl:if test="string-length($notice_set) &gt; 0">
																		<tr>
																			<td>Hinweis:</td>
																			<td>
																				<xsl:value-of select="notice"></xsl:value-of>
																			</td>
																		</tr>
																	</xsl:if>
																</tbody>
															</table>
															<xsl:variable name="userLoggedIn" select="document('../xml/calendar.xml')/calendar/userLoggedIn"></xsl:variable>
															<xsl:if test="$userLoggedIn = 'true'">
																<form method="post" class="edit-form">
																	<xsl:attribute name="action">
																		<xsl:value-of select="document('../xml/calendar.xml')/calendar/current_path"></xsl:value-of>
																	</xsl:attribute>
																	<div>
																		<input type="hidden" name="id">
																			<xsl:attribute name="value">
																				<xsl:value-of select="id"></xsl:value-of>
																			</xsl:attribute>
																		</input>
																		<input type="hidden" name="name">
																			<xsl:attribute name="value">
																				<xsl:value-of select="name"></xsl:value-of>
																			</xsl:attribute>
																		</input>
																		<xsl:variable name="original_date" select="date"></xsl:variable>
																		<input type="hidden" name="date-day">
																			<xsl:attribute name="value">
																				<xsl:value-of select="substring($original_date, 9, 2)"></xsl:value-of>
																			</xsl:attribute>
																		</input>
																		<input type="hidden" name="date-month">
																			<xsl:attribute name="value">
																				<xsl:value-of select="substring($original_date, 6, 2)"></xsl:value-of>
																			</xsl:attribute>
																		</input>
																		<input type="hidden" name="date-year">
																			<xsl:attribute name="value">
																				<xsl:value-of select="substring($original_date, 1, 4)"></xsl:value-of>
																			</xsl:attribute>
																		</input>
																		<xsl:variable name="original_time_period" select="time_period"></xsl:variable>
																		<input type="hidden" name="time-period-beginn">
																			<xsl:attribute name="value">
																				<xsl:value-of select="substring($original_time_period, 1, 5)"></xsl:value-of>
																			</xsl:attribute>
																		</input>
																		<input type="hidden" name="time-period-ende">
																			<xsl:attribute name="value">
																				<xsl:value-of select="substring($original_time_period, 7, 5)"></xsl:value-of>
																			</xsl:attribute>
																		</input>
																		<input type="hidden" name="place">
																			<xsl:attribute name="value">
																				<xsl:value-of select="place"></xsl:value-of>
																			</xsl:attribute>
																		</input>
																		<input type="hidden" name="type">
																			<xsl:attribute name="value">
																				<xsl:value-of select="type"></xsl:value-of>
																			</xsl:attribute>
																		</input>
																		<input type="hidden" name="clubs0">
																			<xsl:attribute name="value">
																				<xsl:value-of select="club0"></xsl:value-of>
																			</xsl:attribute>
																		</input>
																		<input type="hidden" name="clubs1">
																			<xsl:attribute name="value">
																				<xsl:value-of select="club1"></xsl:value-of>
																			</xsl:attribute>
																		</input>
																		<input type="hidden" name="points0">
																			<xsl:attribute name="value">
																				<xsl:value-of select="points0"></xsl:value-of>
																			</xsl:attribute>
																		</input>
																		<input type="hidden" name="points1">
																			<xsl:attribute name="value">
																				<xsl:value-of select="points1"></xsl:value-of>
																			</xsl:attribute>
																		</input>
																		<input type="hidden" name="info-text">
																			<xsl:attribute name="value">
																				<xsl:value-of select="info_text"></xsl:value-of>
																			</xsl:attribute>
																		</input>
																		<input type="hidden" name="notice">
																			<xsl:attribute name="value">
																				<xsl:value-of select="notice"></xsl:value-of>
																			</xsl:attribute>
																		</input>
																	</div>
																	<div class="edit-btn">
																		<input type="submit" value="Bearbeiten" name="edit-event"></input>
																	</div>
																</form>
															</xsl:if>
														</div>
													</div>
												</div>
											</div>
										</xsl:for-each>
									</div>
								</div>
							</xsl:for-each>
						</div>
						<div class="points-table">
							<div>
								<xsl:attribute name="class">
									<xsl:text>points-table-head-bar</xsl:text>
									<xsl:variable name="pointsTableActive" select="document('../xml/calendar.xml')/calendar/pointsTableActive"></xsl:variable>
									<xsl:if test="$pointsTableActive = 'true'">
										<xsl:text> big</xsl:text>
									</xsl:if>
								</xsl:attribute>
								<div class="points-table-btn">
									<button>
										<xsl:attribute name="onclick">
											<xsl:text>location.href='</xsl:text>
											<xsl:value-of select="document('../xml/calendar.xml')/calendar/new_path_points_table_btn"></xsl:value-of>
											<xsl:text>'</xsl:text>
										</xsl:attribute>
									</button>
								</div>
								<xsl:variable name="pointsTableActive" select="document('../xml/calendar.xml')/calendar/pointsTableActive"></xsl:variable>
								<xsl:if test="$pointsTableActive = 'true'">
									<div class="points-table-title">
										Punktetabelle
									</div>
								</xsl:if>
							</div>
							<xsl:variable name="pointsTableActive" select="document('../xml/calendar.xml')/calendar/pointsTableActive"></xsl:variable>
							<xsl:if test="$pointsTableActive = 'true'">
								<div class="points-table-content" id="points-table-content">
									<table>
										<tr>
											<th></th>
											<th>S</th>
											<th>U</th>
											<th>N</th>
											<th>Punkte</th>
										</tr>
										<xsl:for-each select="document('../xml/points_table.xml')/points_table/team">
											<tr>
												<td class="club-name">
													<xsl:attribute name="class">
														<xsl:text>club-name</xsl:text>
														<xsl:variable name="our_club" select="our_club"></xsl:variable>
														<xsl:if test="$our_club = 'true'">
															<xsl:text> our-club</xsl:text>
														</xsl:if>
													</xsl:attribute>
													<xsl:value-of select="name"></xsl:value-of>
												</td>
												<td>
													<xsl:value-of select="win"></xsl:value-of>
												</td>
												<td>
													<xsl:value-of select="draw"></xsl:value-of>
												</td>
												<td>
													<xsl:value-of select="loss"></xsl:value-of>
												</td>
												<td>
													<xsl:value-of select="points"></xsl:value-of>
												</td>
											</tr>
										</xsl:for-each>
									</table>
								</div>
							</xsl:if>
						</div>
					</div>
				</div>
				<div class="footer">3
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>