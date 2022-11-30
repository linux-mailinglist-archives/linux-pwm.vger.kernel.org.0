Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8975E63D939
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Nov 2022 16:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiK3PWK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Nov 2022 10:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiK3PWJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Nov 2022 10:22:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C2F7E40A
        for <linux-pwm@vger.kernel.org>; Wed, 30 Nov 2022 07:22:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuM-0000A6-KE; Wed, 30 Nov 2022 16:21:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuL-001Ldo-6R; Wed, 30 Nov 2022 16:21:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0OuL-001Vqw-6V; Wed, 30 Nov 2022 16:21:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 07/11] pwm: imx27: Propagate errors in .get_state() to the caller
Date:   Wed, 30 Nov 2022 16:21:44 +0100
Message-Id: <20221130152148.2769768-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=657; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=aNMminSzhEfY4RWjyrPU8ROYOcyHGtsXaYEJfl8fVzg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjh3T35lCJuM0bY7G7YFVaGLzhoj+JWyIr1kcMFt8E QjNsoqKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY4d09wAKCRDB/BR4rcrsCcwCCA CVIoVNoOg/MsPy8pRW7krMOjr3DMIlpyphyovx+yqC9uOg0UVxfid7zXlqHI55s081zUuV9uQzIGOa cILu0YQLzzjyRaIDZHzhjREZt8L2lksTHWcP0UCQVeaOvxJCCtGAw+VV3M4aAouFlSZ3BGi4mY2SfI k+hUIKXgYrd/tUaBRnO8rZJxY8eewDgUI8PKE/6Lb4nt+fPnUr7UjdIfnspaZbUApcg3y3jUgesh04 041jE7jJkKAq8YzxZ6tDPmrbyMWOm3Zqjzm9Sgqi2pSweWseAZHAHgYs18B0kNm1BMVphr2rVDO+15 2jcY9Iz2ThSOZFk58B5r7cLTggyOKP
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

.get_state() can return an error indication. Make use of it to propagate
failing hardware accesses.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 3a22c2fddc45..29a3089c534c 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -128,7 +128,7 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
 
 	ret = pwm_imx27_clk_prepare_enable(imx);
 	if (ret < 0)
-		return 0;
+		return ret;
 
 	val = readl(imx->mmio_base + MX3_PWMCR);
 
-- 
2.38.1

