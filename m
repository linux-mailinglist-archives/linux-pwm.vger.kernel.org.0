Return-Path: <linux-pwm+bounces-7710-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B76EC90705
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 01:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7B43A9E99
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 00:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5193C1CBEB9;
	Fri, 28 Nov 2025 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fH5H4QwX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B07511713
	for <linux-pwm@vger.kernel.org>; Fri, 28 Nov 2025 00:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764290333; cv=none; b=LaoXGIAA7/CRdhRNZLa3zsmVGbNHseVDWcpy6kNK4LM0Ggtog+I/5oZuRghz2aF+Bbld8NF9EeJLWWdPQdjG1SvKXeX/WL7MM2RQj/3hXsSEDBHUlqsFMpOsBv1xviZNt0qK+e1aerphMu9K303AO7Y4ffSzU9zYbbd+cDVuqqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764290333; c=relaxed/simple;
	bh=EkpMG+PKrrKY79QW8ls5d/4++Xsjs+hRPiQH+jUHj+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVQ50JfTy7cbbys4l+SVJDSxBQcwkoXhtdgeRvmPqPzoNLHkckhOr1k5O/InUvl4726Pa8FUZSQj17CEvu0idXFo6lk86vJHERaRPAcOB5ZLSqeMoMXQhM00Ki19hCZwoP7jDoh+Z8EoRctQPnCgYucMn9odp0auPnlRqQ41D1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fH5H4QwX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7ade456b6abso1031600b3a.3
        for <linux-pwm@vger.kernel.org>; Thu, 27 Nov 2025 16:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764290330; x=1764895130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oV7/3P94ufHrd/6Nd/jeUWDYgSffhEwvVPtFaFjAozc=;
        b=fH5H4QwX5nT6eYt1J1QTako3gb3LaeGc6vRFT9qOKW2U/9gQwe4j3dsFWfxJpGjXzG
         V8UPwCWKS3uAcTwLyT+cgOqA0XzzWo4caxe5HAeYOJGPg6X2Av6yxN+RTluZt8kbBpgS
         imsUCvHH05peuz/9IY7uajbVhQ6YjZ34s5i6Pp8LkqMMRIK/h+D64+XFW8w3u1oPscJ+
         yNYL7+lz0K1ARP3HTtMIflBFU5FZ2C9E/ahZ7+USzm+g55PmfF2eSEegZqBUxzmi9zhc
         jG6QpG9VLinKeJx8CNemddItLFxbM8I2/d1fHM4GOmBgJqO3r+uwAh2nymb86I98Lng/
         NE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764290331; x=1764895131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oV7/3P94ufHrd/6Nd/jeUWDYgSffhEwvVPtFaFjAozc=;
        b=bxLbVGQM9M+yRP9nZy3HfSOtncBB2XNskrKd3T0PaEmW3mS1mDeRct8K5n9wKHZIfC
         swsf2owlzpizdXkn4441m1JQrvyKBJ86UUkMb5RZZtw+vpIXitw1kr0qHTrSOT1wem/1
         qC8kEVKwExG6JXmsFC9iIpf7bWIRmBxch3fD43Au3NNx7TB1S+/Uogy7OamG7yrFKyHi
         ewrrNN4Ptlek91igFqWgq3OS5cmdRn59cXfVjsyt7ENEnwf4jETFZXOSuB2n5NohouOh
         Lvq6XWr863/bAlXFtHLdgb8/idlQhOM1jf13ctngoxV7+wEl5rMSt8b0JJ/wo6y6xqZv
         OuEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzpiusSxCEdIWOExUl7ZfpDJdbKa2qZliIMeAETfrbjOAd/cpgbsS7A0HbiVjV9+KJY0ZDi7ibHwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxntQFBTa1SCTyhpqXYAV94qNHxhLpEpvd59JN/uDCqbQQi31ag
	BdZXYZuLOx0qh0hO7Xi1RLi6jiLqKM8L4XRKTZn5Ycyl5fg7hRcH9sv6LATzGA==
