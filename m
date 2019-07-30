Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFC597A8DC
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2019 14:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfG3Mmd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Jul 2019 08:42:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48063 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfG3Mmd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Jul 2019 08:42:33 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hsRSX-0006eR-Oa; Tue, 30 Jul 2019 14:42:29 +0200
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hsRSX-0001H4-7M; Tue, 30 Jul 2019 14:42:29 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: imx: document known limitations
Date:   Tue, 30 Jul 2019 14:42:27 +0200
Message-Id: <20190730124227.4854-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 434a351fb626..e37825ddba87 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -3,6 +3,10 @@
  * simple driver for PWM (Pulse Width Modulator) controller
  *
  * Derived from pxa PWM driver by eric miao <eric.miao@marvell.com>
+ *
+ * Limitations:
+ * - When disabled the output is driven to 0 independant of the configured
+ *   polarity.
  */
 
 #include <linux/bitfield.h>
-- 
2.20.1

