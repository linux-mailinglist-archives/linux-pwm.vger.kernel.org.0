Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509077D3E34
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Oct 2023 19:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjJWRqy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Oct 2023 13:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjJWRqu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Oct 2023 13:46:50 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9356F98
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 10:46:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0o-0001MQ-Vq; Mon, 23 Oct 2023 19:46:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0o-003lPh-JH; Mon, 23 Oct 2023 19:46:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0o-004VD8-AF; Mon, 23 Oct 2023 19:46:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v3 05/11] pwm: dwc: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Mon, 23 Oct 2023 19:46:22 +0200
Message-ID: <20231023174616.2282067-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
References: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=B3FUN0XcVewJQeGl7DPiaNNT+ZFEdpVmVTOHA0u9NMw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlNrFuDI547MzT6uxwTI9dA2x9AbT8ARHdebors N9PH6LXXBiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZTaxbgAKCRCPgPtYfRL+ Tm7rB/9veA+QTxBBtZkJgH8TeIEV8jTxxDakuaFgOlmBy1YUIVERo9kv3slwvBjMB6szy6JNESy ah1Z3TGdCZHtP+gYJdqPdgAuKwgo2/hWV+erWCjNytH/u88vSSTnqH7D/6Zx+h+eXbJgPg83zNP XT92WUy/+TjFjyD3oW2/Ght5eUaMQupA/EI+pVwuey/XeHnXPn5+TXWNfPT4nHyz4AgEeJG2ms/ 3dTdG2WZg+0ZzB8HkM74L9xSbAmxY65A3HBNrPpRbI25P8hkPf1NsopQ2RmT4NholhwLhJZCFPd 2osPi9fHBE8cSA7uSt5bg5tIlhjgkjwfwWX2F1DWGh1OaWG8
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
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
index bd9cadb497d7..4929354f8cd9 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -71,7 +71,6 @@ static void dwc_pwm_remove(struct pci_dev *pci)
 	pm_runtime_get_noresume(&pci->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int dwc_pwm_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
@@ -106,9 +105,8 @@ static int dwc_pwm_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(dwc_pwm_pm_ops, dwc_pwm_suspend, dwc_pwm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(dwc_pwm_pm_ops, dwc_pwm_suspend, dwc_pwm_resume);
 
 static const struct pci_device_id dwc_pwm_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x4bb7) }, /* Elkhart Lake */
@@ -122,7 +120,7 @@ static struct pci_driver dwc_pwm_driver = {
 	.remove = dwc_pwm_remove,
 	.id_table = dwc_pwm_id_table,
 	.driver = {
-		.pm = &dwc_pwm_pm_ops,
+		.pm = pm_ptr(&dwc_pwm_pm_ops),
 	},
 };
 
-- 
2.42.0

