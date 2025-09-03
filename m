Return-Path: <linux-pwm+bounces-7248-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9AAB416EC
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Sep 2025 09:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3288B564E7C
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Sep 2025 07:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0352DEA71;
	Wed,  3 Sep 2025 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoDk0nl6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD362D73B2;
	Wed,  3 Sep 2025 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885170; cv=none; b=WfBtjbpphX0IgXY4WYkGl8JBprfRVpTz0rk3tdbMhqeAHXezWuoXt48ccBwm0VgBboaX9Q5ypA5f/6o8fSABXReiGW7GOQ6I3/1xJeIz2xCkzYY/XygLEsIezY6q2COduw9SOIcxZJoyukTzO6wwkHF/7nLQpyLaq/DPunEECic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885170; c=relaxed/simple;
	bh=nabVaKDp95bXX1pjLpK4nzWf1nseMWBruv5tgZaJBoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgLSo4t9RnL2L+JF4an+eVqMdPBh1rtIXER+V/S9sbvnXb+k1NqL6WRuwPspTYV66mcMM27zLuIVDaADulwlmU+XNeZ082KD0yNliA72zJEDa0JPCqzX+D7j1m+BwbkhG+dRWUiFHhPdtE1qwVi9IFNUgxlLzyB3pJr/ahGExq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoDk0nl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA52C4CEF0;
	Wed,  3 Sep 2025 07:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756885169;
	bh=nabVaKDp95bXX1pjLpK4nzWf1nseMWBruv5tgZaJBoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qoDk0nl6DGMhrsb9Zero2GRf3mxlO2Zkmtca2Z/KeKD/A+oBDZ96dYcBPT94dwlkU
	 f0DLzIj/ZwhCrb5B4tPNd/VVQsfYxVSV2/QOOMs9cLSO9APl7W8P7vIBAVhCCtvHGN
	 Wtzw48LeMkWre+8zpgwv+Li+KmKBA5Y9dXQUwTFoIo9DK79zaqWKJYA9eeL0JZADFS
	 qD9EiS0+jbqaNpPL+mO71C0U1WpdfN7z2meHxEAo+95mgjgwwldX3TLfUrljS59Nku
	 X8Zz7gNiYLjBFpa/8drEj34cjLfh0bA/7FZxXieklmnEs9cQou/+e+pY9sOk2PlsS3
	 SwaRwN9OWsD2w==
Date: Wed, 3 Sep 2025 08:39:20 +0100
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Michael Walle <mwalle@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jean Delvare <jdelvare@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
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
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mathew McBride <matt@traverse.com.au>
Subject: Re: (subset) [PATCH v2] dt-bindings: mfd: Move embedded controllers
 to own directory
Message-ID: <20250903073920.GA2163762@google.com>
References: <20250822075712.27314-2-krzysztof.kozlowski@linaro.org>
 <175682479961.2401991.17056649550187344851.b4-ty@kernel.org>
 <63e43445-ef5f-49b2-85c1-f85d95426d5d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63e43445-ef5f-49b2-85c1-f85d95426d5d@kernel.org>

On Tue, 02 Sep 2025, Krzysztof Kozlowski wrote:

> On 02/09/2025 16:53, Lee Jones wrote:
> >> [...]
> > 
> > Applied, thanks!
> > 
> > [1/1] dt-bindings: mfd: Move embedded controllers to own directory
> >       commit: 152afab28f7659a4292c9f7d3324eaeb49a55b8b
> 
> 
> There was a v3 here:
> 
> https://lore.kernel.org/r/20250825081201.9775-2-krzysztof.kozlowski@linaro.org/

Drop this, applied that!

-- 
Lee Jones [李琼斯]

