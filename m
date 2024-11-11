Return-Path: <linux-pwm+bounces-4065-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B14069C4202
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 16:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7155E286DE8
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 15:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6785619F130;
	Mon, 11 Nov 2024 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNpKFAbH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9978119FA9D;
	Mon, 11 Nov 2024 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339404; cv=none; b=W/c1I8I6laaylmc0RV1+zqVAc843EUtXeNBaFvpz+5QWrP0VDmx6Sd/dqHtn7K5flQ3STA64wN6GPmtSQINW5Tw8pOaI2DtBTs1ccBPzTtvqVRjLTRcPg4jUZW6xSnhTHgi/x4EvNmdGs9lrij5vtPco70i824LKKH668eNDmyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339404; c=relaxed/simple;
	bh=LfCkAD+TV6bamuHvX6wvv2w9RY6tpadJQ9PrP2y8SPA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RPd2eTIZ0F/r6F6a3eSuce0XLxRHvC6VmK0y3YLBA713buQC3J+JQGO/kXoP6Q2+FzJUa9GosoxCSjuyB/ZwYo7xgc7aDfr23CQH8MLWN0Uwdpcj38edCWBwUUIjbZ8rmlmbxJJmqd6PhEvNGOi3BmoNJWOgLnnWYS5MevAhoug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNpKFAbH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d8901cb98so3278738f8f.0;
        Mon, 11 Nov 2024 07:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731339401; x=1731944201; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yubgSGoJZBM7xlz8Ebr2D45Yqu3f8AQToAyNBni9urE=;
        b=DNpKFAbH5+djClC9ouX9bDRP1oHsbzTv2WJJLziQBXzA1xTIBxf3drikk5W0DnEOHp
         M/MPyfvd627e1iXUI9DBNnto+aI094WyS2KZ9iSd/1JtAO1LKRM9kpTJqKW//lPKap8R
         WuqWQGhPaaaZlEjDv2yGron+wf8P05yHjKyvLE4oJa5Po96oAjkCB9NSwaP+/pWbmjLg
         XamyrRuB3v2nfonWEccQfkxLVNhiJoMeLM0dW12xKe9jJNFyXIAaNr/3x26LjARamsX+
         2xKuOIqNfMgj0c/KmwbUivL8CmSZgIlE/RR2Hkvv/9uyBSCpjIBZY6GGxkizpYsZ0zHR
         PYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731339401; x=1731944201;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yubgSGoJZBM7xlz8Ebr2D45Yqu3f8AQToAyNBni9urE=;
        b=qH7vN/SUb66buBzqevR2s01yWht04s1MnEpJRwni/3bq050Q7GhXQr3H5SYGOt5PbO
         Z1sONUlSN9Qwd0mUKq35z12UXgBAORgZKy0rNGjHkCMPUULbrm6eGOr4X/hX0dc4VM8N
         W51NxiG9G0d+rOPVbR0a9LoJ+Q8qNKpRo+N+xPkbY2O96Dp+ub8+XGCPxQYbpeiuhMz8
         7ssjA0Z/nVGy1tvQxbzL7gnPErIYZgItq3xmhv/y80Ax2YGQWjuIApUp/VUu0XH2cZO1
         jRbrsXofc4SzXsYgu3FsTsqi6GDk8qnRoTvU3JU/P+LlYn6t+7ce070qXq2K4BgEKQX6
         AZxA==
X-Forwarded-Encrypted: i=1; AJvYcCUfGn9JTYnllcM3nnk88otTX/np8n0nHxOoHWJxC3LyfB3XPJT576WEe7N/YpkAU5BaIdkaG1LeGi0l@vger.kernel.org, AJvYcCVRj3L0HJAW+V7Fzorl5Wi477Lqe19GONYFbJGftLvkt+gDA8P+kDHh/7ziR69h3tzhK3Zww/qsErlDXZC3@vger.kernel.org, AJvYcCXTEmfhASMWZqVp06MYRAIG+dqQEHVSRUCmlG14LyE6LGj9Z+IOYjSh4JTZPv4cLoW01p2BOuMjSGkZ@vger.kernel.org, AJvYcCXlztOxFaCjJVmY3uUVv+lF6EHFX8cfOXwv/ykzqMrtbcsHd+aqnq98BLxntJVSQl81Zw278mPjatYX@vger.kernel.org
X-Gm-Message-State: AOJu0YwX0tT96F5NubnhORhQYZngeNMlcxNNxeS5jYAZMQLQ4A9wdLMt
	Xdf6yj8do4/ebMemO/LbCG+p2Ta3KrmzqyY1CEYKDleHcBrFrxM4
X-Google-Smtp-Source: AGHT+IE5W/ZDC336x6MDi22bnSy9wq+9UtXziMLuvrIe2LSAaFEnCxwXWpiO5clOGiyD4ejtMjgoAw==
X-Received: by 2002:a05:6000:1569:b0:37d:4660:c027 with SMTP id ffacd0b85a97d-381f0f87207mr12370290f8f.24.1731339400540;
        Mon, 11 Nov 2024 07:36:40 -0800 (PST)
Received: from ?IPv6:2003:f6:ef02:f400:a23c:697f:16fb:11c5? (p200300f6ef02f400a23c697f16fb11c5.dip0.t-ipconnect.de. [2003:f6:ef02:f400:a23c:697f:16fb:11c5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97e206sm13012220f8f.25.2024.11.11.07.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 07:36:40 -0800 (PST)
Message-ID: <e683ce92267ec4cafa825cdf1767939d922b04ea.camel@gmail.com>
Subject: Re: [PATCH v6 3/8] iio: backend: add API for oversampling
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Date: Mon, 11 Nov 2024 16:41:02 +0100
In-Reply-To: <20241111121203.3699-4-antoniu.miclaus@analog.com>
References: <20241111121203.3699-1-antoniu.miclaus@analog.com>
	 <20241111121203.3699-4-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-11-11 at 14:11 +0200, Antoniu Miclaus wrote:
> Add backend support for enabling/disabling oversampling.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v6:
> =C2=A0- add iio backend commit for oversampling enable/disable
> =C2=A0drivers/iio/industrialio-backend.c | 14 ++++++++++++++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 3 +++
> =C2=A02 files changed, 17 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index ea184fc2c838..6ba445ba3dd0 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -681,6 +681,20 @@ int iio_backend_data_size_set(struct iio_backend *ba=
ck,
> unsigned int size)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, IIO_BACKEND);
> =C2=A0
> +/**
> + * iio_backend_oversampling_en - set the data width/size in the data bus=
.

Seems unrelated?

> + * @back: Backend device
> + * @en: oversampling enabled/disabled.
> + *
> + * Return:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_oversampling_en(struct iio_backend *back, bool en)
> +{
> +	return iio_backend_op_call(back, oversampling_en, en);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_oversampling_en, IIO_BACKEND);
> +

There was some discussion around having APIs with a boolean parameter (actu=
ally
even improving - in terms of callbacks - further with some generic
getter/setter's) or having two callbacks:

iio_backend_oversampling_enable()
iio_backend_oversampling_disable()

I'm guessing you don't really want to do any major conversion/refactoring a=
t
this point in your series so I have a slight preference for just keeping th=
e
current style of dedicated enable and disable APIs (irrespective of being t=
he
better approach or not). Please consider it, if you have to re-spin the ser=
ies.

- Nuno S=C3=A1



