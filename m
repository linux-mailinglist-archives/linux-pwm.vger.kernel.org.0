Return-Path: <linux-pwm+bounces-6495-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A628AE4F0A
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 23:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C503F17DC79
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 21:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C50D21CA07;
	Mon, 23 Jun 2025 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQsADnD7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5531ACEDA;
	Mon, 23 Jun 2025 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713113; cv=none; b=OIzdBtKHIzcPUC2gXMPEU/cxWzfxknYWLzn2ADCAZpwqsmGWkKA+a2IxuvNDjR/1kMGFKKcnw8uwBapppBYcH7LtR+3nw3kQl2CZKbhL2kRrPiH5APzD8qVsIqug8gWcdydppDX5P8/wY+ZIgOw3lCP/IaFR5YITS16iU4iDVXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713113; c=relaxed/simple;
	bh=uPnVeVt+hHs+H/oH4gdzgcI3DPgjxO5uOWh4F4c7HCY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ub0A0S7Vg6RFRF20mMCHAqL32uFCY/0R2OTSWEutYprlWYSmGQq3T+adp0WvZk5YeYF75pkXpB98V6bL2D6pvKr1rTFuICVxAU+tCGAwr0d5jSNRmaIkFweu/hUYgP8annBb4sDsNsJHBrxtKN0MRC5CQ6mxxd4Bwttwl2DifQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQsADnD7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d6ade159so34648665e9.1;
        Mon, 23 Jun 2025 14:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750713110; x=1751317910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=l++fKgL5huPaU0pKHzuzywcbi9ZHLOVxESs5GUdAg84=;
        b=FQsADnD7VqN+j3EFMbXkeS+o3OBSXrYEjLBauRQWG7+C1ONwE5cBUT8T3+BfQVXNjV
         nvSbHuKEEBjMitWTTCa9Tx+WnMifkmBCOO+JiYjAukuO8y10sgHsahpamp89D7dUf4YL
         gKcEoYKBckCypFU4Bj8m8rWxxReF+Qs4UgoyVbXNdlAYPcrKQDQJtw65qLLXvSel8nHL
         Zy7pBEQaT2e72LlPo76u5xNURpMiOZlnUG4qSFYPuxjhWJWWhT06iXe1yLq4h5hI8IEs
         kYh9Sc9W9vn4D/qMWgTrhrvJbNZEB2yPWi5W3s93xmCeyPiZWleXD3AldzmfH3lgFNCR
         ofvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750713110; x=1751317910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l++fKgL5huPaU0pKHzuzywcbi9ZHLOVxESs5GUdAg84=;
        b=r/H1g6rln6tQFh+U5FeR8ks279OpZDo6CGjtp+jwVViCYFeB8HlWiM39dY/2WjwldZ
         kiU/1i5O8JWEulwgY2Y4ONeYrgWyUxZ4REqr1vDT/CprYnk3fQ1RY/wqxsOEZKLVJnVS
         FV7GDNdAGltVjWMQPaCT0xX8mdJOS+coKYXAB1McGhuVbampzHrIMhDC4JTCY8Q/TOmm
         3J/i5o2QxM073E83DK5UmokfCSP2krEXq2dqzqopLq7k2JhDEcfVm+RNBuK9eIY1rdYa
         qSHxyJFZRA3zP0IYwT4eDk+2cKSNH9h5Y9WZKn9Ot4PYHVCndcibhftGi2mKS/nIZKAB
         5KhA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+pl93n2GB6t/RRSzmLZN6GtgD8zrqxOHX4FLSJ4VWs4QlabsEh71t5kzuwRx+9M7S9Y30SgmIrWfrfo=@vger.kernel.org, AJvYcCXvzK8octsAfr1R4Sua+nkhZOI5Kd2uzfV+aUiabxGiIBeCtuMhLYUpRNimgCm9AKcAQAU8IBo4jfNl@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi1shbhyyxHE0UtpB16301mDuvjTIgpz0LIAT2HUpmIuR925ue
	DCyL/Z+7Gp8RLicIiv6KdNPOeS6F3xj3+91gesWR2iQjDE2EPDx53Eym
X-Gm-Gg: ASbGnct2TWwKpfwwTyCX8OG5Ku+B5hpOkAINvLobeSK/grp5ENpom2hgoaC29RR5q1I
	Dp3NyeRvBEXNyz6pbFHtJpW8e6eFOjX7L6bLdQNKOmnR4oBySn/KnRIGCm4DBkEXzFgo0gyuDmH
	DsSb4CrohHQFeId53eEbiiK0c4qiHHAwQ07pBL4um2KmeFFuuvadq+O6X+fku9O+J03/mHvMxSZ
	9RV/JevOBKT4DqdRNJwPOe8PQ6/tcnhDWJx2Ba/3iuSLauRJqRpqLWe21mJeipYzN3IfbdX8o0d
	8Zo7/3OsnNuEUaeFfkIy4UllDPZBYQ3yqTXDjmZIux28Pmx//rW3/u4l1g+clyrnEiI364lHum7
	WIa9t1isAGNjfoXc0zlHl+H/f2V/7WkW9WgrNwsllWQ==
X-Google-Smtp-Source: AGHT+IFRtHSyRQq4zVv8EjUjO8HsRbU6zGbzQhBrFvqPDSoxCf6AGtB7W4O6XQhWqYQTq5c+nMecSw==
X-Received: by 2002:a05:600c:1da0:b0:44a:775d:b5e8 with SMTP id 5b1f17b1804b1-453653a2ee4mr135199815e9.1.1750713109779;
        Mon, 23 Jun 2025 14:11:49 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45361461375sm138599055e9.14.2025.06.23.14.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 14:11:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v15 1/2] math.h: provide rounddown_ull variant for rounddown MACRO
Date: Mon, 23 Jun 2025 23:11:12 +0200
Message-ID: <20250623211116.1395-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is currently a problem with the usage of rounddown MACRO with
u64 dividends. This cause compilation error on specific arch where
64bit division is done on 32bit system.

To be more specific GCC try optimize the function and replace it with
__umoddi3 but this is actually not compiled in the kernel.

Example:
pwm-airoha.c:(.text+0x8f8): undefined reference to `__umoddi3'

To better handle this, introduce a variant of rounddown MACRO,
rounddown_ull that can be used exactly for this scenario.

rounddown_ull new MACRO use the do_div MACRO that do the heavy work of
handling internally all the magic for 64bit division on 32bit (and
indirectly fix the compilation error).

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v15:
- Add this patch

 include/linux/math.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/math.h b/include/linux/math.h
index 0198c92cbe3e..1cda6578e0aa 100644
--- a/include/linux/math.h
+++ b/include/linux/math.h
@@ -88,6 +88,17 @@
 	__x - (__x % (y));				\
 }							\
 )
+/*
+ * Same as above but for u64 dividends. divisor must be a 32-bit
+ * number.
+ */
+#define rounddown_ull(x, y) (				\
+{							\
+	unsigned long long __x = (x);			\
+	unsigned long long _tmp = __x;			\
+	__x - do_div(_tmp, (y));			\
+}							\
+)
 
 /*
  * Divide positive or negative dividend by positive or negative divisor
-- 
2.48.1


