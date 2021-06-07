Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88D439DC28
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jun 2021 14:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFGM0h (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Jun 2021 08:26:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:57549 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhFGM0g (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Jun 2021 08:26:36 -0400
IronPort-SDR: vhxk3OgWXVw/8lcQsLliDTJPLAYQpOD334+9+62SA0m7RhJA35TtkWHHxnE9GGHRf1ZKUxI/tb
 qEerpf4tx1vQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="268466119"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="268466119"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 05:24:45 -0700
IronPort-SDR: CgjSJ6TRwOHRmiqqOmtJQVsgP9VlrV5h7jC/DT7HPVSjq5QCEVW2vkYsGMWjZ6H/bdXI9arK1O
 BuLTRchJkKXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="476187978"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jun 2021 05:24:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C6CC1A3; Mon,  7 Jun 2021 15:25:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Lee Jones <lee.jones@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v3 2/6] pwm: core: Convert to use fwnode for matching
Date:   Mon,  7 Jun 2021 15:24:54 +0300
Message-Id: <20210607122458.40073-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607122458.40073-1-andriy.shevchenko@linux.intel.com>
References: <20210607122458.40073-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When we traverse the list of the registered PWM controllers,
use fwnode to match. This will help for further cleanup.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: no change
v2: no change

 drivers/pwm/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a42999f877d2..f26da1a6a376 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -692,14 +692,14 @@ int pwm_adjust_config(struct pwm_device *pwm)
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
@@ -778,7 +778,7 @@ struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
 		return ERR_PTR(err);
 	}
 
-	pc = of_node_to_pwmchip(args.np);
+	pc = fwnode_to_pwmchip(of_fwnode_handle(args.np));
 	if (IS_ERR(pc)) {
 		if (PTR_ERR(pc) != -EPROBE_DEFER)
 			pr_err("%s(): PWM chip not found\n", __func__);
-- 
2.30.2

