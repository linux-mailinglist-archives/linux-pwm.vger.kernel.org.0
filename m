Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406FB65086D
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Dec 2022 09:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiLSIKY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Dec 2022 03:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLSIKX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Dec 2022 03:10:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388D662E9
        for <linux-pwm@vger.kernel.org>; Mon, 19 Dec 2022 00:10:22 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p7BE4-0001xN-99; Mon, 19 Dec 2022 09:10:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p7BE2-000HeD-Hc; Mon, 19 Dec 2022 09:10:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p7BE1-006G8y-GT; Mon, 19 Dec 2022 09:10:17 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutonix.de
Subject: [PATCH] pwm: lp3943: Drop unused i2c include
Date:   Mon, 19 Dec 2022 09:10:08 +0100
Message-Id: <20221219081008.1399166-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=604; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=xMnQWhoESjrrFd6jIuNc7ZpLr1qjq+1lykvfARtTF/c=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjoBxcAbrbabqT2hek/ODiodnBBKyyB4ITcSRARGzo YWgNlNWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY6AcXAAKCRDB/BR4rcrsCXBrB/ wNo1XtloOkKkXxAOW7HUHTqRBgZK8nvsLj1HIdUqx0jKkCX4sJ9+1ytypgUuCwA3BHXWaXbsvIgpUp 2Wg8VnsqsVgpaodSMqUK9w1i2hhj5O9A50YRzJpZsFikk0BTgje/Jp8hs3GZiCRenUnfvf9R41Vz3Y WftmJ3yVf3Tqane1FVLP6Thyx7caOuRWoRP7kRsQNGCwVtzth2C46NeIy4J5luq2iOVadhOucswWOS 93WgRhHn4uSaIeZzakVCa3EkjdBr0D3Yuc/TOXjE50OVW7RssTXk4GxZD4kFzdmhKq8J4YbuiBMM7o F/BSgBDA2iV4Ddp6iVg4VNHBZ1gjeB
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

lp3943 is a platform driver that doesn't use any symbol provided in
<linux/i2c.h>. So drop the include.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lp3943.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index 215ef9069114..35675e4058c6 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/err.h>
-#include <linux/i2c.h>
 #include <linux/mfd/lp3943.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-- 
2.38.1

