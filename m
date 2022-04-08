Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9394F99A7
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Apr 2022 17:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbiDHPlH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 Apr 2022 11:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbiDHPlG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Apr 2022 11:41:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4A3F2D
        for <linux-pwm@vger.kernel.org>; Fri,  8 Apr 2022 08:39:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ncqhP-00026q-P1; Fri, 08 Apr 2022 17:38:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ncqhP-001pNY-LZ; Fri, 08 Apr 2022 17:38:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ncqhN-001zxG-GD; Fri, 08 Apr 2022 17:38:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: raspberrypi-poe: Fix endianess in firmware struct
Date:   Fri,  8 Apr 2022 17:38:46 +0200
Message-Id: <20220408153846.172701-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270; h=from:subject; bh=qppT0QwlmwSew9YK86Bork++2LPVJXSxc1b9XmWB6hQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiUFcCcIycYk9qyLkYceQPOYLgFwE6HAKu/TfSvibV 9ecADmyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYlBXAgAKCRDB/BR4rcrsCRqpB/ 9TrhaijANV6uc3yTHjeDVlNsI45nQ+yMki8pzzw6U3MH3w6OzqqqW0ar4KnBjGi+th+ZVepyxQwlbM OfKJqUzFvRBDagmtd/jbHs7999Kt/3aW4l63lYg+51hA94tt72m27nk8Mf7lx9zeWNBMARsDHVtAVP 4cKJq7G2J5CZNsD/XDthMlV9cgR52RrkLHdm8U2xrCxhoGe10+Z6tMabEBR6BoR3OiFEHpBqp2dFCx N550b8GWkBue5K8kTt74cFOmbV0jiQfZ10NVOVkxKZvwGPUY2WEjydRxUwuTM3klSHK9NWey98G5dc kOd0mB01Nk14DpV8j6QCJOwzlvEGIF
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

The reg member of struct raspberrypi_pwm_prop is a little endian 32 bit
quantity. Explicitly convert the (native endian) value to little endian
on assignment as is already done in raspberrypi_pwm_set_property().

This fixes the following sparse warning:

	drivers/pwm/pwm-raspberrypi-poe.c:69:24: warning: incorrect type in initializer (different base types)
	drivers/pwm/pwm-raspberrypi-poe.c:69:24:    expected restricted __le32 [usertype] reg
	drivers/pwm/pwm-raspberrypi-poe.c:69:24:    got unsigned int [usertype] reg

Fixes: 79caa362eab6 ("pwm: Add Raspberry Pi Firmware based PWM bus")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-raspberrypi-poe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-raspberrypi-poe.c b/drivers/pwm/pwm-raspberrypi-poe.c
index e52e29fc8231..6ff73029f367 100644
--- a/drivers/pwm/pwm-raspberrypi-poe.c
+++ b/drivers/pwm/pwm-raspberrypi-poe.c
@@ -66,7 +66,7 @@ static int raspberrypi_pwm_get_property(struct rpi_firmware *firmware,
 					u32 reg, u32 *val)
 {
 	struct raspberrypi_pwm_prop msg = {
-		.reg = reg
+		.reg = cpu_to_le32(reg),
 	};
 	int ret;
 

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1

