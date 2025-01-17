Return-Path: <linux-pwm+bounces-4661-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D75A153BF
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 17:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCAB11883A56
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 16:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82062199249;
	Fri, 17 Jan 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAFidhgg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EDF13CA81;
	Fri, 17 Jan 2025 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130136; cv=none; b=UXELyu6JFAj3UCQYbeBS6iOofr09dx57JgaGAzoH6/9SeZd1ACyvyNuLokgRSWm0X0G5eTWuSG+H9PSjPKNxK7THTUMMy7P77lZlNziW+SzkmwOlQzJ9Hui35suExFblr+h2EUhJt+mXZd+IAkLL0HG1I466kHhrHJpy6PYKZSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130136; c=relaxed/simple;
	bh=iYXOI8LCTEd9k99Q7G9VnYpY0LsfofNyX43iB8U11c8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IEt/yX2hG/K/jdhmNdvkg+gD4W5J0LTCMEEIxoTAeVMNl5ubrDHxe3kPVPGqIAMvCnDClPy9KO+GT3jeTDESB4zAC+pm4T5eP/YCdgDNcdKdpz3h7zYWMdcpDhpedY1EbSM6H55RwJybW0lcVZdNejNV00g4Ayvfol4QIsyxdrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAFidhgg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43618283dedso22143985e9.3;
        Fri, 17 Jan 2025 08:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737130129; x=1737734929; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=suWVJuvyC59xxmWqpljFSKf02Mcdyv9U3eolhIWM1pM=;
        b=MAFidhggAeYNUNoNjFSFSpjMVts71QCezM8KHM7103zYprv2mrbG3M3VE2an9H8TU7
         96vC3NhJE+TxZivdtq95HQLrkK3cXdzbtKWj9Ro4vuxK/aVNNHh80KxSdabBiQrLV5tg
         6toHbbAD3C0s1YFlREXB7RfOVYVGhRt+5LjMuU6hMKRUxMOfiwgap/qwB9D45IpB0IoW
         mcvRw1JlQMcJ5MBWtk5069sAzztGLTq5mliVO5EajZyXh+WW54FS2gvSpg6bez5BpI7s
         VfHnHeAn0zBSpN0O4kOsrIPPiTF7LWWBDVYZTWPBx/UDDPzlf6xjSlbNu4VxLaPyxMvj
         Sr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737130129; x=1737734929;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=suWVJuvyC59xxmWqpljFSKf02Mcdyv9U3eolhIWM1pM=;
        b=M8nawXomTP1M1t/grSlFHCZrO174eQRzybMOCPLRJv/j4DZqqjEZ/50L391LE4CfSA
         Cf7Hq7AOhCtbv2x7Pc+9/TR795jsgpKBnfnWqB7NLIr2zmeRyogA4lCWi2lnHu9UekSc
         XGZiZp+l+gbYvpznMmU+u6MHTiVmU1uanSFPV76/+/a3cqRErBtQdHbhHRa5nFPN0ppx
         x2lcHi5N8vthK5W5cYFwTWVSQttV+vMbFrK0tpHGURubsDspqL27cFfzeW1qKjqhBJet
         j5WsgCwTsfti8eTAeBqFtQE6VbLedUnOXmxbDzNzpYiPG7WKSHNO1fFJIj0RmNi7Ao3Q
         n81A==
X-Forwarded-Encrypted: i=1; AJvYcCUw0zxMJWFiJF5pxVtUGLjdLk1yriFfAEn6XXx0XxvpqagRf+MRvesd/TKn/bv3eOTXYNWB+G2draPw@vger.kernel.org, AJvYcCVTgfhQzutU1lhDILBkrn80ZuSYSmD/WEn4OW9lLWY5uqeIVAhoEroFCUjGSANrWI777Yg1RT8K9m4w@vger.kernel.org, AJvYcCVdj3dRch+TsFGlvgpFkWcSuJUq0LpkB9F1VkfUYTIgvLzM5rV7oQ5evyngRCTzOIz+K3k7VbgvUTub@vger.kernel.org, AJvYcCVoqZMezkpSarVISrQoWTF4E9rR2wJpk9VM9b9yKKHfGLtA8Qr6bcK8ejSSY+6FPGJmHQKAv4ZvKmRLkmra@vger.kernel.org
X-Gm-Message-State: AOJu0YzBWCBLt+XXNFgliNJoT9W+5550kUVyXod0XSi1x5ZSWivz+/cY
	p9Pd6CHGPZfVQ0Xub4fP0wxegPF9ybuam3M5jCg8BnJkGhTu1K3r
X-Gm-Gg: ASbGncvoOvtQuyVOY+SgOKeWcj2EXenU7OcH7vnMIpXIuO01RVlFRGTPbyY5OOKoYUM
	U1th16RI4+YAJuqujzEf/tCe2cuMck1It9Yyi5/xHYoUt+G9G0+oP60xuBttCtLwb/dx5w0X8wZ
	qOQiTPdGWq6+wYuL7o7Ya7PmsGjFQp5oxdseVnP97P9CcBFu7YO0ENIKNRLTf1DwoTPewgGVF7u
	X15ecemG1CSZALdulg06JtmNe2A59+43Jx76zc/iJ2taQh7B0WAgW7uEgCk7QHgixcch0Yfc4Lc
	DZydQtQAM/B1W5Qj4CriLOEgx9ZH
