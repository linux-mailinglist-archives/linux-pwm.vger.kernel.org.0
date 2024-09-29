Return-Path: <linux-pwm+bounces-3396-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E48989588
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 14:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E5F1C20BF6
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 12:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13DA17A596;
	Sun, 29 Sep 2024 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtXBz0pW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E72B15FD16;
	Sun, 29 Sep 2024 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727614469; cv=none; b=ddFmw+wNfVW7ljJlQyDTSMqCxU/aJ9vmGO17SIZjMQwJSV8mJgDcZ2+DJv8dGOfaljEcS1yP9LE9txjlGhoXHcQltxkpeb1lJa1JVegW8a0+SVcur7HfNmEIA5TJ8A6CQF5wuCW2da+4o8qeNsPBp/aUp2UyMzzbmfpr6y4XbxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727614469; c=relaxed/simple;
	bh=lxWU+0g8zJ8Iiq7O21CFrF8NDKioM96RoNpjxez5/tI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMhZPP8glrPIr35ThDabvV7vM25nOOQeT1BQFleD7nkU34QrkqOd2Nf5AGm8GyGsj/F2pC0LNGjZvzFPwR7QDBV0lccrsX1OmWDVQ+8oxulukshPI5tc0wfwX6n2ZYGj8nkt1vU4MYOwlMv+BalFuRMRpR827Tv9FztpuoNKVM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtXBz0pW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFE0C4CEC5;
	Sun, 29 Sep 2024 12:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727614469;
	bh=lxWU+0g8zJ8Iiq7O21CFrF8NDKioM96RoNpjxez5/tI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RtXBz0pWx/qAcTDyaivenMTNOwy6SBOpqL+L4DqTZ64Bwg3n/YB0+QEyoUdRWclSF
	 thASznS1TASJ+8X6YDa0FsDK+U7kLVWu2hugbyKEEfMvlwr5c+7pUgyg35ta86pLF7
	 zOKBRM1Z4FOlufZaXp5Lp+nPCNRdyz8YHxGjCAxMmlFrj72N9HYJ+l6XCyCBB72xLJ
	 P6ubnm/l64++m27QP46Tix4bnRWYn2W2BG45WXlCtgDwpYynM67oVsmdUA+Pafqxw8
	 k1VBaaZy5AqKdxpqdEfVa9o+Vve7yAqmCPId4bF+4ST/1hnxqMBqNiTptXSaeE3qvB
	 xPq7DiOvQ+tbA==
Date: Sun, 29 Sep 2024 13:54:17 +0100
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
Subject: Re: [PATCH v2 09/10] iio: adc: ad7606: Add iio-backend support
Message-ID: <20240929135417.60d08f05@jic23-huawei>
In-Reply-To: <20240920-ad7606_add_iio_backend_support-v2-9-0e78782ae7d0@baylibre.com>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
	<20240920-ad7606_add_iio_backend_support-v2-9-0e78782ae7d0@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Sep 2024 17:33:29 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> - Basic support for iio backend.
> - Supports IIO_CHAN_INFO_SAMP_FREQ R/W.
> - Only hardware mode is available, and that IIO_CHAN_INFO_RAW is not
>   supported if iio-backend mode is selected.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
One trivial comment to add to what David covered.
I'm also curious now on what the limitation is that meant we didn't
support the AD7606B with parallel interface before, and what stops us
supporting other devices with the backend IP?  Is there a fundamental difference?
> ---
>  drivers/iio/adc/Kconfig      |  2 +
>  drivers/iio/adc/ad7606.c     | 94 +++++++++++++++++++++++++++++++++++++-------
>  drivers/iio/adc/ad7606.h     | 15 +++++++
>  drivers/iio/adc/ad7606_par.c | 91 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 187 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 4ab1a3092d88..9b52d5b2c592 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -224,9 +224,11 @@ config AD7606_IFACE_PARALLEL
>  	tristate "Analog Devices AD7606 ADC driver with parallel interface support"
>  	depends on HAS_IOPORT
>  	select AD7606
> +	select IIO_BACKEND
>  	help
>  	  Say yes here to build parallel interface support for Analog Devices:
>  	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
> +	  It also support iio_backended devices for AD7606B.

But not for other devices?  Is the expectation that they will need
a different IP for the backend, or just a case of not tested yet?


>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad7606_par.

> +
> +static int ad7606_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	/* The update scan mode is only for iio backend compatible drivers.
	/*
	 * The update...

> +	 * If the specific update_scan_mode is not defined in the bus ops,
> +	 * just do nothing and return 0.
> +	 */
> +	if (st->bops->update_scan_mode)
> +		return st->bops->update_scan_mode(indio_dev, scan_mask);
> +	else
> +		return 0;
> +}
> +

