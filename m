Return-Path: <linux-pwm+bounces-3395-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D868698957A
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 14:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9966E28287F
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 12:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA170179965;
	Sun, 29 Sep 2024 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0EPkk7E"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716F813D628;
	Sun, 29 Sep 2024 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727613892; cv=none; b=Xzkx6433WX8ECndk1xgltd9/hdti/4xqKCu71ncCOaTpSJL1sCjPPSfUza7jfaW1MkNUJslpw/QfHDNx0QqjGvp7dxRAs2qF5IOQv/otBJpai0WAF8vBcgPtpcuzjXaQabkNrl1xoEwuPNnlHximNZMPEN4nkIuK61AY9H8rz2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727613892; c=relaxed/simple;
	bh=/Vd02km65HADm+GCiWzpnfqbP1Xky3sU68iAwyTdjA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPDivdQDOO+1pEB0VXTLSn2sSwK7HteGFA/nHBX8NTPZ9wEo+Md0GFMggf1kwftHs2nWoMcRXG2ey47BAAp+EkgDMvVFZvgxQ2Q/Dx5/pXgMX87cLNTHRDRK2lbChv/K3l4Iw0mSpFEfg6h4LOCS9FnIobet/Da608WolxdJNsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0EPkk7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC04EC4CEC5;
	Sun, 29 Sep 2024 12:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727613892;
	bh=/Vd02km65HADm+GCiWzpnfqbP1Xky3sU68iAwyTdjA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r0EPkk7EzVtSu8yFJvKifWaQ8bEMwkVF4VKwtrLUQ7h35+RDyeLTiVxvXEli+F3C+
	 GdybcB1fv6GfBjjazKx9FA3cdG7rFgaWRrgc23opaAXw4rEJm7v0r6fS66wmwfyb+s
	 MzvfNGF0RGmRPjGkLyrfZof8Zmnm7Pra9YjDloF8E6boQWWyXWiTuXyhM4rs9WDXD0
	 CDFkOGf23q9tXIJEXeKM05ZNAbQ91VIsyPY+VpPVV8J5AW5VrbrUD3Coes1FFNQEkN
	 IxMIwlf+a4KZ7wj2gMW4j8AnTJD6cC0YMZg0G+v34qlGVhbEOIiBjb3LSVrWZWk399
	 mYwA4nNq6rhZQ==
Date: Sun, 29 Sep 2024 13:44:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Michal Marek
 <mmarek@suse.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com
Subject: Re: [PATCH v2 08/10] iio: adc: ad7606: Fix typo in the driver name
Message-ID: <20240929134439.3d1d57ab@jic23-huawei>
In-Reply-To: <20240920-ad7606_add_iio_backend_support-v2-8-0e78782ae7d0@baylibre.com>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
	<20240920-ad7606_add_iio_backend_support-v2-8-0e78782ae7d0@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Sep 2024 17:33:28 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> The parallel driver's name is ad7606_par and not ad7606_parallel.
> 
> Fixes: 0046a46a8f93 ("staging/ad7606: Actually build the interface modules")

No blank line here and drag this to start of patch set.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
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


