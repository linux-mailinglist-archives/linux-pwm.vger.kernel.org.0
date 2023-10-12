Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FAD7C72A9
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379564AbjJLQbC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379566AbjJLQa5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE8FDC
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaL-0004kz-Nt; Thu, 12 Oct 2023 18:30:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaL-001C5w-1z; Thu, 12 Oct 2023 18:30:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaK-00F5Mn-Oz; Thu, 12 Oct 2023 18:30:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 011/109] pwm: ep93xx: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:28:39 +0200
Message-ID: <20231012162827.1002444-122-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=LHD5njTe7mZENdQkJW0A8QSj/HQtZmw1x8mfHwTVCwI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB65Kwcf5LCeccBBo01mOVWd3R930ht9K3Knp 8o935HoHVWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgeuQAKCRCPgPtYfRL+ TjvtCACC3WWYV/YzDqKBjLkkiw3kNwbepSLhZAAIjLT1Rze4rQJgI4mKqs/in0tEGgybYmjI9Vs ZC5pHIQUtSjUPihPi7IpY2CwC3ZVRSOahEJEAXJiUJ1oS6eNRl4ZaCi0HFMVyk4an4aN6U/8yhc dALXsnWqdlk6f8czJfxYXmIQiIVH7GqY5sC6t7ZDbNrPNDDGuhBYdM1JLhztkxGcaU3FaZ2hHtu DT5DXq44PxwqYmBCD94IPX6YGzLlGpStIn9Gu2PCcKo9sSJRkkFNQgaTW1f16DQ4cVZkSAFUUED CfMNWuJOAFbT247amT0I/P8x+omwqwYPnf9kctG6bTXE0Pmi
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ep93xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 51e072572a87..e4c3546a61c8 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -46,14 +46,14 @@ static inline struct ep93xx_pwm *to_ep93xx_pwm(struct pwm_chip *chip)
 
 static int ep93xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct platform_device *pdev = to_platform_device(chip->dev);
+	struct platform_device *pdev = to_platform_device(pwmchip_parent(chip));
 
 	return ep93xx_pwm_acquire_gpio(pdev);
 }
 
 static void ep93xx_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct platform_device *pdev = to_platform_device(chip->dev);
+	struct platform_device *pdev = to_platform_device(pwmchip_parent(chip));
 
 	ep93xx_pwm_release_gpio(pdev);
 }
-- 
2.42.0

