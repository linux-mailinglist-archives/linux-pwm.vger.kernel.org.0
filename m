Return-Path: <linux-pwm+bounces-3064-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E062967040
	for <lists+linux-pwm@lfdr.de>; Sat, 31 Aug 2024 09:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA83B2286E
	for <lists+linux-pwm@lfdr.de>; Sat, 31 Aug 2024 07:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE7415CD4D;
	Sat, 31 Aug 2024 07:59:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03181176FA5;
	Sat, 31 Aug 2024 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725091169; cv=none; b=KxhZTDag8XaudFPMa8h7PalzG5W+p5Vj5lkdv8f0onxG/NW7dD46jT5i9BMPkh/uyke0mtOXdgm8/aZAwd/jWYG6ns0ofqg5hz64p7IHIraQIJEiTyZ5SKTC24vXrQ+DtGeNOVgbPDnLyVe6VkyR09lxBkPnu/00TUbEbUkPp+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725091169; c=relaxed/simple;
	bh=NASeqy1qkkPPjkDR4mp/EcUVW0pwJPDcwqj0BjOLejo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDnY0uR/+9HXgxjs6k9K1gy456diDYxDCAXDWhZGs5/QAt5ryjRlRgIZl1uB46raEZCQ83jY9+YOTL1mJLrK09CF8XLvTKGrXqJqRoKeAinswtg+x8ZliU3ssQZNogIrqiF7UUoeq0+LRo8LYkpzQn5gxwkzz96rYBkA7n9aNIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WwnRZ47J2zgYk1;
	Sat, 31 Aug 2024 15:57:14 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id D5AF514011B;
	Sat, 31 Aug 2024 15:59:19 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 31 Aug
 2024 15:59:19 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-pwm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ukleinek@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<liaochen4@huawei.com>
Subject: [PATCH -next 2/2] pwm: atmel-hlcdc: Drop trailing comma
Date: Sat, 31 Aug 2024 07:50:59 +0000
Message-ID: <20240831075059.790861-3-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240831075059.790861-1-liaochen4@huawei.com>
References: <20240831075059.790861-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Drop the trailing comma in the terminator entry for the ID table to make
code robust against misrebases.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 02660bd811c4..eb39955a6d77 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -234,7 +234,7 @@ static const struct of_device_id atmel_hlcdc_dt_ids[] = {
 		.data = &atmel_hlcdc_pwm_sama5d3_errata,
 	},
 	{	.compatible = "microchip,sam9x60-hlcdc", },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, atmel_hlcdc_dt_ids);
 
@@ -288,7 +288,7 @@ static void atmel_hlcdc_pwm_remove(struct platform_device *pdev)
 
 static const struct of_device_id atmel_hlcdc_pwm_dt_ids[] = {
 	{ .compatible = "atmel,hlcdc-pwm" },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, atmel_hlcdc_pwm_dt_ids);
 
-- 
2.34.1


