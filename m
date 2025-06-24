Return-Path: <linux-pwm+bounces-6515-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BBBAE6E73
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 20:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194E53A9137
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 18:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7E7223316;
	Tue, 24 Jun 2025 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QgWb0uLp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CA2298984
	for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788993; cv=none; b=S0DkIVGcuJm6+dkVxbXI+GQ2EBTYvB2jNCJPPEN1hKnFOii08WrA81ENkF+LF29hG610UIhzpXqLXKHC87J8TxKATJUeZXkMDshMLD/0d7/9/sb/g3hAL+nJZZgq1Byyl3RwidIZDvB/0ybFqsIlVoUMO+prUdusoku/dI1b6dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788993; c=relaxed/simple;
	bh=AeR5HOeXyWBOLfB7mM+468coOylmeYon8YOOLv3sS2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUJG2LsHKjstxOTNrI+dQ73VpYYX+sHEJ+4FfqA5G9IsQhP8qwhs3UZJaSSoRub7jdNJLNcH8L9KEhnAnbrrOTX/bQv7EEZNGh1KbA/i+Qismu2YyHuD2b24wg69M97C8pHUlSe+lupJcRAbcvgj7bXYZVOf865hqTkJulo+Sqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QgWb0uLp; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0bc9c7835so50326366b.2
        for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 11:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750788990; x=1751393790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4tdqEiAfMmZSrDkN9ucWcWrVJ1NBqGwLO8dXph+7cM=;
        b=QgWb0uLpnl7QQuU1LW7V68zPsltntQXUqyrAlCrBWDNOfHpC6xq5z0miLJ96RO7K4T
         pepCJjfC3rPq5FvjzWbLyGhojAwvhu8pY48kEeIj+RXmBbPqwcoHIfNfLhuJylTVhW/V
         biBnrAo3yGul53QurMDBAl2CvqW7Z0OSKesqAs5mtN13SYsywzZPN9ENrbAquW2R1To8
         kdb6Sqw7JGKkhW0Hl+PrUzcfni2ycdoXKmIQ5uZ2whA+TNCWxl2ddiyZ8HyjYkv389SM
         y16If3gYKhB6IhqMGUdPZQ9ieKgdcPZeS/1umyKq8w2dTzPty/D8vAW+I8rib3ulhc6g
         aXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750788990; x=1751393790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4tdqEiAfMmZSrDkN9ucWcWrVJ1NBqGwLO8dXph+7cM=;
        b=G42i15pfn7Fs5giD/bCo53DA1eth+jsNC6i+yPEk0Hc/984AaffAMWeWXhie4vRy1H
         vWAz0tlUlauN/3kWx29NoyTyZmVQX+0hoJGeWVweYgYn76Vp2wqstziH0Jc04ZK38tci
         FE1IR5hjzqSz2v+MUu57x54vwrtNsalBwwoRZQZa35Kmh04IhBele4b/MaFrnhGYMMoR
         2douZT3P/Odw/sQURCp5n0r3jcwVxia4WmtdhJ1XN94bSXEO4LoD0HW/f1RjYSV5Hf/P
         r/JDH6GnuA5TSgaYzaJI2St2SvdSAJToKnbJ2MurjS2buPox9XGoVYYIJxbxLkUP7FL+
         Numg==
X-Gm-Message-State: AOJu0YzJFVi1e+Oz0h0yit2FTY082nBbVsW3kh6e7GKig+AwzYXnsCw4
	KlqUtLraDwyL7/rk+2uJ4NNGWpAxm/6Q1+nrdRD1tNFW7M6spr6uLn1KtxquiGcecidNdITzBPd
	97LiV
X-Gm-Gg: ASbGncsdYo/TpdrsftnBn7ZNpv/naqLhpR82nXM+JGzhBIfXz3jqlic/7VJLmKJcYNf
	e6oGU+XxxoFAbo3y+vF2htjbTZPKazISyxK3no8leOQZ+CO5Mu1udKvLTxZMBtsKPWFCcsspZ24
	nr4W53lSIaIVcy9Mh+P20IgzIgGDbi6SsEJITkr7DTPQkrmh9wdIlBhREZy+BKkmV1li+/OKXUJ
	m3ScCAiuov6MLlrKChgmSW0sKMqLi506IYLjoCvh4RjPQ51VayZmbwiT0Bhql6pF7uINW/ya6Fc
	uycGyzwh0AJ0Tc9MM5llc3/oomSRPmKxr5b+SjlRr+jIHi4lBJ4Z9VxBslmzhHBZfXs=
