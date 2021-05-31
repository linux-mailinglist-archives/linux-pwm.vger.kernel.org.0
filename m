Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141923954C7
	for <lists+linux-pwm@lfdr.de>; Mon, 31 May 2021 06:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhEaEsL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 May 2021 00:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhEaEsK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 May 2021 00:48:10 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D6FC061763
        for <linux-pwm@vger.kernel.org>; Sun, 30 May 2021 21:46:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l3so14722888ejc.4
        for <linux-pwm@vger.kernel.org>; Sun, 30 May 2021 21:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prusa3d-cz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJYRnusoQB7v01vB94DLoFvMzQbtJxQf7oLDrp3sR/0=;
        b=FMd6BeryGHKKpxN5QOVSyPCqIvtCJyOTMORpcMaEXYT5wWvQ3NTvUrKcv11vnadh7C
         wS+r+KqMBW4/6bcn/+OjRR504oiqx40olVjku7Tn64iYsURlZ30CpC7jRVW/iXhhAOAR
         QyXNl8W3dS6vm2BaEVKCP555IR+zadYXGPWziSLDNZDSCNr/tiNuomLUMZ4qSIiDDGei
         6UjLzw+CXbDd2F5n6i/u1XAkeIoRIAO77PdKxXSZh5tsrkXUbIGIUhH105yszPPbgpZu
         39wpI+b4x+a2qNf5rQk7IMEDj/Ch7oNcW1ksKSatPTWC0/S5660jS2vRmyHnAcyTm9PO
         IJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJYRnusoQB7v01vB94DLoFvMzQbtJxQf7oLDrp3sR/0=;
        b=WANWUxN171KibhT7j9idDKgEUCc26Gz/SA3wgS4hyyY0RQS8ejr0kl35x/b6jLUpPf
         i3Mz26r1oQvBGW4mEfot3MR/qLYK4XZloSDQmaZ92iFTHVBNEKABjzWAGt6ECdGJzDyH
         7LXhFlDn2BBn28xiMwsLXtUhXjdjFFxXYendQjOl2CQrdBZh6jahhkkJ7YiW6CuPfZlq
         CQe8GYVvwkWjG3rBQZGTuSC4Npi9/rCklMMvv4usBhGc7tBiSwwQkxRUHR1gu+7v+Kl/
         dcu4h0SB5VH6XlLdK/8HdYf/BkOZttDeAV6lx5iw9M/IAfUp8I9qFS3QMg9e0tgNkF0R
         kopA==
X-Gm-Message-State: AOAM532ZGc7Ohq3HsuPTh3QhDHkjG9gfII9FgFe4y4l5tqBAZZDyGSpX
        ufIpCPN8UtMaeqeRt0DB2y9oPQ==
X-Google-Smtp-Source: ABdhPJwnNcUhh9/i2h+P0NXuh0zKWYK3ypvfLCnGLZXmGNlLWMEocpsVW7VpGv5Tk4UpwtbuS5L5gg==
X-Received: by 2002:a17:906:4a19:: with SMTP id w25mr20708659eju.500.1622436382237;
        Sun, 30 May 2021 21:46:22 -0700 (PDT)
Received: from zen.local (ip-89-103-215-157.net.upcbroadband.cz. [89.103.215.157])
        by smtp.gmail.com with ESMTPSA id h9sm6238376edt.18.2021.05.30.21.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 21:46:21 -0700 (PDT)
From:   Roman Beranek <roman.beranek@prusa3d.cz>
X-Google-Original-From: Roman Beranek <roman.beranek@prusa3d.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Emil Lenngren <emil.lenngren@gmail.com>,
        Pascal Roeleven <dev@pascalroeleven.nl>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com
Subject: [PATCH 5/6] pwm: sun4i: shorten the delay to 2 cycles
Date:   Mon, 31 May 2021 06:46:07 +0200
Message-Id: <20210531044608.1006024-6-roman.beranek@prusa3d.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531044608.1006024-1-roman.beranek@prusa3d.com>
References: <20210531044608.1006024-1-roman.beranek@prusa3d.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

As Emil Lenngren has previously shown, actually only 1-2 cycles of
the prescaler-divided clock are necessary to pass before the PWM turns
off (instead of a full period). I was able to reproduce his observation
on a A64 using a logic analyzer.

Suggested-by: Emil Lenngren <emil.lenngren@gmail.com>
Suggested-by: Pascal Roeleven <dev@pascalroeleven.nl>
Signed-off-by: Roman Beranek <roman.beranek@prusa3d.com>
---
 drivers/pwm/pwm-sun4i.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 8218173ce3f6..6ab06b9749d0 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -71,7 +71,7 @@ static const u32 prescaler_table[] = {
 	72000,
 	0,
 	0,
-	0, /* Actually 1 but tested separately */
+	1, /* Tested separately */
 };
 
 struct sun4i_pwm_data {
@@ -240,7 +240,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_state cstate;
 	u32 ctrl, duty = 0, period = 0, val;
 	int ret;
-	unsigned int prescaler = 0;
+	unsigned int cycle_ns, current_prescaler, prescaler = 0;
 	bool bypass;
 
 	pwm_get_state(pwm, &cstate);
@@ -277,7 +277,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		ctrl &= ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
 	}
 
-	if (PWM_REG_PRESCAL(ctrl, pwm->hwpwm) != prescaler) {
+	current_prescaler = PWM_REG_PRESCAL(ctrl, pwm->hwpwm);
+	if (current_prescaler != prescaler) {
 		/* Prescaler changed, the clock has to be gated */
 		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 		sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
@@ -308,8 +309,10 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	/* We need a full period to elapse before disabling the channel. */
-	fsleep(cstate.period / NSEC_PER_USEC + 1);
+	/* We need to wait 1-2 cycles before disabling the channel. */
+	cycle_ns = DIV_ROUND_UP(NSEC_PER_SEC, clk_get_rate(sun4i_pwm->clk))
+		   * prescaler_table[current_prescaler];
+	fsleep(DIV_ROUND_UP(cycle_ns * 2, NSEC_PER_USEC));
 
 	ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
-- 
2.31.1

