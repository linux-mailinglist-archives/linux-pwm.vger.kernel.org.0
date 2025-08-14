Return-Path: <linux-pwm+bounces-7067-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 077D0B26F21
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 20:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B85207BD484
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 18:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750BE24111D;
	Thu, 14 Aug 2025 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3LJ4f22"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763712376E1;
	Thu, 14 Aug 2025 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196884; cv=none; b=kJSGOWs2PKqVpWvxjlGD3MaNu3QLLco/1R8CzUlpUKQtiHg7BRhf/qKTf71vYDq7N1ipvCwhS16/vattyTDbg/fATZskIsdTKIcyCn5ArZ0cJKLtjrUFwr39vOXcuOT366p8/EKH0IUftdpIRcA0DHRAtc/+KOZFEXM04+rSaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196884; c=relaxed/simple;
	bh=u0Fv0HZdRXAROjaVPIu0UprHeLZtuiVBR0g1Sb7Etnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9rcFxrWHaIIf15zqJ4GmoZvNuar2KXwxDaJVii3mjaMn/wHrlPp9YGhCwSlanSOaaZN3ZvEOMkYhmMatUdMGU6N5/5xfBwZQaBjRko4hdvpSxkzM84f8YqsSXxkMh0Z4eurabHgVrpsGNGS6BsPtUwzloSk/0sOIXtNctKSlag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3LJ4f22; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b005a3bso6203415e9.0;
        Thu, 14 Aug 2025 11:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755196881; x=1755801681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCk0KkIl7vqRRGGQZjIBlzxezwiOAQS1hqdnSHUAM/c=;
        b=m3LJ4f22gb/1J6QdZ688Hwsf6rBoZdkCB8XIaDexzBei8IDYe4I1P9BjCjPaIlcQjD
         uHXMPf8f7CQgVT0ISoHNdj4OnASxYBLfZD0sOMl/YTE1BRTD6QYwoEXEZ/tCYh/2dfqM
         ktm1y6iM7HRvaMNWXLFOpTbt9tgyMe98VNSaQWGMoFRVOOM5t9TYapzLMSwBFtNnrmRS
         c92ijAIKpD0IUCCQooabOpQ0COQnMS3jcYib7tfdmgmO8cvdCjMT+TzxP8ibcmKyluCx
         02uQvVRtb3N37uw7e/C49Tb6HoBSkaCYu10k057ltA76xDJhnH1fEGPaRop0lm+xUUAa
         Eseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755196881; x=1755801681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCk0KkIl7vqRRGGQZjIBlzxezwiOAQS1hqdnSHUAM/c=;
        b=S0RorUxruyGpwgg1OYHd1JhskDOk4//UWpt7e1jWcTb30XEzkI86lA72isZ5uP4WDK
         aBvA8LGzBotvoHLSq8RHYu2JkfjdsfNz9FrVSr2b4ftXUeP8xdpxOLz4VgAWQ16VfLT7
         2ZyR6COvbO2i1guCMtgYWlqpFXzDpBJrtcHZr27qgvknNqE3MJLNyCW8nFf0RWR3/I3P
         6imq0zhWyxZhehkFfNNuqXRGDuLChuTEOe16csEAHK/Xq6VwK2wMGoF8fJVtaiehywqo
         eyubN+xXaPqFHGKqbYvMtiSUaFdGN1QPu+LDgM+fTkQmfLN7cyuq3gedgaG2CrS1fLBE
         JoxA==
X-Forwarded-Encrypted: i=1; AJvYcCWr6oxnuXRLxCvaewKSgiCjy87qLLQDflCqJkkYb4/+fKZSrxQ9MR5JVjPmyTqRHFlISqKKUNX2eyvGxQY=@vger.kernel.org, AJvYcCWzv4VQaO0H8x7ucDHGqEUe/of8szASoN6q6B3y3pkEjCyNuCLmx/v4V07bLtBiMMWeEOb/SebFLAQasVDuo5c2BR0=@vger.kernel.org, AJvYcCXLC45LhRQ7kazs33uH2UpHTOf6F3UHVH+zzG0fkq8803MNihoDLkuWsclXXLcann2LgHXj+UOqYDW9@vger.kernel.org
X-Gm-Message-State: AOJu0YxLm4uBtnTzM3XmSBSa24AwU/FYr0dWF1Rd1iCByxs25zeuRScg
	bqWU71gVeFTpG6GGOIDfezSHOEZOIrMIyxYT8VPmH6aF8qnGqIjIKHlP
