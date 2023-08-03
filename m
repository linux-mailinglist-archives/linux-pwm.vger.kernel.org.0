Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABA376EBCF
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Aug 2023 16:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbjHCOHq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Aug 2023 10:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjHCOHW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Aug 2023 10:07:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC8A3C3B
        for <linux-pwm@vger.kernel.org>; Thu,  3 Aug 2023 07:06:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRYyO-0006mh-UY; Thu, 03 Aug 2023 16:06:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRYyO-000rBK-4r; Thu, 03 Aug 2023 16:06:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRYyN-00A9kH-4n; Thu, 03 Aug 2023 16:06:39 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/2] pwm: crc: Allow compilation as module and with COMPILE_TEST
Date:   Thu,  3 Aug 2023 16:06:32 +0200
Message-Id: <20230803140633.138165-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803140633.138165-1-u.kleine-koenig@pengutronix.de>
References: <20230803140633.138165-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=urszrUUrXb5eA8QNCUEI+H8nPmd5wkfqzlDPkC5KqDs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBky7RktQPUlZcbGj2lsC3n3u0xKeBJqNuctyNJm B0ZuWDOQdKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZMu0ZAAKCRCPgPtYfRL+ Tu9ZCACc6SmjCfixSkxQ6Bq36Gb7jlrs3Mo61o1PmFnreReU1pDaR1l6G2/IGJanpCzR9ixC8Ov /N/yEZ3PsLu9TEvt2uZWlitWR8qbWccz2XC7MSYAYOh5RIALxTcDAJwNef5xptcgxjV/kQUAOyJ d1XdzBVd+cnnAYjO+cnKXdA76q7mp4nlPbWeTOhxL1Hh+SuE6FWA4SqDZ5k1Qou9k92NOQ0bdYf QNR7vv8EVVsjlg9i+S1Q/yIkIDcZNO/kU8W+1NPdLaUs/e6v3jmt2nyGaKV7K3qgKPCad50fiFu vnNWbG+zZGfg7c3VixNzWC4XyXel+a74WpYDwg2ZGCC4e6cU
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The driver compiles just fine as a module. The parent driver's Kconfig
symbol already depends on X86 || COMPILE_TEST, so X86 can just be
dropped from the dependencies allowing compilation on other platforms
than x86.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/Kconfig   | 4 ++--
 drivers/pwm/pwm-crc.c | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 6210babb0741..9cdefd16bd58 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -173,8 +173,8 @@ config PWM_CLPS711X
 	  will be called pwm-clps711x.
 
 config PWM_CRC
-	bool "Intel Crystalcove (CRC) PWM support"
-	depends on X86 && INTEL_SOC_PMIC
+	tristate "Intel Crystalcove (CRC) PWM support"
+	depends on INTEL_SOC_PMIC
 	help
 	  Generic PWM framework driver for Crystalcove (CRC) PMIC based PWM
 	  control.
diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index b9f063dc6b5f..2b0b659eee97 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -184,5 +184,8 @@ static struct platform_driver crystalcove_pwm_driver = {
 		.name = "crystal_cove_pwm",
 	},
 };
+module_platform_driver(crystalcove_pwm_driver);
 
-builtin_platform_driver(crystalcove_pwm_driver);
+MODULE_ALIAS("platform:crystal_cove_pwm");
+MODULE_DESCRIPTION("Intel Crystalcove (CRC) PWM support");
+MODULE_LICENSE("GPL");
-- 
2.39.2

