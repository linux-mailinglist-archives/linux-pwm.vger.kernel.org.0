Return-Path: <linux-pwm+bounces-5583-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233E2A94554
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 21:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C43178026
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 19:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D751DF97F;
	Sat, 19 Apr 2025 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGsoRE5B"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE89E82899;
	Sat, 19 Apr 2025 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745092144; cv=none; b=u2454RBQLOdpkP3DGV5Kw/E3j8BXeuI/aB6MwXsBRuNOj4mH6BOWfl8l4GRrHXudQZ8NgK10X/xGl0j6n7k5l8Qv8H5i3pK16e99YTbJpS7pK5Hzs9tMRyF3DELqeX2qMeMR3MeG9TEJDHiAfOSuLeJRODK32t/uljmCaZ8SH1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745092144; c=relaxed/simple;
	bh=QS5T6F1N+NeR7iaJ0ybHQhmHCbJrpyvuZnRXWNGBiHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDLnxXX1tlTJhL5xznfQ3SiOFsZMaR+hDdaDuI+YeNAydT5uGcU6iBuUTzVuMcsGlrJD48PWwQeTqO4REo7XaNJObsReF9ZqZhhbtfVqKUXqWXhT+X8SS+TkYOQHJovHc5MOyqKos/eDdK2tqaH/JEgUJj0XwHASlvtVGhUmAYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGsoRE5B; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so2606038b3a.2;
        Sat, 19 Apr 2025 12:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745092142; x=1745696942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8qyQy1Np6oZ7Um7nNvrc/fX1g3K0FFS9eeSqMfkl9M=;
        b=UGsoRE5BO8juHJBkfmRaCLT8JuY/mc3Xrt3Qqcw7vZm272r71dcAP73N/Fh3pOPQ7F
         KdUgS/Jfi34ICPqkpZicXTHtMWdHWu0HzV2V/+iLtVRm+HnrHvi+rhEtviqmh1Q9BzIY
         61SxSo9JMipgiGEJWYX7guUFbXnGoK59Azr1IayRkxtPVsSjs+piI1/1FMy6UeCvaX3Q
         QZuI+uswmaDddHwj99ZZJf+kUHcUWVxxKleb7gAw4Hrvd/6T7ewZwIj9Y+NzzxtFV0TC
         nDRZGtktT07ueauBGf0/Yg8oF8OMuwWm2v+lndRcSrew3wygrSXiwPbdTmifVCX0KNWz
         NEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745092142; x=1745696942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8qyQy1Np6oZ7Um7nNvrc/fX1g3K0FFS9eeSqMfkl9M=;
        b=cqKFtsN3kUo4Nzu7iQ3rd3yTZYSlNzY05jKalJg5XljE3HmDCA34IjRfPFKEix8SoO
         yjvDK+c/mMHLYn9+HesJJ9nNCJn7rA4Dpr4P3sf1oX4aiHjIxORVSlTYcSOw2ZE0wvTB
         oBUeZdNg62QhNzOEjT4Ovsu9RUz0Rfm1rXIicNGcGrEWzZFpnCKGp2KzSf5qWX6QNrs8
         zEiFbt2NKw+Gt3SWzieeNlXSvw50X7QfkjAHGlZJgmi6zKTef2kc42Qg/KogqAvANS3S
         DEBtosB5a/hefHKxdFsCL/pjt8jzkMkShM4yIBQLYfMvXzk89JXCQeZhVbuHXfwwjBGx
         q1Bg==
X-Forwarded-Encrypted: i=1; AJvYcCX0X0uiAAld7gsojQIQGYs3Tny0nHeXIYCpQZ7+oC+ZtKKKkF7eygvsI3PNWbwaZtsOgFnqFuniH2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqcMx5SCXIscSzShtMQz98SdYVyani7gi3jzRm+s11k3fmPRgp
	Rb4aVS7wqW8+3DIZviG3TDcfXJnxSjF3n9B48wUYVaUjYAiRZban
X-Gm-Gg: ASbGncvVCfzenEVb3l2j9sgZ8K+F7DDOIxwN1n7tTNmCP+KjYTpWmPKyM4gU5BWDad8
	HmV7cp/oVxnEcVeaIqs9eY7O4HyQXw/5pOJg9Awwk+rL00eqXcWOvmoJVI4geqMLI/UvpZYckbQ
	MGcgxPvAi/z456rYXTjFVHOSGlYIQy+voHmI4r/lSFvu+HdKJR77hBER2W5WdXX402RRz376+aP
	kSSP8LHPBzjRQNvXglMhf/s04f4ICQj3qf0uMa+NqIMBw1Vl2Kv10TiLByzwMRfjAexI7L9lWo1
	ESIhlwEytJeHVhL8Xo9rVZPZXH1o+KqRvZVUWzyoMGV7jfD2HEdGx7bZvVIQ
