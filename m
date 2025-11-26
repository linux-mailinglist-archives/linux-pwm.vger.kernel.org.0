Return-Path: <linux-pwm+bounces-7703-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55028C895B6
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Nov 2025 11:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BFB84EBED5
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Nov 2025 10:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0684D320A0A;
	Wed, 26 Nov 2025 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZS/8Mve"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ED6320A0B
	for <linux-pwm@vger.kernel.org>; Wed, 26 Nov 2025 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153797; cv=none; b=L4PETy2w9gYLxRa9PH/S3FZJ4SySukVt9YPgLhsNOp7ko/qT+yoh4BTLIN4bqBMyMlc6N0qpt1dTzajDrm8F9S7hfH9RFzDbQy2PTzAEfLT2LLBVR+oDj8ftvYnp7V0JkWkdn5S85mJb06/3WDIgeS5B6IiEUbBXqlGWNZ1u7Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153797; c=relaxed/simple;
	bh=NR1VVRcQZA6ma1hDRE/H83eikDZdbd6qzrIOtMB/wxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VgqUZqjv2gJe+GZG6Ja86CH+hPL83w2jpkPFTmA9FyOChNzTuEslUQYCoKgZ/jSidzB3QGdqL/fvGtcu4RBcjdoWeneJnyMQuqo1S+RGxOqHUTvMGknl+jHi0gbi4knhqfdQgfKdrxT0jFa2PBGulvYyg0YUIMrLZnTgOSsp8wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZS/8Mve; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso38737035e9.1
        for <linux-pwm@vger.kernel.org>; Wed, 26 Nov 2025 02:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764153794; x=1764758594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9mq5CbEjd8GhLwp2NrMaZDK+wqJGPSJKuaRnVHfJbPQ=;
        b=NZS/8Mve6UfbFNYmswdgd2TR1RYBC+CwG+73zXlwFJd121CViR1lSSW7zAnFyi8661
         yTZpKzfuGrC+E+o5uYfH+hcPaDjM5csOZP5sSEmsSNTmyFuGdvjJdbSkJdzDtSMHLwdx
         +9mPiptp8XNUVVQVq58aark8KJpNGfsz+d4q2XxCPutmMflRuitUn8/xSJI8Do+QcO9E
         aFDM+NlcJ7riWu6AF09rkQB9mLtW1IvGE9L6c4xDbWF4fqAQMXJ0pU0uWxv0J1g+Xy0R
         iz80lXB4EO7GrO8ehV1hOh43mXD4nO0sO16jaGR+ucmIfi0yz/1HXEmVZFlkc4MkFYfD
         7UwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764153794; x=1764758594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mq5CbEjd8GhLwp2NrMaZDK+wqJGPSJKuaRnVHfJbPQ=;
        b=B39Q0Vk0CNNOz3NGbzFGphFEyGvGECFs+xfDkK/qz9NtJLhrQ5uRtTPfreNjalci2a
         iO5tkSoJ47v64IAxhieRDV9G93cWI3q5zPWgkXRUI+ObvlchYA8MkCm9UV2vc2odHGcN
         fpjZqsfyV3CcVjqw7Ma8oZUTvTV29fHYCAf4WBxsm8e7e/kumhQn1rf0drvyTlCp7+HW
         WaVFMDmUxE2HN5vvStzEtgJz0NTFc9iMtSFQ2akKM8sfbXlA3ff/1+TrWoWm+QGdA9PB
         m/heFbBMbYH3skD+rwBno6CaBrOeOUUXixUugS7eIxxykV23CX1to7s/8ligwqq1oum8
         kWLg==
X-Forwarded-Encrypted: i=1; AJvYcCU6BA1ylJ6EgyGkx7qjXUGLoVZkwtV1MahNL7t5Ae0T0psyc+wHR2FJ/hEd17hfCBvf6B8wk+m1wZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOvnILZQ8giBf8SRsM4tWgmlBYArFgoaB5+uDstz+q+8Uq22T
	otGNwulfuzqZ2P0/6tZ/WBjjROzv4ErJHewxuHV+Jc73a2IMWoY0+2jdrG1QZg==
