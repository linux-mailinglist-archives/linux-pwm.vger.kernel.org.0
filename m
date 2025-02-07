Return-Path: <linux-pwm+bounces-4826-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4D0A2CF88
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 22:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C78418839EE
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 21:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC381C7003;
	Fri,  7 Feb 2025 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxJLIngt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2EC1B4239;
	Fri,  7 Feb 2025 21:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963863; cv=none; b=uA/T6uSTczGH+TMSkokkcTalM5Au5IpMTX6JhV64P6n13GDKkxfmfXkumm3xAZf7DLTenHaYcMLDAQOOYT615jJ+W4+6E1dWiEPq/tiHvMCsqMXMoxkEHuZPqZ6Ufn5czoWMuRcodej+G9Z3DL/ejxG19THr9O4/o6cSUgwx/DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963863; c=relaxed/simple;
	bh=BXQFxnvsuU4LQPV7c9DJhV8HVRtjQhLi4kkYYPr8Lpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CgETk0lIhMSCXAoiN84Htcx1YQ2fm0H4944X700Y5X6Q1W9ofvRxqo1bvjSa/j/Jp39A3uTjdVNgaWmMkTxB6gWWfcwGpSlYJRBhti88dPZWubUVGd60V/Cth6CSY2He/cGXcYHPB025w4mg68Ygapr8GpbmWqcDYAErto2Wi70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxJLIngt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f4a4fbb35so28326445ad.0;
        Fri, 07 Feb 2025 13:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738963860; x=1739568660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r08o33ipA5MWxiDyUsWZrYJbXTEaBXzVTqjJSzQg9iU=;
        b=gxJLIngtdzlQWZ4yNdXsDTr/hUoDMA6V1Of6bELl3AReG1Zh6Z2zJw2RbsETcWupX1
         XlMo5A8J11XjKk5hoOV31vdj17UBSghNt1P0nE3M547UaP2fIQbMPB1b4lXpGWSqdU0O
         k6G1CSl6A6dBauhyUwCw21BH1VHC9t6ry4miqk3Qb6ZCBghcdezk6wsuNs9r3SbN6bHm
         tR/B2/o/5bgH4vGojEnpkmGPGVyXdHo/10Vs+b5Bn2odZ6lUVlvJvsKqY0CgBwf68Fbh
         BlCvfG1gZRBokfHBdABboYhZbfeYmIP1+cp6VKGacbUEp0XyIjSisvaxdeNORLflHoEn
         IIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738963860; x=1739568660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r08o33ipA5MWxiDyUsWZrYJbXTEaBXzVTqjJSzQg9iU=;
        b=dzw6xrED2vuAE2bcrHfu0RSeABxzdcv8pVzTlyz239DQLeP3VGuHZeDTSa05iZnVOv
         eYy66mvGoX9Y02cF6P17SS8fEa9PEH5D3ulOUeI57gRH60LA1wvxy5BwrZ0Q6bKOWBD3
         0Mb7K2akcqzZ+V9IT/1P/kbOPIjeJiqAdKpy0z3EuLPAkKzp3j8aGcjRtFEs1khTI3mp
         /LkWgK9a0cyyPSGL2pvpWIQHVvi7415D/G3a/EZStfLnjglSBq5yDZ3ZuvFMRcLN3q3C
         omoSMwKPPmtjZdECVJLX0xRtLc7Qj63JxsWz55WGIJz9452hn0vBRAq18fWiyTeVthVs
         dKNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLIVdceL3UC0YA6oNAfCIEuaKfv5nQwwWvOl/idIYvuqIScDv16cJcGrbhzC/31XtgDABKp1g78xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb5ezgDZY/TdZXNlGG0A8lzjkbJbAca8ORCGAzIdH1ix9xWM03
	ZL0h+W/Ai5IJC5iZPikSevQn4L813cZ8W+rDLADuuPTAfz+vVgRp2SWsibla
