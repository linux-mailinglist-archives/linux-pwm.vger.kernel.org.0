Return-Path: <linux-pwm+bounces-3400-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3910989ACA
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2024 08:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2880CB22AAC
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2024 06:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FF816C684;
	Mon, 30 Sep 2024 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLJAaAMu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26116BE17;
	Mon, 30 Sep 2024 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678570; cv=none; b=eaV9/UMGbs4iGJT9gKEdsDA9/2f95SA6E+fgukGy0EZbECfwHMXqaIlvZ4RPXAhpEZfieCwcuJFOBTUOvsSsL/1y8rBkFzqai6OlpcKyuHf5WXksA9m967u4oHG3Lnhg/USD2+ddYwokfG8gz2oojGqFkA22TSWKsc7N19H28O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678570; c=relaxed/simple;
	bh=ZsVkNqE559yYAD0KbYrNq+q5m4LLmYjdu/xt9ojIPSA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s0622Sayf01GLvBu5ybyE3qWRRqtdwhFh9VI1zrpTfX3WAO7oebB8oD1uxoqGIqTOU9y9d8FiP0/R3co44Dwb3T5CLk+Q7Vetvy6yYjjRnxib5DUtF8qsGBY0Qu3wMrC8JNGCZc+BW9zXLTf3AiHpunvldvkdpglT2OSXogFLWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLJAaAMu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a93b2070e0cso486105366b.3;
        Sun, 29 Sep 2024 23:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727678567; x=1728283367; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZsVkNqE559yYAD0KbYrNq+q5m4LLmYjdu/xt9ojIPSA=;
        b=ZLJAaAMu8DV605qMUnaaCSWHGUo5SmzrSeudSW/zAV9vY8YXTbPN1JDwbSJWEkYniS
         /6csGxynsAUlihWTra6b714p15kHEX4JzBED0JO0i83ZWeI+1SEG25dVNMYKHzqLm75O
         s0valQddnDIR6I3C1qyjovgTydf4AGdMLKIBeuWMDq8BXDtt+E5SuR6ZBgwxXlCCeg3s
         v+l9iYr6OF01GRQvc0SALGgXq77Hz3YfvUQPAB0JB3VOeKj1kzYhCzwfp5rK1eT8aF45
         +6+TNfi04UQsVDqMZCyd/BqlEfwGDOR8eSfr0QJ1NguCLNNzvkA47pgGreQe0Nq8S4w9
         qwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727678567; x=1728283367;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZsVkNqE559yYAD0KbYrNq+q5m4LLmYjdu/xt9ojIPSA=;
        b=UeefaC1EFYILFCJJgzNHrna6txFN/neehKudHJoi3vZTZfDBGh1+cpjHZTmdHqD8Jv
         dsZBqi8fz2nSSDf31zo5txrLWgpky8EQ6nQz7smZUlzue9mWuEo351btI5nVK+fEhd5A
         R0EgCknjg/DmR16Gsfge0O5vzjMM+aQ/Mv55FbSsVlwMNqX9IIL5jXv1cmOepBgjFqOB
         vkWubQLQSh2Ht+BQEuJYFG+afuzEw7/bWwrzA4UTqFKBa86T9JHWYSN3NZiT/3TdjRV1
         y/vzVE28uIGgqJhLLqkudEAhSF7HKESLcwFBxUX/sdDasZWXPq2kdN+JvF9vbW0Wgof7
         X9DA==
X-Forwarded-Encrypted: i=1; AJvYcCVNwB2KCVtt2RMmriF3T6s/bG0z97rYJjoYASQU3unTSCWJc+Az5ByKCc2X9dGK7voO3MlIeUlVeAdh@vger.kernel.org, AJvYcCVX2OEUuefkyQN+pYL/FnglnjSSQodFquJFvLh7BQMQKqUPPqkJU/XdA2ya8emw5C9sQbdiCUorjdGH@vger.kernel.org, AJvYcCVfKXIU6tm+RN83bwAJn8j0LIlgQGL0sxhjtYOAaz1zEZXZxVx9SGBo6w1zD1Wu/7tq15MyTi3Pk9RXESir@vger.kernel.org, AJvYcCWHoa2eZNJ90MaaQifWMnQyZ/UwCZwPHg1HcJxX0qO/53LlOIMORtR1twxIruxfZNSfx/BTBk0Ps5Wn@vger.kernel.org
X-Gm-Message-State: AOJu0YwPb0ExM5+YDLoj6TReqH++C55GrRcByiWmKLJvCJ1HWlEZhNuf
	Q7cDbS/M55KJWqVcX4rZqHqJctVGllavzk36/AP21vOgy90JA5HI
