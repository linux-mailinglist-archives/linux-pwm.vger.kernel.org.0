Return-Path: <linux-pwm+bounces-7424-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC716BCA2A0
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Oct 2025 18:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F553A5077
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Oct 2025 16:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4647022127A;
	Thu,  9 Oct 2025 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SCfz9fR/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E010A1E;
	Thu,  9 Oct 2025 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760027098; cv=none; b=uXwS3r/9u4yfABFGpcf08XAetRIbYBaIXya9C2ss3T+PPVwUgAEbgEpDjbQc/WEWKS7Ib4WRvZCve+/eLQ4npSjTUGXvuimtZIDqSE7PtA76skT+tlOeRgYdIv0IP5woZkyzwl4DhMkGGe05q0zWzHuBFhr1hjikzs907SspW3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760027098; c=relaxed/simple;
	bh=jprDNNJ08zE420+D/pmEF4gfQfbqRkUFgl+uoGD+tcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kS522+wfZg7JELDlmpEhrumcNIVhw0tzWCt6KU/cxx7WXPsEXEr3bTbFqJEG8EHcjzcce9GWsQACj/j9ghLRH91KOarRmLxw5cq6jkW0kDG2WTkAl4JuIY8Xo5yNrvxPY/77nsHjOOjy26kFKtQHGqnsG0pU5R/JR8aGWQMBu3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SCfz9fR/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760027094;
	bh=jprDNNJ08zE420+D/pmEF4gfQfbqRkUFgl+uoGD+tcE=;
	h=From:To:Cc:Subject:Date:From;
	b=SCfz9fR/56q5Xu13v9Zu9RuwpTDtp92IoqTXuvASFby4WxJ7dNbwHhMLI0vBeIV79
	 HkQnlYhQDu1YvBUTIXu1c7EfrMtcT8IAznuZJLzveZbGTlBbXNdLwIp9hosm1WfjdE
	 BpFhq4wQaSzcZnWfozR7xXWdVVnvXw46aWogUbExQBzEXUEdwt3arKaZJ6ri+nshmO
	 3WgxvCs5VE8MLChBP6dXEtQH5RGhSg4e5PMMmp5oPZOm7L2vs+zErkLkrG8p07OE+4
	 XOXGopo1Hfnj+IMCr+8KlBFcqETRud7O8dR77UkYYa7KJwylASpAzGgzgTIz9rlIai
	 v+CZgVFMKy0Cg==
Received: from pan.localdomain (unknown [IPv6:2a00:23c6:c338:be00:61ad:9488:9583:2010])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: martyn)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3A3D317E0A30;
	Thu,  9 Oct 2025 18:24:54 +0200 (CEST)
From: Martyn Welch <martyn.welch@collabora.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: kernel@collabora.com,
	Martyn Welch <martyn.welch@collabora.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: rz-mtu3: Share parent device node to MTU3 PWM
Date: Thu,  9 Oct 2025 17:24:44 +0100
Message-ID: <20251009162445.701589-1-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PWM currently functions, however if we try to utilise the pwn in a
device tree, for example as a pwm-backlight:

        lcd_bl: backlight {
                compatible = "pwm-backlight";
                pwms = <&mtu3 3 833333>;
		...

This fails:

[   15.603948] platform backlight: deferred probe pending: pwm-backlight: unable to request PWM

The PWM driver forms part of the Renesas Multi-Function Timer Pulse Unit
3. The PWM does not have a DT node of it's own. Share the DT node of the
parent MFD device, so that the PWM channels can be referenced via phandles.

Co-developed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---
 drivers/pwm/pwm-rz-mtu3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
index ab39bd37edafc..5825875fa0128 100644
--- a/drivers/pwm/pwm-rz-mtu3.c
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -523,6 +523,12 @@ static int rz_mtu3_pwm_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * There is only one DT node, get it from the parent MFD device, so
+	 * that the PWM channels can be referenced via phandles
+	 */
+	dev->of_node = dev->parent->of_node;
+
 	chip->ops = &rz_mtu3_pwm_ops;
 	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
-- 
2.51.0


