Return-Path: <linux-pwm+bounces-6694-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E8BAF59AE
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 15:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437A84E1C16
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 13:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C32287256;
	Wed,  2 Jul 2025 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4txNhWG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ABE285419;
	Wed,  2 Jul 2025 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463376; cv=none; b=q6slvwH0QOXF89oJsuz3Tik8JAXRt8GtCHzSdg+iMizX13TZn7Es1ZN5mZKufsml9/TEbw4A07WMqse6YmZnVrQYP/Mf4swq8J+nJ2tiUwre8lLFICVX8EBXZkCsEmhz/2SH0dmhI2iVS2IEHjeoXM4zmnVO3nJxRgdmPLJ7kMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463376; c=relaxed/simple;
	bh=uGa43jc2Cw+4x9AMXsf5PdOX9TokrUCZweehn6ucM+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bz7fr7gdOUXrfMAoznpWbE7ZuwHkMS/KBavfgfnRWPefVeypZGpywEjz6cEmVQkMAyzDj/cszmV4Db5Um3LIj8CRkpcSurghwfPcpJ21zJnCMr18Lbuz1VINFDvOjerYEpd8776pYRpk4vliOOcdE3PsjqwQ+718Udtb+5EosZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4txNhWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDACC4CEEF;
	Wed,  2 Jul 2025 13:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751463375;
	bh=uGa43jc2Cw+4x9AMXsf5PdOX9TokrUCZweehn6ucM+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4txNhWGJvKd7MU6iu0wLQlijrtUNUKE8RoyYSSe3x4erxW9ja4H4l/Zlv9Kf2KQb
	 YezXsf9i8R2vmgYrPLXF/yGQF0sE89hXqwjMlF29G/uP2fiPPPCbK3kwnyJbCy0KkX
	 bbtnyMuvmMxXWSZnDnqZGYIpfMh86rJSOQo5UqjWH/HzcYRamtswvlbDBUPBheDl9p
	 LT03Ufirkb3SvCGMuHABZeBn9wOVeGlvK6Rz9UrrerZX3i/ubryCzH2c0ncXotxfj0
	 f5qbPEFGoF7+2KvKxQuleVFxTdsymAgIbg2yQoakjQJAlm/bBCgAGk8/XB9FtAmBtj
	 CBt248lNYl4bA==
Date: Wed, 2 Jul 2025 14:36:09 +0100
From: Lee Jones <lee@kernel.org>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Liu Ying <victor.liu@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [GIT PULL] Immutable branch between MFD, GPIO, Input and PWM due for
 the v6.17 merge window
Message-ID: <20250702133609.GQ10134@google.com>
References: <20250701-dev-adp5589-fw-v7-0-b1fcfe9e9826@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250701-dev-adp5589-fw-v7-0-b1fcfe9e9826@analog.com>

Enjoy!

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-input-pwm-v6.17

for you to fetch changes up to 45ee66c37f9bd8cff7718c70d84e0291d385a093:

  mfd: adp5585: Add support for a reset pin (2025-07-01 21:50:51 +0100)

----------------------------------------------------------------
Immutable branch between MFD, GPIO, Input and PWM due for the v6.17 merge window

----------------------------------------------------------------
Nuno Sá (20):
      dt-bindings: mfd: adp5585: ease on the required properties
      mfd: adp5585: Only add devices given in FW
      mfd: adp5585: Enable oscillator during probe
      mfd: adp5585: Make use of MFD_CELL_NAME()
      dt-bindings: mfd: adp5585: document adp5589 I/O expander
      mfd: adp5585: Refactor how regmap defaults are handled
      mfd: adp5585: Add support for adp5589
      mfd: adp5585: Add a per chip reg struture
      gpio: adp5585: add support for the adp5589 expander
      pwm: adp5585: add support for adp5589
      dt-bindings: mfd: adp5585: add properties for input events
      mfd: adp5585: Add support for event handling
      mfd: adp5585: Support reset and unlock events
      mfd: adp5585: Add support for input devices
      gpio: adp5585: support gpi events
      Input: adp5585: Add Analog Devices ADP5585/89 support
      Input: adp5589: remove the driver
      mfd: adp5585: Support getting vdd regulator
      dt-bindings: mfd: adp5585: document reset gpio
      mfd: adp5585: Add support for a reset pin

 .../devicetree/bindings/mfd/adi,adp5585.yaml       |  240 ++++-
 .../devicetree/bindings/trivial-devices.yaml       |    2 -
 MAINTAINERS                                        |    1 +
 drivers/gpio/Kconfig                               |    1 +
 drivers/gpio/gpio-adp5585.c                        |  364 ++++++-
 drivers/input/keyboard/Kconfig                     |   21 +-
 drivers/input/keyboard/Makefile                    |    2 +-
 drivers/input/keyboard/adp5585-keys.c              |  371 +++++++
 drivers/input/keyboard/adp5589-keys.c              | 1066 --------------------
 drivers/mfd/adp5585.c                              |  739 +++++++++++++-
 drivers/pwm/pwm-adp5585.c                          |   78 +-
 include/linux/mfd/adp5585.h                        |  118 ++-
 12 files changed, 1796 insertions(+), 1207 deletions(-)
 create mode 100644 drivers/input/keyboard/adp5585-keys.c
 delete mode 100644 drivers/input/keyboard/adp5589-keys.c

-- 
Lee Jones [李琼斯]

