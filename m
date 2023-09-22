Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD487AB1FC
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Sep 2023 14:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjIVMSJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Sep 2023 08:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbjIVMSJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Sep 2023 08:18:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD71EFB
        for <linux-pwm@vger.kernel.org>; Fri, 22 Sep 2023 05:18:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c4456d595cso3763175ad.1
        for <linux-pwm@vger.kernel.org>; Fri, 22 Sep 2023 05:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695385083; x=1695989883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8QW0xVyp70cq29VZ+jp2qESbgV9XkqbeH4Ceb6Mi7s=;
        b=DzLsRbN3hjTAM2WOL9Qc3PDWho1aR9HE8sGFGJEmM3nrFg3AHBc3tQRGGsHmR0LS/r
         jH792btC2G7JuGhQKMjzYMJ7FKZRwQqAgT/+XE1VIwDpDxmtm+bOCr1MuxRGUQRcGo8/
         VldOVS8E7mtoghxLA4JgP3zZJILLP+Lq6l6E01SU+Qt0Z0vjUR5nsHQuJahtCQUevC/F
         n85tXWQTjIvdE+CFqbF8dLlh01oI7ei8lP2gl6yqcoy0D7q93sLwhZMQSQ1vcQBaMLw9
         Jg0mYnKJ7AQm+qzkRQv+1UxtuAdDIAhs6XI7dI7xvzt/1wQklQgiIf0U8QWENTd2NvZZ
         LHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695385083; x=1695989883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8QW0xVyp70cq29VZ+jp2qESbgV9XkqbeH4Ceb6Mi7s=;
        b=oVg3ujQoOPIapGVin4hIpROHvvsIKQXXHIs0ZJpxdoA6hha7YI0qogK4pBX5mRpdyP
         +mZfXOA6w7OMtZQ2u8cgvUjwEgJCVHsHXIs5e/P4T/UZxLzfOM73gBINyAghNGVE6K1k
         KegwgNrwV9vVoOKCmv3ug0u6VhOBlgeWeVWieQyPInIF7GOcYNLnIVKRpxSRRBs0aVCm
         XdTfWcljz0H7dFOcpLx6lZyoGb6BTd5OW+7esz9b2Dy2nyYiKhSIi9w4cRsoNaYpLZ0j
         ggEnjiCDw0EBM3FQEhjnaNmMFMFw9fawEYaV/l9cRZZ5hcsVbv5BAJO2WAP8+mz4Gg27
         5Njw==
X-Gm-Message-State: AOJu0YxrVGd/4YO4i+mrLO3+EtplR1eH6bN5a1wTv8S9PP2kmk/G+dxo
        HT0xsS9o0d6TeXjDeFaXzN26iQh/Q24=
X-Google-Smtp-Source: AGHT+IF7gs71VxReEpenYvRcRkBNhTAxqEQi0t1LJxIv5tTHUNmHSKvldAxmxhXnw6uLlVbDlWJ+oA==
X-Received: by 2002:a17:903:32ca:b0:1c3:8dbe:aecb with SMTP id i10-20020a17090332ca00b001c38dbeaecbmr8135957plr.2.1695385083091;
        Fri, 22 Sep 2023 05:18:03 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:2546:6c99:4de0:9123])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902eecd00b001b03cda6389sm3330822plb.10.2023.09.22.05.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 05:18:02 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, linux@rasmusvillemoes.dk,
        linux-pwm@vger.kernel.org, rogan@dawes.za.net,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH] pwm: mxs: Fix zero duty cycle
Date:   Fri, 22 Sep 2023 09:17:52 -0300
Message-Id: <20230922121752.344965-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Currently, when a duty cycle of zero is requested, the PWM stops
getting updated. This causes the minimal brightness of an LED to not
turned off completely as expected.

For example, driving an LED via led-pwm and running:

echo 255 >  /sys/class/leds/red/brightness

makes the LED to go to its maximum brightness as expected.

After running:

echo 0 >  /sys/class/leds/red/brightness

The PWM controlled LED does not turn off. Instead, the LED brightness
stays at its maximum.

The reason for this behavior is that when brightness is set to 0,
state->enabled goes to 0 and the PWM is disabled by setting the
PWM_CTRL + CLR register.

Fix this problem by keeping the PWM controller turned on, even in
the case when a zero duty cycle is requested.

Fixes: bf29c2ff82fd ("pwm: mxs: Implement ->apply()")
Reported-by: Rogan Dawes <rogan@dawes.za.net>
Signed-off-by: Fabio Estevam <festevam@denx.de>
Tested-by: Rogan Dawes <rogan@dawes.za.net>
---
 drivers/pwm/pwm-mxs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index 766dbc58dad8..f8ad616eaba2 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -65,7 +65,7 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			return ret;
 	}
 
-	if (!state->enabled && pwm_is_enabled(pwm))
+	if (pwm_is_enabled(pwm))
 		writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + CLR);
 
 	rate = clk_get_rate(mxs->clk);
-- 
2.34.1

