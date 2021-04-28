Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A408236CFF4
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Apr 2021 02:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbhD1AUu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 27 Apr 2021 20:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhD1AUt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 27 Apr 2021 20:20:49 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B59C061574
        for <linux-pwm@vger.kernel.org>; Tue, 27 Apr 2021 17:20:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i24so12484727edy.8
        for <linux-pwm@vger.kernel.org>; Tue, 27 Apr 2021 17:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prusa3d-cz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=coh3uK8A3rVZT8BT4tCqVuJ+myblPEITgGPRbovsrpo=;
        b=S4YKT1KkCm3jQg2KVZ/ehWg+UKPP8SljKPVr7IvlzAl4i7ZJH8UEBMkm1M866bGHNN
         Mt2MwDJbZTwVBZiBwbmV9mgVAP0X4thqHOhxU7wzgVphQI2kxHQyQpXw7gPdR1nQi4lc
         e+cNPJUarku2gyp1VxSJKo3aLkHpoIPW2v8dkc4c1dF/fk8zoYPpcM4oT/gtJ+CPP8qe
         BNJE16xNguIPSSs6Wtn9JLtn1QCAsoTi0/pa2FsYNA96WVqEa51nZjW+Ywn+X49ldQ9D
         +N7bjoMKGwl4rASICkYWpSj7dgm/lsVEgO7HcXJelazmFu+x2PGV2cn+9JW9IEXoXYQx
         MMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=coh3uK8A3rVZT8BT4tCqVuJ+myblPEITgGPRbovsrpo=;
        b=sIHPkZ9ek/c26IlnTMD3OFdlkIHQPMOHZ8d01MU9DZbK0UcW8WA4N8JkvydVgvYRwt
         H/O7xg8+RJIu2ezvHjipWgRyPG6fBrAMIn0ltdzjoHGFWDHpCKrVtVxdz/XOKjfQdDOh
         CZ2SKeTfWauvxVSLmQLBDVOxiASiW6lMmdX2paxvmxAiq7El8vOdgxPpsW8LhCihYHl0
         C77vShq9ZDcefEcFa2QjWqKo76aE5t13ExqOPu7rMaG1BIIjR6MoBzlt+7/e/CjtY+ZW
         5kJstxpAKDOmA7HF7BM5y4vBcyOec5syMnSotOO1SYQJw8ohyvQdx9WuemnIKua7uaAA
         vZbQ==
X-Gm-Message-State: AOAM531CRMeFafnsWQ1GAcaqmn7mcLpjjR4PKfDCfvk0b69hA8K6Lz2Z
        a7+kWrYNjS8b7BiJzq5mhEeUsw==
X-Google-Smtp-Source: ABdhPJz0ekb3OQBIyH6iYc/iKBgeHfQ6WBKq95E5jHRFfKk4F1digJy8gYassw6JCOF9vpb6PuKIag==
X-Received: by 2002:a05:6402:280c:: with SMTP id h12mr7359213ede.332.1619569204001;
        Tue, 27 Apr 2021 17:20:04 -0700 (PDT)
Received: from zen.local (ip-213-220-236-33.net.upcbroadband.cz. [213.220.236.33])
        by smtp.gmail.com with ESMTPSA id rs8sm802460ejb.17.2021.04.27.17.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 17:20:03 -0700 (PDT)
From:   Roman Beranek <roman.beranek@prusa3d.cz>
X-Google-Original-From: Roman Beranek <roman.beranek@prusa3d.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-sunxi@googlegroups.com,
        Roman Beranek <roman.beranek@prusa3d.com>
Subject: [PATCH] pwm: sun4i: Round delay time up to a nearest jiffy
Date:   Wed, 28 Apr 2021 02:19:46 +0200
Message-Id: <20210428001946.1059426-1-roman.beranek@prusa3d.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

More often than not, a PWM period may span nowhere near as far
as 1 jiffy, yet it still must be waited upon before the channel
is disabled.

Signed-off-by: Roman Beranek <roman.beranek@prusa3d.com>
---
 drivers/pwm/pwm-sun4i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index ce5c4fc8d..f4b991048 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -285,7 +285,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	val = (duty & PWM_DTY_MASK) | PWM_PRD(period);
 	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
 	sun4i_pwm->next_period[pwm->hwpwm] = jiffies +
-		nsecs_to_jiffies(cstate.period + 1000);
+		nsecs_to_jiffies(cstate.period) + 1;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		ctrl &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
-- 
2.31.1

