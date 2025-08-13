Return-Path: <linux-pwm+bounces-7033-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3972BB24F96
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Aug 2025 18:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37B91C23807
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Aug 2025 16:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3406B28850C;
	Wed, 13 Aug 2025 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="UkbA0gMv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351CA287508
	for <linux-pwm@vger.kernel.org>; Wed, 13 Aug 2025 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101782; cv=none; b=lTaqyATfHeivTJ0fCXGxA8RJiGEnPyYEtPhLOAA4x6P5laZoWzvTs/Uf1odDBKVOES3Ljudo0b7NvGdgOUpXWIiOT2ipa7OLTeNZnX+6WrxxZD8k6yJr6qPLAU+cHDBjCd5EKZjVLC37NRc9sh5QrYvc+/mPPCgGKFwVgB62OaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101782; c=relaxed/simple;
	bh=XwnqVWfA9gTSiTDvlp61VOAW4mkFRjUkZq3Jme4Q8AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVaRK0/+pyZ0Fncd+j/5CujPHcVqaQME7IQp8TBb4C4mdAuIjlkFqjtbLM95506fmfj87mUtYEXcihNR7Kf0KdflBKF8XS2p++6ZPpw3YxVgolliZmnuw6dc8RLpvOOieQ1XHGsyYFyklm2UYMX7gtigBLbOCK1ERGE0kCAfC9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=UkbA0gMv; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=n7haPBNNPZKbfEGBBu257LnsLaghb2tV2gNrhiHCuVc=; b=UkbA0g
	Mvf03QX4hgcVBPlTjgVR9x3M2VX+A4xm+M/cT5ld0qw+Ue827U5OWtUZ8xmLm3n5
	txpVhgOrfGTZzG3i3aCNdwgp9bUYhmffD/hc1mJimCZ0wN+XfUuLckfhfI5UlBsC
	nC8Sl8b1EyAHFSEjnFwPDa2rzE1cNXjnNPJKERidPLqvkSFclrelb/vFrizi8qXV
	BmXx/adHg5c7geyGDFXDtJ40kHfYd1bezGak0BEdfLwvBe/4NccggXlIaqDyMDZc
	Vz7BLV5DpIgXuGsemEDHS2wmELCbmm/MtR5xZvr8AL6P3Y2HS33nrlqPPy9J8vbM
	4Bi0o3kNvb48OS8w==
Received: (qmail 694641 invoked from network); 13 Aug 2025 18:16:01 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Aug 2025 18:16:01 +0200
X-UD-Smtp-Session: l3s3148p1@lTcFeUE8IJVtKLKq
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 03/21] gpio: remove unneeded 'fast_io' parameter in regmap_config
Date: Wed, 13 Aug 2025 18:14:49 +0200
Message-ID: <20250813161517.4746-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using MMIO with regmap, fast_io is implied. No need to set it
again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
No dependencies, can be applied directly to the subsystem tree. Buildbot is
happy, too.

 drivers/gpio/gpio-mvebu.c  | 1 -
 drivers/gpio/gpio-sifive.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 5e3f54cb8bc4..261ffd0c614b 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -602,7 +602,6 @@ static const struct regmap_config mvebu_gpio_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 };
 
 /*
diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
index 067c8edb62e2..98ef975c44d9 100644
--- a/drivers/gpio/gpio-sifive.c
+++ b/drivers/gpio/gpio-sifive.c
@@ -174,7 +174,6 @@ static const struct regmap_config sifive_gpio_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 	.disable_locking = true,
 };
 
-- 
2.47.2


