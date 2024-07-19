Return-Path: <linux-pwm+bounces-2859-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F07937D51
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 22:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234E41F21ED7
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 20:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4811487F7;
	Fri, 19 Jul 2024 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pl1oXVI1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAA159168;
	Fri, 19 Jul 2024 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721421614; cv=none; b=S8tSgvBOmvCdwHLr12Pmlnm9PEDsauqwbVkXWDQYcf9iw0l0BEiSgRC5JauAcbmIbSUUBSUCh6eD2kSL54II11vVnogCD6yQJdAYSLrtMsW8o2aqm3rpniqfD6F36cPiAArKEzjouhNbI3chPGYMB0ehFaYnggQ6srxqmt6l7Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721421614; c=relaxed/simple;
	bh=phwTgibeppshyJxQXwZkVARKXCQlStTJ7fWi4+aAdcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=roEymw7jsBXOzbUtmH3hBVD+5xofpp5sz1MpWYxHkwEOn+68jjgyawgsS1EQUAdAR5QiTwj/BLHAl9RoiccdGkxAUMJ5Jf1EyueW7UUM+WQQRQ2So0KSbp711YouVO0J5ZxVh+7fqRdIN0mrZ89060GpcQOLqtGEyPSDCpXJOjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pl1oXVI1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 67D373D6;
	Fri, 19 Jul 2024 22:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721421563;
	bh=phwTgibeppshyJxQXwZkVARKXCQlStTJ7fWi4+aAdcg=;
	h=From:To:Cc:Subject:Date:From;
	b=pl1oXVI1nWKZ0UVjVR8N4Lb9A9b2axVcNmdfWa5Otcfe0m6Cgu5jJP+Jvly1jXa6V
	 NhVCA5Bj5LjVYULOrNEY1FZ4rsAfHhSZwxLBUoUZtX/VoZD5HV/mvLU2aESc2+4LGg
	 JWwGi5VHDJAwG0fDTIktGt35/6aTc6fw1Clqz2kQ=
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
Subject: [PATCH v5 0/4] ADP5585 GPIO expander, PWM and keypad controller support
Date: Fri, 19 Jul 2024 23:39:42 +0300
Message-ID: <20240719203946.22909-1-laurent.pinchart@ideasonboard.com>
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

Compared to v4, this version addresses small review comments. I believe
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
 drivers/mfd/adp5585.c                         | 200 +++++++++++++++
 drivers/pwm/Kconfig                           |   7 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-adp5585.c                     | 189 ++++++++++++++
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


