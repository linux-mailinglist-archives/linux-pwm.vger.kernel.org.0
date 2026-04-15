Return-Path: <linux-pwm+bounces-8591-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECfIMkan32nQXQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8591-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 16:57:10 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D1B40590A
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 16:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FFC53072863
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 14:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEBD175A6D;
	Wed, 15 Apr 2026 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="GRkgRyOZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5C83290D2
	for <linux-pwm@vger.kernel.org>; Wed, 15 Apr 2026 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264635; cv=none; b=BW4vEt4PMfFdBGBRrPVUjrN26VWimN+UPBmQvdKV8XCBCLqgxfOeaWXt9pib6sy+jMLHNFV3LADuD7kL4N2pbKO0mYKDojKA/aXjFGf+yZlw5AT+CMiuv4jx7qJq0LD3O/JYGt/KxZx7/XoGwxi6JQ1DA290Z/xT2AesxTFgpZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264635; c=relaxed/simple;
	bh=9qJeHZRbSFduELxueyX7SDFPcOQZv0zK9BdhVLKRq8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxp6aW6VltU/FHt3vqe2nfFw9lugAYB4+MEc9AwSK/X1/RISk3zf2LyowBeiXnWsI+thotMo2fWRch2J9Yh/k8/09yCWRebmk6V0WrBsG+LvuRYmMXb7q9XvPHX9umfS3FgB9/c1WoPdMTtewMOaZlB25aPcF5m48exljsKBGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=GRkgRyOZ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so5447347f8f.2
        for <linux-pwm@vger.kernel.org>; Wed, 15 Apr 2026 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776264633; x=1776869433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dN1czsyDMNwwt/ST8KAAFfEC2IVqy3l0935RmxW/E4s=;
        b=GRkgRyOZHpwWoqmiVFdXBpE4UqrOjYOyBPwzPZeiLouk9x9c+VkfP01wXhu3aNnYi9
         FtMwKadwBcwnx5TLNBc16NS+8/iKzFPTx5yG9i++vbcUPEFj+dZbmcnL1XW9RNDQLGGG
         glM77umT+mDS9or2/WiYznQQLEP0ATwtMEshHey5L6gbyVfrZPD+8tpZIAeIu2Xxg6Aj
         cTtSaae8L7MoAXl7I5R8MYhwPnAUfl1lrM9OGVSaCQezTP0/dWGSULnXCst/0uDc957n
         dSqw4ycX8yiyglLDuY/LIMSp3QykBckO/Qs8XNtFnY7IZaklTMeyuRr/zRXalzae2OYS
         10Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264633; x=1776869433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dN1czsyDMNwwt/ST8KAAFfEC2IVqy3l0935RmxW/E4s=;
        b=o5UREYAU1qKnMwT7gQ4xC0Dg0kAeLbZkFpCxNHPCzKMWE/lyjLcdJf+X/8itRbAYlv
         /Kn1QTFiGnOFAmEtsZCX1w9cjURRTS6Qgds3VjiOpA4u34WkvizqlrHFK5XRMi1PMJ5g
         Iw2RqvwvoLnKMmTOzrw9k+jj1UkGoKeez17dXBAXOat1hBTUPnZSGsKjK1vcbih2SZoR
         XtKtu2eSrwFXuuKI2PjHVXL61HOK2IggyEjmkRCz7BFstfVVKTV/ebsUL8m6Sismz3r+
         1EMvW0OmIu7M+1DW2Qvhj2beOiyoqCsmlzftg50xMmwJpxhD5Oftl1Jsgh8mDB3OVsLg
         W+jA==
X-Gm-Message-State: AOJu0YwSGzh1YGY7iWwve6VV7bK4eyFDOCogqmzdYNBjMDolvEuA6uLW
	EaKzOXOqWFbFSnCgB+LpWcUXqRwQlhmPfgsBIS3agQ/8EFtqCMXuFeBcFhB0vHoVJis=
X-Gm-Gg: AeBDievNsD0GLD45uw/BaBdHH+zdpR3mde3BOLtenNCYcmZ6R18WG03cv1cEojiHA8D
	5xTrCGjH/YEF8S1FNX6PKwNZgBZP/ujvC9ZZdzxqmApTe4UjPnnZm5WoO7roL8nn1Km3NnlLKFt
	2VX+OiPrfSAsN/ONp6G84kmYsebY3gokcteeM6jp7wVtDA8PmCt5gApLAXAQX7PxdIZvhbN04IF
	jUqujkLaJYVogAXeM4t+gYvMr+D7eoJalISjfokKO+C2J8dZd+vCRiqy3GlEnuTPp7i1AmM7ajH
	Qoa4fRj+kxj8R+jEnOTQhZg74bGRcyrc9wpzyB4dq/HcoTE+b+BUypRAn6E0eZ5hAAWS6GFTpCO
	MkoVirgJ5WQ/dq4SFkKkSX9bkamT2obZYKc3vyEbvPOClTkQbk+dHez8ac5bdvVxnTHDb1fWQwV
	aePUxzYis4RGnrBpgBOGxBP8vq5BoJPgAjYfo/OmwA7uWcjISxyQ9roo8uQqkFYHR26al6l43ED
	x2Jyq+rJ2AaSe8=
