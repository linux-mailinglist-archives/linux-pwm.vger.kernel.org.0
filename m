Return-Path: <linux-pwm+bounces-4674-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D96A15E1E
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jan 2025 17:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADA83A7D12
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jan 2025 16:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD76B19D089;
	Sat, 18 Jan 2025 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6cfAekf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4310273F9;
	Sat, 18 Jan 2025 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737218542; cv=none; b=kVmpcXxDgVfMndv4K0qGH+pPxFU/wRmMFlJTUqdrDwNT2QWzqyEywT91jLQz68H8NOK/phVKhzNDjKGA7z5xJXtxeLq2T5gj3IJhVF9z/hoN/28XfF7ogJEj/Ikb4UMHCpEQaF3g9mdHvjyBi2vPcLGjGVWvBNn9IB9+OZnLikQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737218542; c=relaxed/simple;
	bh=hajUkETnORPiNah14nSi3XD9Lwy90NfeehmMBydBHDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpG2P5lVJNhXLk/ZzQubAlNkQ/bWPoQOqYImaNqSk6KkEMTHkGlSRqKKW3T2RSj58WUox6FeZkjBAh9H0nUgAsiPVHPl0ty79QKKg594mrWFrLN8wcIe4tYsRD4ROcmkrY1//WK7khQQZkl2XMZ1Dg+GBeCRDYuef7dygywb3hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6cfAekf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9209C4CEE2;
	Sat, 18 Jan 2025 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737218542;
	bh=hajUkETnORPiNah14nSi3XD9Lwy90NfeehmMBydBHDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J6cfAekf3Fs6/bIDD7fGpwS5zPHgIXzrUegE2XvWrwUX4LRdkHA2AJbPUH9QeZ+UC
	 EP0zv9JFXXDKljHrJINwkG+LjjK/yAuTZ5C7Ua9ZQphS8vWvxWrwmYoXh2m5jDHh/M
	 CWNOqlywB9VzF5joBN9rufIoFJoQdDcCCfQT4I0qTC/Zb/mC5J2COQ3aIDUjRWE32r
	 IzH+gnbrC3OVbs2BdkIoHo/Gmo4eIegBXTm68upPEjssWH3xJvCLNhFODN2ADstdB9
	 xvkHe/ejZF1Lh1K0AmhezitA8vJOdAR3aWp+CUuMhTSjp9rtnChvFl5OHJdi4SH85X
	 yzJT9wBSyiBJw==
Date: Sat, 18 Jan 2025 16:42:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH v10 3/8] iio: backend: add API for oversampling
Message-ID: <20250118164213.74a01067@jic23-huawei>
In-Reply-To: <fb7fe85ad22d778bf462231e693285c7b3d33b98.camel@gmail.com>
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
	<20250117130702.22588-4-antoniu.miclaus@analog.com>
	<fb7fe85ad22d778bf462231e693285c7b3d33b98.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Jan 2025 16:17:13 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2025-01-17 at 15:06 +0200, Antoniu Miclaus wrote:
> > Add backend support for setting oversampling ratio.
> >=20
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> > no changes in v10.
> > =C2=A0drivers/iio/industrialio-backend.c | 15 +++++++++++++++
> > =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 5 +++++
> > =C2=A02 files changed, 20 insertions(+)
> >=20
> > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industria=
lio-
> > backend.c
> > index 2088afa7a55c..d4ad36f54090 100644
> > --- a/drivers/iio/industrialio-backend.c
> > +++ b/drivers/iio/industrialio-backend.c
> > @@ -681,6 +681,21 @@ int iio_backend_data_size_set(struct iio_backend *=
back,
> > unsigned int size)
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, "IIO_BACKEND");
> > =C2=A0
> > +/**
> > + * iio_backend_oversampling_ratio_set - set the oversampling ratio
> > + * @back: Backend device
> > + * @ratio: The oversampling ratio - value 1 corresponds to no oversamp=
ling.
> > + *
> > + * Return:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int iio_backend_oversampling_ratio_set(struct iio_backend *back,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ratio)
> > +{
> > +	return iio_backend_op_call(back, oversampling_ratio_set, ratio);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iio_backend_oversampling_ratio_set, "IIO_BACKEND"=
);
> > + =20
>=20
> Hmm, I'm very late to the party so don't bother in sending another revisi=
on
> unless you have too. But if you do, I would prefer to have this through a
> write_raw() interface. Meaning we would only have write_raw() as a backen=
d op
> and  then you could add this as a convenient inline helper built on top of
> write_raw(). So this would be inline with what happens with read_raw(). A=
nyways,
> we can clean it up afterwards since we already have a .set_sample_rate() =
op that
> could use a similar approach.
I'm not against this, but just to mention that will run into the question of
whether to support the more complex value types.  I guess for now perhaps
pass in val, val2 and the write type and just reject anything that isn't
supported by a particular backend.

>=20
> - Nuno S=C3=A1
>=20
>=20


