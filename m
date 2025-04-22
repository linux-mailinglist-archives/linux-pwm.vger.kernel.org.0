Return-Path: <linux-pwm+bounces-5648-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EB2A962F8
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 10:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689323AF033
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 08:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605CC25B69E;
	Tue, 22 Apr 2025 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Zdek5f3G"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337825C6EA
	for <linux-pwm@vger.kernel.org>; Tue, 22 Apr 2025 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311349; cv=none; b=PEj5s45NC1F5W/E+qP5xkY7kSs9e4pAFqA6dbFhAyR4XC+/u56LM3MX6UZUMms8kbwT1iEEnJX2sLQ6DxQiZg+1MnnRIPR/UEYUYH6iTLL6WvNR7++ozMf7RrEomSxtVGAuhwjPUQDYX4QF5ZaWNe5voHc5ed+IEdlnNJyszN/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311349; c=relaxed/simple;
	bh=K6w2WFh9gMEo/5yGUkNlU3R7QRO5KBl4M7IcHSkIgaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KhVqYLliKRa9ldErxKFaC/8f9YqJEE+4oKtwFC6pmPNs2/jpHMBZb3e0kIosYZTdEBEAzSLkMKqjOhF/USJ7IDqZz4XgdLas3uZcBXlCCfGrZa3cGGW82s9dj/sFuH5Qj77alW7+RzYOTto34PVzC+uzZwc/HXu72pD8WymgesM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Zdek5f3G; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22435603572so50052435ad.1
        for <linux-pwm@vger.kernel.org>; Tue, 22 Apr 2025 01:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1745311347; x=1745916147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89q5KIPhl5BwNYn6HnfG+6c7PCM/cs0DxATEzoR1SG4=;
        b=Zdek5f3G6DqW/cq90zlMNzu40I0wOZDSfg5rtDi+cMm1Ta/YYoyhg7e7s+hOxbtwf+
         AgUcbLeui3dZP3qxNzYMQC8VfwDyXnDJVUrDAzgwrDXofydUPtbUOdpBbIi7kgRWA3cW
         xqUxSqNstO5OfgmlY36cym1jGd5WOKOLUSVAc1IHTh8CoyoN1JPp+/5maQt20N7iqOO3
         2pU0kH7NS/RHdnDtl0a/CLsGh6wJpmg+cNAJ2kLBJFNiaovCqK8zF82bAo8HfhA1OGL4
         WnyHHz6LPMGMxROtKGDBs8j1JW6+QXDh07PRgt8jine9qGWWe0G2PjCxGOKvMxaUgl9a
         1g6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745311347; x=1745916147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89q5KIPhl5BwNYn6HnfG+6c7PCM/cs0DxATEzoR1SG4=;
        b=d2BJKXAGHX3UX2JtoqoQwA88XQZm6eykPe02iX/lBJKHBhCsVcStX2aj8APNc+PcQO
         V/gZ6e27kSShNSg7XLktarYG4t4z3mfynv+bbpYBqt++UpIwcWnBOT9amM4PAvvfMDIU
         F7HykeXPn6Ktfp2O8frLRsP/ydmkKJlkVDA3e0w05M2TSFy1/ZhJAKfU1eYmDz+xgolT
         rvSzbAY2Hjwvrf7i/ICDiEKTG79jD7M/ofvynlEwElILUoltLDl/eCW91epoExqytcW+
         qB+Stj/7xXA/Td1WJRs6xYMqe2QNwp4A2P3rvQG6jDZj+wHkFF7h9OXUpsuJN1FR1kuN
         xa7A==
X-Forwarded-Encrypted: i=1; AJvYcCUmdzZpQL4uZt1dBZeG2hWRjkMLadhcvENUa86CYPjOGOryqVnr5xLYbT2WUrRl7PFefb7RzFIxU9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi719KXpuPxaNP6nxayr0IBriiAivMbru0c50WM3+WZQPaVjXP
	+g/71uXS64SD7aKehdjH/FHTyqosB5UBA8LZit+aGy//EIZNMOsGw1AH9DnB7j4=
X-Gm-Gg: ASbGncvRkIdeZ9ISae0daG/dNN9qL2FexX3KeFZThUFtKhtM9oUspTXkzLgXpiybIJd
	SjkYpr4qFnZsB9aaGILuHTwNUxqZcr1rXrhmCFf2YyIllErbvgZuEARWhgkaMvd5W6K5CnKgUAg
	+TAOguWCe5QFdbygoijxZlJoyCmK5wz+xwRUdUbejEKkiH3FzRwHoWYT3jjwHVVSb2FWCOOCsZs
	U5v/Xpx7B798/GcXczT1XhSHZz7tHHayzlMqusdRiBaT3xjb1vp0Ugc/CxbeuN9C1yd3g/rlHE5
	/fyEVGdA5JVu+XRSlNOFDMmQbj2FRc3WxvfDr7ii59ZWmClUyko1/cQMEP5ZXcDgACxyjy4ov+N
	9yQ==
X-Google-Smtp-Source: AGHT+IG6i6LASvzQIRsj01arYQDJviqBEn/oP/EmdDE8D+TJPVgUwa41kw2BKL7zCVHOsNc3CK8D2g==
X-Received: by 2002:a17:902:cf07:b0:220:f140:f7be with SMTP id d9443c01a7336-22c53601243mr243185875ad.41.1745311347173;
        Tue, 22 Apr 2025 01:42:27 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf90d7f7sm8038343b3a.82.2025.04.22.01.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 01:42:26 -0700 (PDT)
From: Nylon Chen <nylon.chen@sifive.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Nylon Chen <nylon.chen@sifive.com>,
	Zong Li <zong.li@sifive.com>
Subject: [PATCH v12 5/5] pwm: sifive: clarify inverted compare logic in comments
Date: Tue, 22 Apr 2025 16:53:12 +0800
Message-Id: <20250422085312.812877-6-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422085312.812877-1-nylon.chen@sifive.com>
References: <20250422085312.812877-1-nylon.chen@sifive.com>
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
 drivers/pwm/pwm-sifive.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 065d6d2b84bc..a1f13801bca4 100644
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
@@ -161,6 +182,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(frac, state->period;
 	/* The hardware cannot generate a 0% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
+	/* pwmcmp register must be loaded with the inactive(invert the duty) */
 	inactive = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
 
 	mutex_lock(&ddata->lock);
-- 
2.34.1


