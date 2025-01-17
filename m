Return-Path: <linux-pwm+bounces-4662-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99EFA153C3
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 17:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E681884CD7
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 16:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504131946C7;
	Fri, 17 Jan 2025 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkA5VQXf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8DE18A6A7;
	Fri, 17 Jan 2025 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130196; cv=none; b=lgjBL1ooClPp9gaHXQZmSBnTASSByPTouGqXcpL1yNDA+XN0PsLcuI7sXCXwxbEpzVoB+fil6ISsmMt06v8UiN4qR96iBjwUTiyctXc1g7Ikqy/39gcd+hYG9yghP38lle6EmfpdcBQJMTdjVRDjGpCxAZSOhsLeS8JTNNC/DG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130196; c=relaxed/simple;
	bh=8+oe36r/7b0uXAdnsmrE9v42xgT9MMO2a30/kQnki68=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Olt4MSAKIZSjCc4GISfitOupypzc3G6AXm9NkFCwNt1iDebwQdYjwrRYErDiEYHF/uJtFhOoNi/4mtM6cYVAHxTZyqyAbD5UgkjIFY8XrvCD+ibEfWeJKL1Lh24Ut4aukfRS5lUFow25e8JL85V6lqRBIt5kM3N4uESjsiDOxr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkA5VQXf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43626213fffso21007975e9.1;
        Fri, 17 Jan 2025 08:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737130193; x=1737734993; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G8CGu3q0+njkSiVYYyz5X1fPFgKI2oBJnPof+HyRok0=;
        b=YkA5VQXfrHedp9xPT3tPg0dVUsyq8T1jd1o4Cw3Ka18CPS4YPdoLe5tjlOdvzQIFml
         OX2IuTf+673FQM5oLtrJW0nh98Xe46+jQaUXq8B4jfFMr5BhiC1UACX2D7R7ALnqSFYP
         WBEZFeHzJoCcjkzoOn5sxdX99O6SN1kIOLtKVbQx/6/2ZrI2WbHlcBlU+WXwsFFsVi98
         OXD5sB2sdgvhlMMWccOfG2omTjPzCixItWzlqc8y08xve9YYGo7XZ82naaj0XyVdrFv9
         x8R2rsC5wo+DmZ9LW9cMhalWycsGp2lBeBz2xvbfYv6SNAY8VKxW39LWIELUCtUmRDrt
         OP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737130193; x=1737734993;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G8CGu3q0+njkSiVYYyz5X1fPFgKI2oBJnPof+HyRok0=;
        b=s12MDwhIYQWCatSowoq9voGH4Y19wR++t2o/RSndVv+x7gmnuPJPIR11Ma9s51pruc
         VFv0KVNKjGsonjyPcJS801xEUEzXDVmtSPZ8RmdVg0GGnEah12zNkraHzy+9NzrM9aQI
         bnKNxKFjYgF4khyEJUHrxo48IX6kH0I9qP+wvAsahBce2k3VVHToz5j8C9JZW3DoeK6e
         xZL6Nqs0/D7rDla+0Qk2Fivs8gUoiehaoa3lDtWa9IwvXcOgCacSkuiSistlRj/9Rxzy
         J5yE+KWrXMckFiouG/acBL2XVk+gQeVRlAswZmYq/KiWINXy/PP8laRavvehE1W0CP0W
         zMPg==
X-Forwarded-Encrypted: i=1; AJvYcCUIivTZYMgR9H6L1R9Luya4SxdyKJaFfqROVYNSWNdeTCwbvZkVPN9CvTSSfQB8prt5ubokZGafoFNaQIie@vger.kernel.org, AJvYcCV3goxn+zmJmN4nUtMro4Ai4M0vgtRTQLXvTIQEXav/rimZiXSJcmqJoYpm4wwx7y+TAeqYqaZy8DZ5@vger.kernel.org, AJvYcCVsLhvJK/8PJw8zduPioHWTlZxzGNTk3iKm7moDmq5CBEXrUVrc/EZRXqr9W5yKmkwWcEY5pokMvQTV@vger.kernel.org, AJvYcCXjHXx4NjNtLZHidhnsgTuMlUqQaxtR1YsCdAy4zq1Lz+qNwTpD09yPX+0JVIP5uESF7bF4VYURQT6z@vger.kernel.org
X-Gm-Message-State: AOJu0YzN46FA7v7NjZ1g6RD26WubJ1dB5OU81OOm38B/CjO/1piVETvB
	0ugG5u7GfFdtr4YB+gGHNdWp6D8fENQhVImq2Pe2GjUimcgvRdPt
