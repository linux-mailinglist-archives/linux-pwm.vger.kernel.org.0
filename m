Return-Path: <linux-pwm+bounces-6514-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 002AEAE6E7A
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 20:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DFB188947A
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 18:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B8F2DAFB9;
	Tue, 24 Jun 2025 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zQ8kmdA8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2841B233145
	for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788991; cv=none; b=tr/hwm6eaHKrjOXgdIajLDuXsC7MPrcVNGqwHCsZi05Lh+NvB+haRySpvOas6e6ZSPS7luhKnVRW/Xo40GGxbV3VK4ZlHU8Dvqzw4KOglfOmH3jJTIS5lTzdW6l1MhO/nIAz1FPxRSYF3VCEwP9OOazS1PERJBrnPzbhCqPo1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788991; c=relaxed/simple;
	bh=tZK8Wq+anKBP1rLIKaMXsBuPvMqM2sbrLZnT8Z4b6RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAI8n6ud3WCzEM8YhKhKDvYU83np1FuRwGoHcG2p7Q/Y19Q7XV8Vt9a9ighMKl709I5D40bqps4Snk2yZ9nziurA13zTWwXSUHSlVZSEKS+WOWNNy3vuHxNgb3EXSnKTuDHVexixczxYb2aqlwXqhe8iezSeZqo4rFMDSFUUKSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zQ8kmdA8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad93ff9f714so144114966b.2
        for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750788987; x=1751393787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHz/3THqHcjEMon6vyiI8Ozs2SXaYtuBLpbkrNuLzts=;
        b=zQ8kmdA87NKhN8kEmJsx1pk8r6Xdlw1/bk7xvvrhHZqqH0diSuGuyUmfJTG7FcQia/
         Q6QGuteT0sT2ScWCbS5oqQlZC0T/nvdEku/eSuotN+YwKdy9+SiJ7Rd8R6tJq+xp0fNR
         Gyjkopugm3LBdVlYd1qp9dUk4m9xVkGoBwCBX2TcwAfHHo2b6kB/YRs0Tmywh1NwA95c
         ggn27qUd/dcg2cRFGnKrgB8WMpUchNS22OoE/HoLUWGp19QpAEShWMAWIGz6KsH6iYQg
         glkCUnco57MNG7VPNi12rwfKEXIxuJkZxD1wRj9lnn46JYb/Ih8U/TzIZEK3uWGxrBey
         haUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750788987; x=1751393787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHz/3THqHcjEMon6vyiI8Ozs2SXaYtuBLpbkrNuLzts=;
        b=wKr+Zy+RoODkDSXOQCflvqKtxQe03siay2YtAENQWXlzIGw/K91AYRmxTEPfgNoSl2
         GZ3Bgpj3rkEH/wagyQbMRrOd2xzHena7Yb1UHHlFG1IeuowkRzaNsMWoQg24fav7rz02
         ua7X3DnNOqhP8LCTfiQvKjK+OtxhWnovZteEjHhw2uDx8TUWauGR5NS7VI6hoWJ/KFab
         KjCCru31PTcI622eJGlErCw/hXpF85Lj5Uhn/GdBbewHkaFMQO9SrcqXNJ9an3Yniky9
         nRlDmk7Oazci7RHwP4VROOH2S1p91mu5vyLiYxhDagsYZHXlD1nNwENu8KOlh44QDoPR
         LY5Q==
X-Gm-Message-State: AOJu0Yw6l9HsqT9lBGnF45hzj34/EWlzPNtsKa0DoIOehDdMRQUwgkEn
	d2Tx2ekgszecCN8GEPibQOXHRLMlJ48AYQFZyJEN8y3meLcls0djMQE1tUSfsxpTpHHkVF7jURR
	4GUFQ
X-Gm-Gg: ASbGnctqkjDGqYwGu/vybhU/zNhg/prOg5KJ1sdpVw8TnRe30Jm0g3GRCnedONNHAyx
	nItCsbo4xWDxcHwIWCed5pDJNo1buyhARyhxZwEoAzUDjWOBki3jVbB50Dr/W1mlnY4G5D+EuYV
	nc2m6amgMgattzlyUD99H3+fVKaMzJSk0jKk9dBg0eFXMkWVF85EJ3ls4iJZ05pYJy80uWQ8a3D
	K5UGgahcHO0Pmr3Wdlq16hPxhHhP4bOUuTCG8u8YrUQ7K2xJUvuH4MLJZvd6aqWB41Cue4C/KDq
	wzesPz+0hDdhouc1kWOHrQyK0e6ML3VD6rQDEG04Z7MBPicm4nT7w6JkLRxI/86XPNwc0zbLsln
	vww==