X-Gm-Gg: ASbGncs1xLvNfRYW+uyZ5qTEezjcJy3c80J0xEiaglYszi5YO16q5fHPIz/SHEc8LtZ
	IWrrUxI7IYVqJqMkGt3+sIL0exHv6GAa/VWBD/G2sZi+trQztXWLWnvs9iVZrQf685BpzBUp33H
	U9yU+s5jtv0MCHbJxytqsEE082AimGYs3EurpUS0NGyVTTPq5qkSNTi56ah8DgJWn+DX2y+Xc0h
	U978gB8W6g5KwcwWKiBg/xT6DSb9cr0Vo2U8rUVy44AKjARo4rEGsjGM+HyeP1lJ2myZJ4lvOne
	RJh0wCEddCMbfXUT76bsmquDSZmPYz+HHYPCLuXrS1yO0MWmPsKq0SdZkEHc81pSOzJAgZEHgsF
	kfEmD76Q05H5Y1klC1FW8AtHOoKJd+/CgU0DullXr+s7Vp2fDnQ4PRJ98g/kHxg7Sbi2EJ99+uf
	yQqM1lfs2vLZLniqOUBOwxCVSwtam+2G1hYALUBC21RukEhCdZQeQGLQ0231V2OdPOLCnin8iNz
	AA=
X-Google-Smtp-Source: AGHT+IGDQCBktlHP7XlaQJx6GpqJtsNTrxHBS+ivjHzh6Kcd83OVbwN6YnaySf7vK/vLpTylz9wT/w==
X-Received: by 2002:a05:600c:c490:b0:477:b734:8c41 with SMTP id 5b1f17b1804b1-477c10c8596mr182627435e9.1.1764153793699;
        Wed, 26 Nov 2025 02:43:13 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0c3a28sm36441245e9.9.2025.11.26.02.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 02:43:13 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH v6] pwm: rzg2l-gpt: Allow checking period_tick cache value only if sibling channel is enabled
Date: Wed, 26 Nov 2025 10:42:48 +0000
Message-ID: <20251126104308.142302-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The rzg2l_gpt_config() tests the rzg2l_gpt->period_tick variable when
both channels of a hardware channel are in use. This check is not valid
if rzg2l_gpt_config() is called after disabling all the channels, as it
tests against the cached value. Hence, allow checking and setting the
cached value only if the sibling channel is enabled.

While at it, drop else after return statement to fix the check patch
warning.

Cc: stable@kernel.org
Fixes: 061f087f5d0b ("pwm: Add support for RZ/G2L GPT")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5->v6:
 * Updated commit header and description.
 * Added rzg2l_gpt_sibling() for finding sibling channel.
 * Replaced local variable other_sub_ch->sibling_ch.
 * Dropped setting rzg2l_gpt->period_ticks[ch] in rzg2l_gpt_disable() as
   it is not needed.
 * Dropped else after return statement to fix the check patch
   warning.
v4->v5:
 * Updated commit description and code comment to give more details on why
   reinitialising the cached value to zero
 * Added a check in rzg2l_gpt_config(), to prevent setting the cached value, if
   the other channel is not enabled.
v3->v4:
 * Split the patch as separate from [1] for easy merging.
 * Updated commit description
 * Added comments about the fix in rzg2l_gpt_disable()
v3:
 * New patch

[1] https://lore.kernel.org/all/20250915163637.3572-1-biju.das.jz@bp.renesas.com/#t
---
 drivers/pwm/pwm-rzg2l-gpt.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 360c8bf3b190..4856af080e8e 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -96,6 +96,11 @@ static inline unsigned int rzg2l_gpt_subchannel(unsigned int hwpwm)
 	return hwpwm & 0x1;
 }
 
+static inline unsigned int rzg2l_gpt_sibling(unsigned int hwpwm)
+{
+	return hwpwm ^ 0x1;
+}
+
 static void rzg2l_gpt_write(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg, u32 data)
 {
 	writel(data, rzg2l_gpt->mmio + reg);
@@ -271,10 +276,14 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * in use with different settings.
 	 */
 	if (rzg2l_gpt->channel_request_count[ch] > 1) {
-		if (period_ticks < rzg2l_gpt->period_ticks[ch])
-			return -EBUSY;
-		else
+		u8 sibling_ch = rzg2l_gpt_sibling(pwm->hwpwm);
+
+		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch)) {
+			if (period_ticks < rzg2l_gpt->period_ticks[ch])
+				return -EBUSY;
+
 			period_ticks = rzg2l_gpt->period_ticks[ch];
+		}
 	}
 
 	prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
-- 
2.43.0


