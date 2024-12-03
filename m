Return-Path: <linux-pwm+bounces-4210-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327349E2B5D
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 19:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97CB5B2A243
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 17:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB831F8F16;
	Tue,  3 Dec 2024 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="INQooTFH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060471F9F69
	for <linux-pwm@vger.kernel.org>; Tue,  3 Dec 2024 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246197; cv=none; b=RFYip9KwX1QSRWnPQ77oABaCZC0it0VkwKjhF1NcFBOqwmZDuVxMG9R7ygPADb2lwNTcGCdZv9Fq2Npg/OFFKc/VNnK0/6LgQMhBLE/elKVNzAskRSfBiNXqbxSVPgL6hiBAq2UJJClHXdiobieoF5ZUfC5HKr630EJuFRKl9Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246197; c=relaxed/simple;
	bh=MLx0HXKyXXM3y8y6+2+1z0+USh/AYD3UzcwSVg7LVgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ml/FXtq61DhD+7Rqu7+QKEbcWfRjnijZi3IJNGNGmdXH2Yf6QhXX0PwgBoKYzrVQ/J+MLA5hdNXE8ng4K7uToR43GSTnBVQFaTP758X4ErJu91XWeYiw62qSb7XDlulUdLMrQnYfb2hdcq35OzIDHVnSU7PhU4GfCcB2D+UfNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=INQooTFH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a766b475so53684315e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 03 Dec 2024 09:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733246192; x=1733850992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfz7EKDAPFwQQLg5EGqOmoY87z8R+/d21HRHaU4rMP8=;
        b=INQooTFHdqqQuhSunXAND/AZPy6i5KgPgYT/c8DzBDX5WCrUjBk98lEFEAM942Ivs7
         lAJyjzjpCsqLGi7+tMmYT+x0G74Jz8HivoxUlzV3WhcuOyf+a6sVNtPllkONDiqW1odM
         PF3WbZaId7+f9NpgikEnpCDckVvc5exmUvlojcx6d1ez+GEZV+SSsDbNgtz239WT5x4b
         DZlK7+16mEmCGUAsK7WzUgu9Gbab+X25pj1gcpEkvGvWUcs/x2N0EwoiqfFl1KuKtvA7
         cwC7a72bdIp+wXCETsxM7NBroPhhgfUgFDzU4TJTsPZD7XI9TosvhAovMwAqSWfvnscV
         7wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733246192; x=1733850992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfz7EKDAPFwQQLg5EGqOmoY87z8R+/d21HRHaU4rMP8=;
        b=Rq6YhrVPpC6Q3Ere5665C7Uhc4GIaFwglMzZBLXCvB/1UhTLJZV7cjneMMO7aguNZ+
         MYgk2X3EJD1/CnhDeQPglpL5KfzMCUhiwCjdfx3OZ5EDPHK6jJkk+2VRyoqm9qRK9DBa
         UtndbJPSxfj11dgxezxdZrolDyaP5S76tJhzDYjpXz42UUr9k/315+MU3zzwUqJBf3bE
         SlMIV7rtFyHKOU/SsRnbp6wC2f5BXpm0bmjCXfp1atPwdlIjE3tCDVWGOxbqf5h4cwaK
         i/DXIzEn6DLLcH2cO1Q4msCa9Mmi91exXGGFeTxNz9fX2fkFMpJMv96lmFjx1n85VqYg
         NNZg==
X-Gm-Message-State: AOJu0Ywh3qgCN4JBoRTmP+h68HxyyS9QLHWQcAPewVuFmWQ33oq8jbpt
	HeKtcvH+5AdFVW9fZa+bEhXpezgDV07tADmKuizejt9XEFfoBNDUb7Wl5eN5rB32FxQ94xQSFJw
	GORg=
X-Gm-Gg: ASbGncv4xw4QYALX8tpdqij6i2FKHqTXudvGFzWguhNZpuyD1FC1HJSW7DKMUtpFTlS
	K3mH+5NhrhINSBT63jkD2D8siTQDkuT6HKRgoAQgGUa8/rZGcrK+lihN6D4d9dhNRQ0hMqGJPFQ
	T/vzA10HX9O3VmrK2nMa3v6BHHMNc6lF1qz5B6hM2JCHZV8jugunCiRR7LwfsQJUgHXUcN/IAov
	zrhEN8LAbhRgdHLj1qTmgbCf86LXRaUKjhVFg2t6VDS6ajUJ5aYc+ZeL7nmZ1aVqNWoerAwkehB
	RUmy
X-Google-Smtp-Source: AGHT+IFoPJItQ+VTXRbxuqQvrsK7cTv/Gk/LwLMIXuHO9GbWZUw4c7hfqi9jkofbnT9ohgu7PhAUAg==
X-Received: by 2002:a05:600c:35cf:b0:431:52b7:a499 with SMTP id 5b1f17b1804b1-434d0a07e76mr27423905e9.20.1733246192302;
        Tue, 03 Dec 2024 09:16:32 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70cbfsm201776645e9.36.2024.12.03.09.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 09:16:31 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/2] pwm: lpss: Define DEFAULT_SYMBOL_NAMESPACE earlier
Date: Tue,  3 Dec 2024 18:16:15 +0100
Message-ID:  <9f0e30c514a846aec72655a52deaed276467a07e.1733245406.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733245406.git.ukleinek@kernel.org>
References: <cover.1733245406.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=MLx0HXKyXXM3y8y6+2+1z0+USh/AYD3UzcwSVg7LVgU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnTzzjtz/i8uKDCaiZ5c+ovGLZgu/IacX8+/opL x1OD1Svgb6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0884wAKCRCPgPtYfRL+ Tgr8B/wPprElJIbn9hU2u8ge4/4joAnkRmi39mrgL9oAOALP10H1RU8YfBaKt+whiS+3yypEWim vywS1F5ffhpg7KNG3tPQEwUTVM96cbL8ixlxatbfd9TuPyyDOON66UAXrfhO+1NP5xhMlWs5yLW GihqvnoS8cuRVUg1ErOTFGnnWQFVydOOxhLkxnR0uyybJTwtCqmPAYSig7lPrOMoYNDr/ogNzCX z4xzdCXbMYRGY31AQbQxUASQLyKXMI9YT1gcFXcWf8L6buwaagskUDKRwljaONoopVj6pog+PPh 78gNU4tnH81CRyWXaVLzAwrx8cTByxLT9+KW5zy2idk3u0ab
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

DEFAULT_SYMBOL_NAMESPACE must be already defined when <linux/export.h>
is included. So move the define above the include block.

With the DEFAULT_SYMBOL_NAMESPACE being defined too late, the exported
symbols end up in the default namespace. So the modules making use of
the symbols defined in pwm-lpss.c can import these just fine and just
import the the PWM_LPSS namespace without any gain.

Fixes: a3682d2fe3c3 ("pwm: lpss: Move exported symbols to PWM_LPSS namespace")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-lpss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 867e2bc8c601..9519d1b06869 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -10,6 +10,8 @@
  * Author: Alan Cox <alan@linux.intel.com>
  */
 
+#define DEFAULT_SYMBOL_NAMESPACE PWM_LPSS
+
 #include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -19,8 +21,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/time.h>
 
-#define DEFAULT_SYMBOL_NAMESPACE PWM_LPSS
-
 #include "pwm-lpss.h"
 
 #define PWM				0x00000000
-- 
2.45.2


