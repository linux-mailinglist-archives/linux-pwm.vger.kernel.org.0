Return-Path: <linux-pwm+bounces-3386-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD639890CC
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Sep 2024 19:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D5C8B21E81
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Sep 2024 17:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D28713E41D;
	Sat, 28 Sep 2024 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMpImFzb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C1B1531CB;
	Sat, 28 Sep 2024 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727544311; cv=none; b=AE1/5u7q0WCqiM+frd8aDD3zHrKiRx1iLxONehhLSpOzACGJERUEf1w+iV6Syh7VQVA2/TaGvHQN/duX92OGhBSr7ce9mDwUBNZfVJyXjeGRaahApZbp71xOOr9DjW89QWM+msJSguMbZ5USd/Yc81J3Eb0Vh8C4dwVM2nVLGs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727544311; c=relaxed/simple;
	bh=IjPaXoJUOuxQfoMfc1RuNS6iFJFev3/P85f58SkSDfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOStcs9odeBBVOuN+7AKPjcUtlULsuwb2GckN4WrKus4XS+sJxx57e6z5GpSWPBzY1KKXLyXvAWrCHpHUfiDGJ/dOha+zQlAVbitbNjpaWh8lNAa8h4gUHdY4eNtZ6IH0M2fnE1iVTVXjn1Ki2Yv8tOrgivjqLcMItwQMZzxh9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMpImFzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7DFC4CEC3;
	Sat, 28 Sep 2024 17:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727544310;
	bh=IjPaXoJUOuxQfoMfc1RuNS6iFJFev3/P85f58SkSDfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tMpImFzbe1/6Ar934ecy2fJYGP8CijrwbhOZBbXYCMBvbvGxDv9I/LfK/NROqQ6Hz
	 dNJH2w/1Fb1nPOuCDdGTbFlbQ30Fljk4io8D1H2VaqEObUZJKBNqQHCPNdAHh2/FN8
	 4If3GIX0FYf8zc48i7qkWpKH3faaVH9ux6mqTj/E4qYyNPyoKwxLs/5mo50e5d9KRe
	 2yqUNV0RPOnYw7YIkXHgoaWS1xxPIVWKEzQx65qmAhAITkAmEQ1OeQGN6SKfT1o0rx
	 HUhIHz3FgwdcHRVTSSzcRewE5FBCGXqS386J/jDb2rOqgkTtCcYyxaEtfaUjN2Fgxs
	 5NmaccmrWMXJA==
Date: Sat, 28 Sep 2024 18:24:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29u?=
 =?UTF-8?B?w6dhbHZlcw==?= <joao.goncalves@toradex.com>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, Marius Cristea <marius.cristea@microchip.com>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>, Dragos Bogdan
 <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 2/7] iio: backend: add support for data size set
Message-ID: <20240928182457.5919be0d@jic23-huawei>
In-Reply-To: <20240923101206.3753-3-antoniu.miclaus@analog.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
	<20240923101206.3753-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Sep 2024 13:10:19 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add backend support for setting the data size used.

Say 'why' a device might do this.  I assume in general
it's because you haven't wired all the pins, but is there a
reason it might be dynamic?

Jonathan

> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/industrialio-backend.c | 21 +++++++++++++++++++++
>  include/linux/iio/backend.h        |  3 +++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index 53ab6bc86a50..a6a6bedce7f1 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -473,6 +473,27 @@ int iio_backend_interface_type_get(struct iio_backend *back,
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, IIO_BACKEND);
>  
> +/**
> + * iio_backend_data_size_set - set the data width/size in the data bus.
> + * @back: Backend device
> + * @size: Size in bits
> + *
> + * Some frontend devices can dynamically control the word/data size on the
> + * interface/data bus. Hence, the backend device needs to be aware of it so
> + * data can be correctly transferred.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +ssize_t iio_backend_data_size_set(struct iio_backend *back, ssize_t size)
> +{
> +	if (!size)
> +		return -EINVAL;
> +
> +	return iio_backend_op_call(back, data_size_set, size);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, IIO_BACKEND);
> +
>  /**
>   * iio_backend_extend_chan_spec - Extend an IIO channel
>   * @indio_dev: IIO device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index ba8ad30ac9ba..85b33ed69cc0 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -87,6 +87,7 @@ enum iio_backend_interface_type {
>   * @ext_info_set: Extended info setter.
>   * @ext_info_get: Extended info getter.
>   * @interface_type_get: Interface type.
> + * @data_size_set: Data size.
>   **/
>  struct iio_backend_ops {
>  	int (*enable)(struct iio_backend *back);
> @@ -121,6 +122,7 @@ struct iio_backend_ops {
>  			    const struct iio_chan_spec *chan, char *buf);
>  	int (*interface_type_get)(struct iio_backend *back,
>  				  enum iio_backend_interface_type *type);
> +	int (*data_size_set)(struct iio_backend *back, ssize_t size);
>  };
>  
>  int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
> @@ -152,6 +154,7 @@ ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
>  
>  int iio_backend_interface_type_get(struct iio_backend *back,
>  				   enum iio_backend_interface_type *type);
> +ssize_t iio_backend_data_size_set(struct iio_backend *back, ssize_t size);
>  int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
>  				 struct iio_backend *back,
>  				 struct iio_chan_spec *chan);


