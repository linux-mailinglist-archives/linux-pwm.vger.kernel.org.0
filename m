Return-Path: <linux-pwm+bounces-2254-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 131D78D23AF
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 21:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9E11F24511
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 19:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6771316E895;
	Tue, 28 May 2024 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="sc5vGbNd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C115744C8C;
	Tue, 28 May 2024 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923010; cv=none; b=QHyBizVkCEjhjfNQREp3QaHWngW4OA/Sn9pJV+XJ8hFk0h58FsC+JNsqGmWKvqqfz7CupQRrMTIYqpGbgXyAjxWDdCyZZhde1fpjToMLA7N81BYLka+bCwOtaMlnkSen9zPgTw7aqeeCKQeEp+JWERUtHqX6k4KaftP8IEXQq6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923010; c=relaxed/simple;
	bh=h+2v1Uu8sBVsE0sSUT/TQIKV/8xuYS/8QCvqmlBwVeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJJr197Ql+tH26cw9DwVBXwaWv+L8+LwZ91VV4jDEGhrz2ddHZZOQ5gL9XXadNWATsWs29mlxP0qU3HN9E6zHCGsmQaoLYWz+9oQJ01HAyEr0PsY+1Msj1YaIjR4l8jwr7oitTV7m2Bi8zOuRqyBuwZsp6QO6zjdv+oreQ7qu4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=sc5vGbNd; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D583EA27;
	Tue, 28 May 2024 21:03:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716923004;
	bh=h+2v1Uu8sBVsE0sSUT/TQIKV/8xuYS/8QCvqmlBwVeE=;
	h=From:To:Cc:Subject:Date:From;
	b=sc5vGbNdoyU8CSQ7Hv2ZxhwQWJe7uSQc41rrkg3d5sPAj6qoEN80X2rCniDNUf07u
	 as4qoC6VEuRmxjk95qDKDFX1XPuim06eUfOAljfBIaE2q3tZLD+wiuZFJjne0sVmJW
	 OuEciPw/arJu2a/tQZVD0E4IS7I+vFFj0VKS18Tc=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH v2 0/4] ADP5585 GPIO expander, PWM and keypad controller support
Date: Tue, 28 May 2024 22:03:10 +0300
Message-ID: <20240528190315.3865-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.44.1
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

All review comments from v1 have been taken into account as far as I can
tell. The most notable changes are in the DT binding that now merge all
functions in a single node, and the corresponding changes to the
drivers.

Clark Wang (1):
  pwm: adp5585: Add Analog Devices ADP5585 support

Haibo Chen (2):
  mfd: adp5585: Add Analog Devices ADP5585 core support
  gpio: adp5585: Add Analog Devices ADP5585 support

Laurent Pinchart (1):
  dt-bindings: Add bindings for the Analog Devices ADP5585

 .../devicetree/bindings/mfd/adi,adp5585.yaml  | 107 ++++++++
 .../devicetree/bindings/trivial-devices.yaml  |   4 -
 MAINTAINERS                                   |  11 +
 drivers/gpio/Kconfig                          |   7 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-adp5585.c                   | 232 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  11 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/adp5585.c                         | 200 +++++++++++++++
 drivers/pwm/Kconfig                           |   7 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-adp5585.c                     | 187 ++++++++++++++
 include/linux/mfd/adp5585.h                   | 127 ++++++++++
 13 files changed, 892 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
 create mode 100644 drivers/gpio/gpio-adp5585.c
 create mode 100644 drivers/mfd/adp5585.c
 create mode 100644 drivers/pwm/pwm-adp5585.c
 create mode 100644 include/linux/mfd/adp5585.h


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
Regards,

Laurent Pinchart


