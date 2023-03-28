Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE4D6CBC16
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Mar 2023 12:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjC1KLY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Mar 2023 06:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjC1KLQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Mar 2023 06:11:16 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C84E7D84;
        Tue, 28 Mar 2023 03:10:56 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,297,1673881200"; 
   d="scan'208";a="154049022"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Mar 2023 19:10:46 +0900
Received: from localhost.localdomain (unknown [10.226.92.2])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id BBA7940071F7;
        Tue, 28 Mar 2023 19:10:43 +0900 (JST)
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
Subject: [DO NOT APPLY PATCH v7 08/10] pinctrl: renesas: rzg2l-poeg: output-disable request from GPT on dead time error
Date:   Tue, 28 Mar 2023 11:10:09 +0100
Message-Id: <20230328101011.185594-9-biju.das.jz@bp.renesas.com>
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

This patch adds support for output-disable requests from GPT,
when dead time error occurs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/poeg/rzg2l-poeg.c | 18 ++++++++++++++++++
 include/linux/pinctrl/rzg2l-poeg.h        |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
index b66d717d6bf4..7576f756af3c 100644
--- a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
+++ b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
@@ -92,6 +92,8 @@ static void rzg2l_poeg_config_irq(struct rzg2l_poeg_chip *chip)
 	if (test_bit(RZG2L_GPT_OABLF, chip->gpt_irq))
 		rzg2l_gpt_poeg_disable_req_both_low(chip->gpt_dev, chip->index, true);
 
+	if (test_bit(RZG2L_GPT_DTEF, chip->gpt_irq))
+		rzg2l_gpt_poeg_disable_req_deadtime_error(chip->gpt_dev, chip->index, true);
 }
 
 static irqreturn_t rzg2l_poeg_irq(int irq, void *ptr)
@@ -356,10 +358,26 @@ static int rzg2l_poeg_probe(struct platform_device *pdev)
 		case POEG_GPT_BOTH_LOW:
 			assign_bit(RZG2L_GPT_OABLF, chip->gpt_irq, true);
 			break;
+		case POEG_GPT_DEAD_TIME:
+			assign_bit(RZG2L_GPT_DTEF, chip->gpt_irq, true);
+			break;
 		case POEG_GPT_BOTH_HIGH_LOW:
 			assign_bit(RZG2L_GPT_OABHF, chip->gpt_irq, true);
 			assign_bit(RZG2L_GPT_OABLF, chip->gpt_irq, true);
 			break;
+		case POEG_GPT_BOTH_HIGH_DEAD_TIME:
+			assign_bit(RZG2L_GPT_OABHF, chip->gpt_irq, true);
+			assign_bit(RZG2L_GPT_DTEF, chip->gpt_irq, true);
+			break;
+		case POEG_GPT_BOTH_LOW_DEAD_TIME:
+			assign_bit(RZG2L_GPT_OABLF, chip->gpt_irq, true);
+			assign_bit(RZG2L_GPT_DTEF, chip->gpt_irq, true);
+			break;
+		case POEG_GPT_ALL:
+			assign_bit(RZG2L_GPT_OABHF, chip->gpt_irq, true);
+			assign_bit(RZG2L_GPT_OABLF, chip->gpt_irq, true);
+			assign_bit(RZG2L_GPT_DTEF, chip->gpt_irq, true);
+			break;
 		default:
 			ret = -EINVAL;
 			goto err_pm;
diff --git a/include/linux/pinctrl/rzg2l-poeg.h b/include/linux/pinctrl/rzg2l-poeg.h
index e1e0ba5b47a1..5441de7f3751 100644
--- a/include/linux/pinctrl/rzg2l-poeg.h
+++ b/include/linux/pinctrl/rzg2l-poeg.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 
+#define RZG2L_GPT_DTEF	0
 #define RZG2L_GPT_OABHF	1
 #define RZG2L_GPT_OABLF	2
 
-- 
2.25.1

