Return-Path: <linux-pwm+bounces-6005-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B187ABA382
	for <lists+linux-pwm@lfdr.de>; Fri, 16 May 2025 21:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A863172241
	for <lists+linux-pwm@lfdr.de>; Fri, 16 May 2025 19:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0A81E5B71;
	Fri, 16 May 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zgyeYN0Y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954D82AEFE
	for <linux-pwm@vger.kernel.org>; Fri, 16 May 2025 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423148; cv=none; b=TMK2JK1u1t+LhEsqJPQ6DwaTYCD6CJ85jpCUoPKOIt4Ail/ghci1vtASGo0KQXzSuWslrQKQtdgE11fRqYobvdQEUrW9ClqpM1uh73PRT15W6Usam4nQ1udYmmpxCl+P+eKQUVn+cFuU4Ke8aY1/whQVjVjVXuuQQ4wg0Yvx3JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423148; c=relaxed/simple;
	bh=/AkyCI14n2I4N9J4WXq7Mx/GcvL0n8KhRgaPaK0tKYo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rGyLkPDKCaDS9KbAgRIssf7z2ju6MthGAu+DL4EkhIvEQWFUt6PNQ8PSqixW2gLaRPkrVLjEM58X8tmFbQlnw1k5gPzuk9F/ZEaKSABi+n8Yt+O4N4IQI6DAjr+81WgQ7sg5LwSmcEjyi10PNVMYYuR57s5qS4fMYWhlxTJo1cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zgyeYN0Y; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad1a87d93f7so395732966b.0
        for <linux-pwm@vger.kernel.org>; Fri, 16 May 2025 12:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747423143; x=1748027943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W7hrxCAZI9z+SeuK/ikOJqHMTxXgRPMkqGckxlhQOkw=;
        b=zgyeYN0Yu98fb55upGYY9/PWQouFh1s5IiKmc3e9fWiEf7NJ9tBjfONWUvsGfxig8K
         p89rWiuEbbtZY/TRu4asCiAUzVtEufMLtuBDRSpvJWdew+vyf4bXGJA4WMfDjEhytcw3
         cloT76TqmXyx+Qu9uI2XlPQjmu5QrA09twNWppJkfpBw0qFIdBw2WSqDx6bSwelUTAbS
         j5lG1Voog76XMjTipxZWMsso0bBysVc2UZL5MDZ8CjRm5wWArUINtMkafLzQ6QT5TU6n
         Hy15CkyCpRdZ2qNwnejRujnqSqa7S5zsHb8ghUwboRvtwDXnY/o5xGZxEqHUDl5y+Gs9
         C6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747423143; x=1748027943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7hrxCAZI9z+SeuK/ikOJqHMTxXgRPMkqGckxlhQOkw=;
        b=jkco6h5zM1PbRvYi/bOa8/obZpY4ZQsVRnGeYCXrdXSPqyhwXBIVJx/yVqZ/aLC6sF
         AdGYfsntyzB6k/qbI/oOOtLrY4oe7b9cBErdNGtxak+pS9rJU0mPFy0kvNW6Y5beN/tj
         YXRf/GKuocvqK1/YN2j9kR8JSNHUC2UGJApTcrEyH1TWo8FDY0wFNCngp+lne33Y413L
         iWjQVZMZzEbqgTrj2lly+DuyQbmN4NtocZjqA2PngvyfpwAQY85ThDQjVOY7S/EXJftW
         nVr+B3sIk7HAdRDSP7oRYue7DEz1XMXvSHxFJyrAjXbPJq3gOyyNzzeIanzXB0brwCpq
         r4/g==
X-Gm-Message-State: AOJu0Yxw3NErjFUnS532LyWUx2orFIng86U0cksxDdo32HQR1w/FpCcz
	SjrV7nkWh0NJ2kPbCtaRfEdAF/zw5knqmI2oWgeewFiZFF1o4d88TV+Y4sxQ2Kzn4lzfX9+cEsq
	Qu7TA
X-Gm-Gg: ASbGnctpaXPedSn3lXqdwxAu1e62wJAJ101JvFF6akXCIywKmuGBHnronSvzimVY8+E
	nql5LfGlSd2ZNoHR7stXI/Qcw5Jiu65+PC513q/qKXj2tHtZkxTJiyi2RZ2TV6Znd93R2EZlmpB
	nGxtAI9g1z+oIl9wic97lbZYV5bD+KtTbx4TARTA8RbxK1Z/2PuaOXPx5txWXyaYzufFxfdG11/
	dTkakUkAncP4GjASaB39CZsAzNIaRAECLAOhfgZthoemcq3+9BKoZhB2f7pGj5M7FCnfrv8DqIP
	wb9YNc8K6X2iRzuI6qmWGCVc/q6jG0lbXedZD0rqTddPlr9AIrJYX8DC
