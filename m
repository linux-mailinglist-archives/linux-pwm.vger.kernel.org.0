Return-Path: <linux-pwm+bounces-7802-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E7ACC6981
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Dec 2025 09:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5230306FB0F
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Dec 2025 08:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A903338599;
	Wed, 17 Dec 2025 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sq1Ih3FF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A7E33C528
	for <linux-pwm@vger.kernel.org>; Wed, 17 Dec 2025 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765959923; cv=none; b=tqp3LbDAkLdvHQVlMd5Lc9RcjHT8PAsLga/0g7B/KmlQaNfd9yLcjJx8QkS3g++hXsKUqJf8egU6lt3eW8w7f6t1Q0LbBK8aALHWK/UmaubWfMbie3QnzGbJYtYbA8s1ccxdqklgq9pCdjzjjbP2KaULeIb78AE174LDuHAyaRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765959923; c=relaxed/simple;
	bh=kruXyr2OgP/lTPoUJSyWYaLWejFS7ay7PdsApVq9qhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvf8g31tEUcdGzXjGxRGBXnNmai+0JbY72Gg66U1gab5EjNOAYHXEqAiByzVVne3bbwR3B12MIOSGK1g1cmqjHmPTP7XDeLi12g9uCRI6XclVz47JSXwPLlTRce5ZNCSHY+Ll1ElIj3n68gDWeZTm8rCStJ2TzuXGrxGV3b3LYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sq1Ih3FF; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B8364C1A594;
	Wed, 17 Dec 2025 08:24:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3B3026072F;
	Wed, 17 Dec 2025 08:25:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D175119502E4;
	Wed, 17 Dec 2025 09:25:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765959916; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=EcFsxuHmn/wuUxliMzpmv5LpdKsUJIVznPv+0b4QKh4=;
	b=Sq1Ih3FFmgbcU6oRiBfwP1V1V9nwVBs3p8m0ZTHwVX2jV7CoFTVVSvmY/dV8WLs6ZNJcaW
	Wkqhn/80RdH356f2XdFt6xHPpGa/JwlGCTsRv01+akyeP6aTUTLMQI2qjUoilbFTwzGDG3
	ncVPwjqCffnEVVdGpeOOItADyd4ce9CvilKLuVECqM3Qgx5nwpc6phlsGI+QPkWsyLlfyo
	OEpTYOd9IXJjuoSTZER+SCKcsKWInbSl71RFD8EJyW4nRF1egKl/z2DUJ/xtWS3lDjV0fu
	g6hNzJGb48c3BAGSI76woe8mJC88tCxpgcXnhfAhKCgrp5cSswPgHwyN/XJPBA==
From: Richard Genoud <richard.genoud@bootlin.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v2 0/4] Introduce Allwinner H616 PWM controller
Date: Wed, 17 Dec 2025 09:25:00 +0100
Message-ID: <20251217082504.80226-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Allwinner H616 PWM controller is quite different from the A10 one.

It can drive 6 PWM channels, and like for the A10, each channel has a
bypass that permits to output a clock, bypassing the PWM logic, when
enabled.

But, the channels are paired 2 by 2, sharing a first set of
MUX/prescaler/gate.
Then, for each channel, there's another prescaler (that will be bypassed
if the bypass is enabled for this channel).

It looks like that:
            _____      ______      ________
OSC24M --->|     |    |      |    |        |
APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> PWM_clock_src_xy
           |_____|    |______|    |________|
                          ________
                         |        |
                      +->| /div_k |---> PWM_clock_x
                      |  |________|
                      |    ______
                      |   |      |
                      +-->| Gate |----> PWM_bypass_clock_x
                      |   |______|
PWM_clock_src_xy -----+   ________
                      |  |        |
                      +->| /div_k |---> PWM_clock_y
                      |  |________|
                      |    ______
                      |   |      |
                      +-->| Gate |----> PWM_bypass_clock_y
                          |______|

Where xy can be 0/1, 2/3, 4/5

PWM_clock_x/y serve for the PWM purpose.
PWM_bypass_clock_x/y serve for the clock-provider purpose.
The common clock framework has been used to manage those clocks.

This PWM driver serves as a clock-provider for PWM_bypass_clocks.
This is needed for example by the embedded AC300 PHY which clock comes
from PMW5 pin (PB12).

This series is based onto v6.19-rc1

Changes since v1:
- rebase onto v6.19-rc1
- add missing headers
- remove MODULE_ALIAS (suggested by Krzysztof)
- use sun4i-pwm binding instead of creating a new one (suggested by Krzysztof)
- retrieve the parent clocks from the devicetree
- switch num_parents to unsigned int

Richard Genoud (4):
  dt-bindings: pwm: allwinner: add h616 pwm compatible
  pwm: sun50i: Add H616 PWM support
  arm64: dts: allwinner: h616: add PWM controller
  MAINTAINERS: Add entry on Allwinner H616 PWM driver

 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml |  19 +-
 MAINTAINERS                                   |   5 +
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  47 +
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sun50i-h616.c                 | 892 ++++++++++++++++++
 6 files changed, 975 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pwm/pwm-sun50i-h616.c


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.47.3


