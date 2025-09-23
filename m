Return-Path: <linux-pwm+bounces-7342-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C79B9666D
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Sep 2025 16:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091F31889C45
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Sep 2025 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F46925782E;
	Tue, 23 Sep 2025 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGBhYd0w"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31185226D1D
	for <linux-pwm@vger.kernel.org>; Tue, 23 Sep 2025 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638733; cv=none; b=Lnp3BnbNxFbymLNFRVnk44dnAEhl8tyBd/mYgh5lsfXlSetVW8fKYS/xcCxpp+Xs02JExil5s05iqQGHJp1HRtu4llbfNxmBP8CKUSh31V8Pmtqmm44wHJRNgiksWJ+jgZPY2mtDSjLOQjyGaa0n5XMeSgIfbccPxvsDoxxRQNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638733; c=relaxed/simple;
	bh=gHfJe2wkX0a4J0T2iaI/ZrXum2g8dABmTaj/MRvdciw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PncNzHhOk9W0jshk5z1FuYqM6yIwgFVfrjkA+LrR66E72EutWt0lzJw0wnQIqYxMF2/63dTazRaE++m3df6Rx1GdP+WSTez5YH2dibimhRA+XlOSHB3sMXeQwhAWYY/F7f3VVBA2CzJgHVMdxGT9g5gjZVGXQzOqa3kpQTlWYMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGBhYd0w; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e1cc6299cso9761685e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 23 Sep 2025 07:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758638728; x=1759243528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=By9iTZQYVaW98aaM8/fCSAHAyxcTKcPpA3ibSeZs1YE=;
        b=bGBhYd0w++KpcxU7aVvecVbsR5MQIPpvzfsnOQmGahz/yh6ivnTHGt904m3D0OViQA
         JauHkmL+4FhKrV2OAgIGVLuXaGFDN5bmVWRTgWquXlIQrUTEqtmDqnLFX2w+bk+YGzd/
         an5XtmHGtTCM5NyWRJYe9ftUmkBYNXmvBHX06tdd1SIElpvh3YverTe9gMyUW1tufHpX
         hBIP0mQbTybk0fhQuYPYwvgUyQoYmRL+Fpfd0SlRfvUnTtl8pLvIqB3TJQGEeYAdEtjf
         2+B1NG7T2tBl0LNUa2HSlPM752Fw70fsSE4Bq7naPZPf8UrOSD8GVBm1s9rKHlLMvzwA
         66mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638728; x=1759243528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=By9iTZQYVaW98aaM8/fCSAHAyxcTKcPpA3ibSeZs1YE=;
        b=TBwgLhUVMD1Z2ME+X5cxcytLdrN3V0DGM7L1oEpifMEUnk4seygqQgeAgixs1PnimO
         LRg0XCYknLAUIVhDqc6CZSfjka1uoHtr4RRFKkLBANybXqm2PZjYv/7MHR0rNT52CaKH
         BhtAtmhSIOV/CExObm8c87BLNzJJXb8lC2o7wFGQzwFVQ/tsdcaj38WukWEfEMbL136R
         wxMZ+s1trSNmjYwKCMdmA6JOuN6UDnRfVa8IFzsSmZ6m9cxPhLj8T612h6gEAz3o9V6W
         aFQmdVOZNLNHqn9v0SURTJMPA0tZP3KyAS+QYwmOUnmVd4/r5C02aDIb8TRv5PfqrfaN
         cyLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlJWP2uH4IHG/mTLw2B0I5P3jdQXVj/weuzTpceoY2kmk3UAiO5Qohu74ZobUkRKpaQvxqr0/wr1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlKhIiHkB7lwI1dDiY9gTRaH5oT/pR+A2RIocvtmt74qmhRIk3
	17Zrft7ufPs7MI9BJTQRKmNcJ03L3Wo1cmsB5OQQR/5BDysyA2xCq0Rv
X-Gm-Gg: ASbGncugR56FUHTJh9kiTlIPHXB3O/8OYzBzjvtyynbjuB+OavCE6skbliBlHEXNDaH
	HRv4l+JixHLteL7teAmgSjwwct34LeS5a4sZXQ78EjKRa1q/Hxi2QIWcRpJwNFxWS4rRNMZLrJL
	57av/l1dHxjZW+ZPW5LRck4sGfW78A1iwMh0SKdjyXE78NnJFp/UQAeScreVrBRGYqQorzz3lSo
	Wpecd3LeV8MtZ8ociVMQWDjl06tyhPPyuCxIOtI4U5W3/IbvBbMYXh5MnHWmKQIGMfFZqYcXXET
	tiqGIf0xFG3HP3XUi63a/JglwMtoykcSgovhUDQSmMEibBHsobziGv++a2dgB+bYARGodeRofF1
	U4zaqmOgro0h6AQxIqQsGE+Qhbu2i0lXDhYdg7yjePGmW96VXkYSRcVkRN/tlsDfGbaJu4yB8L/
	NYQQ==
