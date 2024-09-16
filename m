Return-Path: <linux-pwm+bounces-3275-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842B3979DE2
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Sep 2024 11:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90061F249E9
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Sep 2024 09:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAE31494B5;
	Mon, 16 Sep 2024 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWEPET8G"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8932148304;
	Mon, 16 Sep 2024 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726477755; cv=none; b=ks2S40liodGUCBgAwOQDZOJfmqR0Nspt8DCjOWisteGqmwAUmAh3Fl8uYtttZQT1F0xHdLYUj20zSWh3BuBcitwPiEJIapZFGEP91wZqPBPWCrxR03fHeWng6FzIE7ks4FxoxfkNKdyItdufhrz5HtmoBNKF6hLyhU3nXJyFRV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726477755; c=relaxed/simple;
	bh=6bAu07qqR/oy28Hk63f8SgDGRZgodwoDApVLtXIhnKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jh5r38Ox5cEBfGy568TCGNWyvQE5ofmf5Tl8mBcLPleVUZywEW4Iug2L+TjGURBRCqF3IjBLZZ6NcV1DSOzxwKPfL8Zzy5skwQOiHofvSCbiLPEK9c9HXZFnqM/55kffiSsKXskmxOGBBEFgDEta9kj3OO5405GJjc2DypJID2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWEPET8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20F3C4CEC4;
	Mon, 16 Sep 2024 09:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726477754;
	bh=6bAu07qqR/oy28Hk63f8SgDGRZgodwoDApVLtXIhnKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWEPET8GkRDhZlgwScXUjeqyarWO78GNRYSkz/w8ZpRRjHhDg/XQPWVoclsA0hYkW
	 43B9rmTeVO5JALDYDUutwRRZlkYiPuHA7uh4MFiDsNjD9rsrkldQS9EQ22TUVhGMcB
	 2KYpxXEdqqs/fIUpwTSHAJV0V2lW8QHCBC6VEgnUY58JJJenIgWHYXVdHrS/N9KvNV
	 QvZJYvNXyVXO/B/csMhAztgdAD5RW4jz0EjaEB/3de/xQ07rsOqVTVZ/Yl1gAJrR1J
	 XyR/AaG/dFz0Wt4jqE+QmPLDXu2sZcqPkoXrEOYRoemvRnBf1B2cJPPU5LWecB+Jrc
	 dEjtkixUyXY6w==
Date: Mon, 16 Sep 2024 11:09:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Simona Vetter <simona@ffwll.ch>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konradybcio@kernel.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v4 14/27] mfd: sec-core: add s2dos05 support
Message-ID: <konn3okav5pzval7cjbuhjgesvhhf7a2cmuz3cxsob4nn6sxgq@nz2bc3i3acx6>
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
 <20240913-starqltechn_integration_upstream-v4-14-2d2efd5c5877@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-14-2d2efd5c5877@gmail.com>

On Fri, Sep 13, 2024 at 06:07:57PM +0300, Dzmitry Sankouski wrote:
> S2dos05 is a panel/touchscreen PMIC, often found in
> Samsung phones. We define 2 sub-devices for which drivers will
> be added in subsequent patches.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  drivers/mfd/sec-core.c           | 11 +++++++++++
>  include/linux/mfd/samsung/core.h |  1 +
>  2 files changed, 12 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


