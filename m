Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1348F64E326
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Dec 2022 22:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiLOVc3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Dec 2022 16:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiLOVc0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Dec 2022 16:32:26 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C7B127B10;
        Thu, 15 Dec 2022 13:32:24 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,248,1665414000"; 
   d="scan'208";a="143493768"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Dec 2022 06:32:24 +0900
Received: from localhost.localdomain (unknown [10.226.92.26])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 52CB040071FC;
        Fri, 16 Dec 2022 06:32:21 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [DO NOT APPLY PATCH v5 3/9] pwm: rzg2l-gpt: Add support for output disable request from gpt
Date:   Thu, 15 Dec 2022 21:32:00 +0000
Message-Id: <20221215213206.56666-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221215213206.56666-1-biju.das.jz@bp.renesas.com>
References: <20221215213206.56666-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When dead time error occurs or the GTIOCA pin output value is
the same as the GTIOCB pin output value, output protection is
required. GPT detects this condition and generates output disable
requests to POEG based on the settings in the output disable request
permission bits, such as GTINTAD.GRPDTE, GTINTAD.GRPABH,
GTINTAD.GRPABL. After the POEG receives output disable requests from
each channel and calculates external input using an OR operation, the
POEG generates output disable requests to GPT.

This patch adds support for output disable request from gpt,
when same time output level is high.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pwm/pwm-rzg2l-gpt.c           | 111 ++++++++++++++++++++++++++
 include/linux/soc/renesas/rzg2l-gpt.h |  32 ++++++++
 2 files changed, 143 insertions(+)
 create mode 100644 include/linux/soc/renesas/rzg2l-gpt.h

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 6bf407550326..bcf843b51e3d 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -26,12 +26,14 @@
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
 #include <linux/reset.h>
+#include <linux/soc/renesas/rzg2l-gpt.h>
 #include <linux/time.h>
 
 #define RZG2L_GTCR		0x2c
 #define RZG2L_GTUDDTYC		0x30
 #define RZG2L_GTIOR		0x34
 #define RZG2L_GTINTAD		0x38
+#define RZG2L_GTST		0x3c
 #define RZG2L_GTBER		0x40
 #define RZG2L_GTCNT		0x48
 #define RZG2L_GTCCRA		0x4c
@@ -72,6 +74,12 @@
 	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE) | RZG2L_GTIOR_OBE)
 
 #define RZG2L_GTINTAD_GRP_MASK			GENMASK(25, 24)
+#define RZG2L_GTINTAD_OUTPUT_DISABLE_SAME_LEVEL_HIGH	BIT(29)
+
+#define RZG2L_GTST_OABHF			BIT(29)
+#define RZG2L_GTST_OABLF			BIT(30)
+
+#define RZG2L_GTST_POEG_IRQ_MASK		GENMASK(30, 28)
 
 #define RZG2L_GTCCR(i) (0x4c + 4 * (i))
 
@@ -458,6 +466,109 @@ static const struct dev_pm_ops rzg2l_gpt_pm_ops = {
 	SET_RUNTIME_PM_OPS(rzg2l_gpt_pm_runtime_suspend, rzg2l_gpt_pm_runtime_resume, NULL)
 };
 