X-Received: by 2002:a05:6000:2884:b0:43d:7147:f51 with SMTP id ffacd0b85a97d-43d71471152mr23644870f8f.26.1776264632805;
        Wed, 15 Apr 2026 07:50:32 -0700 (PDT)
Received: from localhost (p200300f65f20eb084c777289617ec110.dip0.t-ipconnect.de. [2003:f6:5f20:eb08:4c77:7289:617e:c110])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43ead33d6e9sm6002565f8f.1.2026.04.15.07.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:50:32 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v1 2/2] pwm: stm32: Make use of mul_u64_u64_div_u64_roundup()
Date: Wed, 15 Apr 2026 16:50:13 +0200
Message-ID:  <788319f0fff963feca4df3c5fcdd471dcf70ccdf.1776264104.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1776264104.git.u.kleine-koenig@baylibre.com>
References: <cover.1776264104.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2329; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=9qJeHZRbSFduELxueyX7SDFPcOQZv0zK9BdhVLKRq8s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp36Wq+0h8W3DUxZQpoIufXzY1woEyJ2vEcI6Ty gE7fVgqv/2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCad+lqgAKCRCPgPtYfRL+ TvXYCACHODrtzojzM+GDH+KQoXVs9juGlZQxs8Z09ps0/buJOG5/BuNanRDVteKwiGuD1lPSqw/ EDTDA7D8CPKFNhCisbvPeHB/EFl1IWJkLsD6M8dXvVdLMNzBhN1lNQtdBbxVI3800i4L5FQEx0n HwxnQG082WB04KVIjZ1vTW5Tg/nowjwM10bxYnIW3UOEY0kxAij8/84WzxQ/Nf7VgT4UVuYZnKJ /hKuqIua8QIlJmM21WZpG43NSwSQ3rUUSCSvVLBxfVculBsw9zy3STZ2YPJpBL3krO/H3L9DE2G FWHIDoN33CFxASh65+tEq68zFKRcnvVpPDM/LBt+F7qFQz3T
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[foss.st.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8591-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:mid,baylibre.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 55D1B40590A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the driver was converted to the waveform API the need for this
function arised but at that time this function didn't exist yet. In the
meantime it's available, so switch to the global function and drop the
driver specific implementation.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-stm32.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 935257a890b0..c708e4a7ad70 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -193,22 +193,6 @@ static int stm32_pwm_round_waveform_tohw(struct pwm_chip *chip,
 	return ret;
 }
 
-/*
- * This should be moved to lib/math/div64.c. Currently there are some changes
- * pending to mul_u64_u64_div_u64. Uwe will care for that when the dust settles.
- */
-static u64 stm32_pwm_mul_u64_u64_div_u64_roundup(u64 a, u64 b, u64 c)
-{
-	u64 res = mul_u64_u64_div_u64(a, b, c);
-	/* Those multiplications might overflow but it doesn't matter */
-	u64 rem = a * b - c * res;
-
-	if (rem)
-		res += 1;
-
-	return res;
-}
-
 static int stm32_pwm_round_waveform_fromhw(struct pwm_chip *chip,
 					   struct pwm_device *pwm,
 					   const void *_wfhw,
@@ -223,16 +207,15 @@ static int stm32_pwm_round_waveform_fromhw(struct pwm_chip *chip,
 		u64 ccr_ns;
 
 		/* The result doesn't overflow for rate >= 15259 */
-		wf->period_length_ns = stm32_pwm_mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * (wfhw->arr + 1),
-									     NSEC_PER_SEC, rate);
+		wf->period_length_ns = mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * (wfhw->arr + 1),
+								   NSEC_PER_SEC, rate);
 
-		ccr_ns = stm32_pwm_mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * wfhw->ccr,
-							       NSEC_PER_SEC, rate);
+		ccr_ns = mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * wfhw->ccr, NSEC_PER_SEC, rate);
 
 		if (wfhw->ccer & TIM_CCER_CCxP(ch + 1)) {
 			wf->duty_length_ns =
-				stm32_pwm_mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * (wfhw->arr + 1 - wfhw->ccr),
-								      NSEC_PER_SEC, rate);
+				mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * (wfhw->arr + 1 - wfhw->ccr),
+							    NSEC_PER_SEC, rate);
 
 			wf->duty_offset_ns = ccr_ns;
 		} else {
-- 
2.47.3


