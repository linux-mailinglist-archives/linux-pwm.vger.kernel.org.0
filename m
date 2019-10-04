Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31E30CBAED
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2019 14:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387690AbfJDMya (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Oct 2019 08:54:30 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:15210 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387696AbfJDMy1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Oct 2019 08:54:27 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94Cp1gS031982;
        Fri, 4 Oct 2019 14:54:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=33Y2KA3m/b4jRDQPrOEVAIPKGGtoSOGNe2bJpPVSj7U=;
 b=Fy8AkiTLP2OIaoI7+ALvU8i6C9cO3G3dPg8HFgKEnpT69ijcVB1EXEC7ZBSwhL1IQ6k/
 1JJ4I+i8JYmlIoQnz+WSbxXd4iNlh3SpHQknfQyWfIZn0SQxF5R8wTit4UhDJLivWs23
 SvQjG/pmGzSg6dLnhFLfAo9xuUSkfiRLJcDoGaG8Q2lYaVMD3tm5222SwOUKvZWWVJP2
 VgDfz1IEM9nqU77ya6D/zvaF/D/5UQnP3XGjSTLeAXP/7YzXMFca/ies+e4WEUnBPuw1
 mRcrxFbGgIkDddMLOdM4vjO2VjD8LvjhfVM0xkS7NYGxKJ0yU30A6xZ49ryxf5qNLPNP Jw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2v9vnau38b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Oct 2019 14:54:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2F3C510002A;
        Fri,  4 Oct 2019 14:54:12 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 211722BFDEE;
        Fri,  4 Oct 2019 14:54:12 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 4 Oct 2019
 14:54:12 +0200
Received: from localhost (10.48.0.192) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 4 Oct 2019 14:54:11 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>
CC:     <alexandre.torgue@st.com>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <benjamin.gaignard@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 2/3] pwm: stm32: split breakinput apply routine to ease PM support
Date:   Fri, 4 Oct 2019 14:53:52 +0200
Message-ID: <1570193633-6600-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570193633-6600-1-git-send-email-fabrice.gasnier@st.com>
References: <1570193633-6600-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-04_06:2019-10-03,2019-10-04 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Split breakinput routine that configures STM32 timers 'break' safety
feature upon probe, into two routines:
- stm32_pwm_apply_breakinputs() sets all the break inputs into registers.
- stm32_pwm_probe_breakinputs() probes the device tree break input settings
  before calling stm32_pwm_apply_breakinputs()

This is a precursor patch to ease PM support. Registers content may get
lost during low power. So, break input settings applied upon probe need
to be restored upon resume (e.g. by calling stm32_pwm_apply_breakinputs()).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/pwm-stm32.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 359b085..cf8658c 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -19,6 +19,12 @@
 #define CCMR_CHANNEL_MASK  0xFF
 #define MAX_BREAKINPUT 2
 
+struct stm32_breakinput {
+	u32 index;
+	u32 level;
+	u32 filter;
+};
+
 struct stm32_pwm {
 	struct pwm_chip chip;
 	struct mutex lock; /* protect pwm config/enable */
@@ -26,15 +32,11 @@ struct stm32_pwm {
 	struct regmap *regmap;
 	u32 max_arr;
 	bool have_complementary_output;
+	struct stm32_breakinput breakinput[MAX_BREAKINPUT];
+	unsigned int nbreakinput;
 	u32 capture[4] ____cacheline_aligned; /* DMA'able buffer */
 };
 
-struct stm32_breakinput {
-	u32 index;
-	u32 level;
-	u32 filter;
-};
-
 static inline struct stm32_pwm *to_stm32_pwm_dev(struct pwm_chip *chip)
 {
 	return container_of(chip, struct stm32_pwm, chip);
@@ -512,15 +514,27 @@ static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
 	return (bdtr & bke) ? 0 : -EINVAL;
 }
 
-static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv,
+static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < priv->nbreakinput && !ret; i++) {
+		ret = stm32_pwm_set_breakinput(priv,
+					       priv->breakinput[i].index,
+					       priv->breakinput[i].level,
+					       priv->breakinput[i].filter);
+	}
+
+	return ret;
+}
+
+static int stm32_pwm_probe_breakinputs(struct stm32_pwm *priv,
 				       struct device_node *np)
 {
-	struct stm32_breakinput breakinput[MAX_BREAKINPUT];
-	int nb, ret, i, array_size;
+	int nb, ret, array_size;
 
 	nb = of_property_count_elems_of_size(np, "st,breakinput",
 					     sizeof(struct stm32_breakinput));
-
 	/*
 	 * Because "st,breakinput" parameter is optional do not make probe
 	 * failed if it doesn't exist.
@@ -531,20 +545,14 @@ static int stm32_pwm_apply_breakinputs(struct stm32_pwm *priv,
 	if (nb > MAX_BREAKINPUT)
 		return -EINVAL;
 
+	priv->nbreakinput = nb;
 	array_size = nb * sizeof(struct stm32_breakinput) / sizeof(u32);
 	ret = of_property_read_u32_array(np, "st,breakinput",
-					 (u32 *)breakinput, array_size);
+					 (u32 *)priv->breakinput, array_size);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < nb && !ret; i++) {
-		ret = stm32_pwm_set_breakinput(priv,
-					       breakinput[i].index,
-					       breakinput[i].level,
-					       breakinput[i].filter);
-	}
-
-	return ret;
+	return stm32_pwm_apply_breakinputs(priv);
 }
 
 static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
@@ -614,7 +622,7 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	if (!priv->regmap || !priv->clk)
 		return -EINVAL;
 
-	ret = stm32_pwm_apply_breakinputs(priv, np);
+	ret = stm32_pwm_probe_breakinputs(priv, np);
 	if (ret)
 		return ret;
 
-- 
2.7.4

