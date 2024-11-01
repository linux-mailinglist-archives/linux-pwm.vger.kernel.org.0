Return-Path: <linux-pwm+bounces-4001-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3019B944E
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 16:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849CC1F24826
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0061C75F2;
	Fri,  1 Nov 2024 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhJj0DYE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762D41C0DD6;
	Fri,  1 Nov 2024 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474496; cv=none; b=hpaZuIiENNOMVCGNw3OtKToiZjiphX+HTgL/Nwg2QuicfGpFirLL2x5AePDOowk7v+9AjHl5xvn6TrdR3oEg/5jeUrLxtKwzXjQyLlv/YiZBjwkIF7QrX+ZHetcvQtKXWC54Qgru+mlXzWDclFNVKICvhPG3gXSAZzo/ClQ9sAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474496; c=relaxed/simple;
	bh=Z51TdSB5ihgzOjhRHjuOdOQEElBPvJ0Ajww02Qjzc80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1iBMPKPjZ0EJnJIHjYOTrQJsjx/tUeEJOpWj8QzfPfo5FsC9Zhev3r1iRsUbqPwshtxD5DsJHWkt1z4lDZ/JR+549e7YZohTsCF1xy8ZH205lMQnJLLmHinT4VJEHkvIyzSwgM0Xby26qUJa8G2fS5NiNZPWmiIw0oRZL41NKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhJj0DYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBA7C4CECD;
	Fri,  1 Nov 2024 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730474496;
	bh=Z51TdSB5ihgzOjhRHjuOdOQEElBPvJ0Ajww02Qjzc80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jhJj0DYE8D5WHUk8Iro/B8F4AFLf2sdoCE5ui6flPsheh2uM3QZvdwAptgY+va7kX
	 /ZoEZkPBMJjAJBkvmTi9DMD2QMOMFvcics35eQgNteORLnImx2d3Ds1RlhwPFfyNjN
	 DzNEpIn5dIIp+F77LUoGIaOdSeLHW2lLtm3vVsvdrASRpQEfFwtpS6ggwm3Iy/Zc2A
	 wTVThfLDpcuof0kQjQzpV7j11oc/UEDh/eNbgdb9zVRx2dQ3Hwr6YMyTD7FuFWdqxr
	 AOKJ6iTwbTYSVHBWeRIKltGFeJNyPNtJfKY9dK9iYNl0wVO84u0vPDTZaRwdtJj9cl
	 VLPfgd67S4xkw==
Date: Fri, 1 Nov 2024 15:21:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <conor+dt@kernel.org>, <dlechner@baylibre.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v5 6/6] iio: adc: ad4851: add ad485x driver
Message-ID: <20241101152129.4111408f@jic23-huawei>
In-Reply-To: <20241101112358.22996-7-antoniu.miclaus@analog.com>
References: <20241101112358.22996-1-antoniu.miclaus@analog.com>
	<20241101112358.22996-7-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 13:23:58 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Hi Antoniu.

I only took a very quick look and one thing jumped out at me.

Jonathan

> diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
> new file mode 100644
> index 000000000000..0ef8ea0d2fc2
> --- /dev/null
> +++ b/drivers/iio/adc/ad4851.c

> +
> +static int ad4851_set_calibscale(struct ad4851_state *st, int ch, int val,
> +				 int val2)
> +{
> +	u64 gain;
> +	u8 buf[0];

A zero size array?

> +	int ret;
> +
> +	if (val < 0 || val2 < 0)
> +		return -EINVAL;
> +
> +	gain = val * MICRO + val2;
> +	gain = DIV_U64_ROUND_CLOSEST(gain * 32768, MICRO);
> +
> +	put_unaligned_be16(gain, buf);
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_write(st->regmap, AD4851_REG_CHX_GAIN_MSB(ch),
> +			   buf[0]);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD4851_REG_CHX_GAIN_LSB(ch),
> +			    buf[1]);
> +}

