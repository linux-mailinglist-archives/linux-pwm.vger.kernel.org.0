Return-Path: <linux-pwm+bounces-5153-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DABAA5F781
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 15:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDB719C3A79
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8BB267F71;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4gSYMdV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F652676E4;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875557; cv=none; b=cqG0Jic4BHcLnjig+7loHUqb0RFJplC4eRmDRfid/ConMwJznc/du50omLfp1F4rl7H2rt4Oysre7MnHyh3Ijcsdkq3OmIsrIMIP1jZAsQNmtsX2Lk6uKp4cN/8Z7yaz5LtGBHpn4NqdXyiTqYox+5XKkrLMtESxaDq9bIknte4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875557; c=relaxed/simple;
	bh=tfv/OEW5HX1cdoV3Bt6XmUwlf/25u+sSlJmK8/R/SL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pJ1pOFGSU1oeJx8cHEMFaPvcI3M/sJRoeaKcBE0w67jr5BbfhGA+Oo23PRvU/7TITQ5/DgGyA7f+C9h7hytEJd/1jtxNcjkhTcsM1FLcuZFxLCcfhe822J3QW6YmBswEIt1Fi4aMuc+vhZcUv6ZfWUM47P2mjU5N4IuKbxqgNLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4gSYMdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74D37C4CEF1;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875557;
	bh=tfv/OEW5HX1cdoV3Bt6XmUwlf/25u+sSlJmK8/R/SL8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=a4gSYMdVZyamY5EtOkZ2Rf3GeiCU3UcyRk0+Z1QHeax+Q+sWBVdVhBs6EYDwxwgx0
	 XmQefz+JDtQ6VFtEt493bQvDxDMXNiy0wc/QmJKqs+sxPI6fETHHOeCx//Q3LrY6pj
	 2+kFzvwJrmVGfEKZgLvDOpSw8AgSU9ys3C1fuHipohB7KfCxHmLZnFR8+GOjvviMlr
	 RSL5+WAZ0NzfdFhjKQ6VsEiDjXNdAphMpd1CjEFLXGBMS9S6W99d0uEOCGaRNkrPzS
	 uAUboyOmI9JunZSvtRPZvi6rR7zLkWVwEqgYprhKvca8OmVorfK7W8Ctf8tOt+pfem
	 KC6F5jaCgrfCA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB4EC282EC;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 14:19:20 +0000
Subject: [PATCH 03/18] pwm: adp5585: don't control OSC_EN in the pwm driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-adp5589-fw-v1-3-20e80d4bd4ea@analog.com>
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
In-Reply-To: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741875561; l=1401;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=NKMhcBbOgt50Ja7FHiyyQXPORjz4cMFleY53Owp+Grk=;
 b=oXdbhF25zDaKWCKrwdoGgenIXZn6RhFNXPlhcLlcEurnHGqEw08zMUzh6oK2xgY3mdL4VzkcW
 mIpfwjxqNFWAt6eIouSsCe6gPrLvTJ5EoKoeDHrKTqy1rkAp9/FPyu+
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
2.48.1