X-Gm-Gg: ASbGncuUGWoMdwZRLr7jxWY/6a/Gk382H6ZW1Aq7vXMwCKjq9aP0ZpJD5r4lqoyGAWw
	s0YRMmAuxcBzbi6zeWEVCWB0LGrttte+lO/Ea0l0gjYhuCCw+7xPqQcQ/fNuMgqnfOjKTBMU6KN
	UrE0F968cW2BmKes6K11HkVfyzpHaYukyc0zP4LyBmIkH90lqqIV2knDaLHpN9/XnjCIY5aOejw
	NfjGbo2pQObm3cjNo0P5FDmenMEyleUO+EyIxm2TEjAenZsW2ACDtk6YdEYpogRiSSK7qUzWo2K
	Kxk4drtRZQR1W2fC/JbzaOzIbUogSLGbaekS
X-Google-Smtp-Source: AGHT+IHn/Sqx5UTattoHfMQZVuvqP4SjkP7AIUoPZrjTtvEDi6s0xiyeVV7amDsrzhgZo8xXMjEHwQ==
X-Received: by 2002:a17:903:1a0c:b0:215:a303:24e9 with SMTP id d9443c01a7336-21f4f0efcb1mr77119635ad.3.1738963859889;
        Fri, 07 Feb 2025 13:30:59 -0800 (PST)
