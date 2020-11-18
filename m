Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC012B7D92
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 13:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgKRMYz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 07:24:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8109 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKRMYz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Nov 2020 07:24:55 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cbhnn6qv3zLlff;
        Wed, 18 Nov 2020 20:24:29 +0800 (CST)
Received: from compute.localdomain (10.175.112.70) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 18 Nov 2020 20:24:44 +0800
From:   Zhang Changzhong <zhangchangzhong@huawei.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, <shawn.guo@linaro.org>
CC:     <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] pwm: add missed clk_disable_unprepare() in zx_pwm_probe()
Date:   Wed, 18 Nov 2020 20:26:24 +0800
Message-ID: <1605702384-20911-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add the missing clk_disable_unprepare() before return from
zx_pwm_probe() in the error handling case.

Fixes: 4836193c435c ("pwm: Add ZTE ZX PWM device driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 drivers/pwm/pwm-zx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-zx.c b/drivers/pwm/pwm-zx.c
index e2c21cc..3763ce5 100644
--- a/drivers/pwm/pwm-zx.c
+++ b/drivers/pwm/pwm-zx.c
@@ -238,6 +238,7 @@ static int zx_pwm_probe(struct platform_device *pdev)
 	ret = pwmchip_add(&zpc->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
+		clk_disable_unprepare(zpc->pclk);
 		return ret;
 	}
 
-- 
2.9.5

