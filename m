Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE9C754401
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jul 2023 22:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbjGNU4i (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Jul 2023 16:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbjGNU4h (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Jul 2023 16:56:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848691BD
        for <linux-pwm@vger.kernel.org>; Fri, 14 Jul 2023 13:56:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq6-00084j-E7; Fri, 14 Jul 2023 22:56:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq5-00EQSm-N5; Fri, 14 Jul 2023 22:56:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq4-004u47-Ub; Fri, 14 Jul 2023 22:56:32 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 07/10] pwm: rockchip: Consistenly name pwm_chip variables "chip"
Date:   Fri, 14 Jul 2023 22:56:20 +0200
Message-Id: <20230714205623.2496590-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wmvev9dVApR529FLTx3AbMYD+vyfhjH6G8GR9o32e+s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBksbZuODYB8bkDh7pH5CyGZdLbAFRPigIYUZ0Yt NmtNyuwwEaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLG2bgAKCRCPgPtYfRL+ Ts+3CACba6Y0XIVavyIlQJrGTgInI9Lkk0RgmJ26EovG2sZKrofV0oU1ZNfaleq8YeAkO8KH+hu rt/QU7p97NjN7eJLphQAsND7mpE/ngaWkEPuKFiUzdMmonS4y87OQjBNF0zfPqzX1Daj+NJ9LcR efywbRUkBfMSwY5siuoZ3z1oM15exBmrH0toLUGRrR9zJoCyJVhp8Tsxem/MT4TDWq3twtBhoZP bhdpy6ULgxrt0oRCMK18hf4x8eOjPMJC2T8t8HF1YV+EbyX3fO9aHUBghFXMj84K91OCzAhvlR5 CJhQNnSRQm0qgcIMRddqLV4nktWwU9hXVLmMo5H6P01oanlH
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Most variables holding a pointer to a pwm_chip are called "chip" which
is also the usual name in most other pwm drivers. Rename the single
variable that have a different name to be called "chip", too, for
consistency.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index c1a1f2d864b5..03ee18fb82d5 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -52,9 +52,9 @@ struct rockchip_pwm_data {
 	u32 enable_conf;
 };
 
-static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *c)
+static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(c, struct rockchip_pwm_chip, chip);
+	return container_of(chip, struct rockchip_pwm_chip, chip);
 }
 
 static int rockchip_pwm_get_state(struct pwm_chip *chip,
-- 
2.39.2

