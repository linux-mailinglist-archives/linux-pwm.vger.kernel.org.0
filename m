Return-Path: <linux-pwm+bounces-6860-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A05B0C876
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Jul 2025 18:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A635E1AA0F2D
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Jul 2025 16:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E5528469C;
	Mon, 21 Jul 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PPCaj/Bt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498225383
	for <linux-pwm@vger.kernel.org>; Mon, 21 Jul 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753114475; cv=none; b=DVPrXqXGGMh2AasJyGrwhbs7axAMiaET7YOufJLcn6ATAsc9bK7P0qKGmwSwcmfdvsWY+QXteFkUj0WyEptgIjVu4wjWrtbIATZwW3BYJY3ItcNTuYl8cyz4wT++vnwwX5kzUeFFSg3Ym5jvkDGLhQrWTI0izEhPoVgM6pxSo8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753114475; c=relaxed/simple;
	bh=9DwgrNyNOy1Ue1z2CmJMZq0T7TDK8Lmpv56A5DuSQaE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qWEdr7YIk1GdiaIhQqQ+UthDVD9IkIFBOn/5ubc+Vz1H/5zefnxC6D0fCvBHWxGsLdnRqCn8k+F0Gs8LrZqbX4p3MEEFeaRUGGbPgI0G9BsD0CDZSbZFvrAN7fnHwlXgYHZO1PzwtoySuBqKSsH1GW52vJgN6l5pWDZUhBHsS9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PPCaj/Bt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aec5a714ae9so561317766b.3
        for <linux-pwm@vger.kernel.org>; Mon, 21 Jul 2025 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753114470; x=1753719270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1MpDSXcwFBar4GEzw4mjLZSQAzAxBCnhq6pKVpOwpyw=;
        b=PPCaj/Bt/9mNAMDF5DweJ8hvg4jueNezCmtp9STqULDIdK58vt5PpffFyRTJYVrFXA
         cyy7wGA4yTo6sPoYeZT908yjN5dSG0/A08KIZ+opqVOLiLNWUS+HD9qxn5bR8GkjJ4a0
         iAPruJY1YBFMTVfVqdzJMaz+y8oCBZEV7xmHALQ0Yyr7Dy8yayMFXYIKYW++Z/Ru0C7Y
         2O7bHftCyF/fvoLhSHUjQXsLjxye0HshtiYRY44x6eZfBGmB/W9ELnAZWLNuBkSfyjs7
         2O5qt12EQP+OTLPF9aXb9f1nOiPrBTbImEt1QPVgiFLc8wnpOReIdUfmIQvlnc262Sg3
         Gc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753114470; x=1753719270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MpDSXcwFBar4GEzw4mjLZSQAzAxBCnhq6pKVpOwpyw=;
        b=arLNUFeR2QvBXtJaYO73BTuSNsOzRtWIKbEjCWl4MBKzYL7F284TS8wV4oLiQvMW6b
         Wqoc7UJSMXA5IpurQhJlBd8yaeY+lirtrUdur3xOb8IiCXOF/TxU4pS5P9li5RdA4L3U
         5yWy7EjRzZJSVV/e4Sqdl9oiPBAwuTF+R6xwnMWFhLk6r1Fp8+iOZkTEaw6WsxM70n5/
         ZjYWEmoiqpz7BITkIEn8XJ23yYRs7+f2TnMmwCB0PGoTB4dtMPfTXJo/EYipg8TiCeXk
         X0q81I00Pgmz9Ny2KVoh+FsnsXgY37ZunGsjWwQQhg+FVVgTBJO0mKb+Ne5DM/3gvcxJ
         EI6g==
X-Gm-Message-State: AOJu0Yyao4dyVFf77Zw8tLhp6K7VIWpRrqy6fwslwlB1OoRIbP2XP/B7
	CA/nc57U68hq49SzfSqV4A57wxGAMLc4S0MPv44FrHTGRoLt2uHQIf83y3Xdp0OeZ/m+FpfUcvi
	jDj3f
