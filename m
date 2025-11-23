Return-Path: <linux-pwm+bounces-7679-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F45C7E985
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Nov 2025 00:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B765D4E026D
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 23:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F3321D3F2;
	Sun, 23 Nov 2025 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWpfoXA0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ED51CEADB
	for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763940377; cv=none; b=CijwZXsOc7RhoKvFY0V6IiyeT/Ueifi1EiZ3vcuirS55avxnzSvNUoqyZRwlkS+hQckIPJ5Hf6jXZh76cv52q5wB5lsUHT8E9I5Hr+ud+WoDGzfgezJp7PFAo8H9qCgKtkpz9XpVso85KAE9CsAXaYham/GYVAxP2NDCbCio5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763940377; c=relaxed/simple;
	bh=I/UtWPtY+X50wzvYdVCygzQyeJyvIMcRz0qUUBbYIMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5W6FvYAMhIBtY4cbTxiIen//2zPjVYUZrLo1+Nfuw2wyucovxHdnP4UMYs6EIQ4VwZ8+T7HN+mY4BKaFxwkGiGXV96Ds0acXAI0G21+uXUzRuQrqyAodI2WDftwpCoFIFSs572ZHtXGTPnm75jOjVd513wZdBe0kYWkzNzxegE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWpfoXA0; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bdb6f9561f9so579943a12.3
        for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 15:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763940375; x=1764545175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6bsRlmSk+6I1szKDpWgeU4O4J3rwVrH3MMu6SJtfBc=;
        b=JWpfoXA0KYnRdQVaGdMWL1C2JF+3YhodVog9pE2A9kx3pvJ496fDZRl65NG0oqhOLs
         v8IgQ2K3rwciP+K9a2SIhfKHTbMUzNmEWix9wvdv/Q7HoGvXn9LMMe4pjLHlk+25nrIA
         U8PU5Oku5cZJbYjqXAbuB2wEJ84qb18dPU9yRM+gGhH9hRVsOKV3sQkCtwhjSbA5QzY+
         TOxAMOckBVOcGJYYoU7HC2U44F+K/so3iWvj1o55fdu4Is7PkZJ7yAYUJT8hUYU1W3iX
         Uy8GRTX+w6RJT0mGwjckn2EMU1DypQjHLalyXh6PKJtvEdpwHSLbErQTmutVmBAUd+By
         ytzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763940375; x=1764545175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e6bsRlmSk+6I1szKDpWgeU4O4J3rwVrH3MMu6SJtfBc=;
        b=ktRir0fVuKM0KbRSBa+OtMrWn6L47Ju6goVhq1wlSwct7mOJGkS2NRi4oT/GvtYvqw
         HodqIrbc1vm1car76yziWqwcOKjT6ewe0F9wN4I52gUNRYlEjub+JX0gnNOUL7t+yaIg
         Jolfg3LXTdc25aEMzMSYAwyXGotbNsgIBzYzRRxCKjHXuSsTZxt9r1NdsGjEAuLD5XW/
         OmthZ+Xzib1qyxH0DxAyD00oNcDAh7SyXhKrXkMye3XjhK87Bz3Yc3+RwuE9Sj9pUmhF
         NITdVe1spwUEwiruNIZ3TvjmtsOpFNLMD4eHpN+vJiMDlvS//vhg9vKg/CtDoyO0TzAM
         O0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXpYJAv03wHxHlWaF2j+ly7mQnQBk8hKNRv1qptUvah/Dg2Fo45cqr0LEmWY7HkO7R/sDsJZrHEU6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3fOSrKFnAorlcsYf+xTIwDM07pYlz5ZktApQjU/WRLHSXUSFB
	jfcizLwjxZN+E6RAlzAgqRiRPz0KQy1yPDqfSaI81hfm7ixZE4qhibgHVk50dQ==
