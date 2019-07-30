Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 258C77A88C
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2019 14:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbfG3Mce (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Jul 2019 08:32:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60841 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbfG3Mcd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Jul 2019 08:32:33 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hsRIt-0005bn-3Q; Tue, 30 Jul 2019 14:32:31 +0200
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hsRIs-0008IF-Oe; Tue, 30 Jul 2019 14:32:30 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: jz4740: document known limitations
Date:   Tue, 30 Jul 2019 14:32:29 +0200
Message-Id: <20190730123229.31839-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1564435163.6633.4@crapouillou.net>
References: <1564435163.6633.4@crapouillou.net>
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

The jz4740 PMW implementation doesn't fulfill the (up to now
insufficiently documented) requirements of the PWM API. At least
document them in the driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
I intended to also add a Link to the reference manual, Paul suggested to
use https://zcrc.me/~paul/jz_docs/ in December last year, but this
stopped to work.

The second item is something I noticed when reading through the manual,
but it's not confirmed in practise. A test that this is indeed the case
could be done by configuring a long period (say 5s) and a (in
comparison) small duty-cycle (say 1s). If the pwm output isn't active
when the call returns I'd consider this proven.

@Paul: would you mind doing this test?

Best regards
Uwe

 drivers/pwm/pwm-jz4740.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index f901e8a0d33d..9d444d012f92 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -2,6 +2,11 @@
 /*
  *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
  *  JZ4740 platform PWM support
+ *
+ * Limitations:
+ * - The .apply callback doesn't complete the currently running period before
+ *   reconfiguring the hardware.
+ * - Each period starts with the inactive part.
  */
 
 #include <linux/clk.h>
-- 
2.20.1

