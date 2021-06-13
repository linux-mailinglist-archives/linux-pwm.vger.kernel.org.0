Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5B3A5B00
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Jun 2021 01:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhFMXe3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 13 Jun 2021 19:34:29 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:37825 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhFMXe2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 13 Jun 2021 19:34:28 -0400
Received: by mail-wr1-f45.google.com with SMTP id i94so12404070wri.4;
        Sun, 13 Jun 2021 16:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6vRsWsGP4YXz3sR8PQrN46Lc4ndr5AXjtPjUiVcdyyE=;
        b=CBS5Rsj0QLCWj+9FAmolUTz2yIeTKYcEVyiWRcGgrqZuJfrlCIGghsH0sy/fEy76y4
         25ADmTOq8DcxYrVb9/gnRZWCjvTE5Z2i2i845qfCRVxAvljIsFEGoZ5Acra6EAAhJXKG
         xvt7UMvIy8r7lcfoq1CTBau+MWrH5Uy7f/CbNWQZQBOeKdp8WW1pg3goC01aUsJOfGhz
         s4QGAgb0aRts0k6HqNMrhw5nlP181FNL/9/POm5G5YFAQupcjhhoiSRgiculLbzxwIWL
         T0xaEYaQWu9HkjBGu71nA8VB1gzkGtgpDnigyyq2QeB8zn2Bq2N3I0yeQ3jK1rt6RsC3
         Znpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6vRsWsGP4YXz3sR8PQrN46Lc4ndr5AXjtPjUiVcdyyE=;
        b=kQHLQY4mIOXyggp7nvcZv17fmNdIB7fbhrF9MUK4Fh7e97duXN/NERXtsAU/CB7aDq
         hmz97ml31tsE0RNem6vpo52hWUWs+OurnQcEP0As3CtEQSp0y6+IuavSviED8T2b2G2S
         05im5C4pqpdOqnHrnJy19osn/tE0uC2vitSyWC2PC/ZkiCADPokTm5W15G0vh0sULMHV
         UrKY5KyGQt7KvjC2iKETEf3sp22lmyQne7mF5pfyYWnpemma23mZ1cnezRBN2WOPcCNA
         HHZI78F8ufVdyENQiSdlNis0hxXztNh4AC09zo8JE82xAu6Fmv8QkSumLNZQk9hFfsio
         3OYQ==
X-Gm-Message-State: AOAM531WQBc9uh+o/7f5JAIa+OmvcuEzhSKwPQb+v49Q6EXBgIIvpPhA
        jLmKp63LlS8tPKLAXgUgdJI=
X-Google-Smtp-Source: ABdhPJyanqsqf+Jzg7vxKNXr0HvZ/x/EjXJ2+1TDl0bJhQEWTP06uHVrD7q9jtXJm8p9MBOxBpsgNg==
X-Received: by 2002:adf:e944:: with SMTP id m4mr16568800wrn.244.1623627085533;
        Sun, 13 Jun 2021 16:31:25 -0700 (PDT)
Received: from localhost.localdomain ([195.245.23.224])
        by smtp.gmail.com with ESMTPSA id i9sm17882511wrn.54.2021.06.13.16.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 16:31:25 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        linux-pwm@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] pwm: ep93xx: Prepare clock before using it
Date:   Mon, 14 Jun 2021 01:30:41 +0200
Message-Id: <20210613233041.128961-8-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
References: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
to Common Clock Framework.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 drivers/pwm/pwm-ep93xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 4ca70794ad96..8c0d4d69d9e6 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -74,7 +74,7 @@ static int ep93xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * Configuration can be changed at any time.
 	 */
 	if (!pwm_is_enabled(pwm)) {
-		ret = clk_enable(ep93xx_pwm->clk);
+		ret = clk_prepare_enable(ep93xx_pwm->clk);
 		if (ret)
 			return ret;
 	}
@@ -105,7 +105,7 @@ static int ep93xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (!pwm_is_enabled(pwm))
-		clk_disable(ep93xx_pwm->clk);
+		clk_disable_unprepare(ep93xx_pwm->clk);
 
 	return ret;
 }
@@ -120,7 +120,7 @@ static int ep93xx_pwm_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * The clock needs to be enabled to access the PWM registers.
 	 * Polarity can only be changed when the PWM is disabled.
 	 */
-	ret = clk_enable(ep93xx_pwm->clk);
+	ret = clk_prepare_enable(ep93xx_pwm->clk);
 	if (ret)
 		return ret;
 
@@ -129,7 +129,7 @@ static int ep93xx_pwm_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		writew(0x0, ep93xx_pwm->base + EP93XX_PWMx_INVERT);
 
-	clk_disable(ep93xx_pwm->clk);
+	clk_disable_unprepare(ep93xx_pwm->clk);
 
 	return 0;
 }
@@ -139,7 +139,7 @@ static int ep93xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct ep93xx_pwm *ep93xx_pwm = to_ep93xx_pwm(chip);
 	int ret;
 
-	ret = clk_enable(ep93xx_pwm->clk);
+	ret = clk_prepare_enable(ep93xx_pwm->clk);
 	if (ret)
 		return ret;
 
@@ -153,7 +153,7 @@ static void ep93xx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct ep93xx_pwm *ep93xx_pwm = to_ep93xx_pwm(chip);
 
 	writew(0x0, ep93xx_pwm->base + EP93XX_PWMx_ENABLE);
-	clk_disable(ep93xx_pwm->clk);
+	clk_disable_unprepare(ep93xx_pwm->clk);
 }
 
 static const struct pwm_ops ep93xx_pwm_ops = {
-- 
2.32.0

