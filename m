Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EA52DC589
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Dec 2020 18:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgLPRoC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Dec 2020 12:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbgLPRoB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Dec 2020 12:44:01 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62976C061794
        for <linux-pwm@vger.kernel.org>; Wed, 16 Dec 2020 09:43:21 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id e25so3278102wme.0
        for <linux-pwm@vger.kernel.org>; Wed, 16 Dec 2020 09:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bbT7WqhMv9D0JN+M6U2lP44bpKHeGiClVrOCBGsjLB4=;
        b=Wo3GU0SaHfSog6HY2tTj08H3ovgcN6uf/n+njEfVoVCXnR/ojNL//gxbHAyORr/BAK
         pOF3NQkWs/vI0p7FcP8JMhZqeJ7bgNcL+mJ1JoJtylfGAMQFe/UWi3Wb8bG+mmQRUrdp
         9wwYAM7tmAwhmcx3UQTsr4/BKglIh1xf/eb8p6wC2gL4kZvZcTs/3WonHUKKH1ZZOH0r
         qoq+vMSV0VyUBHuUhHMNI1k/Z0RLU/64nh51fA3oTwQAB4MPomimaQDaAb9ASeHE0XST
         0pUzLtZoAAfsaMyxV8McAy6abcsRBV0XYniW75cKd6GE9fMCCa6pLuwBkWcPaImw1jwn
         p74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bbT7WqhMv9D0JN+M6U2lP44bpKHeGiClVrOCBGsjLB4=;
        b=kY8/AzciGD79rsmi5UKwbZrmY67ZYTHpYMHEPaLmQSt1qd68+9HOxSJxoZUiTjWvJ3
         Cta/UG76ZuXWuEvf0ukmsDd5tSQHcT3z/tg5IY1rM6xki/0vDflw39AbRICN+e55rb4J
         SmpT3mfmqrYGULEMkbq0Ms97BaKqDKZg1lb0I21Nxe1AIeI8LayKdHikBFPebBY7mGGm
         7WuC5jXm/NxwbZnDps8ngAUYTwzkNo4Qcpv5XOb7EFKgvWFPVtQ9d/LYH/L8WJoZuz8Y
         TSG9ladU7fnmBCef1W1bEF3yv2+Dj/VveLH+my5f6LA/QcSCQw04brlw7xnlqka5eGLd
         TU/A==
X-Gm-Message-State: AOAM533lD3Ei2b8bzIsNHvTDbw31LLHFRda1GwQn1sJnyKiOi7Q73YJE
        mitCJm1u2uwcnqotLRT7ekw=
X-Google-Smtp-Source: ABdhPJxJOWWJ5FLy7QUzsdhlryZEL/ba8pbZuAcX60Wr4pm+dltvBQtilbbj1eVsw7/fpJ7HCvGdyg==
X-Received: by 2002:a1c:9e53:: with SMTP id h80mr4501911wme.50.1608140600133;
        Wed, 16 Dec 2020 09:43:20 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id p19sm5132137wrg.18.2020.12.16.09.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 09:43:19 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, Taras Galchenko <tpgalchenko@gmail.com>
Subject: [PATCH] pwm: sun4i: Remove erroneous else branch
Date:   Wed, 16 Dec 2020 18:43:09 +0100
Message-Id: <20201216174309.1604658-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Commit d3817a647059 ("pwm: sun4i: Remove redundant needs_delay") changed
the logic of an else branch so that the PWM_EN and PWM_CLK_GATING bits
are now cleared if the PWM is to be disabled, whereas previously the
condition was always false, and hence the branch never got executed.

This code is reported causing backlight issues on boards based on the
Allwinner A20 SoC. Fix this by removing the else branch, which restores
the behaviour prior to the offending commit.

Note that the PWM_EN and PWM_CLK_GATING bits still get cleared later in
sun4i_pwm_apply() if the PWM is to be disabled.

Fixes: d3817a647059 ("pwm: sun4i: Remove redundant needs_delay")
Reported-by: Taras Galchenko <tpgalchenko@gmail.com>
Suggested-by: Taras Galchenko <tpgalchenko@gmail.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index cc1eb0818648..ce5c4fc8da6f 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -294,12 +294,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ctrl |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 
-	if (state->enabled) {
+	if (state->enabled)
 		ctrl |= BIT_CH(PWM_EN, pwm->hwpwm);
-	} else {
-		ctrl &= ~BIT_CH(PWM_EN, pwm->hwpwm);
-		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	}
 
 	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
 
-- 
2.29.2

