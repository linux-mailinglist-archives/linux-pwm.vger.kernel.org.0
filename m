Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9032F3954C4
	for <lists+linux-pwm@lfdr.de>; Mon, 31 May 2021 06:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhEaEsK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 May 2021 00:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhEaEsA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 May 2021 00:48:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08A3C061760
        for <linux-pwm@vger.kernel.org>; Sun, 30 May 2021 21:46:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id dg27so2219026edb.12
        for <linux-pwm@vger.kernel.org>; Sun, 30 May 2021 21:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prusa3d-cz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0wwG/Rn9um6zlw9r9jL8V2Q6hYDd1uPy7KH4n241Hsg=;
        b=S5EbIKVLC9/WQtCT+GNBCYreMNg/ZC4D22aFdQse1Mj4FeXxIr7Sq6ZwK2pF+ZJ9Bg
         GMpya0ctg+rtWwz6rYL5bFz4Q5KvxFtJS9t4aNhle/lGYi5NJTTdRTBWr7r+kjMSZxM5
         tnIgQxuWzg++m+kQc6X/6jYjSxxqlLIQOIe0qEQNDI2SLFVvRXiNu6CYquzMTfDa9LAt
         8QFh9mYUiYVwuyO2Elc6hpIgQy1T92vDiSG2RGztAc3lKjE7luG4s/G2Xbwbmtc2pfdJ
         JJdBuUKDQHEMs3gNtDM5ndlPnLbkbpho3X2Xgrgwqhi14jv9DUM7kGJSwDbuzH/Q8JqQ
         HPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0wwG/Rn9um6zlw9r9jL8V2Q6hYDd1uPy7KH4n241Hsg=;
        b=UbnzmuYBSYIdeWG1hNH1SE3DG7hvZMnGg5X1KVF4skbVFjJnVYO3HpC1I+jKfygTEn
         WwaAwsuB1RY1DkPp4t1PZdYehNSRmW0f6BdZREjxM+SvkMqRZHuuSrlkM/Yn6GV6IXv/
         q7EjkEhVdctuxXzrk1jEbFQfAGmHkkw7WsIcn9pnZnyuCx/q7Solv+o7v5ER2+W0XAOx
         iNVV04koxysEGogsiTNVo/cthLcUBlG+MYOWEBDqm1JD+j8kvZje+7jcVsHMV5SR9mbc
         UumYL4aRtLvnOCEH+E8Ns3wpM9Far3wi+XCohYlq/CzcIL3E6IcUVZ5InB6Uw5EzkRER
         XJ5Q==
X-Gm-Message-State: AOAM533z21cZhtvC0OSrtmqdwhuJFSeqpY3lJonF+kjL892/ylOeCn6w
        EUm/zHisWPScBUk6U0YD4SiZbw==
X-Google-Smtp-Source: ABdhPJx1t3/XMRBY9LSzuPp4oCSFKs8ZpLoo0r7Idrq6tIlRFlYlZponr9ZqTFdRcuMqNtwVLlXEiA==
X-Received: by 2002:a50:ee02:: with SMTP id g2mr7732330eds.333.1622436379476;
        Sun, 30 May 2021 21:46:19 -0700 (PDT)
Received: from zen.local (ip-89-103-215-157.net.upcbroadband.cz. [89.103.215.157])
        by smtp.gmail.com with ESMTPSA id h9sm6238376edt.18.2021.05.30.21.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 21:46:19 -0700 (PDT)
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
Subject: [PATCH 2/6] pwm: sun4i: disable EN bit prior to the delay
Date:   Mon, 31 May 2021 06:46:04 +0200
Message-Id: <20210531044608.1006024-3-roman.beranek@prusa3d.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531044608.1006024-1-roman.beranek@prusa3d.com>
References: <20210531044608.1006024-1-roman.beranek@prusa3d.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The reason why we wait before gating the clock is to allow for the PWM
to finish its cycle and stop. But it won't stop unless the EN bit is
disabled.

Signed-off-by: Roman Beranek <roman.beranek@prusa3d.com>
---
 drivers/pwm/pwm-sun4i.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 3721b9894cf6..2777abe66f79 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -303,6 +303,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (state->enabled)
 		ctrl |= BIT_CH(PWM_EN, pwm->hwpwm);
+	else
+		ctrl &= ~BIT_CH(PWM_EN, pwm->hwpwm);
 
 	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
 
@@ -325,7 +327,6 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	spin_lock(&sun4i_pwm->ctrl_lock);
 	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 	ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	ctrl &= ~BIT_CH(PWM_EN, pwm->hwpwm);
 	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
 	spin_unlock(&sun4i_pwm->ctrl_lock);
 
-- 
2.31.1