X-Gm-Gg: ASbGncsanBBlZoIlyF2oHHbmuGw2Z3ZSpwT4Z4GXieIs8VJ10/JL5AtcLYE89o/9c8r
	rbLFWjlidGN3n1QTZ4krTfq7rZBQLliW6ToKggUUgT9ibmOoTJzz6TKIqs3Q5JxzkVtVS6nnMo+
	YWTQW/n8+uv8O96CH2f5w1WX1OHQGDo3XkmBm3DiToUHp1VaL/ZcYUvArSDa9ucP4X3SRJim/19
	GAg7b07dgX6G7UQIhg8NeAA7oIJzdkQtJDdDTet7m9fbJfsVj2uMU1MYk/3X0FHLn8OwLu6FiLA
	9qCHFkyEzHjdwugtkpUeFFBO8QwT
X-Google-Smtp-Source: AGHT+IFyXvW9hGKdI8n+4snN7GPo2Y12Er8HLPvZrm7TDXLjJI3WDHTKlcPmAdIoKn7asyhLVlQXCA==
X-Received: by 2002:a05:600c:698c:b0:434:f9ad:7222 with SMTP id 5b1f17b1804b1-438918d3bdcmr31474295e9.7.1737130192457;
        Fri, 17 Jan 2025 08:09:52 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7499932sm97813125e9.7.2025.01.17.08.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:09:52 -0800 (PST)
Message-ID: <94461f6e33b25427495b59b133377a0269d73b29.camel@gmail.com>
Subject: Re: [PATCH v10 2/8] iio: backend: add support for data size set
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>
Date: Fri, 17 Jan 2025 16:09:52 +0000
In-Reply-To: <20250117130702.22588-3-antoniu.miclaus@analog.com>
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
	 <20250117130702.22588-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-17 at 15:06 +0200, Antoniu Miclaus wrote:
> Add backend support for setting the data size used.
> This setting can be adjusted within the IP cores interfacing devices.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> no changes in v10.
> =C2=A0drivers/iio/industrialio-backend.c | 21 +++++++++++++++++++++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 3 +++
> =C2=A02 files changed, 24 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index 8bf3d570da1b..2088afa7a55c 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -660,6 +660,27 @@ int iio_backend_interface_type_get(struct iio_backen=
d
> *back,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, "IIO_BACKEND")=
;
> =C2=A0
> +/**
> + * iio_backend_data_size_set - set the data width/size in the data bus.
> + * @back: Backend device
> + * @size: Size in bits
> + *
> + * Some frontend devices can dynamically control the word/data size on t=
he
> + * interface/data bus. Hence, the backend device needs to be aware of it=
 so
> + * data can be correctly transferred.
> + *
> + * Return:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_data_size_set(struct iio_backend *back, unsigned int siz=
e)
> +{
> +	if (!size)
> +		return -EINVAL;
> +
> +	return iio_backend_op_call(back, data_size_set, size);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, "IIO_BACKEND");
> +
> =C2=A0/**
> =C2=A0 * iio_backend_extend_chan_spec - Extend an IIO channel
> =C2=A0 * @back: Backend device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index a0ea6c29d7ba..9ae861a21472 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -95,6 +95,7 @@ enum iio_backend_interface_type {
> =C2=A0 * @ext_info_set: Extended info setter.
> =C2=A0 * @ext_info_get: Extended info getter.
> =C2=A0 * @interface_type_get: Interface type.
> + * @data_size_set: Data size.
> =C2=A0 * @read_raw: Read a channel attribute from a backend device
> =C2=A0 * @debugfs_print_chan_status: Print channel status into a buffer.
> =C2=A0 * @debugfs_reg_access: Read or write register value of backend.
> @@ -137,6 +138,7 @@ struct iio_backend_ops {
> =C2=A0			=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan, char *buf);
> =C2=A0	int (*interface_type_get)(struct iio_backend *back,
> =C2=A0				=C2=A0 enum iio_backend_interface_type *type);
> +	int (*data_size_set)(struct iio_backend *back, unsigned int size);
> =C2=A0	int (*read_raw)(struct iio_backend *back,
> =C2=A0			struct iio_chan_spec const *chan, int *val, int
> *val2,
> =C2=A0			long mask);
> @@ -197,6 +199,7 @@ ssize_t iio_backend_ext_info_get(struct iio_dev
> *indio_dev, uintptr_t private,
> =C2=A0				 const struct iio_chan_spec *chan, char
> *buf);
> =C2=A0int iio_backend_interface_type_get(struct iio_backend *back,
> =C2=A0				=C2=A0=C2=A0 enum iio_backend_interface_type *type);
> +int iio_backend_data_size_set(struct iio_backend *back, unsigned int siz=
e);
> =C2=A0int iio_backend_read_raw(struct iio_backend *back,
> =C2=A0			 struct iio_chan_spec const *chan, int *val, int
> *val2,
> =C2=A0			 long mask);


