Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA79373FCB
	for <lists+linux-pwm@lfdr.de>; Wed,  5 May 2021 18:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhEEQ3s (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 May 2021 12:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbhEEQ3s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 May 2021 12:29:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD35C061574
        for <linux-pwm@vger.kernel.org>; Wed,  5 May 2021 09:28:51 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1leKOG-0002T0-CW; Wed, 05 May 2021 18:28:48 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1leKOE-0001Bc-NH; Wed, 05 May 2021 18:28:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de
Subject: [PATCH 2/2] pwm: stm32-lp: Don't check the return code of pwmchip_remove()
Date:   Wed,  5 May 2021 18:28:43 +0200
Message-Id: <20210505162843.188901-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505162843.188901-1-u.kleine-koenig@pengutronix.de>
References: <20210505162843.188901-1-u.kleine-koenig@pengutronix.de>
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

pwmchip_remove() always returns 0. Don't use the value to make it
possible to eventually change the function to return void. This is a
good thing as pwmchip_remove() is usually called from a remove function
(mostly for platform devices) and their return value is ignored by the
device core anyhow.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32-lp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 2464f7a24983..58bc75857b80 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -224,7 +224,9 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
 {
 	struct stm32_pwm_lp *priv = platform_get_drvdata(pdev);
 
-	return pwmchip_remove(&priv->chip);
+	pwmchip_remove(&priv->chip);
+
+	return 0;
 }
 
 static int __maybe_unused stm32_pwm_lp_suspend(struct device *dev)
-- 
2.30.2

