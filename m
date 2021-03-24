Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7FB348279
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Mar 2021 21:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbhCXUCH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 24 Mar 2021 16:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbhCXUBm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 Mar 2021 16:01:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2863C061763
        for <linux-pwm@vger.kernel.org>; Wed, 24 Mar 2021 13:01:41 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lP9hC-000890-7T; Wed, 24 Mar 2021 21:01:38 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lP9hA-0008TS-8V; Wed, 24 Mar 2021 21:01:36 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] pwm: bcm-iproc: Free resources only after pwmchip_remove()
Date:   Wed, 24 Mar 2021 21:01:34 +0100
Message-Id: <20210324200134.75513-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Before pwmchip_remove() returns the PWM is expected to be functional. So
remove the pwmchip before disabling the clock.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm-iproc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 529a66ab692d..edd2ce1760ab 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -253,9 +253,11 @@ static int iproc_pwmc_remove(struct platform_device *pdev)
 {
 	struct iproc_pwmc *ip = platform_get_drvdata(pdev);
 
+	pwmchip_remove(&ip->chip);
+
 	clk_disable_unprepare(ip->clk);
 
-	return pwmchip_remove(&ip->chip);
+	return 0;
 }
 
 static const struct of_device_id bcm_iproc_pwmc_dt[] = {
-- 
2.30.2