X-Gm-Gg: ASbGncvaur6okoLqMBd8F2wIR4TyW9hFHCGIbXLywggXLFoXXeiRu8E1AVJHcjqaHjz
	5sWSZnTc9vUdaUg1UNgi7LHqAVWiK38V0v/WeILdP197pq1f/RzF3XRA8I0Bh/Jc0WaYX6Zu6SO
	b8AM7mM93ITzkTMsxMOUxXF3DEiWSeDOLtHV1YCkubbTz5BvFHRZMK5fnmujCIQDQ039I1Gf1kG
	j46yYI/WFBGbg9vCpq28VCIkI/HBUXUefQ816iTmyXi+6OEk9fAZefBEO4xoKQZ5GfKLP7PGgHV
	U0VL4EGhNC3ABS+iVGTT6AcTbQjJu2NoZcuF7GBU30/ZzjoQUFjM0rp4RW2Jxr4bo5y0q8znOEE
	WF/Vsna4rMqMmSEqjhIZg1GCv7aUWvf97DSDc4p5xQvvwPIIzb3g+zaMIh/qiNCCWo5aEWxpbjY
	o=
X-Google-Smtp-Source: AGHT+IHVEYbKW0uztHHuBktII2Jreu4LHglgupBb1sK28z2pcLLnIgsI8N3YlF+5cDYjtV14MGKA0A==
X-Received: by 2002:a17:907:3d02:b0:ae0:b46b:decd with SMTP id a640c23a62f3a-ae9c9ac13b7mr2209245266b.31.1753114470403;
        Mon, 21 Jul 2025 09:14:30 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aec6c79c6a7sm702058766b.26.2025.07.21.09.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 09:14:30 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH libpwm] Fix error messages to contain the correct chip and pwm ids
Date: Mon, 21 Jul 2025 18:14:24 +0200
Message-ID: <20250721161423.2273295-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4356; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=9DwgrNyNOy1Ue1z2CmJMZq0T7TDK8Lmpv56A5DuSQaE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBofmdfGNn0srD2pqHRTG3t2gZ4pcEVk5WxSkFHm UcNyQbav12JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaH5nXwAKCRCPgPtYfRL+ TlBnB/0aHNtVjSGKw0SxK7+JzsUxXsGYHkprhW/qEhFEoPeZggM0MIC9Hkud3X11EVLs+WzjFh5 kCBcsFhs7qgL1idVfupPnI+tpDmR0DhG/Z68cziVQptbQIb+Aabzu6kzuBM0nJ4gjK0STdm5VuZ IRS5kJ32Mu9HSAH1aVxBB3REFFHLunlO8bPV/8t41lhhQyb35Z8t9dZa/bjeRaeRlm4KZMlyUrt ZbilveDRjBIruuJ1aPDI8Ztp7EyjMRUt66KYwEKDDJH0OWN30sgS73yjh03OkL1ZCBVBtN8dGuy +JxRXWOGJrFFO8gvagoGrzKh2zt+VXUrsJlPmL3R7CAEoNFP
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Create a variant of perror that takes a format string and arguments and
use that to replace the hardcoded zero in the error string.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 Makefile.am   | 10 +++++++---
 misc.c        | 34 ++++++++++++++++++++++++++++++++++
 misc.h        |  4 ++++
 pwmround.c    |  6 ++++--
 pwmset.c      |  6 ++++--
 pwmtestperf.c |  6 ++++--
 6 files changed, 57 insertions(+), 9 deletions(-)
 create mode 100644 misc.c
 create mode 100644 misc.h

diff --git a/Makefile.am b/Makefile.am
index 191b0dfb551d..c68716c233a7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -8,6 +8,7 @@ include_HEADERS = \
 
 noinst_HEADERS = \
 	pwm-internal.h \
+	misc.h \
 	uapi-pwm.h
 
 lib_LTLIBRARIES = \
@@ -36,15 +37,18 @@ dist_man1_MANS = \
 	pwmtestperf.1
 
 pwmround_SOURCES = \
-	pwmround.c
+	pwmround.c \
+	misc.c
 pwmround_LDADD = libpwm.la
 
 pwmset_SOURCES = \
-	pwmset.c
+	pwmset.c \
+	misc.c
 pwmset_LDADD = libpwm.la
 
 pwmtestperf_SOURCES = \
-	pwmtestperf.c
+	pwmtestperf.c \
+	misc.c
 pwmtestperf_LDADD = libpwm.la
 
 ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}
