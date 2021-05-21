Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FE438C8C5
	for <lists+linux-pwm@lfdr.de>; Fri, 21 May 2021 15:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhEUN4X (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 May 2021 09:56:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:19750 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235925AbhEUN4V (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 21 May 2021 09:56:21 -0400
IronPort-SDR: cWb/gCIwhr1TVlsvRy4jKDnYvTLmsKAE1x3Een08Q7EipvabxkpQc7iVMsk2wJiaQXaQ8c0Ips
 qyhakADSe95Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="188614424"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="188614424"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 06:54:57 -0700
IronPort-SDR: /yvw4OKlaZrB0fNgRORjtXXcCWlmkePKcix+V37lAnPB+Bpja9jqQpTnwAl2cZ6DThCvf+B3CQ
 zkeo9K3GkZmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="474529570"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 21 May 2021 06:54:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 49EAA2AA; Fri, 21 May 2021 16:55:16 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 1/1] platform/x86: Add PWM platform data for Merrifield
Date:   Fri, 21 May 2021 16:55:16 +0300
Message-Id: <20210521135516.64727-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PWM is not functional since it requires pins to be muxed and configured
properly. Add pinctrl mapping to platform initialization code. The pins will
be configured properly whenever PWM driver is probed successfully.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/Makefile             |  4 +++
 drivers/platform/x86/platform_mrfld_pwm.c | 37 +++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 drivers/platform/x86/platform_mrfld_pwm.c

diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 85445148ae7b..fa0ef75b9ab3 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -143,3 +143,7 @@ obj-$(CONFIG_INTEL_TELEMETRY)		+= intel_telemetry_core.o \
 					   intel_telemetry_pltdrv.o \
 					   intel_telemetry_debugfs.o
 obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
+
+ifneq ($(CONFIG_PINCTRL_MERRIFIELD),)
+obj-y += platform_mrfld_pwm.o
+endif
diff --git a/drivers/platform/x86/platform_mrfld_pwm.c b/drivers/platform/x86/platform_mrfld_pwm.c
new file mode 100644
index 000000000000..6d5b04076094
--- /dev/null
+++ b/drivers/platform/x86/platform_mrfld_pwm.c
@@ -0,0 +1,37 @@
+/*
+ * Intel Merrifield PWM platform data initilization file
+ *
+ * Copyright (C) 2016, Intel Corporation
+ *
+ * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+
+#include <linux/init.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/machine.h>
+
+static unsigned long pwm_config[] = {
+	PIN_CONF_PACKED(PIN_CONFIG_BIAS_DISABLE, 0),
+};
+
+static const struct pinctrl_map pwm_mapping[] = {
+	PIN_MAP_MUX_GROUP_DEFAULT("0000:00:17.0",  "INTC1002:00", "pwm0_grp", "pwm0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("0000:00:17.0",  "INTC1002:00", "pwm1_grp", "pwm1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("0000:00:17.0",  "INTC1002:00", "pwm2_grp", "pwm2"),
+	PIN_MAP_MUX_GROUP_DEFAULT("0000:00:17.0",  "INTC1002:00", "pwm3_grp", "pwm3"),
+	PIN_MAP_CONFIGS_PIN_DEFAULT("0000:00:17.0", "INTC1002:00", "GP12_PWM0", pwm_config),
+	PIN_MAP_CONFIGS_PIN_DEFAULT("0000:00:17.0", "INTC1002:00", "GP13_PWM1", pwm_config),
+	PIN_MAP_CONFIGS_PIN_DEFAULT("0000:00:17.0", "INTC1002:00", "GP182_PWM2", pwm_config),
+	PIN_MAP_CONFIGS_PIN_DEFAULT("0000:00:17.0", "INTC1002:00", "GP183_PWM3", pwm_config),
+};
+
+static int __init mrfld_pwm_init(void)
+{
+	return pinctrl_register_mappings(pwm_mapping, ARRAY_SIZE(pwm_mapping));
+}
+postcore_initcall(mrfld_pwm_init);
-- 
2.30.2

