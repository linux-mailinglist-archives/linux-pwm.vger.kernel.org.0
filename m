Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC8EB1364C1
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2020 02:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgAJB3g (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jan 2020 20:29:36 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730567AbgAJB3g (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 9 Jan 2020 20:29:36 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1ABE61B3A44A0AF8283D;
        Fri, 10 Jan 2020 09:29:33 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Fri, 10 Jan 2020 09:29:25 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <mripard@kernel.org>, <wens@csie.org>, <p.zabel@pengutronix.de>,
        "Jernej Skrabec" <jernej.skrabec@siol.net>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] pwm: sun4i: Fix wrong pointer passed to PTR_ERR()
Date:   Fri, 10 Jan 2020 01:25:15 +0000
Message-ID: <20200110012515.32965-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PTR_ERR should access the value just tested by IS_ERR, otherwise
the wrong error code will be returned.

Fixes: 5b090b430d75 ("pwm: sun4i: Add an optional probe for bus clock")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pwm/pwm-sun4i.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 1afd41ebd3fd..a805c347ee84 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -423,7 +423,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	 */
 	pwm->clk = devm_clk_get_optional(&pdev->dev, "mod");
 	if (IS_ERR(pwm->clk)) {
-		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
+		if (PTR_ERR(pwm->clk) != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "get mod clock failed %pe\n",
 				pwm->clk);
 		return PTR_ERR(pwm->clk);
@@ -432,7 +432,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	if (!pwm->clk) {
 		pwm->clk = devm_clk_get(&pdev->dev, NULL);
 		if (IS_ERR(pwm->clk)) {
-			if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
+			if (PTR_ERR(pwm->clk) != -EPROBE_DEFER)
 				dev_err(&pdev->dev, "get unnamed clock failed %pe\n",
 					pwm->clk);
 			return PTR_ERR(pwm->clk);
@@ -441,7 +441,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 
 	pwm->bus_clk = devm_clk_get_optional(&pdev->dev, "bus");
 	if (IS_ERR(pwm->bus_clk)) {
-		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
+		if (PTR_ERR(pwm->bus_clk) != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "get bus clock failed %pe\n",
 				pwm->bus_clk);
 		return PTR_ERR(pwm->bus_clk);



