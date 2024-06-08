Return-Path: <linux-pwm+bounces-2383-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5F29011D8
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2024 16:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6A628249C
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2024 14:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2AF17B410;
	Sat,  8 Jun 2024 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FWeJ52Y6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2187C17A93C;
	Sat,  8 Jun 2024 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717856216; cv=none; b=ufuoxQLVDcqzrp7UrAOWwCIJqRAeA2fqht++beF55JX6s5Hpg7Qnm3xCkHAv1LBZ+pemHAU7xbM3F+AGMvV4qlY/IWnqCuISIwncHQvEIg6zGY4gUr/avO6Zhiyg0Dni4Zyu8y6KKUT8P0Ksqz4Nd/hiYn57BgDn5KbecguoCcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717856216; c=relaxed/simple;
	bh=3ZQeW8xyCfO0mF0Lz2gwAXBPIFqpW8xq/6Un+XG7dl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aOM4Xy6cn/KGSbjDtvF0lgGtDIJRlONVlljfpr24iRJ+Dr2cASniX0DYRxf7/dfoCD1BvwdAaPZSu73J0yuMi9W2XDS/EkAP6WVj1tU1fbEjdKQXpaoGOb7Elr5Qo8sy+A+gnMk0uYg13KG7zwtul9lW9XFj/jpXur6QganRRq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=FWeJ52Y6; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 74E1CC67;
	Sat,  8 Jun 2024 16:16:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1717856201;
	bh=3ZQeW8xyCfO0mF0Lz2gwAXBPIFqpW8xq/6Un+XG7dl8=;
	h=From:To:Cc:Subject:Date:From;
	b=FWeJ52Y6LvaMBC28vCdJ58rQuBqpU4C8SI6PL+y5U7gcVCPyg/xD9Wh+0/noL3RNZ
	 F0zWQwqw6U5C/7jrvkGhZBwNGWrx5YLstlnRWCUchdrLw/hu1MXTlitnV3hDyaCnDt
	 MlW03w20sCD+5MGzOGdiN9XkuXGxb/Ze1oo376ds=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH v4 0/4] ADP5585 GPIO expander, PWM and keypad controller support
Date: Sat,  8 Jun 2024 17:16:29 +0300
Message-ID: <20240608141633.2562-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch series introduces support for the Analog Devices ADP5585, a
GPIO expander, PWM and keyboard controller. It models the chip as an MFD
device, and includes DT bindings (1/4), an MFD driver (2/4) and drivers
for the GPIO (3/4) and PWM (4/4) functions.

Support for the keypad controller is left out, as I have no means to
test it at the moment. The chip also includes a tiny reset controller,
as well as a 3-bit input programmable logic block, which I haven't tried
to support (and also have no means to test).

The driver is based on an initial version from the NXP BSP kernel, then
extensively and nearly completely rewritten, with added DT bindings. I
have nonetheless retained original authorship. Clark, Haibo, if you
would prefer not being credited and/or listed as authors, please let me
know.

Compared to v3, this version addresses small review comments. I believe
it is ready to go, pending another review of the PWM side (Uwe reviewed
a previous version, and to the best of my knowledge, I've addressed all
his concerns) and the MFD driver. Once the PWM driver gets reviewed, I
think the simplest course of action is to merge the whole series through
the MFD tree.

Clark Wang (1):
  pwm: adp5585: Add Analog Devices ADP5585 support

Haibo Chen (2):
  mfd: adp5585: Add Analog Devices ADP5585 core support
  gpio: adp5585: Add Analog Devices ADP5585 support

Laurent Pinchart (1):
  dt-bindings: mfd: Add Analog Devices ADP5585

 .../devicetree/bindings/mfd/adi,adp5585.yaml  |  90 +++++++
 .../devicetree/bindings/trivial-devices.yaml  |   4 -
 MAINTAINERS                                   |  11 +
 drivers/gpio/Kconfig                          |   7 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-adp5585.c                   | 231 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  12 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/adp5585.c                         | 199 +++++++++++++++
 drivers/pwm/Kconfig                           |   7 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-adp5585.c                     | 189 ++++++++++++++
 include/linux/mfd/adp5585.h                   | 126 ++++++++++
 13 files changed, 875 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
 create mode 100644 drivers/gpio/gpio-adp5585.c
 create mode 100644 drivers/mfd/adp5585.c
 create mode 100644 drivers/pwm/pwm-adp5585.c
 create mode 100644 include/linux/mfd/adp5585.h


base-commit: c3f38fa61af77b49866b006939479069cd451173
-- 
Regards,

Laurent Pinchart


