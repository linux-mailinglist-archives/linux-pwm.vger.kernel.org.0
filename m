Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E45A5F278E
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Oct 2022 03:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiJCB4Q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Oct 2022 21:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJCB4P (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 2 Oct 2022 21:56:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7326F2F3B3
        for <linux-pwm@vger.kernel.org>; Sun,  2 Oct 2022 18:56:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b2so3582355plc.7
        for <linux-pwm@vger.kernel.org>; Sun, 02 Oct 2022 18:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2VzSXiyTa2AqhWWV+TIOFyyGIQmkthKoa/iXZbOQnPI=;
        b=VTipjAN6Ydg8bMvjBJQhSUcB6pQATYm5K/1xzHy6hsdH2mFZeuJmPS0BHc6/UlQWrS
         s137zgge95AtFgREC4i5SeztBXv6RPdk1CAajMnp7xZDjZLPbgNk0ADM6izr3RR5hyJI
         75eoxIDBEnJZcbaK/6j5L5aWD9Gabefamh9RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2VzSXiyTa2AqhWWV+TIOFyyGIQmkthKoa/iXZbOQnPI=;
        b=iRA7BC0ImSpUSye+S0RaXRvJdst/mGf8LBWCLYW9yk5DUzco06mOD7vbpwJ/nFI1KG
         tBA/ETQ7If5hfdhLakSFN7+sqLGShU274qVt0V374vaUlRsYbmpSZeR0mO37q0jhyrCb
         2dWvwcDle4GdU85zsMFL5RTMY/y2RYZyDC+XmKdM3ibxIlfsjPhnljudpoK9/9dbLOUW
         cdqIJbO4WanA5DgNxeO96MOdle0n1jkfavJuCy0CsLVZuB+GYyn/+kVzcoCI/f2Vlg54
         I147Pc2yM+JgsK3zZmroFZ5k+ZJBV0bIcJEHIS11SqweP8rH6n7Myk1NcjBvV6LXeBM/
         OSBA==
X-Gm-Message-State: ACrzQf0sGHMrpxNb1S3hIKpfrjdDtYIhiFZQFssDX9EMM9zfZmL3Rcyw
        PH23R1icq7WduEEGNaXrGvMBgQ==
X-Google-Smtp-Source: AMsMyM4ClefyXLJI7/2v+AWka9B0nfUVe6FzorXeWHO19YkqIEfED+6p08WFzwcmiBW4K1UVuJq1Eg==
X-Received: by 2002:a17:90b:368f:b0:208:1675:8b4c with SMTP id mj15-20020a17090b368f00b0020816758b4cmr9808979pjb.162.1664762173898;
        Sun, 02 Oct 2022 18:56:13 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.45.132.124])
        by smtp.gmail.com with ESMTPSA id s9-20020a17090302c900b0017b69f99321sm5893786plk.219.2022.10.02.18.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 18:56:13 -0700 (PDT)
From:   Doug Brown <doug@schmorgal.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 3/5] pwm: pxa: Remove clk enable/disable from pxa_pwm_config
Date:   Sun,  2 Oct 2022 18:55:44 -0700
Message-Id: <20221003015546.202308-4-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221003015546.202308-1-doug@schmorgal.com>
References: <20221003015546.202308-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Now that pxa_pwm_apply always enables the clock first, there is no need
for pxa_pwm_config to do any clock enabling/disabling.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/pwm/pwm-pxa.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 9ee9b41d62b8..cf4d22c91929 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -64,7 +64,6 @@ static int pxa_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long long c;
 	unsigned long period_cycles, prescale, pv, dc;
 	unsigned long offset;
-	int rc;
 
 	offset = pwm->hwpwm ? 0x10 : 0;
 
@@ -86,18 +85,10 @@ static int pxa_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		dc = mul_u64_u64_div_u64(pv + 1, duty_ns, period_ns);
 
-	/* NOTE: the clock to PWM has to be enabled first
-	 * before writing to the registers
-	 */
-	rc = clk_prepare_enable(pc->clk);
-	if (rc < 0)
-		return rc;
-
 	writel(prescale, pc->mmio_base + offset + PWMCR);
 	writel(dc, pc->mmio_base + offset + PWMDCR);
 	writel(pv, pc->mmio_base + offset + PWMPCR);
 
-	clk_disable_unprepare(pc->clk);
 	return 0;
 }
 
-- 
2.34.1

