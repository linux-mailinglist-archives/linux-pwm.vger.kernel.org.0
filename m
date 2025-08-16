Return-Path: <linux-pwm+bounces-7079-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D79B28D2E
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Aug 2025 12:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 334214E2A30
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Aug 2025 10:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005262BD03E;
	Sat, 16 Aug 2025 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="MtvxWOwy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933DD2BD019;
	Sat, 16 Aug 2025 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755341782; cv=none; b=nYnpH+2uIrfVwvcjas+uba16ruRygDTVtGroGHY9j6J/DrMUFwNXJIMI7kk0UZHGvmgpzd9Gp0OM4zMJviYQwN2T6SpzGmfx7/52ne3ZyFqI0YTc1x3WtZ87vxOMyINaA7RLhPoPBBjU3oXuK/OQ0s2lz8zazbJjhqOtgd5/cNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755341782; c=relaxed/simple;
	bh=cR6kC3e3n6Bl1IMPmV9XN3aP3xEyc7Wn9kkGkKeGmyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=brxQl9l8+RFB9BqXF4MX5WQ2TZa0KodtCj2+CaHZLUtQ5nRQwaK7YWhumX6Rf2ftRI3exKf0iHjx1XN5NPyLdbUKAZLenvsB1Y+JhTa5ieo37BXWdKyV3HPVEUNbqmMCERhaHCWVvN9HaT9GKoZ1kbDZvDK70hjZOGji7ON6pS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=MtvxWOwy; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1755341404;
	bh=CbJ7sHuYn22Ps9Cj2TYsRn0iAipKwJrAYBCH2boJmH8=;
	h=From:To:Cc:Subject:Date:From;
	b=MtvxWOwyZ6JUvj3lo9y7OqnWt1F2CgpheEJO0SMiyJbW1gH9+O7SAUhNaBvic6Zl6
	 fb/adK6Bo9eCg4pKb+WDIWA0ES8uJ+K/DuKjWphejDdo2EHLFUZSn90H+dWcwbwYP2
	 Fm8olvbnWcc2NB7DzsyFXeZPErHon2FcoVTXf7o4=
Received: from stargazer (unknown [IPv6:2409:874d:200:3037::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 6BDAF66BB8;
	Sat, 16 Aug 2025 06:50:00 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	linux-pwm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH] pwm: loongson: Fix LOONGSON_PWM_FREQ_DEFAULT
Date: Sat, 16 Aug 2025 18:49:05 +0800
Message-ID: <20250816104904.4779-2-xry111@xry111.site>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per the 7A1000 and 7A2000 user manual, the clock frequency of their
PWM controllers is 50 MHz, not 50 kHz.

Fixes: 2b62c89448dd ("pwm: Add Loongson PWM controller support")
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 drivers/pwm/pwm-loongson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
index 1ba16168cbb4..31a57edecfd0 100644
--- a/drivers/pwm/pwm-loongson.c
+++ b/drivers/pwm/pwm-loongson.c
@@ -49,7 +49,7 @@
 #define LOONGSON_PWM_CTRL_REG_DZONE	BIT(10) /* Anti-dead Zone Enable Bit */
 
 /* default input clk frequency for the ACPI case */
-#define LOONGSON_PWM_FREQ_DEFAULT	50000 /* Hz */
+#define LOONGSON_PWM_FREQ_DEFAULT	50000000 /* Hz */
 
 struct pwm_loongson_ddata {
 	struct clk *clk;
-- 
2.50.1


