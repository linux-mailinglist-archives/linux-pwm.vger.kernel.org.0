Return-Path: <linux-pwm+bounces-6443-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA81AE078E
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Jun 2025 15:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D01BD7ABD17
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Jun 2025 13:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0379F26F47D;
	Thu, 19 Jun 2025 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bn/uqpPL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CE225D1E1;
	Thu, 19 Jun 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750340320; cv=none; b=QSqf5tg2JtgNj3pkIMLi46roQv6vCPyxKxR/ZAI492CNkn/6M+jA410L+Tf2yL8Pw6UnqKz4t8tIU0sERbvwzvHgPykHpFguRKRGrekJdqRK2ucazD3/pbzPI6QtbZap2gogjRfTmFgh4NfAJlnMmtSaraPBucAPBs9BFfBB6+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750340320; c=relaxed/simple;
	bh=MUcIIYeNFNdVSgZmodd9gQcOciHLU+o3JjUKidTW6Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=it0AsmEFBrM3oidTKSeGEV7mjGhyLTndimcy5rJfHQD+FJvF5OIpqq1Sg4rv18NJUAQVC/4rWoAAiqXRv+lQTTanFm63OAEHFiJTJWumORO1SrI4tQTnX+b8zmOFzwEpbUMyO/L7tW6kEdHo7iLhvP3prWoLCmUNiIYAGpr+hI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bn/uqpPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4625CC4CEEA;
	Thu, 19 Jun 2025 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750340320;
	bh=MUcIIYeNFNdVSgZmodd9gQcOciHLU+o3JjUKidTW6Rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bn/uqpPLTn9jf0Bo4wvXQrPX8Y24/pIIvQ+CaLLBDcBdTErtzU3W0EDw6MbGwIJDY
	 tKHh3G5R5dXY7GUhHDbN76D/4vnwr0GmGZ57E8HPXqc8+uxSfFx08JfhZvNt7hLJ4Y
	 JrmMMImGG2rllZOkTenw62vFdthBUvsI9UVikGjaEnj7Mi63FAriMNqAG+ex0xPs4J
	 mrhGGcDptQfO4jTiReVbtfQHCe3X+fEy0faM5Ms3LuS7M3iNpCE/LI4U2WbncMa/Lq
	 siz96CEIokVZaW948esbokgoZqdLgS4NyiqrIPkROuEuzd4vljtB0NkwxPqTe2pd2w
	 78XvWGSLoH85Q==
Date: Thu, 19 Jun 2025 14:38:34 +0100
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
Subject: Re: [PATCH v5 00/20] mfd: adp5585: support keymap events and drop
 legacy Input driver
Message-ID: <20250619133834.GC795775@google.com>
References: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>

On Sat, 14 Jun 2025, Nuno Sá via B4 Relay wrote:

> Hi all,
> 
> Here it goes v4. Main changes is to drop chip info based struct and
> directly use an enum in the FW .data pointer, use the notifier API for
> dispatching events and multiple calls to mfd_add_devices().
> 
> Regarding the last point, I think I could have used multiple calls to
> devm_mfd_add_devices() and avoid those gotos in adp5585_add_devices()
> but I do not feel that would have been "correct".
> 
> Thanks!
> - Nuno Sá
> 
> ---
> Changes in v5:

In future, these should be inside the patches themselves please.

> - Patch 2:
>   * Use the existing devm_mfd_add_devices().
> - Patch 3:
>   * Remove TODO comment.
> - Patch 4:
>   * Mention in the commit message the Copyright update.
> - Patch 6:
>   * Return a struct regmap_config pointer in
>     adp5585_fill_regmap_config();
>   * Just leave a blank entry in the adp5585_regmap_defaults array.
> - Patch 13:
>   * Improve comments for pin6 (row5) validation;
>   * Don't use magic numbers;
>   * Drop some odd line breaks;
>   * Initialize vartiable when declaring.
> - Patch 14:
>   * Drop double spaces;
>   * Don't use magic numbers;
>   * Improve some comments.
> - Patch 16:
>   * Fix missing semicolon.
> - Patch 20:
>   * DS -> datasheet. 
> 
> - Link to v4: https://lore.kernel.org/r/20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com
> - Link to v3: https://lore.kernel.org/r/20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com
> - Link to v2: https://lore.kernel.org/r/20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com
> - Link to v1: https://lore.kernel.org/r/20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com
> 
> ---
> Nuno Sá (20):
>       dt-bindings: mfd: adp5585: ease on the required properties
>       mfd: adp5585: only add devices given in FW
>       mfd: adp5585: enable oscilator during probe
>       mfd: adp5585: make use of MFD_CELL_NAME()
>       dt-bindings: mfd: adp5585: document adp5589 I/O expander
>       mfd: adp5585: refactor how regmap defaults are handled
>       mfd: adp5585: add support for adp5589
>       mfd: adp5585: add a per chip reg struture
>       gpio: adp5585: add support for the adp5589 expander
>       pwm: adp5585: add support for adp5589
>       dt-bindings: mfd: adp5585: add properties for input events
>       mfd: adp5585: add support for event handling
>       mfd: adp5585: support reset and unlock events
>       mfd: adp5585: add support for input devices
>       gpio: adp5585: support gpi events
>       Input: adp5585: Add Analog Devices ADP5585/89 support
>       Input: adp5589: remove the driver
>       mfd: adp5585: support getting vdd regulator
>       dt-bindings: mfd: adp5585: document reset gpio
>       mfd: adp5585: add support for a reset pin
> 
>  .../devicetree/bindings/mfd/adi,adp5585.yaml       |  240 ++++-
>  .../devicetree/bindings/trivial-devices.yaml       |    2 -
>  MAINTAINERS                                        |    1 +
>  drivers/gpio/Kconfig                               |    1 +
>  drivers/gpio/gpio-adp5585.c                        |  364 ++++++-
>  drivers/input/keyboard/Kconfig                     |   21 +-
>  drivers/input/keyboard/Makefile                    |    2 +-
>  drivers/input/keyboard/adp5585-keys.c              |  371 +++++++
>  drivers/input/keyboard/adp5589-keys.c              | 1066 --------------------
>  drivers/mfd/adp5585.c                              |  743 +++++++++++++-
>  drivers/pwm/pwm-adp5585.c                          |   78 +-
>  include/linux/mfd/adp5585.h                        |  118 ++-
>  12 files changed, 1799 insertions(+), 1208 deletions(-)
> ---
> base-commit: 407f60a151df3c44397e5afc0111eb9b026c38d3
> change-id: 20250311-dev-adp5589-fw-e04cfd945286
> --
> 
> Thanks!
> - Nuno Sá
> 
> 

-- 
Lee Jones [李琼斯]