X-Google-Smtp-Source: AGHT+IEOZkYdx1/zibKqZMORZGuO3lgEW21erK3oZBKU/fRGiWuFQ0Dtix+3x3kqUbVdO3ce/uGFQw==
X-Received: by 2002:a17:907:cd16:b0:ad2:40a1:7894 with SMTP id a640c23a62f3a-ae0bea0a411mr32871166b.41.1750788987278;
        Tue, 24 Jun 2025 11:16:27 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae054209a13sm901584066b.168.2025.06.24.11.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 11:16:26 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Vladimir Zapolskiy <vz@mleia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/8] pwm: lpc18xx-sct: Drop driver local locking
Date: Tue, 24 Jun 2025 20:15:40 +0200
Message-ID:  <4f7a2da37adbfe4743564245119045826d86eca6.1750788649.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2821; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=tZK8Wq+anKBP1rLIKaMXsBuPvMqM2sbrLZnT8Z4b6RM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoWutY/hqvEJv/ccjOwk+1Eo4IGImrEhto56NV5 WbUTOYeBvSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaFrrWAAKCRCPgPtYfRL+ Tmk9CACFJ0A/jRALDWw+ocNBbs3Jg1kxVhrPhaaqLaqabNp/L3ZYtMNRq3Pu0rvsMWeGnXlCZnH 6O+RXcF2nVIb44s93mM8z+uHVAKMls3Zuyj8IWBgDz1DCYdrVSpDRFSrJ3r2CsH6Jvnv/XBbIwB TwKNMLAgLMSQo/ZNOjjtzVXMclcZnQAmgyr0F0dl90iJmHaWtA2lNuBcNjRozZ7qHEkieVCtNkh BP1ZvV/qSgCDVjGTpXjKT2vSSzYu1p/DhP8B/pJbS57fWnZwtZLUMvuFW2M70oTtO21nLbZHsxA Eal0wKVvFr2bkKPjwNVNqI7bDjjGvvrU3a1KRrZIbEQzUL5V
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Both mutexes are only used in one function each. These functions are only
called by the .apply() callback. As the .apply() calls are serialized by
the core since commit 1cc2e1faafb3 ("pwm: Add more locking") the mutexes
have no effect apart from runtime overhead. Drop them.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index f351baa63453..1e614b2a0227 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -100,8 +100,6 @@ struct lpc18xx_pwm_chip {
 	u64 max_period_ns;
 	unsigned int period_event;
 	unsigned long event_map;
-	struct mutex res_lock;
-	struct mutex period_lock;
 	struct lpc18xx_pwm_data channeldata[LPC18XX_NUM_PWMS];
 };
 
@@ -129,8 +127,6 @@ static void lpc18xx_pwm_set_conflict_res(struct lpc18xx_pwm_chip *lpc18xx_pwm,
 {
 	u32 val;
 
-	mutex_lock(&lpc18xx_pwm->res_lock);
-
 	/*
 	 * Simultaneous set and clear may happen on an output, that is the case
 	 * when duty_ns == period_ns. LPC18xx SCT allows to set a conflict
@@ -140,8 +136,6 @@ static void lpc18xx_pwm_set_conflict_res(struct lpc18xx_pwm_chip *lpc18xx_pwm,
 	val &= ~LPC18XX_PWM_RES_MASK(pwm->hwpwm);
 	val |= LPC18XX_PWM_RES(pwm->hwpwm, action);
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_RES_BASE, val);
-
-	mutex_unlock(&lpc18xx_pwm->res_lock);
 }
 
 static void lpc18xx_pwm_config_period(struct pwm_chip *chip, u64 period_ns)
@@ -200,8 +194,6 @@ static int lpc18xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -ERANGE;
 	}
 
-	mutex_lock(&lpc18xx_pwm->period_lock);
-
 	requested_events = bitmap_weight(&lpc18xx_pwm->event_map,
 					 LPC18XX_PWM_EVENT_MAX);
 
@@ -214,7 +206,6 @@ static int lpc18xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	    lpc18xx_pwm->period_ns) {
 		dev_err(pwmchip_parent(chip), "conflicting period requested for PWM %u\n",
 			pwm->hwpwm);
-		mutex_unlock(&lpc18xx_pwm->period_lock);
 		return -EBUSY;
 	}
 
@@ -224,8 +215,6 @@ static int lpc18xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		lpc18xx_pwm_config_period(chip, period_ns);
 	}
 
-	mutex_unlock(&lpc18xx_pwm->period_lock);
-
 	lpc18xx_pwm_config_duty(chip, pwm, duty_ns);
 
 	return 0;
@@ -377,9 +366,6 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	if (lpc18xx_pwm->clk_rate > NSEC_PER_SEC)
 		return dev_err_probe(&pdev->dev, -EINVAL, "pwm clock to fast\n");
 
-	mutex_init(&lpc18xx_pwm->res_lock);
-	mutex_init(&lpc18xx_pwm->period_lock);
-
 	lpc18xx_pwm->max_period_ns =
 		mul_u64_u64_div_u64(NSEC_PER_SEC, LPC18XX_PWM_TIMER_MAX, lpc18xx_pwm->clk_rate);
 
-- 
2.49.0