X-Gm-Gg: ASbGnctLMD8uBb+HPYohgu9HjObAOA4/a1/6WAIRv9kg053ORR5wDz21jhFEWcZsIyD
	YZL+XjDnim8KeGuG8KCmdcn3ME5mWzKqDD+cqbFV4j3jzUrTA6RcVBQVXWoUPSpd4V5dFpM2FQq
	4y+wIYOjpYLozcnnzRX9QaLB4i8Yjr5lHJJbgffpX097w0+D2uFpfSL09dLuaPyf7RHfGX35jg5
	Wi2NkYvbcy+NCej58iHrNLY0689qn2Qke/XuImwaAntlnkyKqDUiIh98dli3X3/o6HK4X89ABue
	fygCP6OparvwLDVTV6r8Ou9sehK6YXgNwllyNgD9EPWvnaXwigmvJjzdp3caivkOi9AIKfeXGq/
	1LqkhYZWbH9HUzIRov+KfBBz6NlXcMeeA0SMI5EoKTtKMzTwrUdUAEKghoqN980lXEiuQpBkxNu
	IF8qjkvH7Me2FJzArQMTMQ1GfEgBmk4YhR2CdwfTW5ZD4=
X-Google-Smtp-Source: AGHT+IHrU4TGfiAOPBOfFWACf/m1E1pEvsNN9LTuQjLKeWzkNkqxWHbQ1xKY696IdJFTjBbgzmAEwA==
X-Received: by 2002:a05:7300:7991:b0:2a4:3593:9698 with SMTP id 5a478bee46e88-2a719279d6amr4862186eec.21.1763940374852;
        Sun, 23 Nov 2025 15:26:14 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc5b122dsm46053201eec.5.2025.11.23.15.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:26:14 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: rafael.v.volkmer@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Subject: [PATCH v6 1/6] pwm: tiehrpwm: use GENMASK() and FIELD_PREP() for register fields
Date: Sun, 23 Nov 2025 20:25:21 -0300
Message-ID: <20251123232521.2039-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251123232029.1956-1-rafael.v.volkmer@gmail.com>
References: <20251123232029.1956-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert register field definitions in AQCTL, AQCSFRC and TBCTL to use
GENMASK() and FIELD_PREP(). This clarifies the bit layout, reduces
hand-rolled shift logic and aligns the driver with common kernel patterns.

No functional change.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 91 ++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 42 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 7a86cb090f76..d2151065083b 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -13,6 +13,7 @@
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/bitfield.h>
 
 /* EHRPWM registers and bits definitions */
 
@@ -21,22 +22,24 @@
 #define TBPRD			0x0A
 
 #define TBCTL_PRDLD_MASK	BIT(3)
-#define TBCTL_PRDLD_SHDW	0
-#define TBCTL_PRDLD_IMDT	BIT(3)
-#define TBCTL_CLKDIV_MASK	(BIT(12) | BIT(11) | BIT(10) | BIT(9) | \
-				BIT(8) | BIT(7))
-#define TBCTL_CTRMODE_MASK	(BIT(1) | BIT(0))
-#define TBCTL_CTRMODE_UP	0
-#define TBCTL_CTRMODE_DOWN	BIT(0)
-#define TBCTL_CTRMODE_UPDOWN	BIT(1)
-#define TBCTL_CTRMODE_FREEZE	(BIT(1) | BIT(0))
+#define TBCTL_PRDLD_SHDW	FIELD_PREP(TBCTL_PRDLD_MASK, 0)
+#define TBCTL_PRDLD_IMDT	FIELD_PREP(TBCTL_PRDLD_MASK, 1)
+
+#define TBCTL_CLKDIV_MASK	GENMASK(12, 7)
+
+#define TBCTL_CTRMODE_MASK	GENMASK(1, 0)
+#define TBCTL_CTRMODE_UP	FIELD_PREP(TBCTL_CTRMODE_MASK, 0)
+#define TBCTL_CTRMODE_DOWN	FIELD_PREP(TBCTL_CTRMODE_MASK, 1)
+#define TBCTL_CTRMODE_UPDOWN	FIELD_PREP(TBCTL_CTRMODE_MASK, 2)
+#define TBCTL_CTRMODE_FREEZE	FIELD_PREP(TBCTL_CTRMODE_MASK, 3)
 
 #define TBCTL_HSPCLKDIV_SHIFT	7
 #define TBCTL_CLKDIV_SHIFT	10
 
 #define CLKDIV_MAX		7
 #define HSPCLKDIV_MAX		7