X-Google-Smtp-Source: AGHT+IElaI/si2qkwqpPg3fUdfAqrPKSUb4kBa8BFoJYX+a1bH6g0vYir9eGr7VyZQqndw/1UgBv4g==
X-Received: by 2002:a17:90b:278e:b0:305:2d9d:81c9 with SMTP id 98e67ed59e1d1-3087bb692f8mr11162851a91.16.1745092142054;
        Sat, 19 Apr 2025 12:49:02 -0700 (PDT)
Received: from localhost.localdomain ([177.10.12.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087e05ebdbsm3463311a91.48.2025.04.19.12.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 12:49:01 -0700 (PDT)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: [PATCH v4 1/4] pwm: tiehrpwm: replace manual bit definitions with bitfield.h macros
Date: Sat, 19 Apr 2025 16:48:35 -0300
Message-Id: <20250419194835.77860-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <lhqi2eqfj5eyc67yriezvwwiyusenyohvqzbfrwjkjfjvxxb7a@xwvhrgmer4a7>
References: <lhqi2eqfj5eyc67yriezvwwiyusenyohvqzbfrwjkjfjvxxb7a@xwvhrgmer4a7>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Simplify bit manipulation by replacing manual BIT(x) definitions with
GENMASK() and FIELD_PREP() from <linux/bitfield.h>. This improves
readability, consistency, and aligns with modern kernel practices
while preserving existing functionality.

Additionally, update set_prescale_div() to use FIELD_PREP() for
TBCTL_CLKDIV_MASK and TBCTL_HSPCLKDIV_MASK instead of manually
shifting bits. This makes the code more maintainable and avoids
potential errors in bit field assignments.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 191 ++++++++++++++++++++++---------------
 1 file changed, 114 insertions(+), 77 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 0125e73b98df..1ead1aa91a1a 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -13,85 +13,122 @@
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/bitfield.h>
 
 /* EHRPWM registers and bits definitions */
 
 /* Time base module registers */
-#define TBCTL			0x00
-#define TBPRD			0x0A
-
-#define TBCTL_PRDLD_MASK	BIT(3)
-#define TBCTL_PRDLD_SHDW	0
-#define TBCTL_PRDLD_IMDT	BIT(3)
-#define TBCTL_CLKDIV_MASK	(BIT(12) | BIT(11) | BIT(10) | BIT(9) | \
-				BIT(8) | BIT(7))
-#define TBCTL_CTRMODE_MASK	(BIT(1) | BIT(0))
-#define TBCTL_CTRMODE_UP	0
-#define TBCTL_CTRMODE_DOWN	BIT(0)
-#define TBCTL_CTRMODE_UPDOWN	BIT(1)
-#define TBCTL_CTRMODE_FREEZE	(BIT(1) | BIT(0))
-
-#define TBCTL_HSPCLKDIV_SHIFT	7
-#define TBCTL_CLKDIV_SHIFT	10
-
-#define CLKDIV_MAX		7
-#define HSPCLKDIV_MAX		7
-#define PERIOD_MAX		0xFFFF
-
-/* compare module registers */
-#define CMPA			0x12
-#define CMPB			0x14
-
-/* Action qualifier module registers */
-#define AQCTLA			0x16
-#define AQCTLB			0x18
-#define AQSFRC			0x1A
-#define AQCSFRC			0x1C
-
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
-
-#define AQCTL_CHANA_POLNORMAL	(AQCTL_CAU_FRCLOW | AQCTL_PRD_FRCHIGH | \
-				AQCTL_ZRO_FRCHIGH)
-#define AQCTL_CHANA_POLINVERSED	(AQCTL_CAU_FRCHIGH | AQCTL_PRD_FRCLOW | \
-				AQCTL_ZRO_FRCLOW)
-#define AQCTL_CHANB_POLNORMAL	(AQCTL_CBU_FRCLOW | AQCTL_PRD_FRCHIGH | \
-				AQCTL_ZRO_FRCHIGH)
-#define AQCTL_CHANB_POLINVERSED	(AQCTL_CBU_FRCHIGH | AQCTL_PRD_FRCLOW | \
-				AQCTL_ZRO_FRCLOW)
-
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
-
-#define NUM_PWM_CHANNEL		2	/* EHRPWM channels */
+#define TBCTL	0x00
+#define TBPRD	0x0A
+
+/* TBCTL: CTRMODE field (bits [1:0]) */
+#define TBCTL_CTRMODE_MASK	GENMASK(1, 0)
+#define TBCTL_CTRMODE_UP	FIELD_PREP(TBCTL_CTRMODE_MASK, 0)
+#define TBCTL_CTRMODE_DOWN	FIELD_PREP(TBCTL_CTRMODE_MASK, 1)
+#define TBCTL_CTRMODE_UPDOWN	FIELD_PREP(TBCTL_CTRMODE_MASK, 2)
+#define TBCTL_CTRMODE_FREEZE	FIELD_PREP(TBCTL_CTRMODE_MASK, 3)
+
+/* TBCTL: PRDLD bit (bit [3]) */
+#define TBCTL_PRDLD_MASK	GENMASK(3, 3)
+#define TBCTL_PRDLD_SHDW	FIELD_PREP(TBCTL_PRDLD_MASK, 0)  /* shadow load */
+#define TBCTL_PRDLD_IMDT	FIELD_PREP(TBCTL_PRDLD_MASK, 1)  /* immediate */
+
+/* TBCTL: high‑speed prescale (bits [9:7]) */
+#define TBCTL_HSPCLKDIV_MASK	GENMASK(9, 7)
+/* TBCTL: clock prescale (bits [12:10]) */
+#define TBCTL_CLKDIV_MASK	GENMASK(12, 10)
+
+#define CLKDIV_MAX	7
+#define HSPCLKDIV_MAX	7
+#define PERIOD_MAX	0xFFFF
+
+/*
+ * ----------------------------------------------------------------
+ * Compare module registers
+ * ----------------------------------------------------------------
+ */
+#define CMPA	0x12
+#define CMPB	0x14
+
+/*
+ * ----------------------------------------------------------------
+ * Action Qualifier (AQ) module registers
+ * ----------------------------------------------------------------
+ */
+#define AQCTLA	0x16
+#define AQCTLB	0x18
+#define AQSFRC	0x1A
+#define AQCSFRC	0x1
+
+/* AQCTL: event-action fields */
+/*   ZRO  = bits [1:0] */
+/*   PRD  = bits [3:2] */
+/*   CAU  = bits [5:4] */
+/*   CBU  = bits [9:8] */
+#define AQCTL_ZRO_MASK	GENMASK(1, 0)
+#define AQCTL_PRD_MASK	GENMASK(3, 2)
+#define AQCTL_CAU_MASK	GENMASK(5, 4)
+#define AQCTL_CBU_MASK	GENMASK(9, 8)
+
+/* common action codes (2‑bit) */
+#define AQCTL_FRCLOW	1
+#define AQCTL_FRCHIGH	2
+#define AQCTL_FRCTOGGLE	3
+
+/* ZRO actions */
+#define AQCTL_ZRO_FRCLOW	FIELD_PREP(AQCTL_ZRO_MASK, AQCTL_FRCLOW)
+#define AQCTL_ZRO_FRCHIGH	FIELD_PREP(AQCTL_ZRO_MASK, AQCTL_FRCHIGH)
+#define AQCTL_ZRO_FRCTOGGLE	FIELD_PREP(AQCTL_ZRO_MASK, AQCTL_FRCTOGGLE)
+
+/* PRD actions */
+#define AQCTL_PRD_FRCLOW	FIELD_PREP(AQCTL_PRD_MASK, AQCTL_FRCLOW)
+#define AQCTL_PRD_FRCHIGH	FIELD_PREP(AQCTL_PRD_MASK, AQCTL_FRCHIGH)
+#define AQCTL_PRD_FRCTOGGLE	FIELD_PREP(AQCTL_PRD_MASK, AQCTL_FRCTOGGLE)
+
+/* CAU actions */
+#define AQCTL_CAU_FRCLOW	FIELD_PREP(AQCTL_CAU_MASK, AQCTL_FRCLOW)
+#define AQCTL_CAU_FRCHIGH	FIELD_PREP(AQCTL_CAU_MASK, AQCTL_FRCHIGH)
+#define AQCTL_CAU_FRCTOGGLE	FIELD_PREP(AQCTL_CAU_MASK, AQCTL_FRCTOGGLE)
+
+/* CBU actions */
+#define AQCTL_CBU_FRCLOW	FIELD_PREP(AQCTL_CBU_MASK, AQCTL_FRCLOW)
+#define AQCTL_CBU_FRCHIGH	FIELD_PREP(AQCTL_CBU_MASK, AQCTL_FRCHIGH)
+#define AQCTL_CBU_FRCTOGGLE	FIELD_PREP(AQCTL_CBU_MASK, AQCTL_FRCTOGGLE)
+
+/* predefined channel‑polarity combos */
+#define AQCTL_CHANA_POLNORMAL	\
+	(AQCTL_CAU_FRCLOW  | AQCTL_PRD_FRCHIGH | AQCTL_ZRO_FRCHIGH)
+#define AQCTL_CHANA_POLINVERSED	\
+	(AQCTL_CAU_FRCHIGH | AQCTL_PRD_FRCLOW  | AQCTL_ZRO_FRCLOW)
+
+#define AQCTL_CHANB_POLNORMAL	\
+	(AQCTL_CBU_FRCLOW  | AQCTL_PRD_FRCHIGH | AQCTL_ZRO_FRCHIGH)
+#define AQCTL_CHANB_POLINVERSED	\
+	(AQCTL_CBU_FRCHIGH | AQCTL_PRD_FRCLOW  | AQCTL_ZRO_FRCLOW)
+
+/* AQSFRC: RLDCSF (bits [7:6]) */
+#define AQSFRC_RLDCSF_MASK	GENMASK(7, 6)
+#define AQSFRC_RLDCSF_ZRO	FIELD_PREP(AQSFRC_RLDCSF_MASK, 0)
+#define AQSFRC_RLDCSF_PRD	FIELD_PREP(AQSFRC_RLDCSF_MASK, 1)
+#define AQSFRC_RLDCSF_ZROPRD	FIELD_PREP(AQSFRC_RLDCSF_MASK, 2)
+#define AQSFRC_RLDCSF_IMDT	FIELD_PREP(AQSFRC_RLDCSF_MASK, 3)
+
+/* AQCSFRC: CSFB (bits [3:2]), CSFA (bits [1:0]) */
+#define AQCSFRC_CSFB_MASK	GENMASK(3, 2)
+#define AQCSFRC_CSFA_MASK	GENMASK(1, 0)
+
+#define AQCSFRC_CSFB_FRCDIS	FIELD_PREP(AQCSFRC_CSFB_MASK, 0)
+#define AQCSFRC_CSFB_FRCLOW	FIELD_PREP(AQCSFRC_CSFB_MASK, 1)
+#define AQCSFRC_CSFB_FRCHIGH	FIELD_PREP(AQCSFRC_CSFB_MASK, 2)
+#define AQCSFRC_CSFB_DISSWFRC	FIELD_PREP(AQCSFRC_CSFB_MASK, 3)
+
+#define AQCSFRC_CSFA_FRCDIS	FIELD_PREP(AQCSFRC_CSFA_MASK, 0)
+#define AQCSFRC_CSFA_FRCLOW	FIELD_PREP(AQCSFRC_CSFA_MASK, 1)
+#define AQCSFRC_CSFA_FRCHIGH	FIELD_PREP(AQCSFRC_CSFA_MASK, 2)
+#define AQCSFRC_CSFA_DISSWFRC	FIELD_PREP(AQCSFRC_CSFA_MASK, 3)
+
+/* Number of EHRPWM channels */
+#define NUM_PWM_CHANNEL	2U
 
 struct ehrpwm_context {
 	u16 tbctl;
@@ -167,8 +204,8 @@ static int set_prescale_div(unsigned long rqst_prescaler, u16 *prescale_div,
 			*prescale_div = (1 << clkdiv) *
 					(hspclkdiv ? (hspclkdiv * 2) : 1);
 			if (*prescale_div > rqst_prescaler) {
-				*tb_clk_div = (clkdiv << TBCTL_CLKDIV_SHIFT) |
-					(hspclkdiv << TBCTL_HSPCLKDIV_SHIFT);
+				*tb_clk_div = FIELD_PREP(TBCTL_CLKDIV_MASK, clkdiv) |
+							FIELD_PREP(TBCTL_HSPCLKDIV_MASK, hspclkdiv);
 				return 0;
 			}
 		}
-- 
2.25.1


