Return-Path: <linux-pwm+bounces-7145-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC523B323AE
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 22:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A94624DB2
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 20:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07D12D780C;
	Fri, 22 Aug 2025 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5KQQ1ia"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E72273D8D;
	Fri, 22 Aug 2025 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755895228; cv=none; b=NCmyCDnnxd+Y0JhGMOaxTsXLKT3L6r1vQ9yvMYURmX/469yQhBg7PF23HgpijLld+SbIP+rxNeKKO3Ul6pHtwzq8QkPkcRM/2M2cUM47xClKvJ0yzTz0icKwNW3M1Oj6oiArzQgL+BXOHIZZ2bJMkBBWmIUT1bX7kscnakf8LHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755895228; c=relaxed/simple;
	bh=cQaigDBTxzr1UzSEKTyGQ6sShaL7mmiAEnUOGpm19DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeW3pFmOC0l/mAli5hBRZgi/ssPCEH/SSSXcqnbbKHfPXvGVLn3pxJ9iuDiAWwy7kWFpCCdQFCqooR/HTMKnZz4/czj749FBjgNOLiAiHb032XHh+p6oXV7AO+xyoLBhKLxycLCVtSvVkpsJFHLaOi9u54zzcZX1qqIzvGxx8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5KQQ1ia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF79C4CEED;
	Fri, 22 Aug 2025 20:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755895228;
	bh=cQaigDBTxzr1UzSEKTyGQ6sShaL7mmiAEnUOGpm19DU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q5KQQ1ia/LPE0jWIdLX92S6hU598Aa9oRK7q68PJvX9I1fP/wu2jVpxXUu4ZcRWWh
	 2TfX6N8DyNb10amwbNWFA89/+lM2wvkQBHmBTik/BEEjHPWC89iPGf1jrn5rclz1fe
	 wK04qZwSD+dVz269iAxvyxHAo3q2QlGOaPlxj2K0dXqlH5ssipaSd9MphPUHImfv/h
	 wYEz0UMcT/FekQnw959WOP+qoCbpI8+JNc7ficN2QdOaD2Klz2HXJf3uIhOLMZqlwA
	 PmsO23d3FLfEGROqaXKZp6Fu18+lGDNCv1rzjKbVQ/7OzPzkDeuueIY5lZZ9wjDiWA
	 EQ61a7HDJl4ZQ==
Date: Fri, 22 Aug 2025 15:40:27 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Michael Walle <mwalle@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jean Delvare <jdelvare@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Cheng-Yi Chiang <cychiang@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tinghan Shen <tinghan.shen@mediatek.com>,
	devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mathew McBride <matt@traverse.com.au>
Subject: Re: [PATCH v2] dt-bindings: mfd: Move embedded controllers to own
 directory
Message-ID: <20250822204027.GA319356-robh@kernel.org>
References: <20250822075712.27314-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822075712.27314-2-krzysztof.kozlowski@linaro.org>

On Fri, Aug 22, 2025 at 09:57:13AM +0200, Krzysztof Kozlowski wrote:
> Move ChromeOS Embedded Controller, Gateworks System Controller and
> Kontron sl28cpld Board Management Controller to new subdirectory
> "embedded-controller" matching their purpose.  MFD is coming from Linux
> and does not really fit the actual purpose of this hardware.
> 
> Rename Gateworks GSC filename to match compatible, as preferred for
> bindings.
> 
> Acked-by: Michael Walle <mwalle@kernel.org> # for sl28cpld
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Cc: Mathew McBride <matt@traverse.com.au>
> 
> Lee,
> Can you take it via MFD?
> 
> Changes in v2:
> 1. Correct remaining paths in other schemas ($ref and descriptions)
> ---
>  .../bindings/{mfd => embedded-controller}/google,cros-ec.yaml | 2 +-
>  .../gateworks-gsc.yaml => embedded-controller/gw,gsc.yaml}    | 2 +-
>  .../{mfd => embedded-controller}/kontron,sl28cpld.yaml        | 2 +-
>  .../devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml       | 2 +-
>  .../devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml     | 2 +-
>  .../bindings/interrupt-controller/kontron,sl28cpld-intc.yaml  | 2 +-
>  Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml | 2 +-
>  .../devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml         | 2 +-
>  Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml     | 4 ++--
>  .../devicetree/bindings/sound/google,cros-ec-codec.yaml       | 2 +-
>  .../devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml    | 2 +-
>  MAINTAINERS                                                   | 4 ++--
>  12 files changed, 14 insertions(+), 14 deletions(-)
>  rename Documentation/devicetree/bindings/{mfd => embedded-controller}/google,cros-ec.yaml (99%)
>  rename Documentation/devicetree/bindings/{mfd/gateworks-gsc.yaml => embedded-controller/gw,gsc.yaml} (98%)
>  rename Documentation/devicetree/bindings/{mfd => embedded-controller}/kontron,sl28cpld.yaml (97%)

Who's the maintainer for the 'embedded-controller' directory? Fine if 
me, just need to know.

Other candidates:
Documentation/devicetree/bindings/platform/*
Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
Documentation/devicetree/bindings/misc/ge-achc.yaml ?

Rob

