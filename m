Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968812AF9A9
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 21:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgKKUXB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 15:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgKKUXA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 15:23:00 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4D0C0613D1
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 12:23:00 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 23so3769716wrc.8
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 12:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m39PDSr3n6ozOmx2EIemiMcSqX7Gl5AV9w8EMvQ7D/w=;
        b=J/AXx5DRte7rlVU10gQDvdQ155RG5h6ZVDmlBvEFJOvwCCbv94OynZ1lFO2b6mgicx
         59aqynbgx1IM47BxL+K4q2WI1ZZyDHMEkXYdjAc1Yw2FLG5xQL/PGcBVVy3ZIMalROjZ
         KEZrjSM7Z/koSyWuKOtroQhIm8P1WNybFbsd8Gvd/nkUeAn4pLo0GytVp2HsihiuC+jd
         7xllstPoMpXWgcZ8AaZSsulHSbhq3IQWkeDCj1aOFUN9euk/4Li79IqQplw3WuFP2mPw
         AVR+N48NeV50pebiIfAtstqE792YdQZdJLXzQGwvPZWeqiSocfk8EqM/SSKZYfm5nayJ
         hLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m39PDSr3n6ozOmx2EIemiMcSqX7Gl5AV9w8EMvQ7D/w=;
        b=nNJj51KyOwq5sLp21At8rzy9QptwtYpqbT6GqMYZHD8bJbCTJ1c3yfeS149SjaAnwK
         FGo6FVNmB5SIbr/QkfrOoUmsb/st78HQBkypgQCxGOJ0YUqKhYik3banEaenZ6Hg+X+9
         FHuN1Td3jMRWTA1SHYhLH/jqbMmvHvmlZldcjzW2KMRPICuhb8qrZfhib2WtY1XYUw6H
         k6PWuYG5Lp8dHXlTCcEqUCLUAKrC7xm+vO6PhAh0nyBsOZWf6JIbnPIfWPtjz7GdDsVw
         wk3v4/kxdlJKIYk/wxPmkbjTmvaFHrjppRKM9/KtY12zo1L73RwyNTKEkUTXuB0XSjN7
         gcUQ==
X-Gm-Message-State: AOAM530Ek3FYmNhF3G2WHbYnj8zmXt0IvBvJ3WqUjidn3yv2q/GPYz5s
        1yJ3oDznlekFyVXB19Mhm1s=
X-Google-Smtp-Source: ABdhPJzPEAnuxZrsTTOdJFJC7Jf9fOOp6T6uMCo66s2W2RgUUkdZbCWIvLUOkKnKuBIK769uzvibyg==
X-Received: by 2002:a05:6000:89:: with SMTP id m9mr1867791wrx.412.1605126179251;
        Wed, 11 Nov 2020 12:22:59 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id u195sm3891648wmu.18.2020.11.11.12.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:22:58 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Use -EINVAL for unsupported polarity
Date:   Wed, 11 Nov 2020 21:22:57 +0100
Message-Id: <20201111202257.414889-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Instead of using a mix of -EOPNOTSUPP and -ENOTSUPP, use the more
standard -EINVAL to signal that the specified polarity value was
invalid.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-crc.c     | 2 +-
 drivers/pwm/pwm-iqs620a.c | 2 +-
 drivers/pwm/pwm-rcar.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index ecfdfac0c2d9..1e2276808b7a 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -64,7 +64,7 @@ static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
-		return -EOPNOTSUPP;
+		return -EINVAL;
 
 	if (pwm_is_enabled(pwm) && !state->enabled) {
 		err = regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 0);
diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 7d33e3646436..5ede8255926e 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -50,7 +50,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	int ret;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
-		return -ENOTSUPP;
+		return -EINVAL;
 
 	if (state->period < IQS620_PWM_PERIOD_NS)
 		return -EINVAL;
diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 3e23f1e4e1f6..002ab79a7ec2 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -168,7 +168,7 @@ static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	/* This HW/driver only supports normal polarity */
 	if (state->polarity != PWM_POLARITY_NORMAL)
-		return -ENOTSUPP;
+		return -EINVAL;
 
 	if (!state->enabled) {
 		rcar_pwm_disable(rp);
-- 
2.29.2