X-Gm-Gg: ASbGncvkKleNCB7IGZdgIYBZSRtPr3XO1D249T1Cfe0EJPwvIp4WR3U8MEi8knXTyHB
	Hgz536PHKW4gljBpvgM93wIgeyZVjYPMHyATfI+FXHUTMRTlu8GZbJw5CT9Ixj5tNGaOz3+s1kZ
	ohbsxERUtKlZET/+TRmiLTEY5oa5aWJjxPhH/rTeGEDcXvDWuJySs91FEc/sTexbnGP4IGcE9wJ
	SQq8R7YC51Iq4aFUgE9Q8pMHr+cZKDF12yWzwmEy7ryRT6PvbCMh7N6GxOaIPr0uihg5zCTOf1U
	2axnGTUN3Sr8RoxmunspBCwN28gfC+ETkUU4DsSjkzn8/jF+2PwqCPU0B+nenk3LLpUaY8bN01V
	3A64Jx10jUWEEyKdIabzsDTcdudwSuDQPz902ly/WA3Sf8/TldM+luzKrdHagnJ4imlHKGj1+XX
	0rEcUslAfqIAFkBA3OtlOd59dMV5yN6Ot4Cm8cVqs87UE=
X-Google-Smtp-Source: AGHT+IE2fbpWlQAZqygAVovAOKX5xSsLzCbSItnYQhg+Qu8+yYmrpwadXEASNRFljAmNaHALfpcVaQ==
X-Received: by 2002:a05:7022:2510:b0:11b:1c6d:98bd with SMTP id a92af1059eb24-11c9d711b6bmr17323144c88.9.1764290330395;
        Thu, 27 Nov 2025 16:38:50 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee7076sm12404561c88.4.2025.11.27.16.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 16:38:49 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: [PATCH v7 1/9] pwm: tiehrpwm: prefix register and field definitions
Date: Thu, 27 Nov 2025 21:36:26 -0300
Message-ID: <20251128003634.247529-2-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128003634.247529-1-rafael.v.volkmer@gmail.com>
References: <20251128003634.247529-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prefix all eHRPWM register offsets, bitfields and related constants with
the TIEHRPWM_ prefix to make their origin explicit and avoid clashes
with other PWM drivers or platforms.

While at it, update all users in pwm-tiehrpwm.c to use the new names,
including the period tracking and prescaler helpers, without changing
any underlying values.

This patch is a mechanical rename-only change.

No functional change intended.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 257 +++++++++++++++++++------------------
 1 file changed, 131 insertions(+), 126 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 7a86cb090f76..b6020b2210db 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -17,77 +17,81 @@
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
-#define PERIOD_MAX		0x10000
+#define TIEHRPWM_TBCTL				0x00
+#define TIEHRPWM_TBPRD				0x0A
+
+#define TIEHRPWM_TBCTL_PRDLD_MASK		BIT(3)
+#define TIEHRPWM_TBCTL_PRDLD_SHDW		0
+#define TIEHRPWM_TBCTL_PRDLD_IMDT		BIT(3)
+#define TIEHRPWM_TBCTL_CLKDIV_MASK		(BIT(12) | BIT(11) | BIT(10) | BIT(9) | \
+						BIT(8) | BIT(7))
+#define TIEHRPWM_TBCTL_CTRMODE_MASK		(BIT(1) | BIT(0))
+#define TIEHRPWM_TBCTL_CTRMODE_UP		0
+#define TIEHRPWM_TBCTL_CTRMODE_DOWN		BIT(0)
+#define TIEHRPWM_TBCTL_CTRMODE_UPDOWN		BIT(1)
+#define TIEHRPWM_TBCTL_CTRMODE_FREEZE		(BIT(1) | BIT(0))
+
+#define TIEHRPWM_TBCTL_HSPCLKDIV_SHIFT		7
+#define TIEHRPWM_TBCTL_CLKDIV_SHIFT		10
+
+#define TIEHRPWM_CLKDIV_MAX			7
+#define TIEHRPWM_HSPCLKDIV_MAX			7
+#define TIEHRPWM_PERIOD_MAX			0x10000
 
 /* compare module registers */
