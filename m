Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE11DA3DAC
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Aug 2019 20:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfH3S2e (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Aug 2019 14:28:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:51054 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfH3S2e (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 30 Aug 2019 14:28:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 11:28:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="183878443"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2019 11:28:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 91ED31A1; Fri, 30 Aug 2019 21:28:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2] pwm: pca9685: Fix regression for GPIO use
Date:   Fri, 30 Aug 2019 21:28:30 +0300
Message-Id: <20190830182830.81627-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The commit e926b12c611c ("pwm: Clear chip_data in pwm_put()") breaks GPIO usage
by actually removing a crucial call to pwm_set_chip_data(), which is being used
as a flag to understand the mode (GPIO vs. PWM) in which pin is currently
working. Now, if once I requested GPIO, I may not be able to free and request
it again.

Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: drop leftovers in Fixes tag
 drivers/pwm/pwm-pca9685.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 168684b02ebc..7cdec56ab3ec 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -165,6 +165,7 @@ static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
 	pm_runtime_put(pca->chip.dev);
 	mutex_lock(&pca->lock);
 	pwm = &pca->chip.pwms[offset];
+	pwm_set_chip_data(pwm, NULL);
 	mutex_unlock(&pca->lock);
 }
 
-- 
2.23.0.rc1

