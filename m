Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE5ED1889A0
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 17:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgCQQAI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 12:00:08 -0400
Received: from web0081.zxcs.nl ([185.104.29.10]:55080 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgCQQAI (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 17 Mar 2020 12:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pktgviJTtaLPwXOp3J5JLxVjtw6Q/MSlWaoH6m3lldc=; b=rxvKqLwywq8K0uta3Fab1X6q1C
        2Tvjdj0KwhzX22GwQW4pcGAINWgJr+bb/2o0fHbY8VtBMEZdposBIzptGxMPT107Y2nmZvlR7Di8c
        f6xtp/NTZsFqfsXOIy3J9MSeTZkRQqNejCP15vyhkSe3prJ+zYjLc4iUP3gwXO3mib7t5yVYzJ190
        6geRdk0QAgBg5MLEsxelZP5mtfzkpfVNx2dKpmobgQKhyWrGLQVtB5T0Hxe0WQhd1M7JJF9E/ET6T
        g5w6qIDkvGzJBfkd7RTXq+BvjW5IICeeqYPIdIGjRKD0P9Pr6E+0GgyLdrWRAUEiz4knX+GPWhMm3
        z03CI3ZQ==;
Received: from ip565b1bc7.direct-adsl.nl ([86.91.27.199]:60802 helo=localhost.localdomain)
        by web0081.zxcs.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <dev@pascalroeleven.nl>)
        id 1jEEdO-001IGT-Ig; Tue, 17 Mar 2020 17:00:02 +0100
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
Subject: [RFC PATCH 3/4] pwm: sun4i: Move delay to function
Date:   Tue, 17 Mar 2020 16:59:05 +0100
Message-Id: <20200317155906.31288-4-dev@pascalroeleven.nl>
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

Move the delay to a function so we can reuse it.

Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
---
 drivers/pwm/pwm-sun4i.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 56942036b..a11d00f96 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -89,7 +89,6 @@ struct sun4i_pwm_chip {
 	void __iomem *base;
 	spinlock_t ctrl_lock;
 	const struct sun4i_pwm_data *data;
-	unsigned long next_period[2];
 };
 
 static inline struct sun4i_pwm_chip *to_sun4i_pwm_chip(struct pwm_chip *chip)
@@ -228,6 +227,20 @@ static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
 	return 0;
 }
 
+static void sun4i_pwm_wait(unsigned long next_period) {
+	unsigned int delay_us;
+	unsigned long now;
+
+	now = jiffies;
+	if (time_before(now, next_period)) {
+		delay_us = jiffies_to_usecs(next_period - now);
+		if ((delay_us / 500) > MAX_UDELAY_MS)
+			msleep(delay_us / 1000 + 1);
+		else
+			usleep_range(delay_us, delay_us * 2);
+	}
+}
+
 static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   const struct pwm_state *state)
 {
@@ -235,8 +248,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_state cstate;
 	u32 ctrl, duty = 0, period = 0, val;
 	int ret;
-	unsigned int delay_us, prescaler = 0;
-	unsigned long now;
+	unsigned int prescaler = 0;
+	unsigned long next_period;
 	bool bypass;
 
 	pwm_get_state(pwm, &cstate);
@@ -284,8 +297,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	val = (duty & PWM_DTY_MASK) | PWM_PRD(period);
 	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
-	sun4i_pwm->next_period[pwm->hwpwm] = jiffies +
-		usecs_to_jiffies(cstate.period / 1000 + 1);
+	next_period = jiffies + usecs_to_jiffies(cstate.period / 1000 + 1);
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		ctrl &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
@@ -308,15 +320,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 
 	/* We need a full period to elapse before disabling the channel. */
-	now = jiffies;
-	if (time_before(now, sun4i_pwm->next_period[pwm->hwpwm])) {
-		delay_us = jiffies_to_usecs(sun4i_pwm->next_period[pwm->hwpwm] -
-					   now);
-		if ((delay_us / 500) > MAX_UDELAY_MS)
-			msleep(delay_us / 1000 + 1);
-		else
-			usleep_range(delay_us, delay_us * 2);
-	}
+	sun4i_pwm_wait(next_period);
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
 	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-- 
2.20.1

