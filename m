Return-Path: <linux-pwm+bounces-3276-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0805D979DEC
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Sep 2024 11:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CFF1F24AAB
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Sep 2024 09:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711A71487F6;
	Mon, 16 Sep 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ifszd/5b"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F195476B;
	Mon, 16 Sep 2024 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726477801; cv=none; b=WoC71f60Ctiar25nNcrwvaZlaIVBQ8JWBMzoLM0RTXPusplpHioQ3dekmneHXKG5hoaULEYFra5bS6pHwksBsOGi6k+kUntuvpCDxxvTle1Ssr3Spm0zTYUbifLQeQgCUjWKSpdYsfyo9qjPWKQUHZ3oMWypZgcOP+iajHDQI+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726477801; c=relaxed/simple;
	bh=ONqZl6C9+SC1X648huCoHAghc9uia2nzJ+bhJls5Sds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7Mj5IFBzwHODj1ETVLYSD084ZdkS9cYA7zTQ9Wp10CnbXi6ebhZZH3aVYQ1vC+7qecGor+9RwLFYX0o1b4M+i/I2Rio10nm1kjwvaIGYVSiDjvqZE4el2TZ1M9r+Vid2MDWVMvTXm370i48Vv6hZ8hbrPBaJrhBSzarEj1Ggpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ifszd/5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCDAC4CEC4;
	Mon, 16 Sep 2024 09:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726477800;
	bh=ONqZl6C9+SC1X648huCoHAghc9uia2nzJ+bhJls5Sds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ifszd/5bBzotwBrw9X54H47h4CDgIg0rfIXAvpXq43kD8mGl7Mee/Wbszn1Ce5o/H
	 D2fSN1NVAUS+hRqIiCiVT1Id+C/tjEQA4psHvyF5yUzdJkTi2RA+84xsqo5Sud2lR+
	 KTpQ8A5XbcHPEnetz+bXsjkgF+p+RjaoVVr3nwFcctFiUhmcgGeArtF4RS+bzcJ1fx
	 oAmRuYIh0zPK251BpzdomeAoM7GqINOltXYvAg5y/VxrLQfgKDan84ZQchnGn+SDff
	 kWgNgsolsrztSSM3BXj8zFZYasn7EE5Mj9gS3gp59szQ1P3HaGmHBXT+QuQoGHrbqs
	 Rhhdd6Jyidv8Q==
Date: Mon, 16 Sep 2024 11:09:57 +0200
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
Subject: Re: [PATCH v4 08/27] mfd: max77693: remove unused declarations
Message-ID: <wywp6vj2pqqe7to55k7ssh5sbqrmy7emvwruvm2waytancf3r4@aygtw3y6huwx>
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
 <20240913-starqltechn_integration_upstream-v4-8-2d2efd5c5877@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-8-2d2efd5c5877@gmail.com>

On Fri, Sep 13, 2024 at 06:07:51PM +0300, Dzmitry Sankouski wrote:
> Remove `enum max77693_irq_source` declaration because unused.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  include/linux/mfd/max77693-private.h | 11 -----------
>  1 file changed, 11 deletions(-)

Please split your patchset per subsystems. There is no dependency on MFD
bits from your DTS... (if there is, this needs to be fixed anyway)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