+u32 rzg2l_gpt_poeg_disable_req_irq_status(void *dev, u8 grp)
+{
+	u8 bitpos = grp * RZG2L_MAX_HW_CHANNELS;
+	struct rzg2l_gpt_chip *rzg2l_gpt;
+	unsigned int i;
+	u32 val = 0;
+	u32 offs;
+	u32 reg;
+
+	rzg2l_gpt = dev_get_drvdata(dev);
+	for (i = 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
+		val <<= 3;
+		if (!test_bit(bitpos + i, rzg2l_gpt->poeg_gpt_link))
+			continue;
+
+		offs = RZG2L_GET_CH_OFFS(i);
+		reg = rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTST);
+		val |= FIELD_GET(RZG2L_GTST_POEG_IRQ_MASK, reg);
+	}
+
+	return val;
+}
+EXPORT_SYMBOL_GPL(rzg2l_gpt_poeg_disable_req_irq_status);
+
+int rzg2l_gpt_poeg_disable_req_clr(void *dev, u8 grp)
+{
+	u8 bitpos = grp * RZG2L_MAX_HW_CHANNELS;
+	struct rzg2l_gpt_chip *rzg2l_gpt;
+	unsigned int i;
+	u32 offs;
+	u32 reg;
+
+	rzg2l_gpt = dev_get_drvdata(dev);
+	for (i = 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
+		if (!test_bit(bitpos + i, rzg2l_gpt->poeg_gpt_link))
+			continue;
+
+		offs = RZG2L_GET_CH_OFFS(i);
+		reg = rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTST);
+
+		if (reg & (RZG2L_GTST_OABHF | RZG2L_GTST_OABLF))
+			rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
+					 RZG2L_GTIOR_OBE, 0);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rzg2l_gpt_poeg_disable_req_clr);
+
+int rzg2l_gpt_pin_reenable(void *dev, u8 grp)
+{
+	u8 bitpos = grp * RZG2L_MAX_HW_CHANNELS;
+	struct rzg2l_gpt_chip *rzg2l_gpt;
+	unsigned int i;
+	u32 offs;
+
+	rzg2l_gpt = dev_get_drvdata(dev);
+	for (i = 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
+		if (!test_bit(bitpos + i, rzg2l_gpt->poeg_gpt_link))
+			continue;
+
+		offs = RZG2L_GET_CH_OFFS(i);
+		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
+				 RZG2L_GTIOR_OBE, RZG2L_GTIOR_OBE);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rzg2l_gpt_pin_reenable);
+
+static int rzg2l_gpt_poeg_disable_req_endisable(void *dev, u8 grp, int op, bool on)
+{
+	u8 bitpos = grp * RZG2L_MAX_HW_CHANNELS;
+	struct rzg2l_gpt_chip *rzg2l_gpt;
+	unsigned int i;
+	u32 offs;
+
+	rzg2l_gpt = dev_get_drvdata(dev);
+	pm_runtime_get_sync(dev);
+
+	for (i = 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
+		if (!test_bit(bitpos + i, rzg2l_gpt->poeg_gpt_link))
+			continue;
+
+		offs = RZG2L_GET_CH_OFFS(i);
+		if (on)
+			rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTINTAD, op, op);
+		else
+			rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTINTAD, op, 0);
+	}
+
+	pm_runtime_put(dev);
+
+	return 0;
+}
+
+int rzg2l_gpt_poeg_disable_req_both_high(void *dev, u8 grp, bool on)
+{
+	int id = RZG2L_GTINTAD_OUTPUT_DISABLE_SAME_LEVEL_HIGH;
+
+	return rzg2l_gpt_poeg_disable_req_endisable(dev, grp, id, on);
+}
+EXPORT_SYMBOL_GPL(rzg2l_gpt_poeg_disable_req_both_high);
+
 static void rzg2l_gpt_reset_assert_pm_disable(void *data)
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = data;
diff --git a/include/linux/soc/renesas/rzg2l-gpt.h b/include/linux/soc/renesas/rzg2l-gpt.h
new file mode 100644
index 000000000000..87e641fd8732
--- /dev/null
+++ b/include/linux/soc/renesas/rzg2l-gpt.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_SOC_RENESAS_RZG2L_GPT_H__
+#define __LINUX_SOC_RENESAS_RZG2L_GPT_H__
+
+#if IS_ENABLED(CONFIG_PWM_RZG2L_GPT)
+u32 rzg2l_gpt_poeg_disable_req_irq_status(void *dev, u8 grp);
+int rzg2l_gpt_poeg_disable_req_clr(void *gpt_device, u8 grp);
+int rzg2l_gpt_pin_reenable(void *gpt_device, u8 grp);
+int rzg2l_gpt_poeg_disable_req_both_high(void *gpt_device, u8 grp, bool on);
+#else
+static inline u32 rzg2l_gpt_poeg_disable_req_irq_status(void *dev, u8 grp)
+{
+	return -ENODEV;
+}
+
+static inline int rzg2l_gpt_poeg_disable_req_clr(void *gpt_device, u8 grp)
+{
+	return -ENODEV;
+}
+
+static inline int rzg2l_gpt_pin_reenable(void *gpt_device, u8 grp)
+{
+	return -ENODEV;
+}
+
+static inline int rzg2l_gpt_poeg_disable_req_both_high(void *gpt_device, u8 grp, bool on)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif /* __LINUX_SOC_RENESAS_RZG2L_GPT_H__ */
-- 
2.25.1

