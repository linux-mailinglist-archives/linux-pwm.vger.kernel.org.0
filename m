Return-Path: <linux-pwm+bounces-5723-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA86A9DBED
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Apr 2025 17:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04A94A276C
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Apr 2025 15:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666A25D1F0;
	Sat, 26 Apr 2025 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkJx5L1P"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72512E7F;
	Sat, 26 Apr 2025 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745682334; cv=none; b=Aq0VOFnj5sWLgWUQbDJy4VNhc42LqoWVjWLszS07gvM54Jweim4jK9d0cUbfQv1p0KLflTAUql7WWhqs+1A4u52g6mv5vuSj/OVF6GIZIOhce7NNsLfqXR+LsIKc6V3AjAkeD6kKo/u2M7lrGa5Kx19OPmXSwrF79yD/dKtxe8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745682334; c=relaxed/simple;
	bh=oJgRJQeAarDSih5pb3xmukdeVC4ZewQLObQrPLvqIX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvoWACFCHqOR6u66XiSkGaUycm10dT8kYRlGhAha12mxviNvMqXYkUwxyfSU9oFIq6MWuY1B9X6tQnKAJQJKosW3cvc42oeCGApN6mLLgvU6EtgTnYl+igcvRIBsVyZKsXAxOLHKMg2ZLlIVXnaixfmcwLK6LSFEUwpfj2czViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkJx5L1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D244FC4CEE2;
	Sat, 26 Apr 2025 15:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745682333;
	bh=oJgRJQeAarDSih5pb3xmukdeVC4ZewQLObQrPLvqIX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IkJx5L1P0ovu3NDMEJG+/TJJUt9APv+2cRlbNN8U+dBaB5oKVoFSIPvAZvf1O3AEk
	 wxoFbELvwfwvlGH9P+2XjjwYkPNLyBAVc07QYdT366dpQAD8a72TWIIn4LWHIvlY51
	 IVT17lsP5ZOGzDJmp5S0vDhc4NJTHJTvl0mTrxj+30BC9ZZ4UdaN2iFR3diDNMUA/K
	 srD2IILmNdlsetXVKrXxe08LrfRnjFL9neYFAgzgpD/0CaadnnSSN8OkdTlpKaSZVU
	 ZFjs/Jv2KXb93E+ABIMpOfhaO6fzBsUH6fAWHo4w0Iwhqi81y051CrKGRiQZFsu0D7
	 2rTNGCLzuXBZQ==
Date: Sat, 26 Apr 2025 16:45:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] iio: code: mark iio_dev as const in
 iio_buffer_enabled
Message-ID: <20250426164524.166ce3c8@jic23-huawei>
In-Reply-To: <20250422-iio-driver-ad4052-v2-2-638af47e9eb3@analog.com>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
	<20250422-iio-driver-ad4052-v2-2-638af47e9eb3@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 13:34:47 +0200
Jorge Marques <jorge.marques@analog.com> wrote:

> The iio_dev struct is never modified inside the method, mark it as
> const.
> This allows to be called from get_current_scan_type, and is useful
> when the scan_type depends on the buffer state.
Now I'm confused.   scan type is only relevant when the buffer is enabled
so how can it change as a result of that action?

Maybe all will become clear in later patches!

Jonathan

> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 2 +-
>  include/linux/iio/iio.h         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 178e99b111debc59a247fcc3a6037e429db3bebf..bc6a2ac6415eccf201e148ea98c0b5982787eb6d 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -212,7 +212,7 @@ EXPORT_SYMBOL_GPL(iio_device_id);
>   *
>   * Returns: True, if the buffer is enabled.
>   */
> -bool iio_buffer_enabled(struct iio_dev *indio_dev)
> +bool iio_buffer_enabled(const struct iio_dev *indio_dev)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 638cf2420fbd85cf2924d09d061df601d1d4bb2a..88569e1a888bde4d2bfb5b9f030096af1c15d68d 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -629,7 +629,7 @@ struct iio_dev {
>  
>  int iio_device_id(struct iio_dev *indio_dev);
>  int iio_device_get_current_mode(struct iio_dev *indio_dev);
> -bool iio_buffer_enabled(struct iio_dev *indio_dev);
> +bool iio_buffer_enabled(const struct iio_dev *indio_dev);
>  
>  const struct iio_chan_spec
>  *iio_find_channel_from_si(struct iio_dev *indio_dev, int si);
> 


