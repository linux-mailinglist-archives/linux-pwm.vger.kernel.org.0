Return-Path: <linux-pwm+bounces-2489-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D84BE90AB04
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Jun 2024 12:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A269B2601F
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Jun 2024 09:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA6E1946D5;
	Mon, 17 Jun 2024 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWomhbpO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4CB194147;
	Mon, 17 Jun 2024 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617104; cv=none; b=t7ze8cA1PTJZHqwkNW0ATVefg1M3J4X6w9rP0Rl++G0/cF4GIPC+nrBvpykz57AGlhmUo/Eez0QzsvGp/fZRGsXGa0CQxDIX4P1x48LYN8GwMhhQhdlaYIJN4KubOfq5/fagpUWD2fEouaWfQHwoT+YJm6iqhesy1FJRp/ItQK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617104; c=relaxed/simple;
	bh=OCL2OwGmR4U99+vK5ZiqzBF+MvBHnojmd1wpSc1QfaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WXY1l2iFZNePGv/RhYNZJwcc6fMJz+bUUPQmM3TEAR8+v0HJqfLyU6mj8h2dmOnDMoR5c6ZyjzQN4jkyh1Ci60GFFO1Ox0y8fLaRYFfa+STfGGkoD1mEP0AQ1XXkdYW62GOJp+whdtDkd3Usmj7Y+TNjJMMVf6eKPmPtdakaFkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWomhbpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EB02C4DDF3;
	Mon, 17 Jun 2024 09:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718617104;
	bh=OCL2OwGmR4U99+vK5ZiqzBF+MvBHnojmd1wpSc1QfaA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TWomhbpOVZX3qLUGyBVFwsPbBt0lcVWsNONA/2xmbjDU+oxefBKFXC6n2i4LUpYHz
	 hLS6BiqxZp9oD2BbWxwsjAqadTJoc1+frsghW0oHCaq9xPJ/uEeyHGbJKJz9ZXhWIL
	 PbbZjivpxeR8MtXTt1RZOWspAkwKyykShfQ/1fMSZBGZp+WiUDvL2TTnQi+jiI592g
	 jrKbpNxpYX7Gkh9JFt5QE88NtLC3zORQAiLd0zcASlW4L81BYxIS2HEObLRyVl3MLt
	 NPR20zW/n6gyulhbISIdDp3Vg8DGZKabwh62LbCCdSiABUwADgjg/D1seV/vxsBC+N
	 Vo0nWjyziqtIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2550AC27C7B;
	Mon, 17 Jun 2024 09:38:24 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 17 Jun 2024 12:36:47 +0300
Subject: [PATCH v10 13/38] pwm: ep93xx: add DT support for Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-ep93xx-v10-13-662e640ed811@maquefel.me>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
In-Reply-To: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718617100; l=1236;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=ct0L8elpTvHj/aUU/OBJY6iv8PSAIzqZyzV/Ce2gcnk=;
 b=z7Fop/7ZnjsWnAMWHaWVTmWko0s81Hd6kfLwESWGhEDgO8WA/qW+jT3Wn8t8kSoVmZcrDt01L1M3
 uvYYs3SUDFQAvTPd8cSioxXiJctvN8lII689VxSjViD7JelCIohS
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



