Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB756CBC19
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Mar 2023 12:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjC1KL2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Mar 2023 06:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjC1KLY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Mar 2023 06:11:24 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05AA683C2;
        Tue, 28 Mar 2023 03:11:02 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,297,1673881200"; 
   d="scan'208";a="157440708"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Mar 2023 19:10:50 +0900
Received: from localhost.localdomain (unknown [10.226.92.2])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5326640071EC;
        Tue, 28 Mar 2023 19:10:47 +0900 (JST)
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
Subject: [DO NOT APPLY PATCH v7 09/10] pinctrl: renesas: rzg2l-poeg: output-disable request by external pin
Date:   Tue, 28 Mar 2023 11:10:10 +0100
Message-Id: <20230328101011.185594-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328101011.185594-1-biju.das.jz@bp.renesas.com>
References: <20230328101011.185594-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add support for output-disable request by external pin.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/poeg/rzg2l-poeg.c | 9 +++++++++
 include/linux/pinctrl/rzg2l-poeg.h        | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
index 7576f756af3c..5d93a0be33f3 100644
--- a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
+++ b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
@@ -15,13 +15,16 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pwm/rzg2l-gpt.h>
+#include <linux/pinctrl/rzg2l-poeg.h>
 #include <linux/poll.h>
 #include <linux/reset.h>
 #include <linux/wait.h>
 
 #define POEGG_IOCE	BIT(5)
+#define POEGG_PIDE	BIT(4)
 #define POEGG_SSF	BIT(3)
 #define POEGG_IOCF	BIT(1)
+#define POEGG_PIDF	BIT(0)
 
 #define RZG2L_POEG_MAX_INDEX		3
 
@@ -113,6 +116,9 @@ static irqreturn_t rzg2l_poeg_irq(int irq, void *ptr)
 	if (val & POEGG_IOCF)
 		val &= ~POEGG_IOCF;
 
+	if (val & POEGG_PIDF)
+		val &= ~POEGG_PIDF;
+
 	rzg2l_poeg_write(chip, val);
 
 	return IRQ_HANDLED;
@@ -378,6 +384,9 @@ static int rzg2l_poeg_probe(struct platform_device *pdev)
 			assign_bit(RZG2L_GPT_OABLF, chip->gpt_irq, true);
 			assign_bit(RZG2L_GPT_DTEF, chip->gpt_irq, true);
 			break;
+		case POEG_EXT_PIN_CTRL:
+			rzg2l_poeg_write(chip, POEGG_PIDE);
+			break;
 		default:
 			ret = -EINVAL;
 			goto err_pm;
diff --git a/include/linux/pinctrl/rzg2l-poeg.h b/include/linux/pinctrl/rzg2l-poeg.h
index 5441de7f3751..359849fea6a0 100644
--- a/include/linux/pinctrl/rzg2l-poeg.h
+++ b/include/linux/pinctrl/rzg2l-poeg.h
@@ -7,11 +7,13 @@
 #define RZG2L_GPT_DTEF	0
 #define RZG2L_GPT_OABHF	1
 #define RZG2L_GPT_OABLF	2
+#define RZG2L_POEG_EXT_PIN_CTRL	3
 
 #define RZG2L_POEG_USR_CTRL_ENABLE_CMD	0
 #define RZG2L_POEG_USR_CTRL_DISABLE_CMD	1
 #define RZG2L_POEG_GPT_CFG_IRQ_CMD		2
 #define RZG2L_POEG_GPT_FAULT_CLR_CMD		3
+#define RZG2L_POEG_EXT_PIN_CTRL_FAULT_CLR_CMD	4
 
 struct poeg_event {
 	__u32 gpt_disable_irq_status;
-- 
2.25.1

