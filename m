Return-Path: <linux-pwm+bounces-7176-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 220E1B375AD
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Aug 2025 01:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F1E7A92C3
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Aug 2025 23:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A77307AF9;
	Tue, 26 Aug 2025 23:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ku2eS2aL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B025826D4DD;
	Tue, 26 Aug 2025 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756252245; cv=none; b=Q7CW4RzwrX91TF9kjJq8eEbkStdgcxrxMjfv3fjVf50SYC4A9D/+D3t6zKwhjtrtlnxp2cN9fU6Zn1EqSzIj+uPtb/8EsvbVKL/2OtYP4+6BwCk4JASUr53pFpxEcBB6UOsGOyYACTNwGzu7+tGq71DMUV0/ZnLflq4u5co0uyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756252245; c=relaxed/simple;
	bh=07Ku4luLp6tCckZKvoGpBvBDQ0Ywwcemo2l4BS/xWs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJaeeNxkprsmccTyyeJIBp56PiKBH6On4kyqx08MY6TqZFwpiv05fpaIs1AyEb19Qzr1lg0nEVI4oCTpMKM87lBoHdWjK3Nvdj+2MwqkaKsB86WhRIZz41T/IZYpY5DRAkV84REITSw9Epsvl7S/GwcAbYDQq5Bch4k/a5kkuQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ku2eS2aL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91F3C4CEF1;
	Tue, 26 Aug 2025 23:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756252245;
	bh=07Ku4luLp6tCckZKvoGpBvBDQ0Ywwcemo2l4BS/xWs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ku2eS2aLuk2BO85gltgp9fViBt3A7nXYGIzz3ko+3i02BU56tWHBUt7SqU2nURtEN
	 XBBLjuym5594eRddN8//2A0hIq9YGE3uJyHGblP1kjOj68phQ1DzZczKcjxA+BYH7m
	 beuxjpqZ1t3NkKzgfPTOjhOisGGViCwrEjzxf5/EchC01qkp/d/r0yRVVVq5e9D4ra
	 9iyKZSacjOMQZjnsjMUDUS7FZcVzPkmSyZlv8uUTxMLQ55Ro7lB9BFk8KSd1dsWumX
	 ZZ+S+nCkt7tGurJCOCifKfd1hsdFyeaBfVGIOUwIwszL5KLRmkt2m3Rz7ePoD+ElMf
	 wfPZvM216LTww==
Date: Tue, 26 Aug 2025 18:50:43 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-watchdog@vger.kernel.org,
	Mathew McBride <matt@traverse.com.au>,
	linux-arm-kernel@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Nikita Travkin <nikita@trvn.ru>,
	Guenter Roeck <groeck@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-mediatek@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jean Delvare <jdelvare@suse.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-sound@vger.kernel.org,
	Cheng-Yi Chiang <cychiang@chromium.org>,
	linux-hwmon@vger.kernel.org, Tzung-Bi Shih <tzungbi@kernel.org>,
	Pengyu Luo <mitltlatltl@gmail.com>, linux-gpio@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>,
	linux-pwm@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Tinghan Shen <tinghan.shen@mediatek.com>
Subject: Re: [PATCH v3] dt-bindings: mfd: Move embedded controllers to own
 directory
Message-ID: <175625224288.764159.13881647192010727208.robh@kernel.org>
References: <20250825081201.9775-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825081201.9775-2-krzysztof.kozlowski@linaro.org>


On Mon, 25 Aug 2025 10:12:02 +0200, Krzysztof Kozlowski wrote:
> Move several embedded controller bindings (like ChromeOS EC, Gateworks
> System Controller and Kontron sl28cpld Board Management) to new
> subdirectory "embedded-controller" matching their purpose.
> 
> An embedded controller (EC) is a discrete component that contains a
> microcontroller (i.e. a small CPU running a small firmware without
> operating system) mounted into a larger computer system running
> a fully fledged operating system that needs to utilize the embedded
> controller as part of its operation.
> 
> So far the EC bindings were split between "mfd" and "platform"
> directory.  MFD name comes from Linux, not hardware, and "platform" is a
> bit too generic.
> 
> Rename Gateworks GSC and Huawei Gaokun filenames to match compatible, as
> preferred for bindings.
> 
> Acked-by: Michael Walle <mwalle@kernel.org> # for sl28cpld
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Lee,
> Can you take it via MFD?
> There is a patch on the lists touching kontron,sl28cpld.
> 
> Changes in v3:
> 1. Move more files from "platform" directory.
> 2. Grow commit msg, based on feedback from Linus.
> 3. Add Rb (patch changed, though).
> 
> Changes in v2:
> 1. Correct remaining paths in other schemas ($ref and descriptions).
> 2. Add Ack.
> 
> Cc: Mathew McBride <matt@traverse.com.au>
> ---
>  .../{platform => embedded-controller}/acer,aspire1-ec.yaml  | 2 +-
>  .../{mfd => embedded-controller}/google,cros-ec.yaml        | 2 +-
>  .../gateworks-gsc.yaml => embedded-controller/gw,gsc.yaml}  | 2 +-
>  .../huawei,gaokun3-ec.yaml}                                 | 2 +-
>  .../{mfd => embedded-controller}/kontron,sl28cpld.yaml      | 2 +-
>  .../lenovo,yoga-c630-ec.yaml                                | 2 +-
>  .../microsoft,surface-sam.yaml                              | 2 +-
>  .../devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml     | 2 +-
>  .../devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml   | 2 +-
>  .../interrupt-controller/kontron,sl28cpld-intc.yaml         | 2 +-
>  .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml         | 2 +-
>  .../devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml       | 2 +-
>  Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml   | 4 ++--
>  .../devicetree/bindings/sound/google,cros-ec-codec.yaml     | 2 +-
>  .../devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml  | 2 +-
>  MAINTAINERS                                                 | 6 +++---
>  16 files changed, 19 insertions(+), 19 deletions(-)
>  rename Documentation/devicetree/bindings/{platform => embedded-controller}/acer,aspire1-ec.yaml (94%)
>  rename Documentation/devicetree/bindings/{mfd => embedded-controller}/google,cros-ec.yaml (99%)
>  rename Documentation/devicetree/bindings/{mfd/gateworks-gsc.yaml => embedded-controller/gw,gsc.yaml} (98%)
>  rename Documentation/devicetree/bindings/{platform/huawei,gaokun-ec.yaml => embedded-controller/huawei,gaokun3-ec.yaml} (97%)
>  rename Documentation/devicetree/bindings/{mfd => embedded-controller}/kontron,sl28cpld.yaml (97%)
>  rename Documentation/devicetree/bindings/{platform => embedded-controller}/lenovo,yoga-c630-ec.yaml (95%)
>  rename Documentation/devicetree/bindings/{platform => embedded-controller}/microsoft,surface-sam.yaml (92%)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


