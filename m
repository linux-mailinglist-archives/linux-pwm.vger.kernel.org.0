Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070CA396447
	for <lists+linux-pwm@lfdr.de>; Mon, 31 May 2021 17:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhEaPxQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 May 2021 11:53:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:36246 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233180AbhEaPvJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 31 May 2021 11:51:09 -0400
IronPort-SDR: MpvyMqsvtIpjIlDMJnvf2eBaGviM2hCGBMTGq481XKdr8qPWjjXOy8qBIBGgFxi8LCIByu9pHP
 9lNe4lZuyiHw==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="190738553"
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="190738553"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 08:43:45 -0700
IronPort-SDR: XvaeebbE9UkQYRBPBMrq2G4FzkuMC2lPXkyCIEOFZ7ip8kl+H0vQaruxmjZRRuAGy83OQjsYtL
 XV5zeQxA9Hng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="446639866"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 31 May 2021 08:43:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 31A1F269; Mon, 31 May 2021 18:44:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 3/5] pwm: core: Convert to use fwnode for matching
Date:   Mon, 31 May 2021 18:43:49 +0300
Message-Id: <20210531154351.53614-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210531154351.53614-1-andriy.shevchenko@linux.intel.com>
References: <20210531154351.53614-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When we traverse the list of the registered PWM controllers,
use fwnode to match. This will help for further cleanup.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 25f7b3370672..338d8ee369db 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -691,14 +691,14 @@ int pwm_adjust_config(struct pwm_device *pwm)
 }
 EXPORT_SYMBOL_GPL(pwm_adjust_config);
 
-static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
+static struct pwm_chip *fwnode_to_pwmchip(struct fwnode_handle *fwnode)
 {
 	struct pwm_chip *chip;
 
 	mutex_lock(&pwm_lock);
 
 	list_for_each_entry(chip, &pwm_chips, list)
-		if (chip->dev && chip->dev->of_node == np) {
+		if (chip->dev && dev_fwnode(chip->dev) == fwnode) {
 			mutex_unlock(&pwm_lock);
 			return chip;
 		}
@@ -777,7 +777,7 @@ struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
 		return ERR_PTR(err);
 	}
 
-	pc = of_node_to_pwmchip(args.np);
+	pc = fwnode_to_pwmchip(of_fwnode_handle(args.np));
 	if (IS_ERR(pc)) {
 		if (PTR_ERR(pc) != -EPROBE_DEFER)
 			pr_err("%s(): PWM chip not found\n", __func__);
-- 
2.30.2

