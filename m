Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA34A80C5
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Sep 2019 13:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfIDLAu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Sep 2019 07:00:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5757 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728843AbfIDLAu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 4 Sep 2019 07:00:50 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7ADE3D2E674B83DB96E7;
        Wed,  4 Sep 2019 19:00:48 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Sep 2019 19:00:39 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] pwm: sifive: Remove redundant dev_err call in pwm_sifive_probe()
Date:   Wed, 4 Sep 2019 11:18:36 +0000
Message-ID: <20190904111836.122616-1-weiyongjun1@huawei.com>
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

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pwm/pwm-sifive.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index a7c107f19e66..8fcd05e74581 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -250,10 +250,8 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ddata->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ddata->regs)) {
-		dev_err(dev, "Unable to map IO resources\n");
+	if (IS_ERR(ddata->regs))
 		return PTR_ERR(ddata->regs);
-	}
 
 	ddata->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(ddata->clk)) {



