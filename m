Return-Path: <linux-pwm+bounces-2838-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 514F393334D
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 23:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C34628237A
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 21:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7CE13A869;
	Tue, 16 Jul 2024 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNEXFoQ+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AB08121B;
	Tue, 16 Jul 2024 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721164358; cv=none; b=J/Nf4TxIQoL1TC6WQDRo8ufTIRqS+7M/uwr+wJN2mWXyQyXMQHvm/XnX2vcNRn5h2weBG1ZhYrXBe7xamu8T8AOLyx6jyQLl2ZhWuYnIaBk3/sIqNB6oeiZxkmzMWJPUsql20M5F/2hyoUpRdXhT6QTGfJWIy/Ai/sdetpG4Qak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721164358; c=relaxed/simple;
	bh=CbxmPz9//sNxSegGvbo+xch6ubB1Bto45l24nPrtKhA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=SWfDhw0s6jpyPzNNImBnhm9DybmGlw+rVKAx4SdRTU5u3W8TmMYbkFBGWgjCa4WNU5733tKQDov2Sg4WpMfzpVhQOK9rZXOgIlDXip1i08M0wa+rmdkGXljsOVLlyxv/gqx6dCdGDz/fdvqalP2RoevDZt1MCVSXqDTveMooEUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNEXFoQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C608C116B1;
	Tue, 16 Jul 2024 21:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721164357;
	bh=CbxmPz9//sNxSegGvbo+xch6ubB1Bto45l24nPrtKhA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=sNEXFoQ+XYPto9nQlBo0HId848l0qlutfzU0/qWFseRohI6BRl52Rug0iuYzzwOJ4
	 N422UmDuQFcdBtWVGaFPE/Yi/CWD0R3CDi60s3oO0YIrWzPlyvwyWech14xMgVch1C
	 LyW8XmEg7Y10Ryw8/zGiAlV7QHZUUaLgbTNqEN6c1btE1GR+420EZeTXWqEMNvOhxQ
	 XsnyMfDW9wX6N+1gK9nQVp0GJsoYz2uY27hD9UOjTDmLrdH8H2lpAjtDLnSIh/Lt/7
	 sVdLrOzJ2LN9sbmC+P05vcv1JxI+beCi+Xy32b3JBQbe0dhrhWZuFPrcj8sQwPIFNR
	 QuOZxTLwfucHQ==
Date: Tue, 16 Jul 2024 15:12:36 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev, Conor Dooley <conor+dt@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org, 
 Jun Li <jun.li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Clark Wang <xiaoning.wang@nxp.com>, 
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 linux-gpio@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20240716-adi-v1-0-79c0122986e7@nxp.com>
References: <20240716-adi-v1-0-79c0122986e7@nxp.com>
Message-Id: <172116301291.347275.15990094913310761465.robh@kernel.org>
Subject: Re: [PATCH 0/6] mfd: add adp5585 gpio and pwm support


On Tue, 16 Jul 2024 15:28:23 -0400, Frank Li wrote:
> adp5585 is totally difference adp5588, which in
> drivers/input/keyboard/adp5588-keys.c.
> 
> So create new driver for it.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Clark Wang (1):
>       pwm: adp5585: add adp5585 PWM support
> 
> Frank Li (3):
>       dt-bindings: mfd: Add i2c device adi5585
>       arm64: dts: imx93-11x11-evk: add adi,adp5585 gpio and pwm
>       arm64: dts: imx95-19x19-evk: add i2c2 and adi,adp5585
> 
> Haibo Chen (2):
>       mfd: adp5585: add ADI adp5585 core support
>       gpio: adp5585-gpio: add adp5585-gpio support
> 
>  .../devicetree/bindings/mfd/adi,adp5585.yaml       |  83 ++++++++
>  arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts  |  16 ++
>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts  |  30 +++
>  drivers/gpio/Kconfig                               |   7 +
>  drivers/gpio/Makefile                              |   1 +
>  drivers/gpio/gpio-adp5585.c                        | 184 ++++++++++++++++++
>  drivers/mfd/Kconfig                                |   9 +
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/adp5585.c                              | 134 +++++++++++++
>  drivers/pwm/Kconfig                                |   8 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-adp5585.c                          | 215 +++++++++++++++++++++
>  include/linux/mfd/adp5585.h                        | 100 ++++++++++
>  13 files changed, 789 insertions(+)
> ---
> base-commit: 91e3b24eb7d297d9d99030800ed96944b8652eaf
> change-id: 20240715-adi-11ff2d3d35ec
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y freescale/imx93-11x11-evk.dtb freescale/imx95-19x19-evk.dtb' for 20240716-adi-v1-0-79c0122986e7@nxp.com:

arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: mfd@34: 'gpio', 'pwm' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: mfd@34: 'gpio-adp5585', 'pwm-adp5585' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#






