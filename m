Return-Path: <linux-pwm+bounces-7464-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0783CBEE0B0
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Oct 2025 10:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 948794E2D1C
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Oct 2025 08:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E182829D281;
	Sun, 19 Oct 2025 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XzU8En8/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-78.smtpout.orange.fr [80.12.242.78])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAAA146A66;
	Sun, 19 Oct 2025 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760862778; cv=none; b=WPOpk5pPoaRWNs3v/X2gz0GcIMPbRSMPBzAQmrmG0zHmug0AoD0CIopw+GbzMBD8A7TPKtFbjtIiH54xJsJZK3UueduDkqp/94p56Hkxbvos2Icb3SYOZYJK8HVzpCGh1apaR6MSeWUMgxn7cgCDj6uvsVknFu/1H+nrvlQDLO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760862778; c=relaxed/simple;
	bh=WpX+UrusmdOFu71UogvaT2bAJfzn0AT+XeC5c/lBXkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tO7McOeoaTkTtXYUbgQ0oN3ZkW9kedla4vgsF4YcFwRpMw9YB/eMSvMMrWHPRTUTeLWUpVDDO0zQOfS7F+kIoNNjsDyg6kk16LSBhr0CtKcl3eKVUjdW7oELo83ySujvspfLyQ4daIzazWi9OoyVl5e35gG1t2YXOnOOXXhNG7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XzU8En8/; arc=none smtp.client-ip=80.12.242.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id AOpLvqnmVle4HAOpLvakGs; Sun, 19 Oct 2025 10:31:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1760862704;
	bh=DLuOymrC3C8sEFjkTVXUx2j/qItjdLfaXHfU/fT442Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XzU8En8/8KAteaF2LBJc8Hg8UDIWqtsn8eDIE16UBwoKPK5DzOl2DxOtWPWo50lA2
	 Vd4/39+Yu5zGJFvNIHmFXGtaTun569JACpt2WGLyVLbn+FK6tvXUdV1xzlVPTqYFGY
	 keDFlJ58GtvC2Xpcbm1/4g2h+xrQbb5J/QJ0o4+a6g8N6/N+XvFG2WbHZSfOgf8Rf3
	 B1lN2nJbeus5pg2RURJ8jxuAoptlW3Gd3N4r5fDS1QkIKaTOPWNqsZX95qo1RDtt5h
	 JrWPG3jciafm3Dyz490TzK7q0wbpnFJG84loAg5hMoxHQhEt0ZqbqiQFU90MVVZI7I
	 SyM8t4uaIFhPA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 19 Oct 2025 10:31:44 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH] gpio: mvebu: Slightly optimize mvebu_gpio_irq_handler()
Date: Sun, 19 Oct 2025 10:31:38 +0200
Message-ID: <7190f5def0489ed3f40435449c86cd7c710e6dd4.1760862679.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the main loop of mvebu_gpio_irq_handler() some calls to
irq_find_mapping() can be saved.

There is no point to find an irq number before checking if this something
has to be done.
By testing first, some calls can be saved.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/gpio/gpio-mvebu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index ac799fced950..22c36b79e249 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -573,11 +573,10 @@ static void mvebu_gpio_irq_handler(struct irq_desc *desc)
 	for (i = 0; i < mvchip->chip.ngpio; i++) {
 		int irq;
 
-		irq = irq_find_mapping(mvchip->domain, i);
-
 		if (!(cause & BIT(i)))
 			continue;
 
+		irq = irq_find_mapping(mvchip->domain, i);
 		type = irq_get_trigger_type(irq);
 		if ((type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
 			/* Swap polarity (race with GPIO line) */
-- 
2.51.0


