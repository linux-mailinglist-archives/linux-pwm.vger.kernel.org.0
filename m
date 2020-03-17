Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9BB18899E
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 17:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCQQAD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 12:00:03 -0400
Received: from web0081.zxcs.nl ([185.104.29.10]:54908 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgCQQAC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 17 Mar 2020 12:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H9LrRiFVN/DHzGg7tt6K3nT+T7r5Twb2pPaTqb+k2rM=; b=IpjEpVM6M/Ap5GtnnbY2+ddG5c
        jZT3HfDBgt0Ja/5OS9rUGayxXlmLEvKMOLrpW1xZaPZnjMS+gYipvG2rrGBGvGd+S61CdB2ZYul7K
        ojAvrhr5b9ayIU5CBBToMo32i7v2brizj9lc9L+VbX7mlWyz7Zcfzjq9oPrj+s8va+y32RSNyabwi
        j3nre3ZReEVL0lzwmeSgb0sKHjy4q66b6p+GVYKj4PAcDefJxGpm13Y9waZy6sSHC2pEUD2cj7Wex
        Ct3Jd785VUo/AuUJRQR+B8gvMKZj66AOI9Ychs+qktGl8Erd3vJBxP2meNSb4mDlll4do92PdGU4a
        m5nmUKCQ==;
Received: from ip565b1bc7.direct-adsl.nl ([86.91.27.199]:60802 helo=localhost.localdomain)
        by web0081.zxcs.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <dev@pascalroeleven.nl>)
        id 1jEEdK-001IGT-0t; Tue, 17 Mar 2020 16:59:58 +0100
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
Subject: [RFC PATCH 2/4] pwm: sun4i: Disable pwm before turning off clock gate
Date:   Tue, 17 Mar 2020 16:59:04 +0100
Message-Id: <20200317155906.31288-3-dev@pascalroeleven.nl>
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

The clock gate must stay on when disabling to ensure proper turning off.
After one period it will still be disabled anyway.

Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
---
 drivers/pwm/pwm-sun4i.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 5c677c563..56942036b 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -292,13 +292,12 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		ctrl |= BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
 
-	ctrl |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-
 	if (state->enabled) {
 		ctrl |= BIT_CH(PWM_EN, pwm->hwpwm);
+		ctrl |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 	} else {
+		/* Turn gate off after delay to ensure proper turning off */
 		ctrl &= ~BIT_CH(PWM_EN, pwm->hwpwm);
-		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 	}
 
 	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
-- 
2.20.1