diff --git a/misc.c b/misc.c
new file mode 100644
index 000000000000..3dd248b7cba5
--- /dev/null
+++ b/misc.c
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: 0BSD */
+/* SPDX-FileCopyrightText: 2025 Uwe Kleine-König <u.kleine-koenig@baylibre.com> */
+
+#include "config.h"
+
+#include <errno.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "pwm-internal.h"
+
+void perrorf(const char *restrict format, ...)
+{
+	va_list args;
+	char *buf;
+	int ret;
+
+	va_start(args, format);
+
+	ret = vasprintf(&buf, format, args);
+
+	va_end(args);
+
+	if (ret < 0) {
+		errno = ENOMEM;
+		perror("Out of memory");
+		return;
+	}
+
+	perror(buf);
+
+	free(buf);
+}
diff --git a/misc.h b/misc.h
new file mode 100644
index 000000000000..e935062f87b1
--- /dev/null
+++ b/misc.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: 0BSD */
+/* SPDX-FileCopyrightText: 2025 Uwe Kleine-König <u.kleine-koenig@baylibre.com> */
+
+void perrorf(const char *restrict format, ...);
diff --git a/pwmround.c b/pwmround.c
index da3c018c4494..f23250d71f23 100644
--- a/pwmround.c
+++ b/pwmround.c
@@ -8,6 +8,8 @@
 
 #include <pwm.h>
 
+#include "misc.h"
+
 int main(int argc, char *const argv[])
 {
 	struct pwm_chip *chip;
@@ -67,7 +69,7 @@ int main(int argc, char *const argv[])
 
 	chip = pwm_chip_open_by_number(chipno);
 	if (!chip) {
-		perror("Failed to open pwmchip0");
+		perrorf("Failed to open pwmchip%u", chipno);
 		return EXIT_FAILURE;
 	}
 
@@ -83,7 +85,7 @@ int main(int argc, char *const argv[])
 
 	pwm = pwm_chip_get_pwm(chip, pwmno);
 	if (!pwm) {
-		perror("Failed to get pwm0");
+		perrorf("Failed to get pwm%u", pwmno);
 		return EXIT_FAILURE;
 	}
 
diff --git a/pwmset.c b/pwmset.c
index 4c3d50109f6a..6e76abe68300 100644
--- a/pwmset.c
+++ b/pwmset.c
@@ -8,6 +8,8 @@
 
 #include <pwm.h>
 
+#include "misc.h"
+
 int main(int argc, char *const argv[])
 {
 	struct pwm_chip *chip;
@@ -75,7 +77,7 @@ int main(int argc, char *const argv[])
 
 	chip = pwm_chip_open_by_number(chipno);
 	if (!chip) {
-		perror("Failed to open pwmchip0");
+		perrorf("Failed to open pwmchip%u", chipno);
 		return EXIT_FAILURE;
 	}
 
@@ -91,7 +93,7 @@ int main(int argc, char *const argv[])
 
 	pwm = pwm_chip_get_pwm(chip, pwmno);
 	if (!pwm) {
-		perror("Failed to get pwm0");
+		perrorf("Failed to get pwm%u", pwmno);
 		return EXIT_FAILURE;
 	}
 
diff --git a/pwmtestperf.c b/pwmtestperf.c
index ef6522ecbcee..72abf3987459 100644
--- a/pwmtestperf.c
+++ b/pwmtestperf.c
@@ -8,6 +8,8 @@
 
 #include <pwm.h>
 
+#include "misc.h"
+
 int main(int argc, char *const argv[])
 {
 	struct pwm_chip *chip;
@@ -54,13 +56,13 @@ int main(int argc, char *const argv[])
 
 	chip = pwm_chip_open_by_number(chipno);
 	if (!chip) {
-		perror("Failed to open pwmchip0");
+		perrorf("Failed to open pwmchip%u", chipno);
 		return EXIT_FAILURE;
 	}
 
 	pwm = pwm_chip_get_pwm(chip, pwmno);
 	if (!pwm) {
-		perror("Failed to get pwm0");
+		perrorf("Failed to get pwm%u", pwmno);
 		return EXIT_FAILURE;
 	}
 

base-commit: 7e51859bcc90a61d4ba46a626c48d85c1e4c13ba
-- 
2.50.0

