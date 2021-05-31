Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02A139644A
	for <lists+linux-pwm@lfdr.de>; Mon, 31 May 2021 17:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhEaPxn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 May 2021 11:53:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:5456 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231151AbhEaPvc (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 31 May 2021 11:51:32 -0400
IronPort-SDR: /LfIDPdao+dbiEowT+eGeEBaI/HQOVTXOGjnGQPoR/b+jumywikJmOQ2UFkaVJab5CvG2uwd9o
 5SRz5HZDb5bA==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="183733374"
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="183733374"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 08:43:45 -0700
IronPort-SDR: E2cRdlWDU8bCBCSGn0X40EqLjiY7bKk7LeaTpv7p8I5++9tIwWtMiu/FRHHC+WgEJO80mmVxpv
 VASRv3BWhWVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="548783833"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 31 May 2021 08:43:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2548473; Mon, 31 May 2021 18:44:06 +0300 (EEST)
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
Subject: [PATCH v1 2/5] pwm: core: Always require PWM flags to be provided
Date:   Mon, 31 May 2021 18:43:48 +0300
Message-Id: <20210531154351.53614-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210531154351.53614-1-andriy.shevchenko@linux.intel.com>
References: <20210531154351.53614-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

It makes little sense to make PWM flags optional since in case
of multi-channel consumer the flags can be optional only for
the last listed channel. Thus always require PWM flags to be
provided.

Fixes: 4a6ef8e37c4d ("pwm: Add support referencing PWMs from ACPI")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c165c5822703..25f7b3370672 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -852,8 +852,10 @@ static struct pwm_chip *device_to_pwmchip(struct device *dev)
  *
  * This is analogous to of_pwm_get() except con_id is not yet supported.
  * ACPI entries must look like
- * Package () {"pwms", Package ()
- *     { <PWM device reference>, <PWM index>, <PWM period> [, <PWM flags>]}}
+ * Package () { "pwms", Package () {
+ *		<PWM device reference>, <PWM index>, <PWM period>, <PWM flags>,
+ *	}
+ * }
  *
  * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
  * error code on failure.
@@ -877,7 +879,7 @@ static struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
 	if (!acpi)
 		return ERR_PTR(-EINVAL);
 
-	if (args.nargs < 2)
+	if (args.nargs < 3)
 		return ERR_PTR(-EPROTO);
 
 	chip = device_to_pwmchip(&acpi->dev);
@@ -891,7 +893,7 @@ static struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
 	pwm->args.period = args.args[1];
 	pwm->args.polarity = PWM_POLARITY_NORMAL;
 
-	if (args.nargs > 2 && args.args[2] & PWM_POLARITY_INVERTED)
+	if (args.args[2] & PWM_POLARITY_INVERTED)
 		pwm->args.polarity = PWM_POLARITY_INVERSED;
 #endif
 
-- 
2.30.2