-#define PERIOD_MAX		0x10000
+#define TBPRD_BITS		16
+#define PERIOD_MAX		BIT(TBPRD_BITS)
 
 /* compare module registers */
 #define CMPA			0x12
@@ -48,44 +51,48 @@
 #define AQSFRC			0x1A
 #define AQCSFRC			0x1C
 
-#define AQCTL_CBU_MASK		(BIT(9) | BIT(8))
-#define AQCTL_CBU_FRCLOW	BIT(8)
-#define AQCTL_CBU_FRCHIGH	BIT(9)
-#define AQCTL_CBU_FRCTOGGLE	(BIT(9) | BIT(8))
-#define AQCTL_CAU_MASK		(BIT(5) | BIT(4))
-#define AQCTL_CAU_FRCLOW	BIT(4)
-#define AQCTL_CAU_FRCHIGH	BIT(5)
-#define AQCTL_CAU_FRCTOGGLE	(BIT(5) | BIT(4))
-#define AQCTL_PRD_MASK		(BIT(3) | BIT(2))
-#define AQCTL_PRD_FRCLOW	BIT(2)
-#define AQCTL_PRD_FRCHIGH	BIT(3)
-#define AQCTL_PRD_FRCTOGGLE	(BIT(3) | BIT(2))
-#define AQCTL_ZRO_MASK		(BIT(1) | BIT(0))
-#define AQCTL_ZRO_FRCLOW	BIT(0)
-#define AQCTL_ZRO_FRCHIGH	BIT(1)
-#define AQCTL_ZRO_FRCTOGGLE	(BIT(1) | BIT(0))
+#define AQCTL_CBU_MASK		GENMASK(9, 8)
+#define AQCTL_CBU_FRCLOW	FIELD_PREP(AQCTL_CBU_MASK, 1)
+#define AQCTL_CBU_FRCHIGH	FIELD_PREP(AQCTL_CBU_MASK, 2)
+#define AQCTL_CBU_FRCTOGGLE	FIELD_PREP(AQCTL_CBU_MASK, 3)
+
+#define AQCTL_CAU_MASK		GENMASK(5, 4)
+#define AQCTL_CAU_FRCLOW	FIELD_PREP(AQCTL_CAU_MASK, 1)
+#define AQCTL_CAU_FRCHIGH	FIELD_PREP(AQCTL_CAU_MASK, 2)
+#define AQCTL_CAU_FRCTOGGLE	FIELD_PREP(AQCTL_CAU_MASK, 3)
+
+#define AQCTL_PRD_MASK		GENMASK(3, 2)
+#define AQCTL_PRD_FRCLOW	FIELD_PREP(AQCTL_PRD_MASK, 1)
+#define AQCTL_PRD_FRCHIGH	FIELD_PREP(AQCTL_PRD_MASK, 2)
+#define AQCTL_PRD_FRCTOGGLE	FIELD_PREP(AQCTL_PRD_MASK, 3)
+
+#define AQCTL_ZRO_MASK		GENMASK(1, 0)
+#define AQCTL_ZRO_FRCLOW	FIELD_PREP(AQCTL_ZRO_MASK, 1)
+#define AQCTL_ZRO_FRCHIGH	FIELD_PREP(AQCTL_ZRO_MASK, 2)
+#define AQCTL_ZRO_FRCTOGGLE	FIELD_PREP(AQCTL_ZRO_MASK, 3)
 
 #define AQCTL_CHANA_POLNORMAL	(AQCTL_CAU_FRCLOW | AQCTL_ZRO_FRCHIGH)
 #define AQCTL_CHANA_POLINVERSED	(AQCTL_CAU_FRCHIGH | AQCTL_ZRO_FRCLOW)
 #define AQCTL_CHANB_POLNORMAL	(AQCTL_CBU_FRCLOW | AQCTL_ZRO_FRCHIGH)
 #define AQCTL_CHANB_POLINVERSED	(AQCTL_CBU_FRCHIGH | AQCTL_ZRO_FRCLOW)
 
