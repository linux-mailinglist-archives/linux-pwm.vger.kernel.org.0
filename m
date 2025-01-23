Return-Path: <linux-pwm+bounces-4712-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AFAA1A198
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 11:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E3A3A5B4E
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 10:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E46420CCCC;
	Thu, 23 Jan 2025 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="feAfP992"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AD020D518
	for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2025 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737627092; cv=none; b=oGeeddvc+hkAXIsnR8zXJNu5mY91MpV+GXNdYUem2zv8Cp+6lxL9XDQH75rZNQvS2F1KTLXXELGzJL9BaaRG1a0Ces3iYKLsj/SkG+qjvAe2OJb8EwOtkH313TAjUEQ9rD2vOQoWqVUa5UUk6HOn4I5gDDdEtozmbrFO6NZP9m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737627092; c=relaxed/simple;
	bh=ge5RZPhFn6Hcr3DnmwhCinqGK8/TCxIYXiyA1B+aOEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rN6ae/xgQCKaCPULGfIl86hOmwNL+ghXwGf/d/1aOBmcEYokqGYlk7n/PU4HtKAExKBqDGR4+MvW9pEgHjTn+cZtZ/YqH5BWf8a2NXmLDKZyvja96GnGwDZjSui9lbtq5iV4uY1NKrXFSRbdbr/0bDC0+cFm3LxLkj1az3VWvFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=feAfP992; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab643063598so117243866b.2
        for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2025 02:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737627089; x=1738231889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDSygjJeffviRVz32nmKe1obDDR2MaeUIVDMViuQtnM=;
        b=feAfP992njb3ze0l3HEfMSOMiDVpwW6oZTJRkuMkRneOSAFRtdoGkyvu6OQqZdMIa+
         kKaw4B6UiIP+CauUWNvvSOCyFNUyeqT3sFyC7H5aGfGNcihHkbb005dmttvXuCeHLieT
         f4IMiBaP/7DoyNBxTyhKZgUB7Qw0Szb+zsTc/ZK5oXYcslHEQfcnSnmCqRL9GG/pEGbn
         GNzNgcT7OAk2ZUjsvhhAv2MRRZZCcEdjstMZvCS4vGGCGlgzWTpNJOCYaB1bEWMsnnMs
         M7SxA5UkFr3ZCRm+smQUVPiNlwtsIrWVEguD3pQudZE4L4Xc2QOWe4iHhlPvBkFcGvhG
         TLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737627089; x=1738231889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDSygjJeffviRVz32nmKe1obDDR2MaeUIVDMViuQtnM=;
        b=cc4mOF7PzxLr+aN6q4vmuu49pDm44B6rSW/y6ywfy9VQpU/A0GOCLscchR07TMZnYn
         cBx3ja9mZwaspVQUrpxmo9emSdp1gAmbnckaXHkbahqmmIA/PWHahUix90wMqI26wQHz
         bW4SJE+SMRexZVSMV922NIxgmw23vOBlwCjmrGyDhfkewVPI9sZIGj02k+7KDgB/YL0v
         fbWI+LVng+7shwOfi+dbrSl9zsBFDulPvp2swZF1jTBMLmc3wGLFX8UtbeAT6GsLf5Hn
         iBxDO9HoJgxUen0Rbi6XRjsWd684p4AKyKNV3bF2qHeNATPqbtsxKojnVyHhP71FsVwy
         UKVw==
X-Gm-Message-State: AOJu0Yyo05pDnXUmcFumNyeP4oCZgOXk/4BX5Mf9C3MTYjgUdFPitn0O
	QicDYfXwaoH4ZAM7dy5H4luc9xln/1a/sUaMAstKpzOCPn8YIYOUiZniVjsydkPLNHWHvFJQZdX
	CJ7o=
X-Gm-Gg: ASbGncslU3dWUNaVi257vcBjTbPubNO2fu5ucWTsqdAy+HKGtWWYKrb7VX1upgO678w
	+e8Fa//OUQKtrmZhT8zbAFyIiQio6q/lIWZBQ0PKx7UxtofPv6mFJ35+Ild7bcRYHlMR+kYkt3t
	C8Pq3JyluDdGaJqaZ7aU7AKVmWi21PEo87maXxxljbcqQBO0hmdUzgOt7raeRCdSeGrUGIT2u05
	n9juFRRWQBp4Gv8NAtmZOsHKGR9itSBfKNdRsqLFlzQbAaz6iWpYmrbw+w4F3FHveNrRhn2brmp
	KpaUyx4449tKsZxB7pgGz7niNfpr4gJqBhKcj5tirbEzLiY=
X-Google-Smtp-Source: AGHT+IEiej3kjVDey0/11bFdOMpCs7p8PGomthfxPt/dN2T0bi2hgs4WUw15UFfYrhjy0ehbGWhbuw==
X-Received: by 2002:a05:6402:2745:b0:5d0:bf5e:eb8 with SMTP id 4fb4d7f45d1cf-5db7db07846mr56070171a12.23.1737627089376;
        Thu, 23 Jan 2025 02:11:29 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab3999638f8sm910761566b.9.2025.01.23.02.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 02:11:29 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v2 2/2] pwm: lpss: Actually use a module namespace by defining the namespace earlier
Date: Thu, 23 Jan 2025 11:11:11 +0100
Message-ID: <20250123101110.339337-6-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123101110.339337-4-u.kleine-koenig@baylibre.com>
References: <20250123101110.339337-4-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=ge5RZPhFn6Hcr3DnmwhCinqGK8/TCxIYXiyA1B+aOEc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnkhXEMeBkwVZg1JtRb0pf4s1xa0sEugu8VXh2c /kPn9ufwkmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ5IVxAAKCRCPgPtYfRL+ TlCWB/9BY1S09nj9M8vyPnpMotgSrqWnvT8UyXK3XKHs6Cgolb/W8ALXQyBYVu1Zgw2l0Fqpvin R7CR1tJAjt2jo5qDoHbpTyH9UJ5CTMLKt9psY/LOJfCLgC9CFZypJeNdWyr1QPYSNVtxzjSDvNM GOps/0lbUB4PNadV5+XSCYrDh+n+Nt9DHkIRdCDbynk2IZS64aKkpkaOkJU/0Q5yojHFW9zYuoa NkXDOMB2G3Kg+4OE+fhxZYmi1lHd57Fp6lHVuAFUT0MteKSEDiMjGfmQPE/Po0pJXMqyodPf3f2 Dp5k0kmlYFRmZnIK1kxjCqKrq21U+VK90ElgvWp/lakYEAFb
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

DEFAULT_SYMBOL_NAMESPACE must be already defined when <linux/export.h>
is included. So move the define above the include block.

With the DEFAULT_SYMBOL_NAMESPACE being defined too late, the exported
symbols end up in the default namespace. So the respective modules can
use the symbols defined in pwm-lpss.c just fine and up to now just
imported the PWM_LPSS namespace without any gain.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-lpss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 3b99feb3bb49..e3c72ed7fff1 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -10,6 +10,8 @@
  * Author: Alan Cox <alan@linux.intel.com>
  */
 
+#define DEFAULT_SYMBOL_NAMESPACE "PWM_LPSS"
+
 #include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -19,8 +21,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/time.h>
 
-#define DEFAULT_SYMBOL_NAMESPACE "PWM_LPSS"
-
 #include "pwm-lpss.h"
 
 #define PWM				0x00000000
-- 
2.47.1


