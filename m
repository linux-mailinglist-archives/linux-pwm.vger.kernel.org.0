Return-Path: <linux-pwm+bounces-7779-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B1FCAD916
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Dec 2025 16:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F80F3011FA3
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Dec 2025 15:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD4C2EAB83;
	Mon,  8 Dec 2025 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMyOsaJU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D622D73A6
	for <linux-pwm@vger.kernel.org>; Mon,  8 Dec 2025 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765207303; cv=none; b=IWybXeRE9Se8wzQAkrjjsVRZfNwtBngkeJfjrKsypmvyxU8UbQk+VvyUP7PCz5w1I7y9IrxjDrUqb6MpfQAIgtnc1ISYbNut3futclckH5XOTFIaeuL9HM6l/4kObXzOtNFcLNqZHyX5P5sRfDXfnarACwo5BsLHBelnDqMt7u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765207303; c=relaxed/simple;
	bh=tF8GYHsih3o9B0YaDZiAj7rjm0YqBZPAKJ6MRA0M9uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPwKoBujvSS0H9qm/Ulm9ZMumFUj66ZH7rRUus8D0101ttF/tQy6cjftNGNpl0BhL9JmCjiHjSdfl5BKRc/pgQPgOlJkjYPAPTmDDgti6BBeHttCI71cNKCgR5UvfQK9zSrrgksB4Nit4nLhoHt+DHVp5uo6hDyEIjU/g6VwhBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMyOsaJU; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-641977dc00fso5705362a12.1
        for <linux-pwm@vger.kernel.org>; Mon, 08 Dec 2025 07:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765207298; x=1765812098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvIclrXTCCDVb1tT0Tz5uI8Tzn8Nr2KWj9swXAYTYuQ=;
        b=gMyOsaJU46G67jRxrlH/goJ+usklO3Yv9t53XWgB7qii8SOI5atdfa06EUKL2Xz5ZO
         JmN+dMun+EHgtnMu92cKOiyqz3yFcWuMiSc9TXFVucwglrWSaX9DT6lw7M9MrtxXko4B
         /PBQK5pYHtdlsv/sQqUWZq9Eo5XSCJJSOkiX41KP2551N3DDAtGrj0cOA9gZkGnBKgir
         Dvj96wV2XYqdcGooo5cILnBAms+pGGH8ojHC2/OpGwaSZAjRqGdfQDDoebozsB459IGK
         r4lBs3k4dQRahoomhMAYvruaEhPVTIRLV6jAgUIyCoX31FUFn2R7nybG2WDbQdxu0eFE
         3R/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765207298; x=1765812098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XvIclrXTCCDVb1tT0Tz5uI8Tzn8Nr2KWj9swXAYTYuQ=;
        b=cB7qA6+5yB30P3Rz01wuRgQOnNmlsWrYmfS+ALw0H+YXOFiIb8O59zC26d4QlzFuMY
         fq3yO2wkxuiWlMLMMhOb12PRg3nCr9K7h4DMaG2wngoPk2e4ScVcSmO0LIoSayD5m/v6
         LhVbiAwaEgwNeV2x7JJmxqHZ+OeAfpXnUjM88ThRE+8JwGpWOIxJ8w+ZFBZcNU6fgMu6
         kOzfl7rjkgBZuOflWzDepY2Jh1v3ixSOLxbnDX4grWfDRCxKUCHYsraXUMK1vRbP54oN
         gXKgOPUC0AzhQJVdJPOVu8M9Rp4ng0DFc4bd0oOglcDg1vQHpyjfw/g63tvE+xN4PNxK
         CCrA==
X-Forwarded-Encrypted: i=1; AJvYcCV9XijmhSaeUzo/s+znC9yT4fZ4DprcMg6JcKgwYrXLj/H8yXLinMBGy+kP7pUi8SqPDTKQZ9aCnoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWSIcFS73KRdeE/aonHh7JhAe3fqbe8oaMXXiZngJ5aLgjYvcz
	El2tjYZ66u3ho8PB7TJPa8snZ2JZ15Fc3zBKnyp0LyppDhBtW4teb4rR
