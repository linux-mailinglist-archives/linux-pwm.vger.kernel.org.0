Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBEC04B58A
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2019 11:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfFSJwp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jun 2019 05:52:45 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57620 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731386AbfFSJwn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jun 2019 05:52:43 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5J9l43Z004729;
        Wed, 19 Jun 2019 11:52:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=KZn7FsdsSW1lS9pTNM3TaxOO4OLqesB+hYagQc2H2rc=;
 b=Yo2dlOMPAcKUiV44zajT0RykRR5Ezi2KNnXo8q7RiDm3AT2OuIowwG9rxxEVV2A9p2Xn
 gccNsEdXCiT+/ZnF9uvYQvVJMKpxQvjNz/YFOTVICXGEgL8/CDQLmuV9gNazywidsvkr
 0iOqvbQsy/iRZ2qXb4cDLtj4trQM1RwPTDAKz7ETcTNlyYF7oY8GbuXVqG96JGXjCcPE
 QK2Z/KKid51T60PBNvhRAJFvaCf/4VXaH6a86Zx1vWCUZxFogYPO2afL8nr17P5YR3mq
 QUMa7TKgvx4qdAXbrQdGR8PsAe/yEapGxfn5RcbA4IzRnJNYbJv/nPQ38tn5n0hktZHF VQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t7812u73g-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Jun 2019 11:52:15 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C69031;
        Wed, 19 Jun 2019 09:52:15 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DB0BD24C7;
        Wed, 19 Jun 2019 09:52:14 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Jun 2019 11:52:14
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>
CC:     <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <benjamin.gaignard@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 2/5] pwm: stm32: use 3 cells ->of_xlate()
Date:   Wed, 19 Jun 2019 11:52:02 +0200
Message-ID: <1560937925-8990-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
References: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_05:,,
 signatures=0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

STM32 Timers support generic 3 cells PWM to encode PWM number, period and
polarity.

Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/pwm-stm32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 4f84255..740e2de 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -608,6 +608,8 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
 	priv->max_arr = ddata->max_arr;
+	priv->chip.of_xlate = of_pwm_xlate_with_flags;
+	priv->chip.of_pwm_n_cells = 3;
 
 	if (!priv->regmap || !priv->clk)
 		return -EINVAL;
-- 
2.7.4

