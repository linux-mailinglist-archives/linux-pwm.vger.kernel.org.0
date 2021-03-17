Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A84933F4D5
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Mar 2021 17:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhCQP76 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 17 Mar 2021 11:59:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:62849 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232099AbhCQP7c (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 17 Mar 2021 11:59:32 -0400
IronPort-SDR: 9V0aniCEdISAUZLBqKNtSkMZrIPcGPLCu/kQ5ZcWDNiVZzuoBbEpJ2eaOTpd5CQyESI/H1L9mC
 0KjtRIso1rJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="176624076"
X-IronPort-AV: E=Sophos;i="5.81,256,1610438400"; 
   d="scan'208";a="176624076"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 08:59:32 -0700
IronPort-SDR: tOZX1CPjU/dUiQ1hDfIWWb2hdv9dMCzyvIuWO05wPw6PuUX8V6+nPxZYglu8wnS1dyT6HSWGaz
 xWDGAdKrcZRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,256,1610438400"; 
   d="scan'208";a="605767444"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.176])
  by fmsmga005.fm.intel.com with ESMTP; 17 Mar 2021 08:59:30 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] pwm: dwc: Use dev_get_drvdata() directly in PM callbacks
Date:   Wed, 17 Mar 2021 17:59:25 +0200
Message-Id: <20210317155925.297680-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Instead of figuring out struct pci_dev pointer from device pointer and
then pci_get_drvdata() we can use directly dev_get_drvdata() to get the
pointer to struct dwc_pwm.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/pwm/pwm-dwc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index f6c98e0d57c2..4d59a035c0c9 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -258,8 +258,7 @@ static void dwc_pwm_remove(struct pci_dev *pci)
 #ifdef CONFIG_PM_SLEEP
 static int dwc_pwm_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
-	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
+	struct dwc_pwm *dwc = dev_get_drvdata(dev);
 	int i;
 
 	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
@@ -278,8 +277,7 @@ static int dwc_pwm_suspend(struct device *dev)
 
 static int dwc_pwm_resume(struct device *dev)
 {
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
-	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
+	struct dwc_pwm *dwc = dev_get_drvdata(dev);
 	int i;
 
 	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
-- 
2.30.2