-#define CMPA			0x12
-#define CMPB			0x14
+#define TIEHRPWM_CMPA				0x12
+#define TIEHRPWM_CMPB				0x14
 
 /* Action qualifier module registers */
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
-#define AQCTL_CHANA_POLNORMAL	(AQCTL_CAU_FRCLOW | AQCTL_ZRO_FRCHIGH)
-#define AQCTL_CHANA_POLINVERSED	(AQCTL_CAU_FRCHIGH | AQCTL_ZRO_FRCLOW)
-#define AQCTL_CHANB_POLNORMAL	(AQCTL_CBU_FRCLOW | AQCTL_ZRO_FRCHIGH)
-#define AQCTL_CHANB_POLINVERSED	(AQCTL_CBU_FRCHIGH | AQCTL_ZRO_FRCLOW)
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
+#define TIEHRPWM_AQCTLA				0x16
+#define TIEHRPWM_AQCTLB				0x18
+#define TIEHRPWM_AQSFRC				0x1A
+#define TIEHRPWM_AQCSFRC			0x1C
+
+#define TIEHRPWM_AQCTL_CBU_MASK			(BIT(9) | BIT(8))
+#define TIEHRPWM_AQCTL_CBU_FRCLOW		BIT(8)
+#define TIEHRPWM_AQCTL_CBU_FRCHIGH		BIT(9)
+#define TIEHRPWM_AQCTL_CBU_FRCTOGGLE		(BIT(9) | BIT(8))
+#define TIEHRPWM_AQCTL_CAU_MASK			(BIT(5) | BIT(4))
+#define TIEHRPWM_AQCTL_CAU_FRCLOW		BIT(4)
+#define TIEHRPWM_AQCTL_CAU_FRCHIGH		BIT(5)
+#define TIEHRPWM_AQCTL_CAU_FRCTOGGLE		(BIT(5) | BIT(4))
+#define TIEHRPWM_AQCTL_PRD_MASK			(BIT(3) | BIT(2))
+#define TIEHRPWM_AQCTL_PRD_FRCLOW		BIT(2)
+#define TIEHRPWM_AQCTL_PRD_FRCHIGH		BIT(3)
+#define TIEHRPWM_AQCTL_PRD_FRCTOGGLE		(BIT(3) | BIT(2))
+#define TIEHRPWM_AQCTL_ZRO_MASK			(BIT(1) | BIT(0))
+#define TIEHRPWM_AQCTL_ZRO_FRCLOW		BIT(0)
+#define TIEHRPWM_AQCTL_ZRO_FRCHIGH		BIT(1)
+#define TIEHRPWM_AQCTL_ZRO_FRCTOGGLE		(BIT(1) | BIT(0))
+
+#define TIEHRPWM_AQCTL_CHANA_POLNORMAL		(TIEHRPWM_AQCTL_CAU_FRCLOW | \
+						TIEHRPWM_AQCTL_ZRO_FRCHIGH)
+#define TIEHRPWM_AQCTL_CHANA_POLINVERSED	(TIEHRPWM_AQCTL_CAU_FRCHIGH | \
+						TIEHRPWM_AQCTL_ZRO_FRCLOW)
+#define TIEHRPWM_AQCTL_CHANB_POLNORMAL		(TIEHRPWM_AQCTL_CBU_FRCLOW | \
+						TIEHRPWM_AQCTL_ZRO_FRCHIGH)
+#define TIEHRPWM_AQCTL_CHANB_POLINVERSED	(TIEHRPWM_AQCTL_CBU_FRCHIGH | \
+						TIEHRPWM_AQCTL_ZRO_FRCLOW)
+
+#define TIEHRPWM_AQSFRC_RLDCSF_MASK		(BIT(7) | BIT(6))
+#define TIEHRPWM_AQSFRC_RLDCSF_ZRO		0
+#define TIEHRPWM_AQSFRC_RLDCSF_PRD		BIT(6)
+#define TIEHRPWM_AQSFRC_RLDCSF_ZROPRD		BIT(7)
+#define TIEHRPWM_AQSFRC_RLDCSF_IMDT		(BIT(7) | BIT(6))
+
+#define TIEHRPWM_AQCSFRC_CSFB_MASK		(BIT(3) | BIT(2))
+#define TIEHRPWM_AQCSFRC_CSFB_FRCDIS		0
+#define TIEHRPWM_AQCSFRC_CSFB_FRCLOW		BIT(2)
+#define TIEHRPWM_AQCSFRC_CSFB_FRCHIGH		BIT(3)
+#define TIEHRPWM_AQCSFRC_CSFB_DISSWFRC		(BIT(3) | BIT(2))
+#define TIEHRPWM_AQCSFRC_CSFA_MASK		(BIT(1) | BIT(0))
+#define TIEHRPWM_AQCSFRC_CSFA_FRCDIS		0
+#define TIEHRPWM_AQCSFRC_CSFA_FRCLOW		BIT(0)
+#define TIEHRPWM_AQCSFRC_CSFA_FRCHIGH		BIT(1)
+#define TIEHRPWM_AQCSFRC_CSFA_DISSWFRC		(BIT(1) | BIT(0))
+
+#define TIEHRPWM_NUM_PWM_CHANNEL		2	/* EHRPWM channels */
 
 struct ehrpwm_context {
 	u16 tbctl;
@@ -103,7 +107,7 @@ struct ehrpwm_context {
 struct ehrpwm_pwm_chip {
 	unsigned long clk_rate;
 	void __iomem *mmio_base;
-	unsigned long period_cycles[NUM_PWM_CHANNEL];
+	unsigned long period_cycles[TIEHRPWM_NUM_PWM_CHANNEL];
 	struct clk *tbclk;
 	struct ehrpwm_context ctx;
 };
@@ -146,8 +150,8 @@ static int set_prescale_div(unsigned long rqst_prescaler, u16 *prescale_div,
 {
 	unsigned int clkdiv, hspclkdiv;
 
-	for (clkdiv = 0; clkdiv <= CLKDIV_MAX; clkdiv++) {
-		for (hspclkdiv = 0; hspclkdiv <= HSPCLKDIV_MAX; hspclkdiv++) {
+	for (clkdiv = 0; clkdiv <= TIEHRPWM_CLKDIV_MAX; clkdiv++) {
+		for (hspclkdiv = 0; hspclkdiv <= TIEHRPWM_HSPCLKDIV_MAX; hspclkdiv++) {
 			/*
 			 * calculations for prescaler value :
 			 * prescale_div = HSPCLKDIVIDER * CLKDIVIDER.
@@ -162,8 +166,8 @@ static int set_prescale_div(unsigned long rqst_prescaler, u16 *prescale_div,
 			*prescale_div = (1 << clkdiv) *
 					(hspclkdiv ? (hspclkdiv * 2) : 1);
 			if (*prescale_div >= rqst_prescaler) {
-				*tb_clk_div = (clkdiv << TBCTL_CLKDIV_SHIFT) |
-					(hspclkdiv << TBCTL_HSPCLKDIV_SHIFT);
+				*tb_clk_div = (clkdiv << TIEHRPWM_TBCTL_CLKDIV_SHIFT) |
+					(hspclkdiv << TIEHRPWM_TBCTL_HSPCLKDIV_SHIFT);
 				return 0;
 			}
 		}
@@ -204,7 +208,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * Period values should be same for multiple PWM channels as IP uses
 	 * same period register for multiple channels.
 	 */
-	for (i = 0; i < NUM_PWM_CHANNEL; i++) {
+	for (i = 0; i < TIEHRPWM_NUM_PWM_CHANNEL; i++) {
 		if (pc->period_cycles[i] &&
 				(pc->period_cycles[i] != period_cycles)) {
 			/*
@@ -224,7 +228,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pc->period_cycles[pwm->hwpwm] = period_cycles;
 
 	/* Configure clock prescaler to support Low frequency PWM wave */
-	if (set_prescale_div(DIV_ROUND_UP(period_cycles, PERIOD_MAX), &ps_divval,
+	if (set_prescale_div(DIV_ROUND_UP(period_cycles, TIEHRPWM_PERIOD_MAX), &ps_divval,
 			     &tb_divval)) {
 		dev_err(pwmchip_parent(chip), "Unsupported values\n");
 		return -EINVAL;
@@ -240,52 +244,53 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	/* Update clock prescaler values */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
+	ehrpwm_modify(pc->mmio_base, TIEHRPWM_TBCTL, TIEHRPWM_TBCTL_CLKDIV_MASK, tb_divval);
 
 	if (pwm->hwpwm == 1) {
 		/* Channel 1 configured with compare B register */
-		cmp_reg = CMPB;
+		cmp_reg = TIEHRPWM_CMPB;
 
-		aqctl_reg = AQCTLB;
-		aqctl_mask = AQCTL_CBU_MASK;
+		aqctl_reg = TIEHRPWM_AQCTLB;
+		aqctl_mask = TIEHRPWM_AQCTL_CBU_MASK;
 
 		if (polarity == PWM_POLARITY_INVERSED)
-			aqctl_val = AQCTL_CHANB_POLINVERSED;
+			aqctl_val = TIEHRPWM_AQCTL_CHANB_POLINVERSED;
 		else
-			aqctl_val = AQCTL_CHANB_POLNORMAL;
+			aqctl_val = TIEHRPWM_AQCTL_CHANB_POLNORMAL;
 
 		/* if duty_cycle is big, don't toggle on CBU */
 		if (duty_cycles > period_cycles)
-			aqctl_val &= ~AQCTL_CBU_MASK;
+			aqctl_val &= ~TIEHRPWM_AQCTL_CBU_MASK;
 
 	} else {
 		/* Channel 0 configured with compare A register */
-		cmp_reg = CMPA;
+		cmp_reg = TIEHRPWM_CMPA;
 
-		aqctl_reg = AQCTLA;
-		aqctl_mask = AQCTL_CAU_MASK;
+		aqctl_reg = TIEHRPWM_AQCTLA;
+		aqctl_mask = TIEHRPWM_AQCTL_CAU_MASK;
 
 		if (polarity == PWM_POLARITY_INVERSED)
-			aqctl_val = AQCTL_CHANA_POLINVERSED;
+			aqctl_val = TIEHRPWM_AQCTL_CHANA_POLINVERSED;
 		else
-			aqctl_val = AQCTL_CHANA_POLNORMAL;
+			aqctl_val = TIEHRPWM_AQCTL_CHANA_POLNORMAL;
 
 		/* if duty_cycle is big, don't toggle on CAU */
 		if (duty_cycles > period_cycles)
-			aqctl_val &= ~AQCTL_CAU_MASK;
+			aqctl_val &= ~TIEHRPWM_AQCTL_CAU_MASK;
 	}
 
-	aqctl_mask |= AQCTL_PRD_MASK | AQCTL_ZRO_MASK;
+	aqctl_mask |= TIEHRPWM_AQCTL_PRD_MASK | TIEHRPWM_AQCTL_ZRO_MASK;
 	ehrpwm_modify(pc->mmio_base, aqctl_reg, aqctl_mask, aqctl_val);
 
 	/* Configure shadow loading on Period register */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_PRDLD_MASK, TBCTL_PRDLD_SHDW);
+	ehrpwm_modify(pc->mmio_base, TIEHRPWM_TBCTL, TIEHRPWM_TBCTL_PRDLD_MASK,
+		      TIEHRPWM_TBCTL_PRDLD_SHDW);
 
-	ehrpwm_write(pc->mmio_base, TBPRD, period_cycles - 1);
+	ehrpwm_write(pc->mmio_base, TIEHRPWM_TBPRD, period_cycles - 1);
 
 	/* Configure ehrpwm counter for up-count mode */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CTRMODE_MASK,
-		      TBCTL_CTRMODE_UP);
+	ehrpwm_modify(pc->mmio_base, TIEHRPWM_TBCTL, TIEHRPWM_TBCTL_CTRMODE_MASK,
+		      TIEHRPWM_TBCTL_CTRMODE_UP);
 
 	if (!(duty_cycles > period_cycles))
 		ehrpwm_write(pc->mmio_base, cmp_reg, duty_cycles);
@@ -306,18 +311,18 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	/* Disabling Action Qualifier on PWM output */
 	if (pwm->hwpwm) {
-		aqcsfrc_val = AQCSFRC_CSFB_FRCDIS;
-		aqcsfrc_mask = AQCSFRC_CSFB_MASK;
+		aqcsfrc_val = TIEHRPWM_AQCSFRC_CSFB_FRCDIS;
+		aqcsfrc_mask = TIEHRPWM_AQCSFRC_CSFB_MASK;
 	} else {
-		aqcsfrc_val = AQCSFRC_CSFA_FRCDIS;
-		aqcsfrc_mask = AQCSFRC_CSFA_MASK;
+		aqcsfrc_val = TIEHRPWM_AQCSFRC_CSFA_FRCDIS;
+		aqcsfrc_mask = TIEHRPWM_AQCSFRC_CSFA_MASK;
 	}
 
 	/* Changes to shadow mode */
-	ehrpwm_modify(pc->mmio_base, AQSFRC, AQSFRC_RLDCSF_MASK,
-		      AQSFRC_RLDCSF_ZRO);
+	ehrpwm_modify(pc->mmio_base, TIEHRPWM_AQSFRC, TIEHRPWM_AQSFRC_RLDCSF_MASK,
+		      TIEHRPWM_AQSFRC_RLDCSF_ZRO);
 
-	ehrpwm_modify(pc->mmio_base, AQCSFRC, aqcsfrc_mask, aqcsfrc_val);
+	ehrpwm_modify(pc->mmio_base, TIEHRPWM_AQCSFRC, aqcsfrc_mask, aqcsfrc_val);
 
 	/* Enable TBCLK */
 	ret = clk_enable(pc->tbclk);
@@ -337,25 +342,25 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	/* Action Qualifier puts PWM output low forcefully */
 	if (pwm->hwpwm) {
-		aqcsfrc_val = AQCSFRC_CSFB_FRCLOW;
-		aqcsfrc_mask = AQCSFRC_CSFB_MASK;
+		aqcsfrc_val = TIEHRPWM_AQCSFRC_CSFB_FRCLOW;
+		aqcsfrc_mask = TIEHRPWM_AQCSFRC_CSFB_MASK;
 	} else {
-		aqcsfrc_val = AQCSFRC_CSFA_FRCLOW;
-		aqcsfrc_mask = AQCSFRC_CSFA_MASK;
+		aqcsfrc_val = TIEHRPWM_AQCSFRC_CSFA_FRCLOW;
+		aqcsfrc_mask = TIEHRPWM_AQCSFRC_CSFA_MASK;
 	}
 
 	/* Update shadow register first before modifying active register */
-	ehrpwm_modify(pc->mmio_base, AQSFRC, AQSFRC_RLDCSF_MASK,
-		      AQSFRC_RLDCSF_ZRO);
-	ehrpwm_modify(pc->mmio_base, AQCSFRC, aqcsfrc_mask, aqcsfrc_val);
+	ehrpwm_modify(pc->mmio_base, TIEHRPWM_AQSFRC, TIEHRPWM_AQSFRC_RLDCSF_MASK,
+		      TIEHRPWM_AQSFRC_RLDCSF_ZRO);
+	ehrpwm_modify(pc->mmio_base, TIEHRPWM_AQCSFRC, aqcsfrc_mask, aqcsfrc_val);
 	/*
 	 * Changes to immediate action on Action Qualifier. This puts
 	 * Action Qualifier control on PWM output from next TBCLK
 	 */
-	ehrpwm_modify(pc->mmio_base, AQSFRC, AQSFRC_RLDCSF_MASK,
-		      AQSFRC_RLDCSF_IMDT);
+	ehrpwm_modify(pc->mmio_base, TIEHRPWM_AQSFRC, TIEHRPWM_AQSFRC_RLDCSF_MASK,
+		      TIEHRPWM_AQSFRC_RLDCSF_IMDT);
 
-	ehrpwm_modify(pc->mmio_base, AQCSFRC, aqcsfrc_mask, aqcsfrc_val);
+	ehrpwm_modify(pc->mmio_base, TIEHRPWM_AQCSFRC, aqcsfrc_mask, aqcsfrc_val);
 
 	/* Disabling TBCLK on PWM disable */
 	clk_disable(pc->tbclk);
@@ -421,7 +426,7 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int ret;
 
-	chip = devm_pwmchip_alloc(&pdev->dev, NUM_PWM_CHANNEL, sizeof(*pc));
+	chip = devm_pwmchip_alloc(&pdev->dev, TIEHRPWM_NUM_PWM_CHANNEL, sizeof(*pc));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	pc = to_ehrpwm_pwm_chip(chip);
@@ -495,14 +500,14 @@ static void ehrpwm_pwm_save_context(struct pwm_chip *chip)
 
 	pm_runtime_get_sync(pwmchip_parent(chip));
 
-	pc->ctx.tbctl = ehrpwm_read(pc->mmio_base, TBCTL);
-	pc->ctx.tbprd = ehrpwm_read(pc->mmio_base, TBPRD);
-	pc->ctx.cmpa = ehrpwm_read(pc->mmio_base, CMPA);
-	pc->ctx.cmpb = ehrpwm_read(pc->mmio_base, CMPB);
-	pc->ctx.aqctla = ehrpwm_read(pc->mmio_base, AQCTLA);
-	pc->ctx.aqctlb = ehrpwm_read(pc->mmio_base, AQCTLB);
-	pc->ctx.aqsfrc = ehrpwm_read(pc->mmio_base, AQSFRC);
-	pc->ctx.aqcsfrc = ehrpwm_read(pc->mmio_base, AQCSFRC);
+	pc->ctx.tbctl = ehrpwm_read(pc->mmio_base, TIEHRPWM_TBCTL);
+	pc->ctx.tbprd = ehrpwm_read(pc->mmio_base, TIEHRPWM_TBPRD);
+	pc->ctx.cmpa = ehrpwm_read(pc->mmio_base, TIEHRPWM_CMPA);
+	pc->ctx.cmpb = ehrpwm_read(pc->mmio_base, TIEHRPWM_CMPB);
+	pc->ctx.aqctla = ehrpwm_read(pc->mmio_base, TIEHRPWM_AQCTLA);
+	pc->ctx.aqctlb = ehrpwm_read(pc->mmio_base, TIEHRPWM_AQCTLB);
+	pc->ctx.aqsfrc = ehrpwm_read(pc->mmio_base, TIEHRPWM_AQSFRC);
+	pc->ctx.aqcsfrc = ehrpwm_read(pc->mmio_base, TIEHRPWM_AQCSFRC);
 
 	pm_runtime_put_sync(pwmchip_parent(chip));
 }
@@ -511,14 +516,14 @@ static void ehrpwm_pwm_restore_context(struct pwm_chip *chip)
 {
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 
-	ehrpwm_write(pc->mmio_base, TBPRD, pc->ctx.tbprd);
-	ehrpwm_write(pc->mmio_base, CMPA, pc->ctx.cmpa);
-	ehrpwm_write(pc->mmio_base, CMPB, pc->ctx.cmpb);
-	ehrpwm_write(pc->mmio_base, AQCTLA, pc->ctx.aqctla);
-	ehrpwm_write(pc->mmio_base, AQCTLB, pc->ctx.aqctlb);
-	ehrpwm_write(pc->mmio_base, AQSFRC, pc->ctx.aqsfrc);
-	ehrpwm_write(pc->mmio_base, AQCSFRC, pc->ctx.aqcsfrc);
-	ehrpwm_write(pc->mmio_base, TBCTL, pc->ctx.tbctl);
+	ehrpwm_write(pc->mmio_base, TIEHRPWM_TBPRD, pc->ctx.tbprd);
+	ehrpwm_write(pc->mmio_base, TIEHRPWM_CMPA, pc->ctx.cmpa);
+	ehrpwm_write(pc->mmio_base, TIEHRPWM_CMPB, pc->ctx.cmpb);
+	ehrpwm_write(pc->mmio_base, TIEHRPWM_AQCTLA, pc->ctx.aqctla);
+	ehrpwm_write(pc->mmio_base, TIEHRPWM_AQCTLB, pc->ctx.aqctlb);
+	ehrpwm_write(pc->mmio_base, TIEHRPWM_AQSFRC, pc->ctx.aqsfrc);
+	ehrpwm_write(pc->mmio_base, TIEHRPWM_AQCSFRC, pc->ctx.aqcsfrc);
+	ehrpwm_write(pc->mmio_base, TIEHRPWM_TBCTL, pc->ctx.tbctl);
 }
 
 static int ehrpwm_pwm_suspend(struct device *dev)
-- 
2.43.0


