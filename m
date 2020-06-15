Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC221F99DD
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2020 16:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbgFOOQV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 Jun 2020 10:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730499AbgFOOQR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 Jun 2020 10:16:17 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2586C061A0E;
        Mon, 15 Jun 2020 07:16:16 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gl26so17588562ejb.11;
        Mon, 15 Jun 2020 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8vl4ct4Yo/NmDr9GQNb+5TnEp6gny9A1HqfVqk1MUaE=;
        b=hCtzq5fpUQIUqpy0SN85pGTDmXi8xW2pxm1r070y1RKcinJTOfC+sCONnYzTOhfyET
         lODRUzWXMCUNSfOzTU91B3kfEr7+NHlNGxMaaLfQBOIFUVny9rNKb9L+me7n/f9AST82
         5OzbdkWUUk/WhIL8zYrqriCQsbGpLmKXdQI/S+7dAYYeQDt3qe58uVu+Ti1eV8VyaekS
         6mHeVkGlBKpbPzX/m2xjmwE2CpZA3djgXT+OZp+OhnEYcTSQ9oaYzswWfjvFYA7mDQVb
         H79PqVkNbv/PbtwCSiZ6bK/r6CI0+cgr1CzlABChJqzS0oIOGnca2QN0NVl8mq3UFf4f
         Rk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8vl4ct4Yo/NmDr9GQNb+5TnEp6gny9A1HqfVqk1MUaE=;
        b=BD1FfcjJWgjbR/wvZkFy46h1KGuSOson5KApbjGmdd0gl5JNAzSDqRRhqiMeK+OHsS
         +wimjRkxe5ywSK+EjpYcuSsj1h+Dlh3KNy1MemwWfuDoRReitdTeOck6RIJZxyzxzro6
         hJxgudq9zR9dJdP2gxfMoGcX2hQ3rM2m4lcBHf6o4oUoaX4LVemzP1DyEu2YiAJXEu/E
         8sdwoBgeTeeF6KkX+pEgjAvEGZ9Pxzx3ET2d72jel4GX8HFi/Ql/fT8no0Snbeoiam1B
         YWSlqtD5qYTcPV+cfQWxMM+toU8htS2Udpim3t0h30sqjuxMFSufxJP1dwQIsZRb/h1f
         8GCw==
X-Gm-Message-State: AOAM530ItNHD0RsZZp8zzAbNDMWT1S85bM73rsbkJlmmB3RXJ++TdNnS
        jYzsF6VEz5MauKdSunfEy00=
X-Google-Smtp-Source: ABdhPJx3LjCjlGePx+AwP52VAaSSHKKuHVeOcwStf5hyq+/zIgSo7KGFJEEjTEY5MoE2xx3L99gDLg==
X-Received: by 2002:a17:906:da02:: with SMTP id fi2mr27005621ejb.41.1592230575420;
        Mon, 15 Jun 2020 07:16:15 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id dj26sm8426010edb.4.2020.06.15.07.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:16:14 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pwm: iqs620a: Use 64-bit division
Date:   Mon, 15 Jun 2020 16:16:06 +0200
Message-Id: <20200615141606.2814208-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200615141606.2814208-1-thierry.reding@gmail.com>
References: <20200615141606.2814208-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PWM framework is going to change the PWM period and duty cycles to
be 64-bit unsigned integers. To avoid build errors on platforms that do
not natively support 64-bit division, use explicity 64-bit division.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-iqs620a.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 674f0e238ba0..b2bb27eff623 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -46,7 +46,8 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct iqs620_pwm_private *iqs620_pwm;
 	struct iqs62x_core *iqs62x;
-	int duty_scale, ret;
+	u64 duty_scale;
+	int ret;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -ENOTSUPP;
@@ -69,7 +70,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled to
 	 * allow an external pull-down resistor to hold the GPIO3/LTX pin low.
 	 */
-	duty_scale = state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS;
+	duty_scale = div_u64(state->duty_cycle * 256, IQS620_PWM_PERIOD_NS);
 
 	mutex_lock(&iqs620_pwm->lock);
 
@@ -81,7 +82,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (duty_scale) {
-		u8 duty_val = min(duty_scale - 1, 0xFF);
+		u8 duty_val = min_t(u64, duty_scale - 1, 0xff);
 
 		ret = regmap_write(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE,
 				   duty_val);
-- 
2.24.1

