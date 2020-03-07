Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D872817CE5F
	for <lists+linux-pwm@lfdr.de>; Sat,  7 Mar 2020 14:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgCGNTw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 7 Mar 2020 08:19:52 -0500
Received: from inva021.nxp.com ([92.121.34.21]:43446 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgCGNTw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 7 Mar 2020 08:19:52 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2C925200FCC;
        Sat,  7 Mar 2020 14:19:48 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F165200D84;
        Sat,  7 Mar 2020 14:19:45 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2E45F402FA;
        Sat,  7 Mar 2020 21:19:41 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] pwm: imx27: Add COMPILE_TEST support for PWM_IMX27
Date:   Sat,  7 Mar 2020 21:13:32 +0800
Message-Id: <1583586812-6635-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add COMPILE_TEST support to PWM_IMX27 driver for better compile
testing coverage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 30190be..b4fc982 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -204,7 +204,7 @@ config PWM_IMX1
 
 config PWM_IMX27
 	tristate "i.MX27 PWM support"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	help
 	  Generic PWM framework driver for i.MX27 and later i.MX SoCs.
 
-- 
2.7.4

