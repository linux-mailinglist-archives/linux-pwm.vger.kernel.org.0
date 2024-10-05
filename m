Return-Path: <linux-pwm+bounces-3488-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 470F7991661
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 13:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0844E284610
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 11:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F24D1494BB;
	Sat,  5 Oct 2024 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cz1HRMCf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503A2F9FE;
	Sat,  5 Oct 2024 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728127389; cv=none; b=Ih0ZryCkg77cshl6Kd+SdShGiGG6TNhiHZO5n8CWWoCPLcyJv0007poFYfYUQvEDz4T7SSdvIm334JYImdpMCW+i0nZNvyt+cHCsmzYWEzXUnN/O7kgM9D3HTsqW0utiPrPc72wVldK7tl4JrwEtwVFdXu6k3v266BHGl6obBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728127389; c=relaxed/simple;
	bh=y7Aaf1rQuGE513a/NM0g2Gq6NNV+R4sWwXFnKYDcQNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WewVCEAtPSVSZXghW7gEIxctw0QEudRR5shGJs6DX/ED5l+X4H2ZsDA8IZmOEDE056T+zwNrv/z3UGZeou7T3nSPOU/rZXTm3Fm6LzcCUihc3cn0JCh+NPIfeXqv2Hbt/YLsw5r/f30iapL6NfWzNCXIP0RLuEidOEUv/kflsjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cz1HRMCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEEAC4CEC2;
	Sat,  5 Oct 2024 11:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728127388;
	bh=y7Aaf1rQuGE513a/NM0g2Gq6NNV+R4sWwXFnKYDcQNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cz1HRMCfEc/mq3d5pUhgaspoeny3U/5waIHWOicqmTA55sDiC2DcJbnmjG4bjBUN+
	 08A73unQWs6YyJUVYtLG3bfJPAIzT3o3cuDMHtAJ4tIKUUxjfLP7l+zGt34bBHkQoc
	 nBpvTo8kgkaNP5Ve6coYyi5Y9QQ6y2kJ0h3BweOqbwUcaGS7EnuLdOmSBlNz+BLEto
	 NTGN/EfkY+L+7LeRCd5MLz/NA0L79lkE7Xt+xfL3g+FPpcUafK9+GkxkStmZJHxqFX
	 llvei+E67us7011iU7J1HLjla184pj/FikvtLErZwjGXcbngSFGalFdlTY34SqGZQf
	 WwG/gXq+z32+Q==
Date: Sat, 5 Oct 2024 12:22:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com, dlechner@baylibre.com, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 01/10] iio: adc: ad7606: Fix typo in the driver name
Message-ID: <20241005122257.77c2e582@jic23-huawei>
In-Reply-To: <20241004-ad7606_add_iio_backend_support-v3-1-38757012ce82@baylibre.com>
References: <20241004-ad7606_add_iio_backend_support-v3-0-38757012ce82@baylibre.com>
	<20241004-ad7606_add_iio_backend_support-v3-1-38757012ce82@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Oct 2024 21:48:35 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> The parallel driver's name is ad7606_par and not ad7606_parallel.
> 
> Fixes: 0046a46a8f93 ("staging/ad7606: Actually build the interface modules")
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
I'm going to nibble away at series where I can today because there
are more patches under revision than I'd like.
Merging subsets of series where there are simple ones like this makes
that a little easier to manage.

So applied this one to the togreg branch of iio.git and pushed out as
testing so 0-day can fail to notice it ;)

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 97ece1a4b7e3..4ab1a3092d88 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -229,7 +229,7 @@ config AD7606_IFACE_PARALLEL
>  	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
>  
>  	  To compile this driver as a module, choose M here: the
> -	  module will be called ad7606_parallel.
> +	  module will be called ad7606_par.
>  
>  config AD7606_IFACE_SPI
>  	tristate "Analog Devices AD7606 ADC driver with spi interface support"
> 


