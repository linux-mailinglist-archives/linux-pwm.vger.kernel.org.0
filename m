Return-Path: <linux-pwm+bounces-3026-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D353B954D9E
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Aug 2024 17:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7147E2825DA
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Aug 2024 15:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849291BC9F9;
	Fri, 16 Aug 2024 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5GbSN+q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5163A127E3A;
	Fri, 16 Aug 2024 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822064; cv=none; b=VOPRPJx4lCxLYBUlZ6xe94/VB6R9oQMe4orNg0GSOAEhXCWX01UhyKemWi6+JNO6iNmYSCDg0fPg8jIXwovMtctxBGdpQlq9Xgs2yrCbhwO7Y541kOPWrONHK9QXueXsluqUalAm2grgk79lzAyAItR+E2oUKVhTFxSPLVy3MYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822064; c=relaxed/simple;
	bh=bHbg28x9ZF+oj+ApGQowOZXBQpdCPk7yj6dFt1qAqA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AskTsQA5Ws+PzYwjOohofllFdcGGNt8877rN5O5yfNW9EraMj+ZTEFXO8Noq8kQIXix/hHJMR0vZJIJKZnADqt2aSMqYYHeySZ9//ja7bEIYzLUiLAraXDpC4hqF+AwRLNbTJKO1ErU4kbzVKwF4InHo/bvwXPi3hKcmJf0FZDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5GbSN+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31E5C32782;
	Fri, 16 Aug 2024 15:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723822063;
	bh=bHbg28x9ZF+oj+ApGQowOZXBQpdCPk7yj6dFt1qAqA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5GbSN+qy510lSQK1FxZQnUty4+MnPqHsbFFaZT7+swchpDR+oOVEIvxsi28VMKuk
	 Yotd23wKg3KdLPxx8eo92jtDLS8asHG4JTNeFZ7dPtDDvuTGZHUVkKpYu6aqMu38zd
	 iOwmMBR+H0gLWJq2/IBP/lnjid8+tAIrCeKwgyxZA6bvPFYneut7+jj0YPt4xXRvO+
	 fcMhx0gIL5ah8TmS71IcLCxgbwedSNMnCybrc2gRqLUcO7KNOKi8GPSrAAA1SXdKTI
	 7Tw+58+jTwUsqxj/3Jwlruuh1lRc//GcO5Q3uq7Lr1Z3C05CFO9C+CC9xAzxo0M0Ty
	 5+mSo4kXQni1Q==
Date: Fri, 16 Aug 2024 16:27:38 +0100
From: Lee Jones <lee@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>
Subject: Immutable branch between MFD, GPIO and PWM due for the v6.12 merge
 window
Message-ID: <20240816152738.GB5853@google.com>
References: <20240722121100.2855-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240722121100.2855-1-laurent.pinchart@ideasonboard.com>

Sorry for the tardy PR - enjoy!

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-gpio-pwm-v6.12

for you to fetch changes up to e9b503879fd2b6332eaf8b719d1e07199fc70c6b:

  pwm: adp5585: Add Analog Devices ADP5585 support (2024-08-01 14:09:28 +0100)

----------------------------------------------------------------
Immutable branch between MFD, GPIO and PWM due for the v6.12 merge window

----------------------------------------------------------------
Clark Wang (1):
      pwm: adp5585: Add Analog Devices ADP5585 support

Haibo Chen (2):
      mfd: adp5585: Add Analog Devices ADP5585 core support
      gpio: adp5585: Add Analog Devices ADP5585 support

Laurent Pinchart (1):
      dt-bindings: mfd: Add Analog Devices ADP5585

 .../devicetree/bindings/mfd/adi,adp5585.yaml       |  92 +++++++++
 .../devicetree/bindings/trivial-devices.yaml       |   4 -
 MAINTAINERS                                        |  11 +
 drivers/gpio/Kconfig                               |   7 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-adp5585.c                        | 229 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |  12 ++
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/adp5585.c                              | 205 ++++++++++++++++++
 drivers/pwm/Kconfig                                |   7 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-adp5585.c                          | 184 +++++++++++++++++
 include/linux/mfd/adp5585.h                        | 126 ++++++++++++
 13 files changed, 876 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
 create mode 100644 drivers/gpio/gpio-adp5585.c
 create mode 100644 drivers/mfd/adp5585.c
 create mode 100644 drivers/pwm/pwm-adp5585.c
 create mode 100644 include/linux/mfd/adp5585.h

-- 
Lee Jones [李琼斯]

