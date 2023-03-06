Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FCE6AB91E
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Mar 2023 10:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCFJBE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Mar 2023 04:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCFJBD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Mar 2023 04:01:03 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 272BFE077;
        Mon,  6 Mar 2023 01:00:58 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.98,236,1673881200"; 
   d="scan'208";a="151662829"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Mar 2023 18:00:57 +0900
Received: from localhost.localdomain (unknown [10.226.93.39])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6D3A841C869B;
        Mon,  6 Mar 2023 18:00:54 +0900 (JST)
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
Subject: [DO NOT APPLY PATCH v6 10/13] pinctrl: renesas: rzg2l-poeg: output-disable request from GPT when both outputs are low.
Date:   Mon,  6 Mar 2023 09:00:11 +0000
Message-Id: <20230306090014.128732-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306090014.128732-1-biju.das.jz@bp.renesas.com>
References: <20230306090014.128732-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds support fpr output-disable requests from GPT, when both
outputs are low.

Added sysfs to enable/disable for configuring GPT output disable request
when both outputs are low.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/poeg/rzg2l-poeg.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
index b6f01065c058..bbca21557a70 100644
--- a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
+++ b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
@@ -97,6 +97,20 @@ static int rzg2l_poeg_output_disable_both_high(struct rzg2l_poeg_chip *chip,
 	return 0;
 }
 
+static int rzg2l_poeg_output_disable_both_low(struct rzg2l_poeg_chip *chip,
+					      bool enable)
+{
+	if (enable)
+		set_bit(RZG2L_GPT_OABLF, chip->gpt_irq);
+	else
+		clear_bit(RZG2L_GPT_OABLF, chip->gpt_irq);
+
+	rzg2l_gpt_poeg_disable_req_both_low(chip->gpt_dev, chip->index,
+					    test_bit(RZG2L_GPT_OABLF, chip->gpt_irq));
+
+	return 0;
+}
+
 static int rzg2l_poeg_cb(void *context, const char *fname, const char *gname,
 			 enum pin_output_disable_conf conf,
 			 unsigned int conf_val)
@@ -123,6 +137,8 @@ static int rzg2l_poeg_cb(void *context, const char *fname, const char *gname,
 		ret = rzg2l_poeg_output_disable_both_high(context, !!conf_val);
 		break;
 	case PINCTRL_OUTPUT_DISABLE_BY_SOC_ON_PIN_OUTPUT_LOW:
+		ret = rzg2l_poeg_output_disable_both_low(context, !!conf_val);
+		break;
 	case PINCTRL_OUTPUT_DISABLE_BY_SOC_ON_DEAD_TIME_ERROR:
 	default:
 		return -EINVAL;
-- 
2.25.1

