Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B87250045
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Aug 2020 16:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgHXO6u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 10:58:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:48633 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgHXO6t (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 24 Aug 2020 10:58:49 -0400
IronPort-SDR: NUjWG9wSHCT7NUEBHHneBErutiWV2tZHtDVG1YjtSmiF2yrLDPNZvCXRm3WBE0NqmUiF7M0HwS
 CKL9O8Gjzl4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="153497473"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="153497473"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 07:55:47 -0700
IronPort-SDR: 5kTiPmBqfUCTlGsbJysoUBp+5s8APTup5ygf0aYMNk9at5Ct51C85epK9FPwHM0m0a7nULNaM1
 Mqnv24Nmhpow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="294629772"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.187])
  by orsmga003.jf.intel.com with ESMTP; 24 Aug 2020 07:55:44 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] pwm: Allow store 64-bit duty cycle from sysfs interface
Date:   Mon, 24 Aug 2020 17:55:39 +0300
Message-Id: <20200824145539.3160946-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PWM core was converted to u64 by the commit a9d887dc1c60 ("pwm: Convert
period and duty cycle to u64") but did not change the duty_cycle_store()
so it will error out if trying to pass a numeric string bigger than
2^32-1.

Fix this by using u64 and kstrtou64() in duty_cycle_store().

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
I don't think this qualifies for a Fixes tag since original commit doesn't
cause a regression while still might be good for v5.9 material.
---
 drivers/pwm/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 449dbc0f49ed..9903c3a7eced 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -87,10 +87,10 @@ static ssize_t duty_cycle_store(struct device *child,
 	struct pwm_export *export = child_to_pwm_export(child);
 	struct pwm_device *pwm = export->pwm;
 	struct pwm_state state;
-	unsigned int val;
+	u64 val;
 	int ret;
 
-	ret = kstrtouint(buf, 0, &val);
+	ret = kstrtou64(buf, 0, &val);
 	if (ret)
 		return ret;
 
-- 
2.28.0

