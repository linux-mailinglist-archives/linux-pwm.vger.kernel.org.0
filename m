Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40B84FB3B6
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Apr 2022 08:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiDKG14 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Apr 2022 02:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244963AbiDKG1n (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Apr 2022 02:27:43 -0400
Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E523E15A29;
        Sun, 10 Apr 2022 23:25:28 -0700 (PDT)
Received: from tarshish.tkos.co.il (unknown [10.0.8.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id CB20D440B04;
        Mon, 11 Apr 2022 09:24:54 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1649658295;
        bh=8TsfAT2S1U8xqv6JM1/X3JBGHORa30BGGzVHgtIwLbc=;
        h=From:To:Cc:Subject:Date:From;
        b=c1X5n50YlK2MGLpoodtqVZEUYNqVEK/362HbkEo1UP28uo8ZSI6bRxpEWhtBUTYgT
         x4oobefUzWK764OBrV+R0lEpgRRgcXEc2uvd1jeRgxaLEF3Xm39dFrsvXYFvkwNTx/
         WieABLFuHtuNahqhKpAYjIoowAB1vndwoOPy4dJ0Gys3nl5kFWdLpjyY+n55cTaQgs
         FBnL76baWv/LW9mtSDzge0NEcZ1VHDzEFYBAv60Y2xzNzOCAe2dxm0YyOcKgqKi4qg
         R5/+t4g7jaLtRc7xZLvOH758vP81wQ/qb16ITLeaNbi6LDH7ltVPjvJ8LIMLA3g6E+
         EVFzyglWO9YMg==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>, linux-pwm@vger.kernel.org,
        linux-gpio@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] gpio: mvebu: drop pwm base assignment
Date:   Mon, 11 Apr 2022 09:23:40 +0300
Message-Id: <145383feecbe43f3bbd3e128143f7890f0314b3b.1649658220.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pwmchip_add() unconditionally assigns the base ID dynamically. Commit
f9a8ee8c8bcd1 ("pwm: Always allocate PWM chip base ID dynamically")
dropped all base assignment from drivers under drivers/pwm/. It missed
this driver. Fix that.

Fixes: f9a8ee8c8bcd1 ("pwm: Always allocate PWM chip base ID dynamically")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/gpio/gpio-mvebu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 4c1f9e1091b7..a2c8dd329b31 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -871,13 +871,6 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	mvpwm->chip.dev = dev;
 	mvpwm->chip.ops = &mvebu_pwm_ops;
 	mvpwm->chip.npwm = mvchip->chip.ngpio;
-	/*
-	 * There may already be some PWM allocated, so we can't force
-	 * mvpwm->chip.base to a fixed point like mvchip->chip.base.
-	 * So, we let pwmchip_add() do the numbering and take the next free
-	 * region.
-	 */
-	mvpwm->chip.base = -1;
 
 	spin_lock_init(&mvpwm->lock);
 
-- 
2.35.1

