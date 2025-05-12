Return-Path: <linux-pwm+bounces-5900-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACD4AB373D
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 14:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4EF188C5D1
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 12:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423C2293B6A;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R74obJ26"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049BC4A08;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053539; cv=none; b=pwEVyGxZvlCXmutPTALrrhXq5JX3adHLUx7isKyDhhjxZr1yyRJxrpD3HO6D8ynCtcbsRKkiZMJvqQEmj/OUEQsKnFBis7oFJwQCIte93VXRrj6njUold55X/8OKw/FTVX6eGXJxB4Ziov3peZ5ywhvZyRXfdxTKlqOqyxFek7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053539; c=relaxed/simple;
	bh=HgcAr0PBB4Py95fVn5f8uWZI71qwh+M5gpX5UYPwIpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a8l72AEaA4VKz6ecvAXYoMD9DEuSgx48EGWMuDeV4PnVR8WxcqoqWK5r2yMpsOs7zFYYdqcUOj43B78oflTVH1USSVdR/DQj0WjXhN0J+uUz3NQ3YeEHtctmnqn6JoSwz+NSWtBllDLkvczTPBnFHCLmI+b5tEiSWG0TS1VN4Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R74obJ26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93831C4CEF3;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053538;
	bh=HgcAr0PBB4Py95fVn5f8uWZI71qwh+M5gpX5UYPwIpU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R74obJ261MRq9zWlq1K0pwUdOZh0vh3HYDSSki6oPCq6eyvrLvxI+iraqWJdWVgvw
	 Ttn1sgqwWUCZKGolREStAPASK60d8r600ALKwfj0HxsuG+S8YQ9wpIWcsRqOjKMihc
	 eddEZN4G4oMXUpW1KQe0NNVOy+OxoWb7uISSl4h6tCw/pmTkTp3geBCNFUzGBakKYT
	 +LWjYSDZA95Ispv3pvVp+iq0J2589cdatVziK89/i3l94XlZ28psU4JKql6/VJEagd
	 71ioEHm4ATZeR3x6UhoxGgp1EQS2/D7dQHE5oLUtJWyX9i/uWCk/Xf2q7b/8bf4Wzj
	 Wy2fHx3FjC4tw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A958C3ABCD;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 13:38:56 +0100
Subject: [PATCH v3 04/22] pwm: adp5585: don't control OSC_EN in the pwm
 driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-adp5589-fw-v3-4-092b14b79a88@analog.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
In-Reply-To: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747053537; l=1401;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=MVCU5kPBNDbHxIfJmLO114QSq4N3ZehCh55N9NFh/nk=;
 b=e73+7UDtEa7JsEUNcmfk1BRIjDHf6yGm16rJN160lpWBPTe8cbC5EmIUXAOygYuJ4jQMBXgYb
 2tLS2W6N1HNAUQENyO4MmnmlaPJMW2bH/882aMDPefzBZunwyRk3ZPi
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