X-Google-Smtp-Source: AGHT+IF0hQAKZDwoxLd5tVspvsrveQH4KSYpSAjWHeVzaDavS1YefPjYEHkLfjEOx9XjvPjVE+kSUA==
X-Received: by 2002:a17:907:3e99:b0:a86:ac91:a571 with SMTP id a640c23a62f3a-a93c4c256famr1140528266b.56.1727678566407;
        Sun, 29 Sep 2024 23:42:46 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef02:2700:7684:3ff1:6790:3866? (p200300f6ef02270076843ff167903866.dip0.t-ipconnect.de. [2003:f6:ef02:2700:7684:3ff1:6790:3866])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2948029sm475568966b.127.2024.09.29.23.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 23:42:46 -0700 (PDT)
Message-ID: <0c9945bb7e39371f467cdc5df206fab28e286642.camel@gmail.com>
Subject: Re: [PATCH 1/7] iio: backend: add API for interface get
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Antoniu Miclaus	
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa	 <nuno.sa@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	
 <ukleinek@kernel.org>, Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt	
 <marcelo.schmitt@analog.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
  AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,  =?ISO-8859-1?Q?Jo=E3o?= Paulo
 =?ISO-8859-1?Q?Gon=E7alves?=	 <joao.goncalves@toradex.com>, Marius Cristea
 <marius.cristea@microchip.com>,  Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-pwm@vger.kernel.org
Date: Mon, 30 Sep 2024 08:46:58 +0200
In-Reply-To: <20240928182302.767953f1@jic23-huawei>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
		<20240923101206.3753-2-antoniu.miclaus@analog.com>
		<CAMknhBHmtpnX-nXxReF-rUW1ks1=iw3m_BmiRUTkf5XckPsvPw@mail.gmail.com>
		<83cf3c3eb1cc5fcc06ce72cab14cc0da3bd817b6.camel@gmail.com>
	 <20240928182302.767953f1@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-09-28 at 18:23 +0100, Jonathan Cameron wrote:
