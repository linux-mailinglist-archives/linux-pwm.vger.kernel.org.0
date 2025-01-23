Return-Path: <linux-pwm+bounces-4713-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD35A1A1FE
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 11:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825BD188E34B
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 10:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B2E20DD63;
	Thu, 23 Jan 2025 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zrkT/tFB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CEE20127F
	for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2025 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737628796; cv=none; b=h6x7wYBVc5KiUj77d2kNjm3G26kmetZ6i5eT/GNj7TV92USGkGGt1/zxEP9UzO1cFhwicz79Lq6/A//H2B6pnp37Fmi0DU9H2ir8n4qJ6/gLAxxiq61K2+7q/iDE5JpY/yoyWQT8zCOeL+X+EiSD+CGhSNx2hQBFglCo4HfWfkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737628796; c=relaxed/simple;
	bh=UDIJXnlGyGEROu3FJMgJtS6rA5A6esq9k45h6yBULwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IsFbiaJ8pl4EKOimWiqT3JVoD7Gp2V+Fcqo2xXOtG9NHtIQwrIwSCfPOKCa7Qgr392Qa6NOyVlkIoeskYXokFv7dCeoEMqKApk1MvXWJ6kc3ioKlMr4OTpa78ZsrYdoTph4dKJJMiCOWqyJYOgX6xCcb2SWr9gn41YU8xqfbcPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zrkT/tFB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab2e308a99bso154373766b.1
        for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2025 02:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737628791; x=1738233591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=95I7VYNZlNdmyZTDT4VHYGGqTjLg7esPz8Q75pVXZjE=;
        b=zrkT/tFBjUaYYaZVTG5tXxFDVGmivj/lWMzHL8dkvq+WopT8hg8wvU9magDzKB5YsW
         8W8LNBkx1jzsqJxlbWFBdXZhCs+YQPrZePhiO/YFMA9Ien+bdrDCBORa/UBdtIN/nro+
         pju5pLercBLFYjJ79JhwcdxuY89uvCuqsdYfRruZbG1YuVOUPjUtORcX6WoODv4fkpvz
         4KdtdgMORf/DE/qbn4dbS3CJ8+iqwbIHJN/z2adRY+ANt6UPw32swlPKPXcPlUJagYd0
         BlQoW7LgM9qOWga+XpL2vzreDFMfr/ClhScknhmtZh5hJF05wdPIPmI+pJQhrHNU30kA
         a1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737628791; x=1738233591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95I7VYNZlNdmyZTDT4VHYGGqTjLg7esPz8Q75pVXZjE=;
        b=hOcGV2o/NQbDbpNEhEW/tHTCL23AehLB9cz6IEuqe5F/8qNjxsFTb9ZQIDAVm/HbeR
         Zb/kyRz3JTNSKkDYk4jiDTwaoDoE9zaOnch/f8iYCpOKMkzpbyge325Fj4vcpKU8r0ZR
         c9WE8nZtjkqyt3jPbyuEZPRHX8DICyJJXq34H2E3ohuLmXdfEqfKEzxzLrXHQSxEUprw
         4qjLIl/y8hlnWJkVCVViZ6aEft/dMfCJXXXZxJbWY8/r4zwWlNXzKN6Nm7lRq0IDI4x9
         zo15CJUBRhiberbzvg97QgxB9yls+rtCxt7N5ilkA0AP00Jf3a+qxNS32jLIeflAYUwl
         xP6w==
X-Gm-Message-State: AOJu0Yy65QabqDYFaHWflHmMXJbRNhigHvRkNIMvSwqzeDsQs5HJjanp
	Enm9quhPEWkdItfbFKIhMe785e8j1PPyuSSR4YAWaYuQ6qI1KdoDRNcRv+CTTwU=
X-Gm-Gg: ASbGncu4unOW+MzRqTaHMOH9NZ5Tn1BvIuj79PjHtj1uB987bvIPYvFlqIHxeCWwr4/
	Nxn3EJYDcR9pZVGRhGFxwlNdPJfIXA0isKPwhhUZ+XtsPfW3WTc48sSTmgLb/omHwBHUzlj7Fbl
	sqwU7q3Yu2iiCDPV8mpejORLAyfvGkcre4wS4Q4SvEgcdqMiqkSWWlxschWiu/weYKiA4bQy8p4
	CWl94Fu0ewepPnaa9DaocAJ99uNYQpw71ulCh9RM0FOSmqcr7Mf+VVim9bzx4Wj5m1XkK1Vkvs+
	3fNINbHSkG8UEe8z28sR08JKGFZm6ifE7HHeAasuV87bMm4=
X-Google-Smtp-Source: AGHT+IF/ckUl4sAuvsuPGjQmUkgTVDMA4yqwUOM6UibQdzWmyL2vhH3DNATpA00kWy/1SzqGLX2Z1A==
X-Received: by 2002:a17:907:7291:b0:ab3:a515:c41 with SMTP id a640c23a62f3a-ab6629c61f6mr225252466b.16.1737628791351;
        Thu, 23 Jan 2025 02:39:51 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384c57034sm1039856166b.34.2025.01.23.02.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 02:39:51 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: lpss: Only include <linux/pwm.h> where needed
Date: Thu, 23 Jan 2025 11:39:38 +0100
Message-ID: <20250123103939.357160-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=UDIJXnlGyGEROu3FJMgJtS6rA5A6esq9k45h6yBULwc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnkhxrRra3NIIjwucWIMl4/ZtN+GXfRt9hbaYAs NWjTYfzCkaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ5IcawAKCRCPgPtYfRL+ TkEnB/41Oac8LkZweJRXtPE5W5ulfeO1kdUstczkH2w2xrxUHGeGOIrAZWSMupjb0Wf2ssITYYv aCLeUnTJEKv0xnf0fdyQh30nywykQZbzOHcXcmGbjLVoEkfH2V8TvffjqiQ/N97Q+LUUhyHlg+u 1fOAyQRg+OkEWiwc1+QBUd8wZSJ/ux9sAZw/nn8vfAgbNOMYhS+6T5Wx5oYrXe7qQno9k+/8mMy shTPcs7mw7AbFY8ZJtVTwqr1AHYciCyPr4QwkHUIH6DtwfMrlkbaiQAYPott4DDMBICNiSmjUkv 51ktRc+RSmEgGgSTSM4yg9slABxHyQB4ZXOt0a4iN6aQjZEP
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Among the three files that include pwm-lpss.h only pwm-lpss.c actually
needs <linux/pwm.h>. So move the #include statement from the former to
the latter.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-lpss.c | 1 +
 drivers/pwm/pwm-lpss.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index e3c72ed7fff1..c976ff1c8ed9 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/pwm.h>
 #include <linux/time.h>
 
 #include "pwm-lpss.h"
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index b5267ab5193b..60792181401e 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -10,7 +10,6 @@
 #ifndef __PWM_LPSS_H
 #define __PWM_LPSS_H
 
-#include <linux/pwm.h>
 #include <linux/types.h>
 
 #include <linux/platform_data/x86/pwm-lpss.h>

base-commit: 232f121837ad8b1c21cc80f2c8842a4090c5a2a0
-- 
2.47.1


