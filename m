Return-Path: <linux-pwm+bounces-4131-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A369D7610
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 17:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB7F28246C
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 16:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB55918A92C;
	Sun, 24 Nov 2024 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qw38TOIO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FC918A6C5;
	Sun, 24 Nov 2024 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732466677; cv=none; b=avEUV99iYpksR0YM0dakTeNzoeRe0oPvrVBUDwRzFmsh4msJUBm6pteYFR4rKk6ib6R0pZwuAFLd4AWWtnxJCi3wJvaH8UVxGfJTy5nd0c6w/hqXgt3+uW3gkZW+190iNqrPSvzaRGlTufo/jy3J2IMiUhHzrbXR1iQXqkx375Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732466677; c=relaxed/simple;
	bh=xVMYbpcLjtnlstFSdSWP+o+OFpVkdd5lSpsHXHUP5qU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAcnZ/oufmGfK+nA+/4feOYz46ooW/U8NFtkcCbc8woEzTKlg5x6mCO0Ue56PwDhBL/F7mxd0zA5L42NGae4IxjoljrwZ/3nhB/nqiHXQAY4Ra3YYb6UzrfmgcHSEvsRSPemLb0VJvJIFA56zb2Pw8z6sUsw6bvHHz0Ry5FZhdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qw38TOIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E9FC4CECC;
	Sun, 24 Nov 2024 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732466677;
	bh=xVMYbpcLjtnlstFSdSWP+o+OFpVkdd5lSpsHXHUP5qU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qw38TOIOYPRWPkIDLjnGuUAMSdDQUv/n7j8fE08CGQQmxUUBgjsC/b7x2Lg3FTUJZ
	 JsG0nchgFDc1joPIOJ+j3VkiCcQi3HC1fc4i+7m4qbv9b5VhIMkRdOQPnvGXkg6m34
	 6qABwt9sW8B7saqP5iAYmsSG8P6hM9BnS6R/ejJ3uu2KLE6AGLyEkCTdvdXmGHDVju
	 8or4g/BazkesFBfylfH9CU1VA5JI4NoVJnybCrvCSEvcY7KZSKP8xwY7wOAj5XO+/W
	 JawoSxAhk0TDX9lwuuWTyYwIlI96KP1DIFt4Swef2awAhCJsBtZKoDcVgwjdtdfQKk
	 wcvs35nu7cV6g==
Date: Sun, 24 Nov 2024 16:44:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 05/16] spi: offload-trigger: add PWM trigger driver
Message-ID: <20241124164427.6e787b2b@jic23-huawei>
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-5-bea815bd5ea5@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
	<20241115-dlech-mainline-spi-engine-offload-2-v5-5-bea815bd5ea5@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 14:18:44 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Add a new driver for a generic PWM trigger for SPI offloads.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Trivial thing to tidy up mentioned below.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> +static int spi_offload_trigger_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct spi_offload_trigger_info info = {
> +		.fwnode = dev_fwnode(dev),
> +		.ops = &spi_offload_trigger_pwm_ops,
> +	};
> +	struct spi_offload_trigger_pwm_state *st;
> +	struct pwm_state state;
> +	int ret;
> +
> +	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
use dev.

> +	if (!st)
> +		return -ENOMEM;
> +
> +	info.priv = st;
> +	st->dev = dev;
> +
> +	st->pwm = devm_pwm_get(&pdev->dev, NULL);
use dev.

> +	if (IS_ERR(st->pwm))
> +		return dev_err_probe(dev, PTR_ERR(st->pwm), "failed to get PWM\n");
> +
> +	/* init with duty_cycle = 0, output enabled to ensure trigger off */
> +	pwm_init_state(st->pwm, &state);
> +	state.enabled = true;
> +
> +	ret = pwm_apply_might_sleep(st->pwm, &state);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to apply PWM state\n");
> +
> +	ret = devm_add_action_or_reset(dev, spi_offload_trigger_pwm_release, st->pwm);
> +	if (ret)
> +		return ret;
> +
> +	return devm_spi_offload_trigger_register(dev, &info);
> +}

