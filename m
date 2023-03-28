Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF276CBC09
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Mar 2023 12:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjC1KLX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Mar 2023 06:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbjC1KLO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Mar 2023 06:11:14 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05C24618A;
        Tue, 28 Mar 2023 03:10:54 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,297,1673881200"; 
   d="scan'208";a="154049005"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Mar 2023 19:10:39 +0900
Received: from localhost.localdomain (unknown [10.226.92.2])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5C91440071EC;
        Tue, 28 Mar 2023 19:10:36 +0900 (JST)
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
Subject: [DO NOT APPLY PATCH v7 06/10] pinctrl: renesas: rzg2l-poeg: output-disable request from GPT when both outputs are low.
Date:   Tue, 28 Mar 2023 11:10:07 +0100
Message-Id: <20230328101011.185594-7-biju.das.jz@bp.renesas.com>
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

This patch adds support for output-disable requests from GPT, when both
outputs are low.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/poeg/rzg2l-poeg.c | 11 +++++++++++
 include/linux/pinctrl/rzg2l-poeg.h        |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
index 2683930309ca..b66d717d6bf4 100644
--- a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
+++ b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
@@ -88,6 +88,10 @@ static void rzg2l_poeg_config_irq(struct rzg2l_poeg_chip *chip)
 {
 	if (test_bit(RZG2L_GPT_OABHF, chip->gpt_irq))
 		rzg2l_gpt_poeg_disable_req_both_high(chip->gpt_dev, chip->index, true);
+
+	if (test_bit(RZG2L_GPT_OABLF, chip->gpt_irq))
+		rzg2l_gpt_poeg_disable_req_both_low(chip->gpt_dev, chip->index, true);
+
 }
 
 static irqreturn_t rzg2l_poeg_irq(int irq, void *ptr)
@@ -349,6 +353,13 @@ static int rzg2l_poeg_probe(struct platform_device *pdev)
 		case POEG_GPT_BOTH_HIGH:
 			assign_bit(RZG2L_GPT_OABHF, chip->gpt_irq, true);
 			break;
+		case POEG_GPT_BOTH_LOW:
+			assign_bit(RZG2L_GPT_OABLF, chip->gpt_irq, true);
+			break;
+		case POEG_GPT_BOTH_HIGH_LOW:
+			assign_bit(RZG2L_GPT_OABHF, chip->gpt_irq, true);
+			assign_bit(RZG2L_GPT_OABLF, chip->gpt_irq, true);
+			break;
 		default:
 			ret = -EINVAL;
 			goto err_pm;
diff --git a/include/linux/pinctrl/rzg2l-poeg.h b/include/linux/pinctrl/rzg2l-poeg.h
index d21b70c219e6..e1e0ba5b47a1 100644
--- a/include/linux/pinctrl/rzg2l-poeg.h
+++ b/include/linux/pinctrl/rzg2l-poeg.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 
 #define RZG2L_GPT_OABHF	1
+#define RZG2L_GPT_OABLF	2
 
 #define RZG2L_POEG_USR_CTRL_ENABLE_CMD	0
 #define RZG2L_POEG_USR_CTRL_DISABLE_CMD	1
-- 
2.25.1

