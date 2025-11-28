Return-Path: <linux-pwm+bounces-7714-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73DDC9072C
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 01:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B5C3ABD5D
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 00:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C648C23C513;
	Fri, 28 Nov 2025 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8UvmslD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2585423817E
	for <linux-pwm@vger.kernel.org>; Fri, 28 Nov 2025 00:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764290347; cv=none; b=RYGvarqD/OBYDxWae9/NVpRn57BHfN7QYOGMq3UHlq3QxYv+GsCgATN+rCek9KEfmgMhK/XHeeAoM0LhMGDkPu/sZMFc+XEFH5ERg9AXxyFx/g8hRipVAN+JSTuFXgNlbGmCXNi4RFMUj4V4x7KnOd1GjEtxf7m5M4f0hzfJiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764290347; c=relaxed/simple;
	bh=OSim1mj9HkSTe46cFg4rOkLc0yUfhq8IhSvph0dkAAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5mEwVkYpUEBS9qdMl+Vw8Q7w+75hbR7SfzIzKDc2NLgxPeXODeA69C01lS2ih3CxakfK+1xuhCcWEACegjNwu3/y8x418qvvT1lMSgkyqnL8jHUuyo5L3MMePjvJgUhEYyNd9YuSz+icd04D2FTYfyUG2bhwmKzxzpL53DlBQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8UvmslD; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-11b6bc976d6so2809282c88.0
        for <linux-pwm@vger.kernel.org>; Thu, 27 Nov 2025 16:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764290344; x=1764895144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afOk1ITr+hgg7p4RIrqg51cCVfFBtTkqq0M/4LUt7uo=;
        b=L8UvmslD3fd3bSbhWrunjz3CO1hEf4yuyNX1j+NssbDyWmUoyIPrPANbHjVtMf5slS
         LsOZsww5Sd3yhB4q/Tp2zP7BAh3HpsEanpTfJmwuxPEDjEV8XJ3UeQ9+8YRQB+4ytI/S
         tOgP6BPA9vJMrhJSe6tHr7vDkqkSosm/VvNIjWFixJMDulpD0pA0JOpVGxlU+i5dh+EM
         3Rd+xSUviS8w3BzQDTOBum8oXP+5as3MyLNMmxTqQ/t7SMGoLMFWSPMHvswIAjwYF6Hx
         mGAjsZR9BDg6cIvNNq4x7Cjitwl39cwZq5BUwhToEQZWlr6LA36pEZayzi+sROLDcCBn
         fBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764290344; x=1764895144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=afOk1ITr+hgg7p4RIrqg51cCVfFBtTkqq0M/4LUt7uo=;
        b=N42FZC4d7BZHX4KLQK0YPkf497rCDU1KF3a89NjKWe5iFBaCWGl/0Mcg8W3Mlf7nUn
         A5WrcPr1BjQBLdFM2i/C1O0DEnU3fkXvVaAwRmTSzcgAmo2zDqQJhDXH9P9fFsyuHK20
         Z711rXBRfISDpoOY4Sw+gDLmgg2F6vAwRuWey6I4ieRDhZeIzcXVEJtDDBKMHHad6ufR
         KBNas666mOIzl4N3gnodBf2z+Iy9RN+tlE9B5aAcuBkttldmbDw+dMRzzUoktfFFrLg5
         yJX0l1foe6CcwXQuNB6KN//Naxe2wA4mOqXmehsiPGdAMlOA6/d1rcFdnodc66XvBOiG
         wkNA==
X-Forwarded-Encrypted: i=1; AJvYcCXwd/Tkm3/eQbFSpK+0djYCJ6UdHlBHN8X4sXmmRpDf3i7JWdPfrcfdK31X8bIVowYGneQkdvHCozs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy49zpVlagXA78K1M4LpBaiwfAVmRHmmiPb5QcNPylAK0AQGtzF
	0BPoLn2WTYJyXgWdTf9Yg/sNSlurViDGcIdzChBg6rnjCUt7rhg2dbLHx1YK3Q==
X-Gm-Gg: ASbGncujj/mHBXCd0wq8BLm5F+sJr0RdVyvUv8Abt8RVPLI8cHwOF2+aBacOp+FAAOb
	Wor3wC1j56vVJSrc2Oy1nRx8GV2qKu/XXfg4kQdO9cqJ0rkzwHPmRxr0+hx4d8M1C4VwSEsZSuE
	cAkCi9X6ZNtzyw6QRy+XWMmBReggUXZjH56e6P/XTf5HSdluhwUguzKdbNMem+lQapbufSGcqXE
	cS777/akR4di9ftGB9rF7QyFlNwPSHGN4NXgo52K5NzoR2vp/OjGg51nsPqZ7/iM2jYegltXEMk
	GpDdwXSIZK09PMXzq2UkSIgtTnCvhPf8KFnNgIRezn3F+t1eG75Xw+uuK6e5+mkEkn2gkfkG9ek
	MjmkKS13BCW9SjSEikFnBwlJ+xkn9JZZBOOem37WxrgYKmRsU5ce89vhJax7GTapC1IGhf+Qx4P
	yeACUWmHo67cIllKeFlqPxwageouHgEvZsnkRskHIkq+gZxa6bmzxzuQ==
