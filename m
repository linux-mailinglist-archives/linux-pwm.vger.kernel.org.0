Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF79E2B7A90
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 10:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgKRJpW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 04:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgKRJpW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Nov 2020 04:45:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C08C061A4D
        for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2020 01:45:22 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfK1f-0002Sf-0T; Wed, 18 Nov 2020 10:45:19 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfK1d-0007rF-Pu; Wed, 18 Nov 2020 10:45:17 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org
Subject: [PATCH 2/2] pwm: lpss: make compilable with COMPILE_TEST
Date:   Wed, 18 Nov 2020 10:45:09 +0100
Message-Id: <20201118094509.365684-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201118094509.365684-1-u.kleine-koenig@pengutronix.de>
References: <20201118094509.365684-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

All used acpi functions have dummy implementations, and there is no hard
dependency on x86.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 852aa128c30c..9e497e26aed5 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -301,8 +301,8 @@ config PWM_LPSS
 
 config PWM_LPSS_PCI
 	tristate "Intel LPSS PWM PCI driver"
-	depends on X86 && PCI
-	depends on HAS_IOMEM
+	depends on X86 || COMPILE_TEST
+	depends on HAS_IOMEM && PCI
 	select PWM_LPSS
 	help
 	  The PCI driver for Intel Low Power Subsystem PWM controller.
@@ -312,7 +312,7 @@ config PWM_LPSS_PCI
 
 config PWM_LPSS_PLATFORM
 	tristate "Intel LPSS PWM platform driver"
-	depends on X86 && ACPI
+	depends on (X86 && ACPI) || COMPILE_TEST
 	depends on HAS_IOMEM
 	select PWM_LPSS
 	help
-- 
2.28.0