X-Google-Smtp-Source: AGHT+IHB03NuG/f9MRDJURP6D/BhwS0djMKz3ULL9wQGb51JtJ3Qz5UFrm1DUu76v9h4A1Ip04DVmw==
X-Received: by 2002:a17:907:1c2a:b0:ad2:3fa9:751f with SMTP id a640c23a62f3a-ad536dce3demr352220966b.38.1747423142800;
        Fri, 16 May 2025 12:19:02 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad52d04af35sm200208166b.32.2025.05.16.12.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:19:02 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH libpwm] cdev: Make backend compilable without <linux/pwm.h>
Date: Fri, 16 May 2025 21:18:56 +0200
Message-ID: <20250516191855.1354125-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5278; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=/AkyCI14n2I4N9J4WXq7Mx/GcvL0n8KhRgaPaK0tKYo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoJ4+gIZnQvct14Su3C9Tmhcuwu10TicXdUYtLU T+BoA2Soj+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaCePoAAKCRCPgPtYfRL+ TqNuCACBktbwzAtNk/LY4dXZ883Kfuvg6vdTjLUDWfx5e9Vf4IZGgzdRl/CqmpKSkGxl6kpKS+j 4G+WwTPN/+wSfPBCP5JaxFaIHyBH3NX2j2xUW89u9zu0PAuSUWy9rw7kNb/CWfASvmwQboExwmw lZYQKAZHZLWQwpbWeDBtRsScB4dL/MSpIJBehE8PPtGfInFlusZF2k8j8OZft9WwrL3ER6+LoeC ovAe3frJoFHP06tIoM4FbZ6PyyqeTlrrgCKkQw0mt14K2KLoAQayiww5FRdp1arAepey1aqi+el ZzvWpB3j8jkdZVAxPt6ohM+yGb3s00ECdR3Pq9EOb3SaLn9e
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

That uapi header is quite new and so hardly any system provides it yet.
So add a local copy and fall back to that to make character device
support included unconditional.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 Makefile.am  |  5 +----
 cdev.c       |  7 ++++++-
 configure.ac | 21 ++++++---------------
 core.c       |  4 ----
 uapi-pwm.h   | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 24 deletions(-)
 create mode 100644 uapi-pwm.h

diff --git a/Makefile.am b/Makefile.am
index a2086de0f14b..08e2827e00fa 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -21,12 +21,9 @@ EXTRA_DIST = libpwm.sym
 
 libpwm_la_SOURCES = \
 	core.c \
+	cdev.c \
 	sysfs.c
 
-if HAVE_PWMCDEV
-libpwm_la_SOURCES += cdev.c
-endif
-
 bin_PROGRAMS = \
 	pwmround \
 	pwmset \
diff --git a/cdev.c b/cdev.c
index 924e6f74a0de..7000a8394592 100644
--- a/cdev.c
+++ b/cdev.c
@@ -5,7 +5,6 @@
 
 #include <errno.h>
 #include <fcntl.h>
-#include <linux/pwm.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/ioctl.h>
@@ -13,6 +12,12 @@
 
 #include <pwm.h>
 