X-Google-Smtp-Source: AGHT+IGeaLZNcziJFwxEnB+ujLHDeNr3b8C5SkLS7nPKFj5AlRt42fsuSfQ2qfOOoel3vyehbrlVsA==
X-Received: by 2002:a05:600c:c171:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-46e1dadca3cmr28239555e9.27.1758638728217;
        Tue, 23 Sep 2025 07:45:28 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac3fdsm238940435e9.1.2025.09.23.07.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:45:27 -0700 (PDT)
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
	Biju Das <biju.das.au@gmail.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH v3 2/8] pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt_chip
Date: Tue, 23 Sep 2025 15:45:06 +0100
Message-ID: <20250923144524.191892-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3E GPT IP is similar to the one found on RZ/G2L GPT, but there are
some differences. The field width of prescalar on RZ/G3E is 4 whereas on
RZ/G2L it is 3. Add rzg2l_gpt_info variable to handle this differences.
The FIELD_PREP and FIELD_GET macro is giving compilation issue as the
parameters are not build time constants. So added Non-constant mask
variant of FIELD_GET() and FIELD_PREP().

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * Collected tag.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 392bd129574b..1d09fb01c72f 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -33,6 +33,19 @@
 #include <linux/time.h>
 #include <linux/units.h>
 
+/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
+#define field_get(_mask, _reg)	\
+({\
+	typeof(_mask) (mask) = (_mask); \
+	(((_reg) & (mask)) >> (ffs(mask) - 1)); \
+})
+
+#define field_prep(_mask, _val)	\
+({\
+	typeof(_mask) (mask) = (_mask); \
+	(((_val) << (ffs(mask) - 1)) & (mask)); \
+})
+
 #define RZG2L_GET_CH(hwpwm)	((hwpwm) / 2)
 #define RZG2L_GET_CH_OFFS(ch)	(0x100 * (ch))
 
@@ -46,7 +59,6 @@
 
 #define RZG2L_GTCR_CST		BIT(0)
 #define RZG2L_GTCR_MD		GENMASK(18, 16)
-#define RZG2L_GTCR_TPCS		GENMASK(26, 24)
 
 #define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD, 0)
 
@@ -77,9 +89,14 @@
 #define RZG2L_MAX_SCALE_FACTOR	1024
 #define RZG2L_MAX_TICKS		((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
 
+struct rzg2l_gpt_info {
+	u32 gtcr_tpcs_mask;
+};
+
 struct rzg2l_gpt_chip {
 	void __iomem *mmio;
 	struct mutex lock; /* lock to protect shared channel resources */
+	const struct rzg2l_gpt_info *info;
 	unsigned long rate_khz;
 	u32 period_ticks[RZG2L_MAX_HW_CHANNELS];
 	u32 channel_request_count[RZG2L_MAX_HW_CHANNELS];
@@ -324,7 +341,7 @@ static int rzg2l_gpt_read_waveform(struct pwm_chip *chip,
 
 	guard(mutex)(&rzg2l_gpt->lock);
 	if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm, &gtcr)) {
-		wfhw->prescale = FIELD_GET(RZG2L_GTCR_TPCS, gtcr);
+		wfhw->prescale = field_get(rzg2l_gpt->info->gtcr_tpcs_mask, gtcr);
 		wfhw->gtpr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
 		wfhw->gtccr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
 		if (wfhw->gtccr > wfhw->gtpr)
@@ -364,8 +381,8 @@ static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC(ch), RZG2L_GTUDDTYC_UP_COUNTING);
 
 		/* Select count clock */
-		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_TPCS,
-				 FIELD_PREP(RZG2L_GTCR_TPCS, wfhw->prescale));
+		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), rzg2l_gpt->info->gtcr_tpcs_mask,
+				 field_prep(rzg2l_gpt->info->gtcr_tpcs_mask, wfhw->prescale));
 
 		/* Set period */
 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), wfhw->gtpr);
@@ -430,6 +447,8 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (IS_ERR(rzg2l_gpt->mmio))
 		return PTR_ERR(rzg2l_gpt->mmio);
 
+	rzg2l_gpt->info = of_device_get_match_data(dev);
+
 	rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(rstc))
 		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert reset control\n");
@@ -472,8 +491,12 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct rzg2l_gpt_info rzg2l_data = {
+	.gtcr_tpcs_mask = GENMASK(26, 24),
+};
+
 static const struct of_device_id rzg2l_gpt_of_table[] = {
-	{ .compatible = "renesas,rzg2l-gpt", },
+	{ .compatible = "renesas,rzg2l-gpt", .data = &rzg2l_data },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
-- 
2.43.0


