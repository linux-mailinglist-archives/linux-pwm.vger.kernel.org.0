Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21693D5AF6
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Jul 2021 16:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbhGZNZ4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Jul 2021 09:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhGZNZ4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Jul 2021 09:25:56 -0400
X-Greylist: delayed 291 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Jul 2021 07:06:24 PDT
Received: from forward106p.mail.yandex.net (forward106p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F853C061757
        for <linux-pwm@vger.kernel.org>; Mon, 26 Jul 2021 07:06:24 -0700 (PDT)
Received: from myt6-22bd3499f8ff.qloud-c.yandex.net (myt6-22bd3499f8ff.qloud-c.yandex.net [IPv6:2a02:6b8:c12:239b:0:640:22bd:3499])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id 451911C8236B;
        Mon, 26 Jul 2021 17:01:31 +0300 (MSK)
Received: from myt3-07a4bd8655f2.qloud-c.yandex.net (myt3-07a4bd8655f2.qloud-c.yandex.net [2a02:6b8:c12:693:0:640:7a4:bd86])
        by myt6-22bd3499f8ff.qloud-c.yandex.net (mxback/Yandex) with ESMTP id nR4srztfoV-1VHC9flO;
        Mon, 26 Jul 2021 17:01:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1627308091;
        bh=19r/IJH5zjWBxHf0yF/eDrBrzuQx5ewvS9HfSxCtqEk=;
        h=In-Reply-To:References:Date:Subject:To:From:Message-Id:Cc;
        b=LSbUCMWULaq1/iJWROWo2qNOLoBAYdc3t2qdkUp3j+FTVquOjAQ5SGzT+KuPhMV/n
         r7Pz8r2+E1JFbe+UKgYINUIIlc8PWHsQOQkOKWNuEDjKjaBN0F8gN7fHXymEKZQ9DO
         JCAx6Kratrv0gR4V5U1yMxEed6lVQKwnWKWu0ESo=
Authentication-Results: myt6-22bd3499f8ff.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt3-07a4bd8655f2.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id olJ9yWy468-1U2iFbK5;
        Mon, 26 Jul 2021 17:01:30 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 7/8] pwm: ep93xx: Prepare clock before using it
Date:   Mon, 26 Jul 2021 16:59:55 +0300
Message-Id: <20210726140001.24820-8-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210726140001.24820-1-nikita.shubin@maquefel.me>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
to Common Clock Framework.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/pwm/pwm-ep93xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 4ca70794ad96..8c0d4d69d9e6 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -74,7 +74,7 @@ static int ep93xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * Configuration can be changed at any time.
 	 */
 	if (!pwm_is_enabled(pwm)) {
-		ret = clk_enable(ep93xx_pwm->clk);
+		ret = clk_prepare_enable(ep93xx_pwm->clk);
 		if (ret)
 			return ret;
 	}
@@ -105,7 +105,7 @@ static int ep93xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (!pwm_is_enabled(pwm))
-		clk_disable(ep93xx_pwm->clk);
+		clk_disable_unprepare(ep93xx_pwm->clk);
 
 	return ret;
 }
@@ -120,7 +120,7 @@ static int ep93xx_pwm_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * The clock needs to be enabled to access the PWM registers.
 	 * Polarity can only be changed when the PWM is disabled.
 	 */
-	ret = clk_enable(ep93xx_pwm->clk);
+	ret = clk_prepare_enable(ep93xx_pwm->clk);
 	if (ret)
 		return ret;
 
@@ -129,7 +129,7 @@ static int ep93xx_pwm_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		writew(0x0, ep93xx_pwm->base + EP93XX_PWMx_INVERT);
 
-	clk_disable(ep93xx_pwm->clk);
+	clk_disable_unprepare(ep93xx_pwm->clk);
 
 	return 0;
 }
@@ -139,7 +139,7 @@ static int ep93xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct ep93xx_pwm *ep93xx_pwm = to_ep93xx_pwm(chip);
 	int ret;
 
-	ret = clk_enable(ep93xx_pwm->clk);
+	ret = clk_prepare_enable(ep93xx_pwm->clk);
 	if (ret)
 		return ret;
 
@@ -153,7 +153,7 @@ static void ep93xx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct ep93xx_pwm *ep93xx_pwm = to_ep93xx_pwm(chip);
 
 	writew(0x0, ep93xx_pwm->base + EP93XX_PWMx_ENABLE);
-	clk_disable(ep93xx_pwm->clk);
+	clk_disable_unprepare(ep93xx_pwm->clk);
 }
 
 static const struct pwm_ops ep93xx_pwm_ops = {
-- 
2.26.2

