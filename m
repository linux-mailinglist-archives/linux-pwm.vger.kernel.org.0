Return-Path: <linux-pwm+bounces-4453-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27D9FADC0
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 12:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74C407A1D44
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 11:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897FA19F12A;
	Mon, 23 Dec 2024 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0pEJG6+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253D19DF47;
	Mon, 23 Dec 2024 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734953632; cv=none; b=H8h4H/E90XxV4ilr/r9vqJZeGe28Ez2nu0GZQDe3n/VCd4dnhbH48thM3d6qehQlg0MQbIgJ2n9dTQMwV3FeQVhlHpQktn0+8O9ujWpmFNpYzhPkvBC3DHOo0xRJ+u3VCldcHTnAwxTk/C9xtx72ky5UYuWYlGGfA/lovkGdMvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734953632; c=relaxed/simple;
	bh=WK5VWsfSnLRBRR1t/8Tc94+mIVNbie2E8mxtM+eYNk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHN2KEvmozr2tYlBWWsU8LpOnb+eE8xr41EF0QuP+iTpvXTG0ijIo026eP5sthcmMFmy/1Tli3evkYu8/EtHKrO/XnCq9L1weQF5Wd5gtOmClL3st2kluxIdv2gC9h1pHFIql1cBzzyfs6zAl6vnCcP8oittFphSFVSs8knoC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0pEJG6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B89C4CED3;
	Mon, 23 Dec 2024 11:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734953631;
	bh=WK5VWsfSnLRBRR1t/8Tc94+mIVNbie2E8mxtM+eYNk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J0pEJG6+DiUNui1GrnMJDTEE4ON2zFPFw1lbWSXc7DFaXhDpQZ/zR/3Yn1i9AKcD3
	 VdHiOBskZ3GpfHKGB5lBsS7AE9OoG1ciTindTBi5LQ3k0H+1uFMiJ1m//hhnSds0yW
	 d6JS3BCx6qjtn4KwkgpUrLwGrGwbGYy8h9NvoNOdc6StdhtejcdtybCZnthLegwmL+
	 DK/g9v0xEBYou8nXCoIkgbw6HGu0JptjvECQpSekNgVjDDUXlbSyapJBVBKDRPVd0H
	 RuvqoRg/PjGOwRuyWXSusbtHmw57rPx5krUOsPJpiY3xvpcxs/57OtI2SLt1s81RD7
	 /bP1jzMrXfbTQ==
Date: Mon, 23 Dec 2024 11:33:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v9 1/8] iio: backend: add API for interface get
Message-ID: <20241223113343.6fb631c9@jic23-huawei>
In-Reply-To: <20241220120134.42760-1-antoniu.miclaus@analog.com>
References: <20241220120134.42760-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 14:01:27 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add backend support for obtaining the interface type used.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Hi Antoniu,

There was a specific request in v8 reviews for a cover letter with
reasoning for some of the recent changes.  I'm not seeing that so
perhaps just reply with a cover letter type email to this first patch.

Given David's done some good review of this I'll be waiting for
his replies anyway before considering pick it up and perhaps such
an email will answer some questions before they are asked!

FWIW, this patch is fine, I'm just replying here as no cover letter
to reply to!

Jonathan

> ---
> changes in v9:
>  - rebase on iio/testing and use quotes for IIO_BACKEND
>  drivers/iio/industrialio-backend.c | 24 ++++++++++++++++++++++++
>  include/linux/iio/backend.h        | 11 +++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index 363281272035..8bf3d570da1b 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -636,6 +636,30 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, "IIO_BACKEND");
>  
> +/**
> + * iio_backend_interface_type_get - get the interface type used.
> + * @back: Backend device
> + * @type: Interface type
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_interface_type_get(struct iio_backend *back,
> +				   enum iio_backend_interface_type *type)
> +{
> +	int ret;
> +
> +	ret = iio_backend_op_call(back, interface_type_get, type);
> +	if (ret)
> +		return ret;
> +
> +	if (*type >= IIO_BACKEND_INTERFACE_MAX)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, "IIO_BACKEND");
> +
>  /**
>   * iio_backend_extend_chan_spec - Extend an IIO channel
>   * @back: Backend device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 10be00f3b120..a0ea6c29d7ba 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -70,6 +70,12 @@ enum iio_backend_sample_trigger {
>  	IIO_BACKEND_SAMPLE_TRIGGER_MAX
>  };
>  
> +enum iio_backend_interface_type {
> +	IIO_BACKEND_INTERFACE_SERIAL_LVDS,
> +	IIO_BACKEND_INTERFACE_SERIAL_CMOS,
> +	IIO_BACKEND_INTERFACE_MAX
> +};
> +
>  /**
>   * struct iio_backend_ops - operations structure for an iio_backend
>   * @enable: Enable backend.
> @@ -88,6 +94,7 @@ enum iio_backend_sample_trigger {
>   * @extend_chan_spec: Extend an IIO channel.
>   * @ext_info_set: Extended info setter.
>   * @ext_info_get: Extended info getter.
> + * @interface_type_get: Interface type.
>   * @read_raw: Read a channel attribute from a backend device
>   * @debugfs_print_chan_status: Print channel status into a buffer.
>   * @debugfs_reg_access: Read or write register value of backend.
> @@ -128,6 +135,8 @@ struct iio_backend_ops {
>  			    const char *buf, size_t len);
>  	int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
>  			    const struct iio_chan_spec *chan, char *buf);
> +	int (*interface_type_get)(struct iio_backend *back,
> +				  enum iio_backend_interface_type *type);
>  	int (*read_raw)(struct iio_backend *back,
>  			struct iio_chan_spec const *chan, int *val, int *val2,
>  			long mask);
> @@ -186,6 +195,8 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
>  				 const char *buf, size_t len);
>  ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
>  				 const struct iio_chan_spec *chan, char *buf);
> +int iio_backend_interface_type_get(struct iio_backend *back,
> +				   enum iio_backend_interface_type *type);
>  int iio_backend_read_raw(struct iio_backend *back,
>  			 struct iio_chan_spec const *chan, int *val, int *val2,
>  			 long mask);


