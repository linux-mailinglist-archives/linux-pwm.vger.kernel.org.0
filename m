Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8417F64E32C
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Dec 2022 22:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiLOVcg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Dec 2022 16:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiLOVcd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Dec 2022 16:32:33 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F053164A5;
        Thu, 15 Dec 2022 13:32:32 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,248,1665414000"; 
   d="scan'208";a="146337526"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Dec 2022 06:32:31 +0900
Received: from localhost.localdomain (unknown [10.226.92.26])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A2B1A40071FC;
        Fri, 16 Dec 2022 06:32:28 +0900 (JST)
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
Subject: [DO NOT APPLY PATCH v5 5/9] pwm: rzg2l-gpt: Add support for output disable when both output low
Date:   Thu, 15 Dec 2022 21:32:02 +0000
Message-Id: <20221215213206.56666-6-biju.das.jz@bp.renesas.com>
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

This patch adds support for output disable request from gpt,
when same time output level is low.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pwm/pwm-rzg2l-gpt.c           | 9 +++++++++
 include/linux/soc/renesas/rzg2l-gpt.h | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index bcf843b51e3d..749c468a5d66 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -75,6 +75,7 @@
 
 #define RZG2L_GTINTAD_GRP_MASK			GENMASK(25, 24)
 #define RZG2L_GTINTAD_OUTPUT_DISABLE_SAME_LEVEL_HIGH	BIT(29)
+#define RZG2L_GTINTAD_OUTPUT_DISABLE_SAME_LEVEL_LOW	BIT(30)
 
 #define RZG2L_GTST_OABHF			BIT(29)
 #define RZG2L_GTST_OABLF			BIT(30)
@@ -569,6 +570,14 @@ int rzg2l_gpt_poeg_disable_req_both_high(void *dev, u8 grp, bool on)
 }
 EXPORT_SYMBOL_GPL(rzg2l_gpt_poeg_disable_req_both_high);
 
+int rzg2l_gpt_poeg_disable_req_both_low(void *dev, u8 grp, bool on)
+{
+	int id = RZG2L_GTINTAD_OUTPUT_DISABLE_SAME_LEVEL_LOW;
+
+	return rzg2l_gpt_poeg_disable_req_endisable(dev, grp, id, on);
+}
+EXPORT_SYMBOL_GPL(rzg2l_gpt_poeg_disable_req_both_low);
+
 static void rzg2l_gpt_reset_assert_pm_disable(void *data)
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = data;
diff --git a/include/linux/soc/renesas/rzg2l-gpt.h b/include/linux/soc/renesas/rzg2l-gpt.h
index 87e641fd8732..1977d94baf8d 100644
--- a/include/linux/soc/renesas/rzg2l-gpt.h
+++ b/include/linux/soc/renesas/rzg2l-gpt.h
@@ -7,6 +7,7 @@ u32 rzg2l_gpt_poeg_disable_req_irq_status(void *dev, u8 grp);
 int rzg2l_gpt_poeg_disable_req_clr(void *gpt_device, u8 grp);
 int rzg2l_gpt_pin_reenable(void *gpt_device, u8 grp);
 int rzg2l_gpt_poeg_disable_req_both_high(void *gpt_device, u8 grp, bool on);
+int rzg2l_gpt_poeg_disable_req_both_low(void *gpt_device, u8 grp, bool on);
 #else
 static inline u32 rzg2l_gpt_poeg_disable_req_irq_status(void *dev, u8 grp)
 {
@@ -27,6 +28,11 @@ static inline int rzg2l_gpt_poeg_disable_req_both_high(void *gpt_device, u8 grp,
 {
 	return -ENODEV;
 }
+
+static inline int rzg2l_gpt_poeg_disable_req_both_low(void *gpt_device, u8 grp, bool on)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __LINUX_SOC_RENESAS_RZG2L_GPT_H__ */
-- 
2.25.1

