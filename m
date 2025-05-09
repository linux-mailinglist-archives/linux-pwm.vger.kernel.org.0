Return-Path: <linux-pwm+bounces-5871-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E706AB0F69
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 11:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 811C97B7991
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 09:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CC828D8E7;
	Fri,  9 May 2025 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="f0cHU1Fq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FDA28DEEC
	for <linux-pwm@vger.kernel.org>; Fri,  9 May 2025 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746783721; cv=none; b=LEdQN9kwgTaNXlFLSu6/KIY3kBH4OTZdDDb1hmzSq+nhiP8vybKYj9v35QWcM1M38I1StvbJdfy3s2FlEO2TzcTAfbFydX+Qc1RDi7023LPzNtgDNQw/CcYQaR7X4ARce9iRR5E/0Ait6YEyOCaRDfozX1/6UvOrIK/Bj4uB8FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746783721; c=relaxed/simple;
	bh=to9iLI09IuUpk5B76wu/vxa60Ry89kvmQ/y3CQWanPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mdmu1RRTlOxqhVZUh87lsij1GTOi5BsaArwa88hRhom/rukzcuj7SZsGWsmOX/ab+HFnIBRu8FUSl5rNn8B006RxcEYg9Klir4qcHrPTQxI7kGgKT2P7sniCkoPom7owiBU4giFLvtKC4fJfeSPrH/KY9aSY0kG/Dt+dSgljbjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=f0cHU1Fq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7411f65811cso1443820b3a.1
        for <linux-pwm@vger.kernel.org>; Fri, 09 May 2025 02:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1746783718; x=1747388518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=db3r56u6WbxunAQsqmv+qz1Bx6fNV6R3VtqVTo1N8lM=;
        b=f0cHU1FqsQM77D6YjCqt1Q7VxDzwAtqjLwRwNFDP3SyCh9VLzkZSCnV9RSGKH/eqzt
         nMfeazoI2Ryi8htOswiNeps7mLoY1eIS2q1yG8eQMjXQJwhvuRVuXg9eH+eFeXcV8MAu
         e2iAq0GZb/hgqAfSb3/gseSrneanO8q7VZ43cCz0qRhtnUEf0Xdg1S4OjLgnJIXAd0h3
         Gzvuv+G0+oi+LhMJbc/K3kpA7+dytJs9+F/9bE5Cnn7ZiL44bY3HXl9bS4BVG3fDnM9H
         xj3b71GR0vFxbQTpbkuumJDTk/Tmuj55ZrAXWld7+B3Fsbfc3+Hus3EUyU4/SHSsBlcy
         NA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783718; x=1747388518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=db3r56u6WbxunAQsqmv+qz1Bx6fNV6R3VtqVTo1N8lM=;
        b=YJa57ofCo0CdHqz0Wb80cb+K7DcIUFBl97Ve0KV8HEOQvtgYEmu7u2WGFBTBhVC9m4
         c7GGUKfEHYqGHRSSxVUsoUlaZRbpyNUSfRaxyqn11ITjUfU+H8SBLNCKh0RsrCTAdKJ4
         jpVsJdtpQn8gWnNu9zKahG6V3y1t62ZUOcQoNZ8Aw40EYp8y5dnthg+iixi0epEq89NX
         VXsEE9IRoXn5+mlRm3SIeEXkUzCRI/tL78yB8Mp+yV3+OeHlccEzZOar2xRP37Rdt+fg
         49FZvWP+GyqszK1vMGNC11ZIphCvYPATEC9OeChRyS+iyaD7h77kTmojNr1ekNDH5hsB
         Br4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwn/hzRu/vXcEMD/AN+DsB7wLtW4bT3JoraldGB6PsZkhs6TZPSV4sgBiooJOp2S4dTvjnoctKCyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPuzAHVgWfwofCGie+PlFDN3FDjY32a08/e3AAm3dsW4zYkGsH
	yasoa7+DdWWRHuLH9VU+AWuTfFA6P+jgkp3E9vehZZXMeJopjg/mbzn6Zl4XNsc=