X-Google-Smtp-Source: AGHT+IH+lU0c3o9sWYufaj0SCswN83+YEHr96aAl0WIL54XimNvkU9ohDDavWF+TcrWgbKoIN5ax+g==
X-Received: by 2002:a05:600c:1e18:b0:436:8a6f:b6db with SMTP id 5b1f17b1804b1-4389141c12emr30990685e9.22.1737130129135;
        Fri, 17 Jan 2025 08:08:49 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275995sm2864100f8f.74.2025.01.17.08.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:08:48 -0800 (PST)
Message-ID: <0d917148509217f3fab95b4cf2e7f14b4c3c0dd1.camel@gmail.com>
Subject: Re: [PATCH v10 1/8] iio: backend: add API for interface get
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>
Date: Fri, 17 Jan 2025 16:08:49 +0000
In-Reply-To: <20250117130702.22588-2-antoniu.miclaus@analog.com>
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
	 <20250117130702.22588-2-antoniu.miclaus@analog.com>
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
> Add backend support for obtaining the interface type used.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> no changes in v10.
> =C2=A0drivers/iio/industrialio-backend.c | 24 ++++++++++++++++++++++++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 11 +++++++++++
> =C2=A02 files changed, 35 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index 363281272035..8bf3d570da1b 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -636,6 +636,30 @@ ssize_t iio_backend_ext_info_set(struct iio_dev
> *indio_dev, uintptr_t private,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, "IIO_BACKEND");
> =C2=A0
> +/**
> + * iio_backend_interface_type_get - get the interface type used.
> + * @back: Backend device
> + * @type: Interface type
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_interface_type_get(struct iio_backend *back,
> +				=C2=A0=C2=A0 enum iio_backend_interface_type *type)
> +{
> +	int ret;
> +
> +	ret =3D iio_backend_op_call(back, interface_type_get, type);
> +	if (ret)
> +		return ret;
> +
> +	if (*type >=3D IIO_BACKEND_INTERFACE_MAX)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, "IIO_BACKEND");
> +
> =C2=A0/**
> =C2=A0 * iio_backend_extend_chan_spec - Extend an IIO channel
> =C2=A0 * @back: Backend device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 10be00f3b120..a0ea6c29d7ba 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -70,6 +70,12 @@ enum iio_backend_sample_trigger {
> =C2=A0	IIO_BACKEND_SAMPLE_TRIGGER_MAX
> =C2=A0};
> =C2=A0
> +enum iio_backend_interface_type {
> +	IIO_BACKEND_INTERFACE_SERIAL_LVDS,
> +	IIO_BACKEND_INTERFACE_SERIAL_CMOS,
> +	IIO_BACKEND_INTERFACE_MAX
> +};
> +
> =C2=A0/**
> =C2=A0 * struct iio_backend_ops - operations structure for an iio_backend
> =C2=A0 * @enable: Enable backend.
> @@ -88,6 +94,7 @@ enum iio_backend_sample_trigger {
> =C2=A0 * @extend_chan_spec: Extend an IIO channel.
> =C2=A0 * @ext_info_set: Extended info setter.
> =C2=A0 * @ext_info_get: Extended info getter.
> + * @interface_type_get: Interface type.
> =C2=A0 * @read_raw: Read a channel attribute from a backend device
> =C2=A0 * @debugfs_print_chan_status: Print channel status into a buffer.
> =C2=A0 * @debugfs_reg_access: Read or write register value of backend.
> @@ -128,6 +135,8 @@ struct iio_backend_ops {
> =C2=A0			=C2=A0=C2=A0=C2=A0 const char *buf, size_t len);
> =C2=A0	int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
> =C2=A0			=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan, char *buf);
> +	int (*interface_type_get)(struct iio_backend *back,
> +				=C2=A0 enum iio_backend_interface_type *type);
> =C2=A0	int (*read_raw)(struct iio_backend *back,
> =C2=A0			struct iio_chan_spec const *chan, int *val, int
> *val2,
> =C2=A0			long mask);
> @@ -186,6 +195,8 @@ ssize_t iio_backend_ext_info_set(struct iio_dev
> *indio_dev, uintptr_t private,
> =C2=A0				 const char *buf, size_t len);
> =C2=A0ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr=
_t
> private,
> =C2=A0				 const struct iio_chan_spec *chan, char
> *buf);
> +int iio_backend_interface_type_get(struct iio_backend *back,
> +				=C2=A0=C2=A0 enum iio_backend_interface_type *type);
> =C2=A0int iio_backend_read_raw(struct iio_backend *back,
> =C2=A0			 struct iio_chan_spec const *chan, int *val, int
> *val2,
> =C2=A0			 long mask);