-#define AQSFRC_RLDCSF_MASK	(BIT(7) | BIT(6))
-#define AQSFRC_RLDCSF_ZRO	0
-#define AQSFRC_RLDCSF_PRD	BIT(6)
-#define AQSFRC_RLDCSF_ZROPRD	BIT(7)
-#define AQSFRC_RLDCSF_IMDT	(BIT(7) | BIT(6))
-
-#define AQCSFRC_CSFB_MASK	(BIT(3) | BIT(2))
-#define AQCSFRC_CSFB_FRCDIS	0
-#define AQCSFRC_CSFB_FRCLOW	BIT(2)
-#define AQCSFRC_CSFB_FRCHIGH	BIT(3)
-#define AQCSFRC_CSFB_DISSWFRC	(BIT(3) | BIT(2))
-#define AQCSFRC_CSFA_MASK	(BIT(1) | BIT(0))
-#define AQCSFRC_CSFA_FRCDIS	0
-#define AQCSFRC_CSFA_FRCLOW	BIT(0)
-#define AQCSFRC_CSFA_FRCHIGH	BIT(1)
-#define AQCSFRC_CSFA_DISSWFRC	(BIT(1) | BIT(0))
+#define AQSFRC_RLDCSF_MASK	GENMASK(7, 6)
+#define AQSFRC_RLDCSF_ZRO	FIELD_PREP(AQSFRC_RLDCSF_MASK, 0)
+#define AQSFRC_RLDCSF_PRD	FIELD_PREP(AQSFRC_RLDCSF_MASK, 1)
+#define AQSFRC_RLDCSF_ZROPRD	FIELD_PREP(AQSFRC_RLDCSF_MASK, 2)
+#define AQSFRC_RLDCSF_IMDT	FIELD_PREP(AQSFRC_RLDCSF_MASK, 3)
+
+#define AQCSFRC_CSFB_MASK	GENMASK(3, 2)
+#define AQCSFRC_CSFB_FRCDIS	FIELD_PREP(AQCSFRC_CSFB_MASK, 0)
+#define AQCSFRC_CSFB_FRCLOW	FIELD_PREP(AQCSFRC_CSFB_MASK, 1)
+#define AQCSFRC_CSFB_FRCHIGH	FIELD_PREP(AQCSFRC_CSFB_MASK, 2)
+#define AQCSFRC_CSFB_DISSWFRC	FIELD_PREP(AQCSFRC_CSFB_MASK, 3)
+
+#define AQCSFRC_CSFA_MASK	GENMASK(1, 0)
+#define AQCSFRC_CSFA_FRCDIS	FIELD_PREP(AQCSFRC_CSFA_MASK, 0)
+#define AQCSFRC_CSFA_FRCLOW	FIELD_PREP(AQCSFRC_CSFA_MASK, 1)
+#define AQCSFRC_CSFA_FRCHIGH	FIELD_PREP(AQCSFRC_CSFA_MASK, 2)
+#define AQCSFRC_CSFA_DISSWFRC	FIELD_PREP(AQCSFRC_CSFA_MASK, 3)
 
 #define NUM_PWM_CHANNEL		2	/* EHRPWM channels */
 
-- 
2.43.0