X-Gm-Gg: ASbGncu+nqMRCoxWYCF8HPj2V5Z1QPI1KpMvV0TK7Z7ghXbkaPQoNoEBqYj7/wA2bw9
	vF0e5HlKVQEpwuAa82+kZebBWFal5huTvhn2DUuFDqnXLHbsYjaVjE5Tq1dcv6N9TW/QOJGcVwf
	c7b2kESwXJWvM5ETtHmLn+2VhnMF5BEuynnPOUdfA0NhYtVLjbmeTdabbPBtJkKODfg+Q9riYfr
	8hTifiA6ya9gqDNGFG2uGCu01PqUlPD2pUCNbHIg2Hm/sVKSZUb08sKyKjb1cNWt1uH6HXSn2KP
	oV1mODQCIqWGoJRDr4iiifWwPWZDLNbif/cXkQlicWKLNgZKjaZlDSCkPQBL4w6kyTOC/5pIXIO
	DJA==
X-Google-Smtp-Source: AGHT+IH5OUjlU44wPTcS9YvNdweW8Hmi+ylHBcWO0ZjkJN+zsQnLZEzF4So5FHTc3N4rkAEKt0P6Pg==
X-Received: by 2002:a17:902:e744:b0:22d:b240:34c9 with SMTP id d9443c01a7336-22fc91a9093mr48509735ad.53.1746783717970;
        Fri, 09 May 2025 02:41:57 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271c38sm13271035ad.119.2025.05.09.02.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:41:57 -0700 (PDT)
From: Nylon Chen <nylon.chen@sifive.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	samuel.holland@sifive.com,
	Nylon Chen <nylon.chen@sifive.com>,
	Zong Li <zong.li@sifive.com>
Subject: [PATCH v14 5/5] pwm: sifive: clarify inverted compare logic in comments
Date: Fri,  9 May 2025 17:52:34 +0800
Message-Id: <20250509095234.643890-6-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509095234.643890-1-nylon.chen@sifive.com>
References: <20250509095234.643890-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reference manual says "pwms >= pwmcmpX -> HIGH", but in Figure 29 pwmcmpXcenter
is forced to 0 via an XOR, so hardware actually outputs HIGH when pwms < pwmcmpX.
Thus pwmcmp holds the off-period count, and the driver must invert it
to expose a normal active-high interface.

Co-developed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 70cf644cde4a..4a07315b0744 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -4,11 +4,28 @@
  * For SiFive's PWM IP block documentation please refer Chapter 14 of
  * Reference Manual : https://static.dev.sifive.com/FU540-C000-v1.0.pdf
  *
+ * PWM output inversion: According to the SiFive Reference manual
+ * the output of each comparator is high whenever the value of pwms is
+ * greater than or equal to the corresponding pwmcmpX[Reference Manual].
+ *
+ * Figure 29 in the same manual shows that the pwmcmpXcenter bit is
+ * hard-tied to 0 (XNOR), which effectively inverts the comparison so that
+ * the output goes HIGH when  `pwms < pwmcmpX`.
+ *
+ * In other words, each pwmcmp register actually defines the **inactive**
+ * (low) period of the pulse, not the active time exactly opposite to what
+ * the documentation text implies.
+ *
+ * To compensate, this driver always **inverts** the duty value when reading
+ * or writing pwmcmp registers , so that users interact with a conventional
+ * **active-high** PWM interface.
+ *
+ *
  * Limitations:
  * - When changing both duty cycle and period, we cannot prevent in
  *   software that the output might produce a period with mixed
  *   settings (new period length and old duty cycle).
- * - The hardware cannot generate a 100% duty cycle.
+ * - The hardware cannot generate a 0% duty cycle.
  * - The hardware generates only inverted output.
  */
 #include <linux/clk.h>
@@ -113,6 +130,10 @@ static int pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	u32 duty, val, inactive;
 
 	inactive = readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
+	/*
+	 * PWM hardware uses 'inactive' counts in pwmcmp, so invert to get actual duty.
+	 * Here, 'inactive' is the low time and we compute duty as max_count - inactive.
+	 */
 	duty = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - inactive;
 
 	state->enabled = duty > 0;
-- 
2.34.1