+#ifdef HAVE_USABLE_LINUX_PWM_H
+#include <linux/pwm.h>
+#else
+#include "uapi-pwm.h"
+#endif
+
 #include "pwm-internal.h"
 
 struct pwm_cdev {
diff --git a/configure.ac b/configure.ac
index 63ccb8d819a1..3c6ed36d3447 100644
--- a/configure.ac
+++ b/configure.ac
@@ -28,28 +28,19 @@ AC_PROG_CC
 
 LT_INIT
 
-AC_ARG_ENABLE([pwmcdev],
-	      [AS_HELP_STRING([--enable-pwmcdev], [Build code to use /dev/pwmchipX @<:@default=check@:>@])],
-	      [],
-	      [: m4_divert_text([DEFAULTS], [enable_pwmcdev=check])])
-
-available_pwmcdev=yes
+have_usable_linux_pwm_h=yes
 
 AC_CHECK_HEADER([linux/pwm.h], [
-AC_CHECK_DECL([PWM_IOCTL_SETROUNDEDWF],, [available_pwmcdev=no], [#include <linux/pwm.h>])
-		], [available_pwmcdev=no])
+AC_CHECK_DECL([PWM_IOCTL_SETROUNDEDWF],, [have_usable_linux_pwm_h=no], [#include <linux/pwm.h>])
+		], [have_usable_linux_pwm_h=no])
 
-AS_IF([test "x$enable_pwmcdev" = "xcheck"], [enable_pwmcdev=$available_pwmcdev])
+AC_MSG_CHECKING([if system has a usable <linux/pwm.h>])
 
-AC_MSG_CHECKING([if character device support is to be enabled])
-
-AS_IF(test "x$enable_pwmcdev" = "xyes", [
-	AC_DEFINE([HAVE_PWMCDEV], [1], [Define to 1 if the character device backend should be built])
+AS_IF(test "x$have_usable_linux_pwm_h" = "xyes", [
+	AC_DEFINE([HAVE_USABLE_LINUX_PWM_H], [1], [Define to 1 if the character device backend should be built])
 	AC_MSG_RESULT([yes])
 ], [AC_MSG_RESULT([no])])
 
-AM_CONDITIONAL([HAVE_PWMCDEV], [test x$enable_pwmcdev = xyes])
-
 AC_CONFIG_FILES([
 	Makefile
 	libpwm.pc
diff --git a/core.c b/core.c
index cd1b2c591790..a1591d4efd4d 100644
--- a/core.c
+++ b/core.c
@@ -15,13 +15,9 @@ struct pwm_chip *pwm_chip_open_by_number(unsigned int num)
 {
 	struct pwm_chip *chip;
 
-#if HAVE_PWMCDEV
 	chip = pwm_chip_cdev_open_by_number(num);
 	if (chip == NULL && errno == ENOENT)
 		chip = pwm_chip_sysfs_open_by_number(num);
-#else
-	chip = pwm_chip_sysfs_open_by_number(num);
-#endif
 
 	return chip;
 }
diff --git a/uapi-pwm.h b/uapi-pwm.h
new file mode 100644
index 000000000000..182d59cc07ee
--- /dev/null
+++ b/uapi-pwm.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+
+#ifndef _UAPI_PWM_H_
+#define _UAPI_PWM_H_
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/**
+ * struct pwmchip_waveform - Describe a PWM waveform for a pwm_chip's PWM channel
+ * @hwpwm: per-chip relative index of the PWM device
+ * @__pad: padding, must be zero
+ * @period_length_ns: duration of the repeating period.
+ *    A value of 0 represents a disabled PWM.
+ * @duty_length_ns: duration of the active part in each period
+ * @duty_offset_ns: offset of the rising edge from a period's start
+ */
+struct pwmchip_waveform {
+	__u32 hwpwm;
+	__u32 __pad;
+	__u64 period_length_ns;
+	__u64 duty_length_ns;
+	__u64 duty_offset_ns;
+};
+
+/* Reserves the passed hwpwm for exclusive control. */
+#define PWM_IOCTL_REQUEST	_IO(0x75, 1)
+
+/* counter part to PWM_IOCTL_REQUEST */
+#define PWM_IOCTL_FREE		_IO(0x75, 2)
+
+/*
+ * Modifies the passed wf according to hardware constraints. All parameters are
+ * rounded down to the next possible value, unless there is no such value, then
+ * values are rounded up. Note that zero isn't considered for rounding down
+ * period_length_ns.
+ */
+#define PWM_IOCTL_ROUNDWF	_IOWR(0x75, 3, struct pwmchip_waveform)
+
+/* Get the currently implemented waveform */
+#define PWM_IOCTL_GETWF		_IOWR(0x75, 4, struct pwmchip_waveform)
+
+/* Like PWM_IOCTL_ROUNDWF + PWM_IOCTL_SETEXACTWF in one go. */
+#define PWM_IOCTL_SETROUNDEDWF	_IOW(0x75, 5, struct pwmchip_waveform)
+
+/*
+ * Program the PWM to emit exactly the passed waveform, subject only to rounding
+ * down each value less than 1 ns. Returns 0 on success, -EDOM if the waveform
+ * cannot be implemented exactly, or other negative error codes.
+ */
+#define PWM_IOCTL_SETEXACTWF	_IOW(0x75, 6, struct pwmchip_waveform)
+
+#endif /* _UAPI_PWM_H_ */

base-commit: 00aff52a76199f13ea9e0ad628ffcac93fdce538
-- 
2.47.2


