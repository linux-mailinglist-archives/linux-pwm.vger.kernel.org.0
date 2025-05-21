Return-Path: <linux-pwm+bounces-6040-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A700ABF104
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 12:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 297257AA340
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 10:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168CB253F3A;
	Wed, 21 May 2025 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTMREkfT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B0F253946;
	Wed, 21 May 2025 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822211; cv=none; b=o8clj6uzxY6qhYc48vZgUG3CIjO1xUwfhNHpAYieyU/xVfRjSfRuXPx+kqSBE0bBFxs4AHpvyxg2P6cs+hLyQ1UyhIdnUa085xL0N8TajPb/AzVYjKZVgHIFnyKQTYmKZIEOTFjO4Rnpyh7tY5FJwAKtg3NtyPfjxaf3as4jSh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822211; c=relaxed/simple;
	bh=swnBOTBW5kgGvMn+NskR73AMAOrDSaeB0gWqSlNKv0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYuo19cDegWeJ97MHaZcdd8U1VulaTuXCv8MuPBdPrxTj7zu2yDOvAmv/UDmIx+phHERmIUM1REzrLm8Ea59DuNdxzo76CDAy/Wx7XxKjhsvM+zzV66RPZqjMQtncI/OQZyH5CInBay8b0cDmGnPO5Xrr0Q7QzXO0Zf5bmbRopM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTMREkfT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2DEC4CEE4;
	Wed, 21 May 2025 10:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747822209;
	bh=swnBOTBW5kgGvMn+NskR73AMAOrDSaeB0gWqSlNKv0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oTMREkfTQOsHFui2XykL0jzMk1dCllCjt/RVy22+sSQT3JQy9St3jU5oWBXDWXmvC
	 XTiXHEB9BlWcOyYQalfHFRZ/CT2jeyBzQYpND4N/cNRQIqt4qEm8qgHp5mWjMMdi36
	 pjMuWxItudzD1L+qa9GAW9MutGmC/36SsrA0UrnknSTvVSHaMp28YZ4E7zQ/Q0as1c
	 BbC+VspzpcXCNP8ZjUBV4/vKDV8Ga69SNb/uN0AJXWDtg6fyLVJFd8BIRQvbdEPiT8
	 LMUufE1mYxwfmsx6cEkXN3lF2E2KojpMMPen9Rw0DaRH9ZNE+mD1s7NWUh5kL6hn14
	 But+2YoQkXUyA==
Date: Wed, 21 May 2025 12:10:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pwm: axi-pwmgen: add support for external clock
Message-ID: <20250521-nostalgic-pretty-hedgehog-d08a77@kuoka>
References: <20250520-pwm-axi-pwmgen-add-external-clock-v1-0-6cd63cc001c8@baylibre.com>
 <20250520-pwm-axi-pwmgen-add-external-clock-v1-3-6cd63cc001c8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250520-pwm-axi-pwmgen-add-external-clock-v1-3-6cd63cc001c8@baylibre.com>

On Tue, May 20, 2025 at 04:00:46PM GMT, David Lechner wrote:
> Add support for external clock to the AXI PWM generator driver.
> 
> In most cases, there is a separate external clock that drives the PWM
> output separate from the peripheral clock. This allows enabling both
> clocks.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/pwm/pwm-axi-pwmgen.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> index 4337c8f5acf055fc87dc134f2a70b99b0cb5ede6..67992a7561ec0440b1c1fa327f844a0602872771 100644
> --- a/drivers/pwm/pwm-axi-pwmgen.c
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -280,9 +280,26 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
>  	ddata = pwmchip_get_drvdata(chip);
>  	ddata->regmap = regmap;
>  
> -	clk = devm_clk_get_enabled(dev, NULL);
> -	if (IS_ERR(clk))
> -		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
> +	/* When clock-names is present, there is a separate ext clock. */
> +	if (device_property_present(dev, "clock-names")) {

No. List is ordered, you do not need such dance at all.

> +		struct clk *axi_clk;
> +
> +		axi_clk = devm_clk_get_enabled(dev, "axi");
> +		if (IS_ERR(axi_clk))
> +			return dev_err_probe(dev, PTR_ERR(axi_clk),
> +					     "failed to get axi clock\n");
> +
> +		clk = devm_clk_get_enabled(dev, "ext");

So that's messing the order, which confirms my question from the
binding.

No. List has a strict order, you cannot change it just because you want
to add optional clock.

Best regards,
Krzysztof


