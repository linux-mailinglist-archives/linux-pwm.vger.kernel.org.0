Return-Path: <linux-pwm+bounces-3157-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 542C0971165
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 10:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804681C21FAB
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 08:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573FD1B1D4C;
	Mon,  9 Sep 2024 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdtembQe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7EA1B1501;
	Mon,  9 Sep 2024 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869536; cv=none; b=Y9ygB8bozex2XQUSamWatTQElddO+4S0I0iwBW2Yw1eVoJ7iaeXRcJfD0pH+B591+HcPyYrMM1wG5SjIML/s+CH1co10D7JM81TBpZ7Q4tE8v10zML8Yfb46zg2Kc6QRqV9eD/tfvg3ScWbvf873gFpoAZzDdFhPGnDn2F5kUtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869536; c=relaxed/simple;
	bh=OCL2OwGmR4U99+vK5ZiqzBF+MvBHnojmd1wpSc1QfaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pXOUdYzTWcM2uLorOI1tnzEYL8YzYlI68slsMgHQSJIgUA9qGjOecY9IL3b3+h8XWKFWxSdTE5et2HQCqapb+cvF9nAp5vYH6TQNFjLNMHJ3yhv4uXrL3jjcxIyREDBOYAQBX3E2EgqbrI2uZ4v1I1yxtn8mRkF9GxQhiOY4p/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdtembQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A1ECC4AF14;
	Mon,  9 Sep 2024 08:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725869536;
	bh=OCL2OwGmR4U99+vK5ZiqzBF+MvBHnojmd1wpSc1QfaA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fdtembQe+KLpDr/1mv8uWWYPWXm7+mBfkxMK8oFb43jB0uz3lo41Nym68V1uRDnhA
	 Dytf0JqS6LBkzXo89bLuSIDS7Y8GKzQIYYQrfeXa1V/LFYiAXHThSk3gRIjCT5z3lI
	 8Tzq7aPlUNKu4PA5NmwDLdqU4JVK8nJSzn4rIArBjU0uTFYlG6Tn6J53I16cXPwwe4
	 IYKc6kC/IFdqtkba/UYl+XeRpnzKt4pYxsd5LBo/XIZ8ENB4uFpT1JBvXWclNbItal
	 F20yOdVOfhcrPvi9zIop/JxfRnJlYx0sRwu75IgmeHuVCXFN51eu6q8kCwsdkQ7Z6v
	 ErK5vsbqADsxQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E7DCD4F4C;
	Mon,  9 Sep 2024 08:12:16 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 09 Sep 2024 11:10:38 +0300
Subject: [PATCH v12 13/38] pwm: ep93xx: add DT support for Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240909-ep93xx-v12-13-e86ab2423d4b@maquefel.me>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
In-Reply-To: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725869532; l=1236;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=ct0L8elpTvHj/aUU/OBJY6iv8PSAIzqZyzV/Ce2gcnk=;
 b=/4fdkDuONr927B+O36yJ+BFAl7VhqSwCQlAYGnlC4vEP+7Hv8qt7+NbS3njnWHD22U8vssirdOg8
 9TGokHrCCdv+7tMQdrFsFblFl8+Kcn+dwJ0Oy4uibMf9/lYJYsrC
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add OF ID match table.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ep93xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 666f2954133c..67c3fdbf7ae3 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
@@ -188,9 +189,16 @@ static int ep93xx_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ep93xx_pwm_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-pwm" },
+	{ /* sentinel */}
+};
+MODULE_DEVICE_TABLE(of, ep93xx_pwm_of_ids);
+
 static struct platform_driver ep93xx_pwm_driver = {
 	.driver = {
 		.name = "ep93xx-pwm",
+		.of_match_table = ep93xx_pwm_of_ids,
 	},
 	.probe = ep93xx_pwm_probe,
 };

-- 
2.43.2