> On Thu, 26 Sep 2024 12:52:39 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Thu, 2024-09-26 at 10:40 +0200, David Lechner wrote:
> > > On Mon, Sep 23, 2024 at 12:15=E2=80=AFPM Antoniu Miclaus
> > > <antoniu.miclaus@analog.com> wrote:=C2=A0=20
> > > >=20
> > > > Add backend support for obtaining the interface type used.
> > > >=20
> > > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > > ---
> > > > =C2=A0drivers/iio/industrialio-backend.c | 24 +++++++++++++++++++++=
+++
> > > > =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 10 ++++++++++
> > > > =C2=A02 files changed, 34 insertions(+)
> > > >=20
> > > > diff --git a/drivers/iio/industrialio-backend.c
> > > > b/drivers/iio/industrialio-
> > > > backend.c
> > > > index efe05be284b6..53ab6bc86a50 100644
> > > > --- a/drivers/iio/industrialio-backend.c
> > > > +++ b/drivers/iio/industrialio-backend.c
> > > > @@ -449,6 +449,30 @@ ssize_t iio_backend_ext_info_set(struct iio_de=
v
> > > > *indio_dev,
> > > > uintptr_t private,
> > > > =C2=A0}
> > > > =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, IIO_BACKEND);
> > > >=20
> > > > +/**
> > > > + * iio_backend_interface_type_get - get the interace type used.
> > > > + * @back: Backend device
> > > > + * @type: Interface type
> > > > + *
> > > > + * RETURNS:
> > > > + * 0 on success, negative error number on failure.
> > > > + */
> > > > +int iio_backend_interface_type_get(struct iio_backend *back,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_backend_=
interface_type
> > > > *type)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D iio_backend_op_call(b=
ack, interface_type_get, type);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return ret;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*type > IIO_BACKEND_INTER=
FACE_CMOS)
> Put a COUNT entry or similar on the end of the enum so this doesn't need
> updating for more types.
>=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, IIO_BACKEND);
> > > > +
> > > > =C2=A0/**
> > > > =C2=A0 * iio_backend_extend_chan_spec - Extend an IIO channel
> > > > =C2=A0 * @indio_dev: IIO device
> > > > diff --git a/include/linux/iio/backend.h b/include/linux/iio/backen=
d.h
> > > > index 8099759d7242..ba8ad30ac9ba 100644
> > > > --- a/include/linux/iio/backend.h
> > > > +++ b/include/linux/iio/backend.h
> > > > @@ -63,6 +63,11 @@ enum iio_backend_sample_trigger {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_BACKEND_SAMPLE_TRIGG=
ER_MAX
> > > > =C2=A0};
> > > >=20
> > > > +enum iio_backend_interface_type {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_BACKEND_INTERFACE_LVDS,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_BACKEND_INTERFACE_CMOS
>=20
> trailing comma.
>=20
> This is going to get bigger!
>=20
> > > > +};
> > > > +
> > > > =C2=A0/**
> > > > =C2=A0 * struct iio_backend_ops - operations structure for an iio_b=
ackend
> > > > =C2=A0 * @enable: Enable backend.
> > > > @@ -81,6 +86,7 @@ enum iio_backend_sample_trigger {
> > > > =C2=A0 * @extend_chan_spec: Extend an IIO channel.
> > > > =C2=A0 * @ext_info_set: Extended info setter.
> > > > =C2=A0 * @ext_info_get: Extended info getter.
> > > > + * @interface_type_get: Interface type.
> > > > =C2=A0 **/
> > > > =C2=A0struct iio_backend_ops {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*enable)(struct iio=
_backend *back);
> > > > @@ -113,6 +119,8 @@ struct iio_backend_ops {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 const char *buf, size_t len);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*ext_info_get)(stru=
ct iio_backend *back, uintptr_t private,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan, char
> > > > *buf);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*interface_type_get)(str=
uct iio_backend *back,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_backend_interf=
ace_type
> > > > *type);
> > > > =C2=A0};
> > > >=20
> > > > =C2=A0int iio_backend_chan_enable(struct iio_backend *back, unsigne=
d int
> > > > chan);
> > > > @@ -142,6 +150,8 @@ ssize_t iio_backend_ext_info_set(struct iio_dev
> > > > *indio_dev,
> > > > uintptr_t private,
> > > > =C2=A0ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, u=
intptr_t
> > > > private,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_s=
pec *chan, char
> > > > *buf);
> > > >=20
> > > > +int iio_backend_interface_type_get(struct iio_backend *back,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_backend_=
interface_type
> > > > *type);
> > > > =C2=A0int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_backend *bac=
k,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec *c=
han);
> > > > --
> > > > 2.46.0
> > > > =C2=A0=20
> > >=20
> > > This seems very specific to the AD485x chips and the AXI ADC backend.
> > > Since it is describing how the chip is wired to the AXI DAC IP block,
> > > I would be tempted to use the devicetree for this info instead of
> > > adding a new backend function.=C2=A0=20
> >=20
> > Not sure If I'm following your point but I think this is the typical ca=
se
> > where the
> > chip (being it a DAC or ADC) supports both CMOS and LVDS interfaces.
> > Naturally you
> > only use one on your system and this is a synthesis parameter on the FP=
GA IP
> > core.
> > Therefore, it makes sense for the frontend to have way to ask for this
> > information to
> > the backend.
> >=20
> > That said, we could also have a DT parameter but, ideally, we would the=
n
> > need a way
> > to match the parameter with the backend otherwise we could have DT stat=
ing
> > LVDS and
> > the backend built with CMOS.
>=20
> That would be a DTS bug that you should fix :)=C2=A0 For this to make sen=
se you are
> relying on an FPGA that also has pins flexible enough to support LVDS and=
 CMOS
> so it's only a firmware thing. Been a while since I last messed with FPGA=
s,
> but that seems unlikely to be true in general.
>=20

Sure, but if this is something the FPGA can give us as part of it's registe=
r
map, it makes sense to me to have an interface like this...

> So far I'm with David on this, feels like something we shouldn't be
> discovering
> at runtime though maybe that's a convenience that we do want to enable.
>=20

To be clear, I'm not against a DT parameter as it indeed describes how the =
HW is
being used (even though we could get it done solely with the interface_get(=
))
and while I agree with you that having a mismatch in interface types would =
be a
DT bug, it's always better to be able to detect and catch it early on (and =
fail
early) then going against the wall until we realize the issue. So, I do see
value in an interface like this even if only to match and validate against =
a DT
parameter.

- Nuno S=C3=A1
>=20