X-Google-Smtp-Source: AGHT+IFT8RsjgV6EDZ8DwSkn6xgloOqqY5oHeZflkVbmSve7CDF6qj9GaFa5/HSngXC5dIgtO9Drrg==
X-Received: by 2002:a05:7022:a93:b0:11b:a738:65b2 with SMTP id a92af1059eb24-11c94aefcabmr20854764c88.5.1764290344092;
        Thu, 27 Nov 2025 16:39:04 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee7076sm12404561c88.4.2025.11.27.16.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 16:39:03 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: [PATCH v7 5/9] pwm: tiehrpwm: use FIELD_PREP() for prescaler fields
Date: Thu, 27 Nov 2025 21:36:30 -0300
Message-ID: <20251128003634.247529-6-rafael.v.volkmer@gmail.com>
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

Refactor TBCTL prescaler handling to use GENMASK() and FIELD_PREP()
instead of open-coded shifts.

Split the prescaler bits into TIEHRPWM_TBCTL_CLKDIV_MASK and
TIEHRPWM_TBCTL_HSPCLKDIV_MASK and introduce TIEHRPWM_TBCTL_PRESCALE_MASK
to cover both fields. Use FIELD_PREP() in set_prescale_div() to build
the prescaler value, and update ehrpwm_modify() to clear and program
both fields in a single call. The removed *_SHIFT macros are no longer
needed.

No functional change intended.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 4b8b4a9e7379..41af1bf74cbb 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -25,7 +25,10 @@
 #define TIEHRPWM_TBCTL_PRDLD_SHDW		FIELD_PREP(TIEHRPWM_TBCTL_PRDLD, 0)
 #define TIEHRPWM_TBCTL_PRDLD_IMDT		FIELD_PREP(TIEHRPWM_TBCTL_PRDLD, 1)
 
-#define TIEHRPWM_TBCTL_CLKDIV_MASK		GENMASK(12, 7)
+#define TIEHRPWM_TBCTL_CLKDIV_MASK		GENMASK(12, 10)
+#define TIEHRPWM_TBCTL_HSPCLKDIV_MASK		GENMASK(9, 7)
+#define TIEHRPWM_TBCTL_PRESCALE_MASK		(TIEHRPWM_TBCTL_CLKDIV_MASK | \
+						TIEHRPWM_TBCTL_HSPCLKDIV_MASK)
 
 #define TIEHRPWM_TBCTL_CTRMODE_MASK		GENMASK(1, 0)
 #define TIEHRPWM_TBCTL_CTRMODE_UP		FIELD_PREP(TIEHRPWM_TBCTL_CTRMODE_MASK, 0)
@@ -33,9 +36,6 @@
 #define TIEHRPWM_TBCTL_CTRMODE_UPDOWN		FIELD_PREP(TIEHRPWM_TBCTL_CTRMODE_MASK, 2)
 #define TIEHRPWM_TBCTL_CTRMODE_FREEZE		FIELD_PREP(TIEHRPWM_TBCTL_CTRMODE_MASK, 3)
 
-#define TIEHRPWM_TBCTL_HSPCLKDIV_SHIFT		7
-#define TIEHRPWM_TBCTL_CLKDIV_SHIFT		10
-
 #define TIEHRPWM_CLKDIV_MAX			7
 #define TIEHRPWM_HSPCLKDIV_MAX			7
 
@@ -174,8 +174,8 @@ static int set_prescale_div(unsigned long rqst_prescaler, u16 *prescale_div,
 			*prescale_div = (1 << clkdiv) *
 					(hspclkdiv ? (hspclkdiv * 2) : 1);
 			if (*prescale_div >= rqst_prescaler) {
-				*tb_clk_div = (clkdiv << TIEHRPWM_TBCTL_CLKDIV_SHIFT) |
-					(hspclkdiv << TIEHRPWM_TBCTL_HSPCLKDIV_SHIFT);
+				*tb_clk_div = FIELD_PREP(TIEHRPWM_TBCTL_CLKDIV_MASK, clkdiv) |
+					FIELD_PREP(TIEHRPWM_TBCTL_HSPCLKDIV_MASK, hspclkdiv);
 				return 0;
 			}
 		}
@@ -252,7 +252,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	/* Update clock prescaler values */
-	ehrpwm_modify(pc->mmio_base, TIEHRPWM_TBCTL, TIEHRPWM_TBCTL_CLKDIV_MASK, tb_divval);
+	ehrpwm_modify(pc->mmio_base, TIEHRPWM_TBCTL,  TIEHRPWM_TBCTL_PRESCALE_MASK, tb_divval);
 
 	if (pwm->hwpwm == 1) {
 		/* Channel 1 configured with compare B register */
-- 
2.43.0


