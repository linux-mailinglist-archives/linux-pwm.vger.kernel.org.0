Return-Path: <linux-pwm+bounces-1197-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3E4849108
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Feb 2024 23:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A04F1F22917
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Feb 2024 22:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B882C1A4;
	Sun,  4 Feb 2024 22:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="WeeRrM2p"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C83A2C689;
	Sun,  4 Feb 2024 22:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084557; cv=none; b=ZBFOpp1P4Wq1rGACr8XK5zjiNktM1MQ/pZAlGMUzZyeTkWVl516oKZMkzF+qBn9c9rmpb06eOP42+Ev2tSJRRVimjFF8lU5e8TwEZCMX0RtWZ/wY/gHWyHE47SU69TTWdWgGdRoJc4hAPXprO3fAEfobODAFjwzpfHGWhvn9jgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084557; c=relaxed/simple;
	bh=lcSALU3XCoeVYGVW+3iPlWS+WqbYkXLoQrHUCLujJbo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YjX8MUewNvRifHLGpHbJMX8/FkvI/jg2smmSYFTW4HHPlVYYPZLU+Sc9s4GoAn3xYSnSe3bi4x5LBLUlCfUZRwok7iLIFiHy+T8JLQ6t+RBnUmCbectMmer7YjGZaW40NgA1qgUX8cKfEhkfm3yhf+DGBFluPwfAnc9vULe5uic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=WeeRrM2p; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707084546; x=1707689346; i=wahrenst@gmx.net;
	bh=lcSALU3XCoeVYGVW+3iPlWS+WqbYkXLoQrHUCLujJbo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=WeeRrM2paNvcMecnAJWRrxJ77E/3HyJBgecL0SnyHSfBqyfKeWimam7mqGPxVq9O
	 aBcWtnV94yyiIsN3+SYpU7Q+BqWEMVeVoJPM6Ad7AhDyoJMcKQRgUbb+KogJk5l9h
	 5LaT49gsiPquRM8gnRP4iPoeWc9Fe3F4mBb3eFt7iIb3qvbl0LH94FkY3DInHB1+c
	 e/05dkIG5U+VZGNU3s5/873RszZUHRHC4LkmC5vRUdbFjJy99RCDMi2QVAtVl0y0v
	 VYGeKV7oCog1jaEQOFil/0EPPkGnxSeTBa/8NMHAi/f3L3Tb4820zv9MBGD6ZhqMP
	 dRCC/xVnd1njalq1pA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOzT4-1rMvzq0X3U-00PNXu; Sun, 04
 Feb 2024 23:09:06 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: andy.shevchenko@gmail.com,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Philip Howard <phil@gadgetoid.com>,
	Sean Young <sean@mess.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V4 0/2] pwm: Add GPIO PWM driver
Date: Sun,  4 Feb 2024 23:08:49 +0100
Message-Id: <20240204220851.4783-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9jOGDJzJ/olR+EgtNQUuD153AnMlMe07O5RepJJFnMh9dEUsA6g
 ic3C96A/knoGZb++jA7DYE+GBmMFFD9xt/jPVj4XYveatgXuJR2a3kee1BLoc9SmxLk8Tdw
 qhTATXwZmH2ulxDgxjq8y0lUos3ugcpod0E6j1/0H30lmFenMHV/Nc6JSPi5kreTYB/GE1x
 wlu52NpHpGEMATt5YGoKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5Sa6vjEsESw=;OlCxJ4MXx9wE5bmlgtWys1tz8pB
 Vz2Scxzk1gh1VSMh1CWPQpzRjmlHtqAOCVeERjqkQsxgfnEQrAjinBPzuGapovjLqNrRtuqHR
 OBHqE1BMRtUu5pTp5LzMl0BQs/ExZSyojPRf1VWdxQg9Q5N5qLtRJVS/qfQMIdIfUsLTVomk3
 D2D2gR5ns/oIxMvP2YnppB6QrfCVrZG2hVFpRwqexktfnK+Nf3z7LCOe4UdJR8GYU17ZqGKN9
 VeRto0J6Zesd93e+mlt/DK+okrJnqHpzJQN56B1XT+Ynr44rjB2ZQWh0XU9BKOTyCzeC2nl4h
 6jhq7H+kjOpQKGkqVg4dmynJInq9rmzuJTWC9sFobAbkP4ozdSIsCX7DEFuhpne9i+eYtqar0
 cu1wFMV3OqLYjqvcFNu0LG8Zt+ZIcT+PRHPJmJs3ecMjXWucLHcpGSelZdC7lyzCj2Fz3hrme
 hH1huOf8skx23OLeqe2ShQssc9ib5ZN/k5yFvjpg/2barAbsWh/dMxhsx8UDywlWTmHyvs32/
 dRiM1X1iVfPoSWIAs3NKbfnPnfCLYY6QbjZSxe+JbaIm4LMOEheMWZ95Rgkh4uryPRMX1Yu+S
 2WYsSkWQjqa83WkOR96tgfbikYBolNEUbKqhx2L1n4tveibeiLxWNFf6XKremb7tfKjjZ6KK0
 bF88l1JF47sYBiVR9puUlxpRL4k22OSwvnz9iQwIu7R5kl0UjDSJEI+nQL4fIw9p+AZ0qp46k
 GytcGSyY5litqN+PujmRePByFh8F/zbGg9QPZurE34/1FF4WDGQmovaxu4pYnMkDrxi2POnbP
 Gtz0nHar5FoNyr3Izfbv6vZTfSGfhAd7TH+YiapI/6VRw=

Add a software PWM which toggles a GPIO from a high-resolution timer.

Recent discussions in the Raspberry Pi community revealt that a lot
of users still use MMIO userspace tools for GPIO access. One argument
for this approach is the lack of a GPIO PWM kernel driver. So this
series tries to fill this gap.

This continues the work of Vincent Whitchurch [1], which is easier
to read and more consequent by rejecting sleeping GPIOs than Nicola's
approach [2].

The work has been tested on a Raspberry Pi 3 B+ and a cheap logic
analyzer.

V4:
 - address DT bindings comments from Conor Dooley
 - drop unnecessary MODULE_ALIAS() as suggested by Krzysztof Kozlowski
 - add range checks to apply which consider the hrtimer resolution
   (idea comes from Sean Young)
 - mark driver as atomic as suggested by Sean Young

V3:
 - rebase on top of v6.8-pwm-next
 - cherry-pick improvements from Nicola's series
 - try to address Uwe's, Linus' and Andy's comments
 - try to avoid GPIO glitches during probe
 - fix pwm_gpio_remove()
 - some code clean up's and comments

V2:
 - Rename gpio to gpios in binding
 - Calculate next expiry from expected current expiry rather than "now"
 - Only change configuration after current period ends
 - Implement get_state()
 - Add error message for probe failures
 - Stop PWM before unregister

[1] - https://lore.kernel.org/all/20200915135445.al75xmjxudj2rgcp@axis.com=
/T/
[2] - https://lore.kernel.org/all/20201205214353.xapax46tt5snzd2v@einstein=
.dilieto.eu/

Nicola Di Lieto (1):
  dt-bindings: pwm: Add pwm-gpio

Vincent Whitchurch (1):
  pwm: Add GPIO PWM driver

 .../devicetree/bindings/pwm/pwm-gpio.yaml     |  42 ++++
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-gpio.c                        | 228 ++++++++++++++++++
 4 files changed, 282 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
 create mode 100644 drivers/pwm/pwm-gpio.c

=2D-
2.34.1


