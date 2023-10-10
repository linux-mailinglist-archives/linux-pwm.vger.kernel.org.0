Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956FA7BF4BF
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Oct 2023 09:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442488AbjJJHvX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Oct 2023 03:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442597AbjJJHvV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Oct 2023 03:51:21 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDF0B8
        for <linux-pwm@vger.kernel.org>; Tue, 10 Oct 2023 00:51:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WP-00086W-MA; Tue, 10 Oct 2023 09:51:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WP-000bix-9D; Tue, 10 Oct 2023 09:51:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WP-00Cvmo-0B; Tue, 10 Oct 2023 09:51:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 05/11] pwm: dwc: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Tue, 10 Oct 2023 09:51:06 +0200
Message-Id: <20231010075112.755178-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
References: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hnJyU72cjYfeGb3703HMX6Xcn5/1Hg2lADECe005B+Y=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlRVpkSpuA7XOZ3JDxhbnJIFK547TfvhkPX35s6Vdizzv 7/IieDpZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAixZ84GHrkFf0/BlrbOlq0 iyc+28Vkz8jd/60s8nBZyryIe2YmkTt5p1douUe9VNkvVhn3PS3AwK5opW/Rmyk9RSfUpmdGu/8 sL9R1d126bL979OKJjgJ/Fvos0zk0X1Ig9WL8oadn5/1qFxSLVv4febJ6ccTf+IrO674pK6ZHac 2buX1XRn3hD+3fiqcjTSc++OsaNDtYYMG6z38K7APm3iufdLHp0a0Vszr/WSaUWVgcTk26q/xUp 9845Jvp+T+2d1TsrvtUBWxfGBd6JObVBq+z7VONg2MlzUzYPX/KHOorrIiYxBcTUH1VtFtlpeQr pw+v4sN54/13+0y9eMo1fxHP0dokBRbW9Ef7pu/6sIcTAA==
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

This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
care about when the functions are actually used, so the corresponding
#ifdef can be dropped.

Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
isn't enabled.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-dwc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 3bbb26c862c3..87cc3d6c7868 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -260,7 +260,6 @@ static void dwc_pwm_remove(struct pci_dev *pci)
 	pm_runtime_get_noresume(&pci->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int dwc_pwm_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
@@ -295,9 +294,8 @@ static int dwc_pwm_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(dwc_pwm_pm_ops, dwc_pwm_suspend, dwc_pwm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(dwc_pwm_pm_ops, dwc_pwm_suspend, dwc_pwm_resume);
 
 static const struct pci_device_id dwc_pwm_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x4bb7) }, /* Elkhart Lake */
@@ -311,7 +309,7 @@ static struct pci_driver dwc_pwm_driver = {
 	.remove = dwc_pwm_remove,
 	.id_table = dwc_pwm_id_table,
 	.driver = {
-		.pm = &dwc_pwm_pm_ops,
+		.pm = pm_ptr(&dwc_pwm_pm_ops),
 	},
 };
 
-- 
2.40.1

