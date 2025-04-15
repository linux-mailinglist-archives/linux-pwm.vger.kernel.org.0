Return-Path: <linux-pwm+bounces-5494-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25311A8A19B
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 16:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0287B441E67
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAE829A3E9;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLXOoMxE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E7823816F;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728559; cv=none; b=UwmnktWs6rxTSPNvegMBdH5g/XAvyT391tl40us04BvkKF88Lc5UkAdSg5VXMvDRHwiGzXWqqAKNvzDMWBEhkUBI/aOV6Ceqip4B3Pta59f8x826lLKM/xRDMdJ3JhUBMlYPTc5c0BawHaWVXlCY23gTCFL5oVcvTbijWcSZD0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728559; c=relaxed/simple;
	bh=HgcAr0PBB4Py95fVn5f8uWZI71qwh+M5gpX5UYPwIpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DSfcN/AHFXJEpyDBTrEm9f6eL8DtVrJ/+Rn7S5gBUSezfgOXZUOAzrZxtQGAba/JipGyoGnVr6Z9RCYo0uGCc4toOOYBqzSNJQr/qX+pCWXM3DftDJANGmB0XaBQTaAPBgFBvRV3yvIrqYdujm2uueJv/Dxggwr0Jcqe6b/qm1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLXOoMxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E120C4CEEF;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744728559;
	bh=HgcAr0PBB4Py95fVn5f8uWZI71qwh+M5gpX5UYPwIpU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jLXOoMxEsUW8Vh6tFYdg6SrkUsNU8qJ7IE11UAgn2B59kXuq2yHaY9xn1gP3ngDTR
	 4y7MXjSmkHnGjAuX4gJC+vfzRcs8jYRNURzO6CSBFAYBlGPh3jBdXvVbTTcSzt4IZj
	 zHQg1FGc5RZiZBmQevgefve73V1aHron/xqPAJqaqss0S9nWJIepiCS1iYBuAUIz0j
	 HTZOWcyiFxhQjUT9uUHk76aNcuFTEeu1fNG8CNFoYe50bOgSCHasc6xiYbl5wiPTNv
	 DBDvfHIqdJ6rdiBxa5BIYyIb9nh7YZbbDRpA2JBeqT9cFAFhgW795nnNJZ4INnyMRC
	 VQJw86K2KqKpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4041BC369BF;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 15 Apr 2025 15:49:19 +0100
Subject: [PATCH v2 03/17] pwm: adp5585: don't control OSC_EN in the pwm
 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-dev-adp5589-fw-v2-3-3a799c3ed812@analog.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
In-Reply-To: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
To: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744728559; l=1401;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=MVCU5kPBNDbHxIfJmLO114QSq4N3ZehCh55N9NFh/nk=;
 b=FK5Mp5exFOfBO8W5zO3/ykDCjDKMhs7g7kZQFKaMh0WcHdWLpSGQ0zlsN/pbImJFVnfpcgD2v
 Wo1H/mOKsAdBWC+scx/0ajQDxzFFTHVzpW6dQw66Uaoa0vIAoKVxHYB
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

The adp5585 is a Multi Function Device that can also be a gpio
controller and as it turns out, when OSC_EN is not set, we can't
reliably read the gpio value when it's configured as input. Hence,
OSC_EN will be set during probe by the parent device (and cleared on
unbind).

Moreover, we'll add support for the keymap matrix (input device) which
definitely needs OSC_EN to be set and so, we cannot afford that disabling
the PWM output also breaks the keymap events generation.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/pwm/pwm-adp5585.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
index 40472ac5db6410a33e4f790fe8e6c23b517502be..c8821035b7c1412a55a642e6e8a46b66e693a5af 100644
--- a/drivers/pwm/pwm-adp5585.c
+++ b/drivers/pwm/pwm-adp5585.c
@@ -62,7 +62,6 @@ static int pwm_adp5585_apply(struct pwm_chip *chip,
 	int ret;
 
 	if (!state->enabled) {
-		regmap_clear_bits(regmap, ADP5585_GENERAL_CFG, ADP5585_OSC_EN);
 		regmap_clear_bits(regmap, ADP5585_PWM_CFG, ADP5585_PWM_EN);
 		return 0;
 	}
@@ -100,10 +99,6 @@ static int pwm_adp5585_apply(struct pwm_chip *chip,
 	if (ret)
 		return ret;
 
-	ret = regmap_set_bits(regmap, ADP5585_GENERAL_CFG, ADP5585_OSC_EN);
-	if (ret)
-		return ret;
-
 	return regmap_set_bits(regmap, ADP5585_PWM_CFG, ADP5585_PWM_EN);
 }
 

-- 
2.49.0



