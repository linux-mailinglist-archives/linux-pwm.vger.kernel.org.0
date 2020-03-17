Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4F51889A2
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 17:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgCQQAK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 12:00:10 -0400
Received: from web0081.zxcs.nl ([185.104.29.10]:55122 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgCQQAJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 17 Mar 2020 12:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HWIu6Gi0APrIzMyoHqBqzed91EoxSikvrYfhLbeVFFw=; b=cg9sFtCAwrmdx6rka7MxExCpLO
        ApcT5kz+0tEAgqOQQPojFNu79MiGohxUH3ZStdLgQV/HXK3kbz58jUmhF/hdoTvU2qXGVA17S6lmC
        Pt/6sYyWRqwndFO9oM3wRgnEDXydDzis8Sm98suR9AfFdjXMqDsEG8jJEz8HZUe9XRucMjoOzBPmd
        CvpXQQy92/KcuB0+81CGGSx2wkps4mB2fHjWe5oE/AFtzMvOBCWXI43MnDc62JKYZO4RKrs48PJV5
        mm4c5bhHt3BBKDWJeuBtXFrUKPYkSapmW4ZA2aJe0HAKKlSmNg6X2aU18pRpjIJyFZsGCP+XPlF2O
        9ZFwuHqw==;
Received: from ip565b1bc7.direct-adsl.nl ([86.91.27.199]:60802 helo=localhost.localdomain)
        by web0081.zxcs.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <dev@pascalroeleven.nl>)
        id 1jEEdR-001IGT-HV; Tue, 17 Mar 2020 17:00:05 +0100
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com,
        Pascal Roeleven <dev@pascalroeleven.nl>
Subject: [RFC PATCH 4/4] pwm: sun4i: Delay after writing the period
Date:   Tue, 17 Mar 2020 16:59:06 +0100
Message-Id: <20200317155906.31288-5-dev@pascalroeleven.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317155906.31288-1-dev@pascalroeleven.nl>
References: <20200317155906.31288-1-dev@pascalroeleven.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: dev@pascalroeleven.nl
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When disabling, ensure the period write is complete before continuing.
This fixes an issue on some devices when the write isn't complete before
the panel is turned off but the clock gate is still on.

Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
---
 drivers/pwm/pwm-sun4i.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index a11d00f96..75250fd4c 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -299,6 +299,10 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
 	next_period = jiffies + usecs_to_jiffies(cstate.period / 1000 + 1);
 
+	/* When disabling, make sure the period register is written first */
+	if (!state->enabled && cstate.enabled)
+		sun4i_pwm_wait(next_period);
+
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		ctrl &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
 	else
@@ -320,6 +324,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 
 	/* We need a full period to elapse before disabling the channel. */
+	next_period = jiffies + usecs_to_jiffies(cstate.period / 1000 + 1);
 	sun4i_pwm_wait(next_period);
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
-- 
2.20.1