X-Gm-Gg: ASbGnct49EknH0bekmOAZht4ToRH5I86HXBWHx4uFQOXimTseKFAL1PRZ6uufD5Cwo0
	FBK0vKK5Cb9k77vjFp3WHpW7pL6Qf9izrRsTN2i4kLuzsHvOWby6/7W98lM1WnCdTjquzBRLtiC
	ByEBpyP2f8CbTkvHZJvTTy4+1aT+Xm4yl4PkN7GT7AlwWqXYHkjMLi8fVDdptjx7EaVjRLMyqiu
	uJGhIe6Kby5GjltziN4uJiDz8a48qpPl5Li3lT8v9ffVOsiv6Rb80PHvhE8nYc/ovLglLYOoLEl
	aVINM16OyUOWyB7a7x5KuSnMh0HTCAEWzBxWMOW9060kBa/h4OZE9Jb/DQS5Ylziz/a+wuCwp5F
	tdEWduL8OQ8TdvO/CBwZrBQmtC7SgkTgkUf/hx8oiH8cDq8OseMEZeZ5vZvhuHnYEAtMqdzGxtE
	i2xJrlNIUbJuuDSsQbtstQ7Ks9pM+0tEj9AurLFCtWgmCDa1qdZjHqj4pI1Xf2adRB7kipzplL5
	19amYzeuX+Tj2z8
X-Google-Smtp-Source: AGHT+IEvrdFD9FgeW/bA4hUzp/Jbiem9O8wCDG3yvb5HD0CZ4A7m/Ceg6xhg7uyFT48QS210VBjCJA==
X-Received: by 2002:a05:6402:2714:b0:647:8d63:d8b4 with SMTP id 4fb4d7f45d1cf-6491a1dc13bmr6927676a12.6.1765207298136;
        Mon, 08 Dec 2025 07:21:38 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b412deddsm11547484a12.31.2025.12.08.07.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 07:21:37 -0800 (PST)
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
Subject: [PATCH v4 3/9] pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt_chip
Date: Mon,  8 Dec 2025 15:21:20 +0000
Message-ID: <20251208152133.269316-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208152133.269316-1-biju.das.jz@bp.renesas.com>
References: <20251208152133.269316-1-biju.das.jz@bp.renesas.com>
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

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Dropped field_{get,prep} as mainline now support it.
 * Updated commit description.
 * Retained RZG2L_GTCR_TPCS bit definitons
 * Replaced gtcr_tpcs_mask->gtcr_tpcs
v2->v3:
 * No change.
v1->v2:
 * Collected tag.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 2f424a7b05cc..5a8e5a3eb1b1 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -77,9 +77,14 @@
 #define RZG2L_MAX_SCALE_FACTOR	1024
 #define RZG2L_MAX_TICKS		((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
 
+struct rzg2l_gpt_info {
+	u32 gtcr_tpcs;
+};
+
 struct rzg2l_gpt_chip {
 	void __iomem *mmio;
 	struct mutex lock; /* lock to protect shared channel resources */
+	const struct rzg2l_gpt_info *info;
 	unsigned long rate_khz;
 	u32 period_ticks[RZG2L_MAX_HW_CHANNELS];
 	u32 channel_request_count[RZG2L_MAX_HW_CHANNELS];
@@ -332,7 +337,7 @@ static int rzg2l_gpt_read_waveform(struct pwm_chip *chip,
 
 	guard(mutex)(&rzg2l_gpt->lock);
 	if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm, &gtcr)) {
-		wfhw->prescale = FIELD_GET(RZG2L_GTCR_TPCS, gtcr);
+		wfhw->prescale = field_get(rzg2l_gpt->info->gtcr_tpcs, gtcr);
 		wfhw->gtpr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
 		wfhw->gtccr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
 		if (wfhw->gtccr > wfhw->gtpr)
@@ -372,8 +377,8 @@ static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC(ch), RZG2L_GTUDDTYC_UP_COUNTING);
 
 		/* Select count clock */
-		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_TPCS,
-				 FIELD_PREP(RZG2L_GTCR_TPCS, wfhw->prescale));
+		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), rzg2l_gpt->info->gtcr_tpcs,
+				 field_prep(rzg2l_gpt->info->gtcr_tpcs, wfhw->prescale));
 
 		/* Set period */
 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), wfhw->gtpr);
@@ -438,6 +443,8 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (IS_ERR(rzg2l_gpt->mmio))
 		return PTR_ERR(rzg2l_gpt->mmio);
 
+	rzg2l_gpt->info = of_device_get_match_data(dev);
+
 	rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(rstc))
 		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert reset control\n");
@@ -480,8 +487,12 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct rzg2l_gpt_info rzg2l_data = {
+	.gtcr_tpcs = RZG2L_GTCR_TPCS,
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


