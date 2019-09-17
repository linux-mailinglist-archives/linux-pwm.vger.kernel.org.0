Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35641B4FB3
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Sep 2019 15:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfIQNwq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Sep 2019 09:52:46 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39176 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbfIQNwR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Sep 2019 09:52:17 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8HDfoKU019778;
        Tue, 17 Sep 2019 15:52:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=aUuRSQwIFPiGfsmi4Vym/gWuxjE0wuSWUtUhECjq8Vc=;
 b=1pFlI5o2/+K+HEBbhT3MPTQXm7yxt3Gzo2eBe5uTkx372Kt7/Laxyj3Vtx+Gmx5fNMaY
 qloenvWqU1Z3UVZ6ob5J6SZGGLqzSFIEukHcJBFJDDgE6v7YkbEtGXsLmEsYc7CNERVZ
 oT52XBQFinU0phxaysyMRatRlMtYQluA14BOOpCfFdLgx0tRFA/o30A2zrnZ3IoZksSZ
 HvpJe2tLblTVSGlFARLU6FnIeFdgMiXsZN13jX37BGVkT5t+rqZfSPkt2C1mRwmhkn1t
 FN6KiqjXiAlHy01FMmU07yaqY5/IPOS0CTTzQa9WHDo5txYNt4tJw2rZJa18Bgu4XuIL pQ== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2v0q3fspqm-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 17 Sep 2019 15:52:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9777D4D;
        Tue, 17 Sep 2019 13:52:05 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 068FE2C2B9A;
        Tue, 17 Sep 2019 15:52:05 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 17 Sep
 2019 15:52:04 +0200
Received: from localhost (10.48.1.232) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 17 Sep 2019 15:52:04 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>
CC:     <fabrice.gasnier@st.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] pwm: stm32-lp: add check in case requested period cannot be achieved
Date:   Tue, 17 Sep 2019 15:51:50 +0200
Message-ID: <1568728310-20948-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.1.232]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-17_06:2019-09-17,2019-09-17 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

LPTimer can use a 32KHz clock for counting. It depends on clock tree
configuration. In such a case, PWM output frequency range is limited.
Although unlikely, nothing prevents user from requesting a PWM frequency
above counting clock (32KHz for instance):
- This causes (prd - 1) = 0xffff to be written in ARR register later in
the apply() routine.
This results in badly configured PWM period (and also duty_cycle).
Add a check to report an error is such a case.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/pwm-stm32-lp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 2211a64..5c2c728 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -59,6 +59,12 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* Calculate the period and prescaler value */
 	div = (unsigned long long)clk_get_rate(priv->clk) * state->period;
 	do_div(div, NSEC_PER_SEC);
+	if (!div) {
+		/* Fall here in case source clock < period */
+		dev_err(priv->chip.dev, "Can't reach expected period\n");
+		return -EINVAL;
+	}
+
 	prd = div;
 	while (div > STM32_LPTIM_MAX_ARR) {
 		presc++;
-- 
2.7.4

