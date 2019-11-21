Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6DE61050EC
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Nov 2019 11:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfKUK6w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Nov 2019 05:58:52 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:45837 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbfKUK6w (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Nov 2019 05:58:52 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALAv0D0003536;
        Thu, 21 Nov 2019 11:58:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=+ryPb9ETJPdsYWVGk+7MMd7fF4WRlNWEqIU9BO/5o/E=;
 b=c5n+Tu9CAwZRtKQzeN+Gk8BIJqhT8+m8ggCyptm0ywzgiRLJSE8JSbYgaf1Q74YvNe1S
 iMiCAiNSbaz3lmcSc7eZg7p//tEkJuDgffXpQK99A7AzmXj1NpBdeF19kOI/v+42rGPl
 bEavf9hTpDw/AAtrkegWrKwv+oProMFBNjv7Cc24wM/8DuOc2mv11/btkS5JYsrmFz9N
 PVqwFnPezKkLlkIvUnhvAu29qnHPVEgK2R3xSroOwu7SGUS67BONKotm7AMjZxas/4xp
 tp0CnzLLlB5iguJknqTti1mf3A7HAB2X9a5RYhaW9Q5TtcE0knB4TjmWARN19XfJQPa6 zA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wa9usjv1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Nov 2019 11:58:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 34550100034;
        Thu, 21 Nov 2019 11:58:42 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2690D2B90B8;
        Thu, 21 Nov 2019 11:58:42 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Nov 2019 11:58:41
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>
CC:     <alexandre.torgue@st.com>, <benjamin.gaignard@st.com>,
        <fabrice.gasnier@st.com>, <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] pwm: stm32: remove automatic output enable
Date:   Thu, 21 Nov 2019 11:58:00 +0100
Message-ID: <1574333880-29339-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_02:2019-11-21,2019-11-21 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Don't use AOE (automatic output enable) by default.
In case of break events, pwm is automatically re-enabled on next pwm
cycle otherwise.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/pwm-stm32.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 359b085..3079818 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -374,9 +374,7 @@ static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
 	else
 		regmap_update_bits(priv->regmap, TIM_CCMR2, mask, ccmr);
 
-	regmap_update_bits(priv->regmap, TIM_BDTR,
-			   TIM_BDTR_MOE | TIM_BDTR_AOE,
-			   TIM_BDTR_MOE | TIM_BDTR_AOE);
+	regmap_update_bits(priv->regmap, TIM_BDTR, TIM_BDTR_MOE, TIM_BDTR_MOE);
 
 	return 0;
 }
-- 
2.7.4

