Return-Path: <linux-pwm+bounces-2894-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7492938EE0
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 14:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D656B21019
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 12:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440F716D4D1;
	Mon, 22 Jul 2024 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Rni74CVy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8F116CD3B;
	Mon, 22 Jul 2024 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721650282; cv=none; b=sRM3FtgGFItRJcrz2xcYGouVW1dwnxALE9k0AHuqsZWh2rqEYrsJqpXSsc8O1rZoQo+GYkOLLqKffYdUWKVRYJP7XS3ug1r/9NWbSEfslsNrxFADIksA8ZigNI3nQlh2lVSdLA4A3glpfqS4OB1q94BbLY/wJWhfFx+GNAEYCJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721650282; c=relaxed/simple;
	bh=6JjbiKt2EElXXn2fNVQlEfWX5/tSPM44Ms3XEhpuj8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XcvmADDXXwXfgT9wSZDfaeiD1vW3BC/41UxoIylcLNc1zCWtGq4p43D+fopi7UzuB19mHLDG+bOr7GaPCwu8rM9Rv317YWgTnArjJxUdiP1g9Xj2YDRo8s+VSm5HZkx6Gy7ySxpQMkdbRi06FlDGm6KAYIX5TV95OQZNjNWfmLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Rni74CVy; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 96F6045B;
	Mon, 22 Jul 2024 14:10:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721650236;
	bh=6JjbiKt2EElXXn2fNVQlEfWX5/tSPM44Ms3XEhpuj8M=;
	h=From:To:Cc:Subject:Date:From;
	b=Rni74CVyXlkmVgMETNF+exKeTdfWksbyXBjEdToaRRX1iU0r58+V5tA/r8gu66Nuj
	 eOXN/tTxs6bR9cGYs/ETyxpVzyr9lhgdr+y/WQqcAIuarpnB93VSAsZzc2GTWI3JKu
	 s8IQRhZeaiXsQC3LcZUApFtKCZBqIR/mtUM1lo2k=
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>
Subject: [PATCH v7 0/4] ADP5585 GPIO expander, PWM and keypad controller support
Date: Mon, 22 Jul 2024 15:10:56 +0300
Message-ID: <20240722121100.2855-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Compared to v6, this version addresses small review comments. I believe
it is ready to go, as the PWM and GPIO drivers have been acked by the
respective subsystem maintainers, and I have addressed Lee's comments on
the MFD side. Lee, if there's no more issue, could you apply this to
your tree for v6.12 ?

Clark Wang (1):
  pwm: adp5585: Add Analog Devices ADP5585 support

Haibo Chen (2):
  mfd: adp5585: Add Analog Devices ADP5585 core support
  gpio: adp5585: Add Analog Devices ADP5585 support

Laurent Pinchart (1):
  dt-bindings: mfd: Add Analog Devices ADP5585

 .../devicetree/bindings/mfd/adi,adp5585.yaml  |  92 +++++++
 .../devicetree/bindings/trivial-devices.yaml  |   4 -
 MAINTAINERS                                   |  11 +
 drivers/gpio/Kconfig                          |   7 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-adp5585.c                   | 229 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  12 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/adp5585.c                         | 205 ++++++++++++++++
 drivers/pwm/Kconfig                           |   7 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-adp5585.c                     | 184 ++++++++++++++
 include/linux/mfd/adp5585.h                   | 126 ++++++++++
 13 files changed, 876 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
 create mode 100644 drivers/gpio/gpio-adp5585.c
 create mode 100644 drivers/mfd/adp5585.c
 create mode 100644 drivers/pwm/pwm-adp5585.c
 create mode 100644 include/linux/mfd/adp5585.h


base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
-- 
Regards,

Laurent Pinchart


