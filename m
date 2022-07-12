Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8306B5714FE
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Jul 2022 10:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiGLIrL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 Jul 2022 04:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiGLIrK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Jul 2022 04:47:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403DCA5E7D
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jul 2022 01:47:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBBXs-0005qu-N6; Tue, 12 Jul 2022 10:47:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBBXr-000TRi-1N; Tue, 12 Jul 2022 10:47:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBBXq-004glI-Cl; Tue, 12 Jul 2022 10:47:02 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: twl-led: Document some limitations and link to the reference manual
Date:   Tue, 12 Jul 2022 10:46:56 +0200
Message-Id: <20220712084656.21043-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599; h=from:subject; bh=kot9CrGSPDenLpPrY+ywPeTxXA9dZ8AWO95dXBQj0CY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBizTT7ltCCwCcsEPpDOAmjW4PYimQiwVsLEsCqlQYP /ix5gWaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYs00+wAKCRDB/BR4rcrsCfmhB/ 9CGQjvqJBcqhazakqdhXvvzwcN+qlG00L9q5NCUDWvMQeJD10aR0YxZVUYFZybV3QP6/WOUU9ivBOp poutk4fyeBUWepKFM7nBLqtp/jPsijZPHnumhhc7OitagJA7bbcZdeJaceTGNS53JlL3NGYOidcFeE kx2tu7NmrFObC55l2ERLJYk1zi5Vk24yBLG+fqoJGFyraK7nD8E0pltBJj4IDTHnYA/Yo8hIyEVbm9 FuK+udPPNq51Ms0K9yI59YY7IxFJ7x0SsKIcXOA4Me+JGZHp9WuQZj3H++VIH0eAsKKa9nWGU3FwXj 1oVlP27D30C8n4rjgnTTPdCaVJ+unx
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

I found these just from reading the reference manual and the driver
source. It's unclear to me if there are glitches when updating the ON
and OFF registers.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-twl-led.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
index ed0b63dd38f1..8fb84b441853 100644
--- a/drivers/pwm/pwm-twl-led.c
+++ b/drivers/pwm/pwm-twl-led.c
@@ -7,6 +7,22 @@
  *
  * This driver is a complete rewrite of the former pwm-twl6030.c authorded by:
  * Hemanth V <hemanthv@ti.com>
+ *
+ * Reference manual for the twl6030 is available at:
+ * https://www.ti.com/lit/ds/symlink/twl6030.pdf
+ *
+ * Limitations:
+ * - The twl6030 hardware only supports two period lengths (128 clock ticks and
+ *   64 clock ticks), the driver only uses 128 ticks
+ * - The hardware doesn't support ON = 0, so the active part of a period doesn't
+ *   start at its beginning.
+ * - The hardware could support inverted polarity (with a similar limitation as
+ *   for normal: the last clock tick is always inactive).
+ * - The hardware emits a constant low output when disabled.
+ * - A request for .duty_cycle = 0 results in an output wave with one active
+ *   clock tick per period. This should better use the disabled state.
+ * - The driver only implements setting the relative duty cycle.
+ * - The driver doesn't implement .get_state().
  */
 
 #include <linux/module.h>

base-commit: 394b517585da9fbb2eea2f2103ff47d37321e976
-- 
2.36.1

