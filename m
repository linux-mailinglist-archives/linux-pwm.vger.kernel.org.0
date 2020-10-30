Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513B62A06A2
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Oct 2020 14:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgJ3Nlq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Oct 2020 09:41:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39976 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3Nlq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Oct 2020 09:41:46 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09UDfeUB093582;
        Fri, 30 Oct 2020 08:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604065300;
        bh=yvVr19obSpLwUPQ/Gzos7pBM2m/777m1etKh7pftCw0=;
        h=From:To:CC:Subject:Date;
        b=RvFMg13dx1YLfHLhu7L0iFUwJZt0WSNSnnyHrnvy4UrUPEasvLkZ9URj5wjlg8JPh
         pu0huHAN7rVv30nwwoYtCH+0CKx10npoUcJ4pkZLIv7JJYjuxJ4WTHkaOk9p787TSQ
         iAZWSqhjjVTVJlSAB6zQiBimjYnVJHsiH29OPo7U=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09UDfeHZ088059
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Oct 2020 08:41:40 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 30
 Oct 2020 08:41:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 30 Oct 2020 08:41:40 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09UDfbaJ036552;
        Fri, 30 Oct 2020 08:41:38 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH] pwm: lp3943: Dynamically allocate pwm chip base
Date:   Fri, 30 Oct 2020 19:11:35 +0530
Message-ID: <20201030134135.28730-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When there are other pwm controllers enabled along with pwm-lp3943,
pwm-lp3942 is failing to probe with -EEXIST error. This is because
other pwm controller is probed first and assigned pwmchip 0 and
pwm-lp3943 is requesting for 0 again. In order to avoid this, assign the
chip base with -1, so that id is dynamically allocated.

Fixes: af66b3c0934e ("pwm: Add LP3943 PWM driver")
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/pwm/pwm-lp3943.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index 7551253ada32..bf3f14fb5f24 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -275,6 +275,7 @@ static int lp3943_pwm_probe(struct platform_device *pdev)
 	lp3943_pwm->chip.dev = &pdev->dev;
 	lp3943_pwm->chip.ops = &lp3943_pwm_ops;
 	lp3943_pwm->chip.npwm = LP3943_NUM_PWMS;
+	lp3943_pwm->chip.base = -1;
 
 	platform_set_drvdata(pdev, lp3943_pwm);
 
-- 
2.28.0

