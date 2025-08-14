Return-Path: <linux-pwm+bounces-7063-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73FEB26F14
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 20:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA267BCCF3
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 18:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA3B238142;
	Thu, 14 Aug 2025 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zm0AKpHd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A36230270;
	Thu, 14 Aug 2025 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196882; cv=none; b=T8vvMtN6TnSawzdQr9eL8XY+91Kf5VpH+lVrG0ohsjkMyXt6+Z19P8OyBlQb3jlKgjnE8Yvs0nZjmpkHOrPJt9GfG9RJjR6jlOV1h87CohByYHmQXskyruhMg6p1UVBqi90EIx7tWMk7wXRM3MMNj/264hN4g8H0QmqjAL/tRWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196882; c=relaxed/simple;
	bh=7P9RQMxfnYZe9ayZSvmL1RkWQDxQBRTpt8EBlClunxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uun9Fo2JMoGiwdKip2VJlI3y5YFiZiyRd7RePuDkfMTqCgXD/VvGg+1FJMMuffGprPgmlL4oCJAdbDQRpa/aqjUj6nPmp6YD1DSm47MLhl2YlnSNPYzmdfmzHqFLmHX8ch7xvZJfoyYZnQibZ32PjJCPjD8gEisbK9COrgn5cqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zm0AKpHd; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9edf504e6so654763f8f.3;
        Thu, 14 Aug 2025 11:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755196879; x=1755801679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oX9RdwakuSJos+Ns603jeBf+/qXKiht9qzh9vf0nZbI=;
        b=Zm0AKpHd1L0sw4oyIkmqmBt8kYPiths6XfQfWWiYq6oO3+k7yVRoJ4dNF37cNBCyz7
         Sk1xM3W9cGRNVR48ZtBZisI2Se6WK4PfJUCgzaF9roS+Oqo8BdMRv29ylWz2UcFSndob
         Q90+v280Y9xa0S+uDOTS8P6KRu00sCnro40vK0+V7n7tyU867BAH4ODzeIrNHZmf8Fi/
         zRhj61bZggd+gjwTeXRWq7b1hNhRMatm57KpjeO+nGJGuu3ZLkyceuk+myHB8vJ5JmcA
         jlfmNvveEdqmMCmaBeFxGcY/aFpzHpVL439eX5qOOoWZTX+mtTNvnWh22Vj0uOzdrTCf
         CLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755196879; x=1755801679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oX9RdwakuSJos+Ns603jeBf+/qXKiht9qzh9vf0nZbI=;
        b=u6BE2RQpBFY2tmdCGXt85A6vK8oi/+VxTZTMfUQcGq4Vf5CG1j1SezFugZSpJlwzL+
         T08xfFKneBbh/iAp5GGpH8BnF4SXrfIikVtaRN13dgsrQ6Ou8Jt5euC9u893QGcf4duY
         n3tZ9VEIcTySZAL8YCDmaAclOYPQN0/RccGYVIGieK5SCcC1sVdko70OVMsfRMopBJUT
         aUMo3B2wUAs55waaeeLj4HvIyfF7VHbSQFiUJasw01Rg6/IHXMvhHVl/K41WxoqxoOEh
         Nm5WTR5K27mOgqBc/ehARvl7ArROwPwHSFPTRDul1ZD/TaICXnxTM9RzVPAM0rddMC0J
         fMpg==
X-Forwarded-Encrypted: i=1; AJvYcCUCqwkTV/KH4nVfveVxj6xB1DHmINP+8+DW+IQNP/rMTW1ql2v8QOPm49GLReEmen7jAjORgYbAvwKjkoU=@vger.kernel.org, AJvYcCWSemi7eSf2rAXyrKxS2VXrEgqpaIsNIygi4dRkdAca5Y58YJFpJCen6eoNLcqRFchslnnCGdpdFYzqpPnwSm6iuyI=@vger.kernel.org, AJvYcCWo74YcqpnSNrXbSmPDw2740YlomRTZjX46dLK0lKo5CA3j8h5szkdwPzJ8e8dCS/9j1HutKhLaPsgQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnwp88vGPBbn6xwerkqYS8B3LB7CXFipNNoZjkFOE9J2mJxJ5P
	R67AJ2rFkm3I/5d4o9VBxKeeQShakal0MNNBInrCel49jOEPPGZIUncz
