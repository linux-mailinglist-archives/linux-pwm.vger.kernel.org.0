Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31C564B340
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Dec 2022 11:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbiLMK2x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Dec 2022 05:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbiLMK2W (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Dec 2022 05:28:22 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8680E62
        for <linux-pwm@vger.kernel.org>; Tue, 13 Dec 2022 02:28:20 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDAJBHq020788;
        Tue, 13 Dec 2022 11:27:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=BWg+HDZmgPHQRKWNccXLhmf8oUCWCRsnu09e0ZlymTo=;
 b=4mrgnWCizqeYbazHpFTds6hvlbnjWXTOQSLaJkeucw+0yoMJPbrXB35y2FRLxvNlSXWN
 Bk00nf/CUxuFFm6cH86wDxIjyF/AzDZ21uJAO5iuGwMqZzMpzYynbvTOjC1LINyMiZcP
 VVwj/kZARciT8gH+86iAaYkQt8knT/DdudfsSXI4q4tkKfZ65dYHOaD1qPH23DSUyVNf
 m5Z+b4dtl23+4tb2ADK5AdSOPVBeA29IOTlrZgVxIF5wkKGt2nXwNlJC1634y0GqoE8v
 cB+P9BoNZ7yr81QFE+PZvU1OgytmjgRtP2ISM5RjrVxleBQY0GwT8/E5Kl80tCPk4mvM ow== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mcgdphmf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 11:27:56 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8E76610002A;
        Tue, 13 Dec 2022 11:27:49 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 841A321A211;
        Tue, 13 Dec 2022 11:27:49 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Tue, 13 Dec
 2022 11:27:49 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lee Jones <lee@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] pwm: stm32: enforce settings for pwm capture
Date:   Tue, 13 Dec 2022 11:27:07 +0100
Message-ID: <20221213102707.1096345-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PWM capture assumes that the input selector is set to default
input and that the slave mode is disabled. Force reset state for
TISEL and SMCR registers to match this requirement.

Note that slave mode disabling is not a pre-requisite by itself
for capture mode, as hardware supports it for PWM capture.
However, the current implementation of the driver does not
allow slave mode for PWM capture. Setting slave mode for PWM
capture results in wrong capture values.

Fixes: 53e38fe73f94 ("pwm: stm32: Add capture support")
Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/pwm/pwm-stm32.c          | 4 ++++
 include/linux/mfd/stm32-timers.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 794ca5b02968..24aab0450c78 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -207,6 +207,10 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	regmap_write(priv->regmap, TIM_ARR, priv->max_arr);
 	regmap_write(priv->regmap, TIM_PSC, psc);
 
+	/* Reset input selector to its default input and disable slave mode */
+	regmap_write(priv->regmap, TIM_TISEL, 0x0);
+	regmap_write(priv->regmap, TIM_SMCR, 0x0);
+
 	/* Map TI1 or TI2 PWM input to IC1 & IC2 (or TI3/4 to IC3 & IC4) */
 	regmap_update_bits(priv->regmap,
 			   pwm->hwpwm < 2 ? TIM_CCMR1 : TIM_CCMR2,
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index 5f5c43fd69dd..1b94325febb3 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -31,6 +31,7 @@
 #define TIM_BDTR	0x44	/* Break and Dead-Time Reg */
 #define TIM_DCR		0x48	/* DMA control register    */
 #define TIM_DMAR	0x4C	/* DMA register for transfer */
+#define TIM_TISEL	0x68	/* Input Selection         */
 
 #define TIM_CR1_CEN	BIT(0)	/* Counter Enable	   */
 #define TIM_CR1_DIR	BIT(4)  /* Counter Direction	   */
-- 
2.25.1

