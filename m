Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE671363D9
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2020 00:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgAIXbP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jan 2020 18:31:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37377 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgAIXbP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jan 2020 18:31:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so24895wru.4
        for <linux-pwm@vger.kernel.org>; Thu, 09 Jan 2020 15:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6mL2rwAPESuHHV2T0yqwj8NcOs/y+OPpLLCMYhkdgY=;
        b=WHYq1fFh9Cxbs9wNaMgifYWFbckwV0pUXZqMxJQCtBA3YP2j/BbVnFoVGSfN65SwSv
         gUiQ+lh/SQXhNWPPqEF9P+u4NjB54mMMprX9wevto19lDtvn2MmOi1qdH01q7ExdSYZA
         T4oJ9NVOU9Fbq5xWX4cRsKvqOVbyCsSsbrtEasmQROlKfYk86d7ksdG05+V5BfeswNCX
         GmXCGVNZUrHkOkgbiiqHhejqH9HEMkJNsogVlCBOBSzEoUqBNhVXQE2nHGf+7Oblzszo
         oBEqqB7TvA9q0jesZLGTK0YbHXjYJv6sxkbQeF4IAlIXxYRAnA6Vvjc3cKkcvQYqbNl+
         bqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6mL2rwAPESuHHV2T0yqwj8NcOs/y+OPpLLCMYhkdgY=;
        b=MY/Q43EHPJLnwg7X0/14vM+7q2nf/K1348Apz6NwM3CT6XHDxY71FVNlFdTzzZ7+JB
         4fWk37ZV+JCz/IYqNs4Y6AWlJVEXE8x0sNS1H3ASPLi4z3jJ7f/I0kR3SQ/UjTqKbqY1
         JBimDRrhpch55H2ANBUMWzTvT71/jI6SenZm1CpCtokTwaWoT0aHUeDdPWNgpdagq1F5
         jetksl9KY3y2pASizCVP2XAw6xrLiwEDRYu0b97RS1yxpPdsZyFYxIyW25bj2g+MaLV6
         GUrsPjcyJzrcxb345H879rWUKKW33/BzG0DiccjRIsrQZunA0XyovKXZvWD+Y9rqys3k
         u5gg==
X-Gm-Message-State: APjAAAW9OKQOr6qe5Lbe6NR/Q3HL4lsQv1qqHvFGjAeeN/0zgLGCqHYA
        Szn2t0n0Jth/28L4vCoRUiM=
X-Google-Smtp-Source: APXvYqxYCt3lxuhdOfrbwTTC08LgsFznYbnh4QnkiyuzHfw0Pr0dMFXtnPnXBE6EQuGhXyiUcDU6zQ==
X-Received: by 2002:adf:eb09:: with SMTP id s9mr237036wrn.61.1578612672652;
        Thu, 09 Jan 2020 15:31:12 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::42f0:c285])
        by smtp.gmail.com with ESMTPSA id h2sm107563wrt.45.2020.01.09.15.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 15:31:12 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Alex Mobigo <alex.mobigo@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] [RFC] pwm: sun4i: Move pwm_calculate out of spin_lock
Date:   Fri, 10 Jan 2020 00:31:06 +0100
Message-Id: <20200109233106.17060-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pwm_calculate calls clk_get_rate while holding a spin_lock.

This create an issue as clk_get_rate() may sleep.

Move pwm_calculate out of this spin_lock.

Fixes: c32c5c50d4fe ("pwm: sun4i: Switch to atomic PWM")
Reported-by: Alex Mobigo <alex.mobigo@gmail.com>
Suggested-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---

Hi,

this issue has been reported on linux-sunxi Google groups.

I don't have a board with PWM to confirm it.

Please wait a tested-by.

Thanks,
Clément

 drivers/pwm/pwm-sun4i.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 1afd41ebd3fd..6b230029dc49 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -248,19 +248,18 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	}
 
-	spin_lock(&sun4i_pwm->ctrl_lock);
-	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-
 	ret = sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler,
 				  &bypass);
 	if (ret) {
 		dev_err(chip->dev, "period exceeds the maximum value\n");
-		spin_unlock(&sun4i_pwm->ctrl_lock);
 		if (!cstate.enabled)
 			clk_disable_unprepare(sun4i_pwm->clk);
 		return ret;
 	}
 
+	spin_lock(&sun4i_pwm->ctrl_lock);
+	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+
 	if (sun4i_pwm->data->has_direct_mod_clk_output) {
 		if (bypass) {
 			ctrl |= BIT_CH(PWM_BYPASS, pwm->hwpwm);
-- 
2.20.1

