Return-Path: <linux-pwm+bounces-4136-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A109D7699
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 18:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20842839A1
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 17:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05C753365;
	Sun, 24 Nov 2024 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2it6MTE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872BB2500C9;
	Sun, 24 Nov 2024 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732469084; cv=none; b=E3GyKPymsp971ZMlzRzm+qYE6sSiiFZp7nf+cAKKPd49lz//1Fa2C0yL0yf0zVLErVo/jnuugyJ6zRuXxwxUrqRFThVWp9FYbcBnMrDecUN1dHXCVQ2NZBj/2FkPfbUmJXeYsorJr+y/eFoGDedHEwnPhTeENBo55lsrlDTH6ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732469084; c=relaxed/simple;
	bh=gBS9Xb9J9aUTspgdk8YKdUceNEXMi87MEJY9qeNPAok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqt0Oov4uukaWPdnEmCfq5n5nHGt7vt62KM3gYzzkiEe0qF09KoqSIIYCiXgPa43w9kRelVrYCoAiaBWnyaYnzMksJtKAXkQg/Cz+oV7GTCjobOAuj0hf2DmOfHKMaxVdapc7kPuP9tSkzEQIyPC3FYieORRhsFoobGTrp+WZ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2it6MTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E091C4CECC;
	Sun, 24 Nov 2024 17:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732469084;
	bh=gBS9Xb9J9aUTspgdk8YKdUceNEXMi87MEJY9qeNPAok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T2it6MTEWkKftEs8ueslPHX9WP2/Vz5Aas4YWxOyRhB1xfRm5cU1jZunQz5PDCbBa
	 /FqN4dbzriaKVB6HQwxsLAtLKoIWdPzRues6FXvEckJicaktWHVXyyNg4NN8jj5erf
	 ItVpUhT0FCDxzhubVPTBtrWWDC9EBjws4xpsiFsoEfVYck04uu9nCw+aScEEvXO8XY
	 qmmrad3EnGkrqZcC3j/e8LWfY6wOQYyHjZeFTA5jjicaXptQaC9R72FXTxYWOKF0C1
	 BKmyEAykZqT2gM24uMcxXNpz2OQtbuQZwLkMRG6XSX/9tE8EV7YRWVpbEbUqqM/LP7
	 pZoi4OxzUyp1Q==
Date: Sun, 24 Nov 2024 17:24:33 +0000
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
Subject: Re: [PATCH v5 12/16] iio: adc: ad7944: add support for SPI offload
Message-ID: <20241124172433.78079a9c@jic23-huawei>
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-12-bea815bd5ea5@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
	<20241115-dlech-mainline-spi-engine-offload-2-v5-12-bea815bd5ea5@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 14:18:51 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This adds support for SPI offload to the ad7944 driver. This allows
> reading data at the max sample rate of 2.5 MSPS.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
One request for some documentation on the storagebits value.

Otherwise looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Note I'm giving tags because it might not all go through my tree +
it's big and complex so they have the advantage I won't read things
again if I've already tagged them (probably!)

Jonathan


> @@ -129,13 +144,33 @@ static const struct ad7944_chip_info _name##_chip_info = {		\
>  		},							\
>  		IIO_CHAN_SOFT_TIMESTAMP(1),				\
>  	},								\
> +	/* basically the same minus soft timestamp plus sampling freq */\
> +	.offload_channels = {						\
> +		{							\
> +			.type = IIO_VOLTAGE,				\
> +			.indexed = 1,					\
> +			.differential = _diff,				\
> +			.channel = 0,					\
> +			.channel2 = _diff ? 1 : 0,			\
> +			.scan_index = 0,				\
> +			.scan_type.sign = _diff ? 's' : 'u',		\
> +			.scan_type.realbits = _bits,			\
> +			.scan_type.storagebits = 32,			\

Add a comment somewhere here on why it jumps up to 32 bits.

> +			.scan_type.endianness = IIO_CPU,		\
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	\
> +					| BIT(IIO_CHAN_INFO_SCALE)	\
> +					| BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +			.info_mask_separate_available =			\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +		},							\
> +	},								\
>  }