X-Gm-Gg: ASbGncvQUFazc3zLTvkkE2zwdeRXcAb9s+z1VsmQN3vMhdVcXwIKSAyxScUunHXmOD7
	5PsAPIU0GFULhITTho2LmFb+/VfgN/hT6b9Ar+MRMMSo2aAypQj55UhLgaK3Z6DehG5oWinJnXu
	vVCRdiJvw50lAjD2ZOeb1X8+8cNfI2wJUExjiFgQziSAiP/thDE2nXn6ozbEJN81CHRcuiL2QAh
	mzcHq7IWvkJM4LlK79SydBr+nuoF1SOxhX0juxVMbmUewXo1F2LhVzZljunvqi6OWcxjTTTjed/
	f/xEX99GdDsMqF82KdRVZN/zOjoAWmQh7mNvZ04v4wmHrUwhxNVGcJhTf19ckuHCai4Nx5TDwsn
	I67sMR7HQpNoeEwVurjQ+QJDwAoMqfxGHylKTJwE7fBm/TFDOrm93cucLZ76ep0gtWdgbTsVCwQ
	==
X-Google-Smtp-Source: AGHT+IFJCN0PYyIVxRhegWZuyYhBJnyddimqMqmbZlDZcEpyEIr1u/KfBKS5DhZk9bRWXgFGEdQuDw==
X-Received: by 2002:a05:6000:4014:b0:3b8:5b26:b3c6 with SMTP id ffacd0b85a97d-3b9edf5bff4mr3967381f8f.48.1755196879016;
        Thu, 14 Aug 2025 11:41:19 -0700 (PDT)
Received: from biju.lan (host31-53-6-191.range31-53.btcentralplus.com. [31.53.6.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453aeasm53744383f8f.40.2025.08.14.11.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 11:41:18 -0700 (PDT)
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
Subject: [PATCH 2/7] pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt_chip
Date: Thu, 14 Aug 2025 19:41:06 +0100
Message-ID: <20250814184115.192930-3-biju.das.jz@bp.renesas.com>
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

RZ/G3E GPT IP is similar to the one found on RZ/G2L GPT, but there are
some differences. The field width of prescalar on RZ/G3E is 4 whereas on
RZ/G2L it is 3. Add rzg2l_gpt_info variable to handle this differences.
The FIELD_PREP and FIELD_GET macro is giving compilation issue as the
parameters are not build time constants. So added Non-constant mask
variant of FIELD_GET() and FIELD_PREP().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pwm/pwm-rzg2l-gpt.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index f0a8531457ca..bf989defa527 100644
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
@@ -317,7 +334,7 @@ static int rzg2l_gpt_read_waveform(struct pwm_chip *chip,
 
 	if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm)) {
 		gtcr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR(ch));
-		wfhw->prescale = FIELD_GET(RZG2L_GTCR_TPCS, gtcr);
+		wfhw->prescale = field_get(rzg2l_gpt->info->gtcr_tpcs_mask, gtcr);
 		wfhw->gtpr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
 		wfhw->gtccr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
 		if (wfhw->gtccr > wfhw->gtpr)
@@ -354,8 +371,8 @@ static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC(ch), RZG2L_GTUDDTYC_UP_COUNTING);
 
 		/* Select count clock */
-		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_TPCS,
-				 FIELD_PREP(RZG2L_GTCR_TPCS, wfhw->prescale));
+		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), rzg2l_gpt->info->gtcr_tpcs_mask,
+				 field_prep(rzg2l_gpt->info->gtcr_tpcs_mask, wfhw->prescale));
 
 		/* Set period */
 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), wfhw->gtpr);
@@ -414,6 +431,8 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (IS_ERR(rzg2l_gpt->mmio))
 		return PTR_ERR(rzg2l_gpt->mmio);
 
+	rzg2l_gpt->info = of_device_get_match_data(dev);
+
 	rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(rstc))
 		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert reset control\n");
@@ -456,8 +475,12 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
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