Received: from localhost.localdomain ([181.192.80.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c79esm35406485ad.175.2025.02.07.13.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 13:30:59 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: [PATCH v3 1/3] pwm: tiehrpwm: replace manual bit definitions with bitfield.h macros
Date: Fri,  7 Feb 2025 18:29:54 -0300
Message-Id: <20250207212954.934-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <uw4ans5zzvo65voerbaxvj2erethpuh2jfm2iu7ekqyvgg62nx@lglwyjcpa5aw>
References: <uw4ans5zzvo65voerbaxvj2erethpuh2jfm2iu7ekqyvgg62nx@lglwyjcpa5aw>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
 drivers/pwm/pwm-tiehrpwm.c | 222 ++++++++++++++++++++++++-------------
 1 file changed, 142 insertions(+), 80 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 0125e73b98df..50516f46ab04 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -13,85 +13,147 @@
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/bitfield.h>
 
-/* EHRPWM registers and bits definitions */
-
-/* Time base module registers */
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
+/*
+ * --------------------------------------
+ * Time base module registers
+ * --------------------------------------
+ */
+#define TBCTL					0x00
+#define TBPRD					0x0A
+
+/* TBCTL: CTRMODE field (bits [1:0]) */
+#define TBCTL_CTRMODE_MASK		GENMASK(1, 0)
+
+/* The possible values for that field */
+#define TBCTL_CTRMODE_UP		FIELD_PREP(TBCTL_CTRMODE_MASK, 0U)
+#define TBCTL_CTRMODE_DOWN		FIELD_PREP(TBCTL_CTRMODE_MASK, 1U)
+#define TBCTL_CTRMODE_UPDOWN	FIELD_PREP(TBCTL_CTRMODE_MASK, 2U)
+#define TBCTL_CTRMODE_FREEZE	FIELD_PREP(TBCTL_CTRMODE_MASK, 3U)
+
+/* TBCTL: PRDLD bit (bit [3]) */
+#define TBCTL_PRDLD_MASK		GENMASK(3, 3)
+
+/* Possible values for PRDLD */
+#define TBCTL_PRDLD_SHDW		FIELD_PREP(TBCTL_PRDLD_MASK, 0U) /* 0 => shadow */
+#define TBCTL_PRDLD_IMDT		FIELD_PREP(TBCTL_PRDLD_MASK, 1U) /* 1 => immediate */
+
+/* TBCTL: Combined bits [12:7] actually split into two subfields:
+ *    - TBCTL_HSPCLKDIV => bits [9:7]
+ *    - TBCTL_CLKDIV    => bits [12:10]
+ */
+#define TBCTL_HSPCLKDIV_MASK	GENMASK(9, 7)
+#define TBCTL_CLKDIV_MASK		GENMASK(12, 10)
+
+/* Max values if needed: */
+#define CLKDIV_MAX				7U
+#define HSPCLKDIV_MAX			7U
+#define PERIOD_MAX				0xFFFF
+
+/*
+ * --------------------------------------
+ * Compare module registers
+ * --------------------------------------
+ */
+#define CMPA					0x12
+#define CMPB					0x14
+
+/*
+ * --------------------------------------
+ * Action qualifier (AQ) module registers
+ * --------------------------------------
+ */
+#define AQCTLA					0x16
+#define AQCTLB					0x18
+#define AQSFRC					0x1A
+#define AQCSFRC					0x1C
+
+/*
+ * AQCTLA and AQCTLB share similar 2-bit fields for
+ * various events (ZRO, PRD, CAU, CBU, etc.).
+ *
+ * For instance, bits [1:0] => ZRO,
+ *               bits [3:2] => PRD,
+ *               bits [5:4] => CAU,
+ *               bits [9:8] => CBU, etc.
+ */
+#define AQCTL_ZRO_MASK			GENMASK(1, 0)
+#define AQCTL_PRD_MASK			GENMASK(3, 2)
+#define AQCTL_CAU_MASK			GENMASK(5, 4)
+#define AQCTL_CBU_MASK			GENMASK(9, 8)
+
+/*
+ * FORCE LOW	=> 0b01
+ * FORCE HIGH	=> 0b01
+ * FORCE TOGGLE	=> 0b01
+ */
+#define AQCTL_FRCLOW			1U
+#define AQCTL_FRCHIGH			2U
+#define AQCTL_FRCTOGGLE			3U
+
+/* These values in CAU: */
+#define AQCTL_CAU_FRCLOW		FIELD_PREP(AQCTL_CAU_MASK, AQCTL_FRCLOW)
+#define AQCTL_CAU_FRCHIGH		FIELD_PREP(AQCTL_CAU_MASK, AQCTL_FRCHIGH)
+#define AQCTL_CAU_FRCTOGGLE	FIELD_PREP(AQCTL_CAU_MASK, AQCTL_FRCTOGGLE)
+
+/* These values in PRD: */
+#define AQCTL_PRD_FRCLOW		FIELD_PREP(AQCTL_PRD_MASK, AQCTL_FRCLOW)
+#define AQCTL_PRD_FRCHIGH		FIELD_PREP(AQCTL_PRD_MASK, AQCTL_FRCHIGH)
+#define AQCTL_PRD_FRCTOGGLE		FIELD_PREP(AQCTL_PRD_MASK, AQCTL_FRCTOGGLE)
+
+/* These values in ZRO: */
+#define AQCTL_ZRO_FRCLOW		FIELD_PREP(AQCTL_ZRO_MASK, AQCTL_FRCLOW)
+#define AQCTL_ZRO_FRCHIGH		FIELD_PREP(AQCTL_ZRO_MASK, AQCTL_FRCHIGH)
+#define AQCTL_ZRO_FRCTOGGLE		FIELD_PREP(AQCTL_ZRO_MASK, AQCTL_FRCTOGGLE)
+
+/* These values in CBU: */
+#define AQCTL_CBU_FRCLOW		FIELD_PREP(AQCTL_CBU_MASK, AQCTL_FRCLOW)
+#define AQCTL_CBU_FRCHIGH		FIELD_PREP(AQCTL_CBU_MASK, AQCTL_FRCHIGH)
+#define AQCTL_CBU_FRCTOGGLE		FIELD_PREP(AQCTL_CBU_MASK, AQCTL_FRCTOGGLE)
+
+/* Predefined combinations for channel polarity */
+#define AQCTL_CHANA_POLNORMAL	\
+	(AQCTL_CAU_FRCLOW  | AQCTL_PRD_FRCHIGH | AQCTL_ZRO_FRCHIGH)
+#define AQCTL_CHANA_POLINVERSED	\
+	(AQCTL_CAU_FRCHIGH | AQCTL_PRD_FRCLOW  | AQCTL_ZRO_FRCLOW)
+#define AQCTL_CHANB_POLNORMAL	\
+	(AQCTL_CBU_FRCLOW  | AQCTL_PRD_FRCHIGH | AQCTL_ZRO_FRCHIGH)
+#define AQCTL_CHANB_POLINVERSED	\
+	(AQCTL_CBU_FRCHIGH | AQCTL_PRD_FRCLOW  | AQCTL_ZRO_FRCLOW)
+
+/* AQSFRC: RLDCSF => bits [7:6] */
+#define AQSFRC_RLDCSF_MASK		GENMASK(7, 6)
+
+#define AQSFRC_RLDCSF_ZRO		FIELD_PREP(AQSFRC_RLDCSF_MASK, 0U)
+#define AQSFRC_RLDCSF_PRD		FIELD_PREP(AQSFRC_RLDCSF_MASK, 1U)
+#define AQSFRC_RLDCSF_ZROPRD	FIELD_PREP(AQSFRC_RLDCSF_MASK, 2U)
+#define AQSFRC_RLDCSF_IMDT		FIELD_PREP(AQSFRC_RLDCSF_MASK, 3U)
+
+/* AQCSFRC: CSFB => bits [3:2], CSFA => bits [1:0] */
+#define AQCSFRC_CSFB_MASK		GENMASK(3, 2)
+#define AQCSFRC_CSFA_MASK		GENMASK(1, 0)
+
+/* The possible 2-bit values for CSFB or CSFA fields */
+#define AQCSFRC_FRCDIS			0U
+#define AQCSFRC_FRCLOW			1U
+#define AQCSFRC_FRCHIGH			2U
+#define AQCSFRC_DISSWFRC		3U
+
+/* These values in CSFB: */
+#define AQCSFRC_CSFB_FRCDIS		FIELD_PREP(AQCSFRC_CSFB_MASK, AQCSFRC_FRCDIS)
+#define AQCSFRC_CSFB_FRCLOW		FIELD_PREP(AQCSFRC_CSFB_MASK, AQCSFRC_FRCLOW)
+#define AQCSFRC_CSFB_FRCHIGH	FIELD_PREP(AQCSFRC_CSFB_MASK, AQCSFRC_FRCHIGH)
+#define AQCSFRC_CSFB_DISSWFRC	FIELD_PREP(AQCSFRC_CSFB_MASK, AQCSFRC_DISSWFRC)
+
+/* These values in CSFA: */
+#define AQCSFRC_CSFA_FRCDIS		FIELD_PREP(AQCSFRC_CSFA_MASK, AQCSFRC_FRCDIS)
+#define AQCSFRC_CSFA_FRCLOW		FIELD_PREP(AQCSFRC_CSFA_MASK, AQCSFRC_FRCLOW)
+#define AQCSFRC_CSFA_FRCHIGH	FIELD_PREP(AQCSFRC_CSFA_MASK, AQCSFRC_FRCHIGH)
+#define AQCSFRC_CSFA_DISSWFRC	FIELD_PREP(AQCSFRC_CSFA_MASK, AQCSFRC_DISSWFRC)
+
+/* EHRPWM channels */
+#define NUM_PWM_CHANNEL			2U
 
 struct ehrpwm_context {
 	u16 tbctl;
@@ -167,8 +229,8 @@ static int set_prescale_div(unsigned long rqst_prescaler, u16 *prescale_div,
 			*prescale_div = (1 << clkdiv) *
 					(hspclkdiv ? (hspclkdiv * 2) : 1);
 			if (*prescale_div > rqst_prescaler) {
-				*tb_clk_div = (clkdiv << TBCTL_CLKDIV_SHIFT) |
-					(hspclkdiv << TBCTL_HSPCLKDIV_SHIFT);
+				*tb_clk_div = FIELD_PREP(TBCTL_CLKDIV_MASK, clkdiv) |
+								FIELD_PREP(TBCTL_HSPCLKDIV_MASK, hspclkdiv);
 				return 0;
 			}
 		}
-- 
2.25.1


