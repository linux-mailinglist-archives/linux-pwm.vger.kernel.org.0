Return-Path: <linux-pwm+bounces-3063-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A85C96703D
	for <lists+linux-pwm@lfdr.de>; Sat, 31 Aug 2024 09:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52770284A67
	for <lists+linux-pwm@lfdr.de>; Sat, 31 Aug 2024 07:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8729916F282;
	Sat, 31 Aug 2024 07:59:24 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4315CD4D;
	Sat, 31 Aug 2024 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725091164; cv=none; b=uZaHLSy0zYp49Jg7OtMCK5dhfcho2cgnTIA9DLheRTIgukEXBLCMDPgm0tdhrj5vnbOv9zdRexduuAjre5wyOauCU6rzNeiPZQrLRYopKBJd5VJCeuV/ZX2gBE+Kg1rJHWwoM2moRdPTgM8olwbpQjlyzYPJuXD1HEWDGzkcfu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725091164; c=relaxed/simple;
	bh=HH2Oc/qT+Y4SfhKOV2ul8rRq6iw4lA6NfESnWjV8IOI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYKpW3whtNLAtvbY0SLlzH6h37rnOD8LQD1TbOyFtOPR1cbuTk2yYIBcwjyIoUf3esgE++l76eYhTg2GhyhYuTRm/iC5tZMJgxOAfoBAmyNpIaeXVz7jN/gCaQzPrHB6GLuet9gWiI/99UOkh/A4x2z/GpPRnRn7Z7F0OUfU3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WwnSz31SjzyQRd;
	Sat, 31 Aug 2024 15:58:27 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id AB6CE18006C;
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
Subject: [PATCH -next 1/2] pwm: atmel-hlcdc: Enable module autoloading
Date: Sat, 31 Aug 2024 07:50:58 +0000
Message-ID: <20240831075059.790861-2-liaochen4@huawei.com>
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

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 2afb302be02c..02660bd811c4 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -290,6 +290,7 @@ static const struct of_device_id atmel_hlcdc_pwm_dt_ids[] = {
 	{ .compatible = "atmel,hlcdc-pwm" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, atmel_hlcdc_pwm_dt_ids);
 
 static struct platform_driver atmel_hlcdc_pwm_driver = {
 	.driver = {
-- 
2.34.1