X-Gm-Gg: ASbGncvERJwPOVzVWPLO12mtXbJDXia9w+13S37Y5aO10kybKFqGxBAodaOKRO1mNBm
	DAXzQWcJjoRZCdun7Z9JomDLyeG7yLIzaQHbDP1iA+ndb/2kTGHTKCKyUjRWV/3mad9AvQ7Datc
	SMFQAxwoq/LOYLH4Qoa3OZFgkrqC0zLxmM/eJWQRvyAlXgvS5orhPkJKKdiXEthCV5kfwWMHzpJ
	bNI5iwhatrc57FcKR7ehVlS2MTpT4SEGQ2vd+0qiDygEIKpcKIY1AYZLPNYfJl1rPlvSYQvL6Mb
	8MVH+sJU3TGh/nNcIEOc8/3NX6CmOXaYZnnPStpkDMQn6bA9w8rQq+rccaFh/jQxweopmpUfHqd
	95z9CLiBL0bd6XsM6EOddzqMcNpVPm+LcZi3zquCL6N6ctNhIPj9d58XtZm2pmwrcUuOQSuCiy4
	xgdg2ZA+vE
X-Google-Smtp-Source: AGHT+IGAuNInzSydtvLMOTvjddze3kF8zFi+MgiSOs+XNI1JUSi3Z2K2iYdOzje5T7hcQHWOoxRZuA==
X-Received: by 2002:a05:600c:46c8:b0:456:76c:84f2 with SMTP id 5b1f17b1804b1-45a1b6670bemr42487015e9.30.1755196880544;
        Thu, 14 Aug 2025 11:41:20 -0700 (PDT)
Received: from biju.lan (host31-53-6-191.range31-53.btcentralplus.com. [31.53.6.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453aeasm53744383f8f.40.2025.08.14.11.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 11:41:20 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 5/7] pwm: rzg2l-gpt: Add RZ/G3E support
Date: Thu, 14 Aug 2025 19:41:09 +0100
Message-ID: <20250814184115.192930-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814184115.192930-1-biju.das.jz@bp.renesas.com>
References: <20250814184115.192930-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add RZ/G3E GPT support. It has multiple clocks and resets compared to
RZ/G2L. Also prescale field width and factor for calculating prescale
are different.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pwm/pwm-rzg2l-gpt.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index b247a6c181d5..7047359cac63 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -153,6 +153,27 @@ static u8 rzg2l_gpt_calculate_prescale(u64 period_ticks)
 	return prescale;
 }
 
+static u8 rzg3e_gpt_calculate_prescale(u64 period_ticks)
+{
+	u32 prescaled_period_ticks;
+	u8 prescale;
+
+	prescaled_period_ticks = period_ticks >> 32;
+	if (prescaled_period_ticks >= 64 && prescaled_period_ticks < 256) {
+		prescale = 6;
+	} else if (prescaled_period_ticks >= 256 && prescaled_period_ticks < 1024) {
+		prescale = 8;
+	} else if (prescaled_period_ticks >= 1024) {
+		prescale = 10;
+	} else {
+		prescale = fls(prescaled_period_ticks);
+		if (prescale > 1)
+			prescale -= 1;
+	}
+
+	return prescale;
+}
+
 static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
@@ -443,6 +464,14 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (IS_ERR(rstc))
 		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert reset control\n");
 
+	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, "rst_s");
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert rst_s reset\n");
+
+	clk = devm_clk_get_optional_enabled(dev, "bus");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Cannot get bus clock\n");
+
 	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk), "Cannot get clock\n");
@@ -481,6 +510,12 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct rzg2l_gpt_info rzg3e_data = {
+	.calculate_prescale = rzg3e_gpt_calculate_prescale,
+	.gtcr_tpcs_mask = GENMASK(26, 23),
+	.prescale_pow_of_two_mult_factor = 1,
+};
+
 static const struct rzg2l_gpt_info rzg2l_data = {
 	.calculate_prescale = rzg2l_gpt_calculate_prescale,
 	.gtcr_tpcs_mask = GENMASK(26, 24),
@@ -488,6 +523,7 @@ static const struct rzg2l_gpt_info rzg2l_data = {
 };
 
 static const struct of_device_id rzg2l_gpt_of_table[] = {
+	{ .compatible = "renesas,r9a09g047-gpt", .data = &rzg3e_data },
 	{ .compatible = "renesas,rzg2l-gpt", .data = &rzg2l_data },
 	{ /* Sentinel */ }
 };
-- 
2.43.0