X-Google-Smtp-Source: AGHT+IEUFcPaDicHrC6kAbAVuJBUW3hcGGkEc2u9n4KbT8XxA1Qh9pF/Jfy1ywddJWe+c7zGqGbcHQ==
X-Received: by 2002:a17:906:6a12:b0:ae0:a1c2:262e with SMTP id a640c23a62f3a-ae0bea2e0c8mr30082966b.50.1750788989758;
        Tue, 24 Jun 2025 11:16:29 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae0541b7242sm910719866b.118.2025.06.24.11.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 11:16:29 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH 5/8] pwm: microchip-core: Drop driver local locking
Date: Tue, 24 Jun 2025 20:15:41 +0200
Message-ID:  <6d6ef0376ea0058b040eec3b257e324493a083f1.1750788649.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
References: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2660; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=AeR5HOeXyWBOLfB7mM+468coOylmeYon8YOOLv3sS2c=; b=owGbwMvMwMXY3/A7olbonx/jabUkhoyo19EFDP+zZvpFbYjVt7snG2LB+ZhlY/D+i/uz3yuqu hSax5p0MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjARaTn2P5xlnEEctl+8PW1+ WS1I6FlvckbW4KGcZOL6NU+nbxM/o9PzNXbux9WzxRaZTOeMOeD5etPtrVe27/rkHNqswqevPOX mO3vxnEPpT8L2RQo1zzrC7qOSYL86lVeOsfQoU4T49lQNqWK7WNa406ZcmU7vlKQfJwSdUKkVbd z20IJf3yirvNDbmudIT1bVjVvNufvuz1/CevJQsdnirV2RVY9OZs2cKh6zxfROuubK8Huz2xs/c ajvi+0xjrb6a7NXbLt63MSWdaF8D1IijFTWNCelvprEt9w17uyqBY9ezFw/7/2hQ+4Zi88lPTR2 8720XotL7WO7eLCVXHvv//mx4pwZC/Xu5zU/3XH55+EsAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The pwm core already serializes .apply() and .get_state(), so the driver
local lock is always free and adds no protection.

Drop it.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-microchip-core.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip-core.c
index 12821b4bbf97..4ff32bb4c205 100644
--- a/drivers/pwm/pwm-microchip-core.c
+++ b/drivers/pwm/pwm-microchip-core.c
@@ -36,7 +36,6 @@
 #include <linux/ktime.h>
 #include <linux/math.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
@@ -56,7 +55,6 @@
 struct mchp_core_pwm_chip {
 	struct clk *clk;
 	void __iomem *base;
-	struct mutex lock; /* protects the shared period */
 	ktime_t update_timestamp;
 	u32 sync_update_mask;
 	u16 channel_enabled;
@@ -360,17 +358,10 @@ static int mchp_core_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			       const struct pwm_state *state)
 {
 	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
-	int ret;
-
-	mutex_lock(&mchp_core_pwm->lock);
 
 	mchp_core_pwm_wait_for_sync_update(mchp_core_pwm, pwm->hwpwm);
 
-	ret = mchp_core_pwm_apply_locked(chip, pwm, state);
-
-	mutex_unlock(&mchp_core_pwm->lock);
-
-	return ret;
+	return mchp_core_pwm_apply_locked(chip, pwm, state);
 }
 
 static int mchp_core_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -381,8 +372,6 @@ static int mchp_core_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm
 	u16 prescale, period_steps;
 	u8 duty_steps, posedge, negedge;
 
-	mutex_lock(&mchp_core_pwm->lock);
-
 	mchp_core_pwm_wait_for_sync_update(mchp_core_pwm, pwm->hwpwm);
 
 	if (mchp_core_pwm->channel_enabled & (1 << pwm->hwpwm))
@@ -415,8 +404,6 @@ static int mchp_core_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm
 	posedge = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm->hwpwm));
 	negedge = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm->hwpwm));
 
-	mutex_unlock(&mchp_core_pwm->lock);
-
 	if (negedge == posedge) {
 		state->duty_cycle = state->period;
 		state->period *= 2;
@@ -469,8 +456,6 @@ static int mchp_core_pwm_probe(struct platform_device *pdev)
 				 &mchp_core_pwm->sync_update_mask))
 		mchp_core_pwm->sync_update_mask = 0;
 
-	mutex_init(&mchp_core_pwm->lock);
-
 	chip->ops = &mchp_core_pwm_ops;
 
 	mchp_core_pwm->channel_enabled = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_EN(0));
-- 
2.49.0


