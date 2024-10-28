Return-Path: <linux-pwm+bounces-3940-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3853C9B2E8D
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 12:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8360BB23756
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958731DB37C;
	Mon, 28 Oct 2024 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W13JUlpX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0628C1DA633;
	Mon, 28 Oct 2024 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113740; cv=none; b=p3dT/mbZLjY66nh30dtBGn2dQMdLfwweRTu7of94lJY7Yb4b8lTdy+S94pq1NoWlwGmtdGJi9tz/72AU5RPRmJ+BSzX/QoMRIlJn3dEZhw3RCQq9z4lTDA+T+WL7h4R0ngvzH3mWZ1jFXUnhQFybV1PP5hnmO0EhBNaTguVcjtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113740; c=relaxed/simple;
	bh=k+C2WEQ5miw0ZOJlHBxDIswiKkg40rsya70jjvsVg78=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pGYTn4Y6kx2xeIDSUGOs7ljz9pXQoXwLKMjPjAIQ3l1BY9uzECy5Uw6WO8UsVGrIQxib3qp6jAh2MQEWZGIHfseqEvyZlhFBz7FvjWAG9T+JT/uJJZMqVTyOG2yr6Ut0cXeTDxEKebmkRpIlJBYbMS7cshj2tI/OhEK8F8lo3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W13JUlpX; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so4980135e87.1;
        Mon, 28 Oct 2024 04:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730113736; x=1730718536; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k+C2WEQ5miw0ZOJlHBxDIswiKkg40rsya70jjvsVg78=;
        b=W13JUlpXv2PTxfnnMhQqrCGtFKlNiZusRqO/1jhOwxAy5kodPjG5BY+sK527mZLPPM
         jdBT5iZuofKiuiJuaMHm8F5LXsjd53eQhR2itwJRwfSAmggqORJ4a4z/eHNasYDYcGxs
         iu5/GVgj9Iv7MP8amqPFNkmC3px6reofBqpeyV4Xg6m4a0c0TxgonrDG6CGWq8o3vcal
         8leIYqjTRARfLMTO62XDFWZQT//EmMde7Q5O7KZwAeDeCrgohnyZCu8DgYbyaBm9/bS1
         /+PCfynfunXkmhSXdGYADwD+OoYp00OB7HeSkXC9R4r0/wPeMVNX2VelzptctEJQcnEZ
         pmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113736; x=1730718536;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+C2WEQ5miw0ZOJlHBxDIswiKkg40rsya70jjvsVg78=;
        b=UzHD7dIpd7ytAa1D8soGjRP7cgHNye9Q2H45sx0b8e1ub99/HgxuEqq5zyUh+ZuwoJ
         gs1DyX/ICrWaa4Bm60w3xjc6uJahXxm4e9H/KsRNUPb5BU+wLwjmTD3YMnbCv0GtkQD9
         4neWrHtd5pnWMy9ZFGmwbUfOeVqNds5dGt89fGtaCcXzS0w4QOxGQ+jZB2GZKwWT6fl1
         fDofUZ4C3sngyyBJL6pfUNaYuaeDOsDrS2MrK/nK+uoeKsCcpOGqw+uc5pfcuQnrlILR
         8BZwSIGS1zjcmHQCdUJ2I1P4M7CIk3E+51PkWa6YeanCkzuLxQ22peb3hQZeMkdJjdPf
         u2kg==
X-Forwarded-Encrypted: i=1; AJvYcCUYeYd7WH4nD73ytPFZr0SHM1v71T31N65TDJ9fSIk1758dUukdyUvbjBDmtqTZeHZIU2dWErLE+ErKsbvP@vger.kernel.org, AJvYcCV2L4/BFfNpEHv+1sQC/UAUYsP7tgzC0UtPu6cSaa/P605jyU9Y5pZH1V8FZiw4EsviTyaYE+p0wCg6@vger.kernel.org, AJvYcCV32XCcPMEpRDlWEKWjFosw8SozC/VI6f7zVoNoDqh9g31UQPgy/Pi8zfjk503C0x/tRmo7JeBjTvSp@vger.kernel.org, AJvYcCVUUoF61OIkIm/TxkUL3f2IKBIygbyFgDQpjFSIk2nI/0bP7l4IWKq2vn+tmIK6r5GkI31Ky0RiSCwr@vger.kernel.org, AJvYcCWwoPoO3/xWTiXI1miTKadQ/VPM7GTfF32tSHQAiBm2hdIRbRnNIxN/Gt/DCRjykdSgwgm8svom9Xey@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5owo/qpHMEivKeT1fOauzAvKxrHPcHuaR4s9B/kX+gDFpVFVO
	S/fVYK7RjQsk5MYzsGZamllpTVXX8ZsJO7U9DCmUqsEX5Q66Tcl7
X-Google-Smtp-Source: AGHT+IGZpPN97FmnyWE/T+gJ2ZjvwPkNgyBqurU5ktqqaJQQzU19h97yUjKm5xmwPCG6wWVrGQL4vQ==
X-Received: by 2002:a05:6512:3c90:b0:536:55ef:69e8 with SMTP id 2adb3069b0e04-53b347266cfmr3003689e87.0.1730113735688;
        Mon, 28 Oct 2024 04:08:55 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1c65dsm9242201f8f.8.2024.10.28.04.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:08:55 -0700 (PDT)
Message-ID: <6671d95514e39e59dfda04a7a7ed1b83df001477.camel@gmail.com>
Subject: Re: [PATCH RFC v4 11/15] iio: buffer-dmaengine: add
 devm_iio_dmaengine_buffer_setup_ext2()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org,  linux-pwm@vger.kernel.org
Date: Mon, 28 Oct 2024 12:08:49 +0100
In-Reply-To: <20241026164815.47de1ffa@jic23-huawei>
References: <dc52cda0-47d9-4cbf-a68e-0af304edc32e@gmail.com>
	 <20241026164815.47de1ffa@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-10-26 at 16:48 +0100, Jonathan Cameron wrote:
> On Fri, 25 Oct 2024 20:40:42 +0200 (GMT+02:00)
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > Oct 25, 2024 18:42:02 David Lechner <dlechner@baylibre.com>:
> >=20
> > > On 10/25/24 8:24 AM, Nuno S=C3=A1 wrote:=C2=A0=20
> > > > I still need to look better at this but I do have one though alread=
y=20
> > > > :)
> > > >=20
> > > > On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote:=C2=A0=20
> > > > > Add a new devm_iio_dmaengine_buffer_setup_ext2() function to hand=
le
> > > > > cases where the DMA channel is managed by the caller rather than=
=20
> > > > > being
> > > > > requested and released by the iio_dmaengine module.
> > > > >=20
> > > > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > > > ---
> > > > >=20
> > > > > v4 changes:
> > > > > * This replaces "iio: buffer-dmaengine: generalize requesting DMA=
=20
> > > > > channel"
> > > > > ---=C2=A0=20
> > >=20
> > > ...
> > > =C2=A0
> > > > > @@ -282,12 +281,38 @@ void iio_dmaengine_buffer_free(struct=20
> > > > > iio_buffer *buffer)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_buffer_to_dmaengin=
e_buffer(buffer);
> > > > > =C2=A0
> > > > > =C2=A0=C2=A0=C2=A0 iio_dma_buffer_exit(&dmaengine_buffer->queue);
> > > > > -=C2=A0=C2=A0 dma_release_channel(dmaengine_buffer->chan);
> > > > > -
> > > > > =C2=A0=C2=A0=C2=A0 iio_buffer_put(buffer);
> > > > > +
> > > > > +=C2=A0=C2=A0 if (dmaengine_buffer->owns_chan)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_release_channel(dmaengi=
ne_buffer->chan);=C2=A0=20
> > > >=20
> > > > Not sure if I agree much with this owns_chan flag. The way I see it=
,=20
> > > > we should always
> > > > handover the lifetime of the DMA channel to the IIO DMA framework.=
=20
> > > > Note that even the
> > > > device you pass in for both requesting the channel of the spi_offlo=
ad=C2=A0=20
> > > > and for
> > > > setting up the DMA buffer is the same (and i suspect it will always=
=20
> > > > be) so I would
> > > > not go with the trouble. And with this assumption we could simplify=
 a=20
> > > > bit more the
> > > > spi implementation.=C2=A0=20
> > >=20
> > > I tried something like this in v3 but Jonathan didn't seem to like it=
.
> > >=20
> > > https://lore.kernel.org/all/20240727144303.4a8604cb@jic23-huawei/
> > > =C2=A0
> > > >=20
> > > > And not even related but I even suspect the current implementation=
=20
> > > > could be
> > > > problematic. Basically I'm suspecting that the lifetime of the DMA=
=20
> > > > channel should be
> > > > attached to the lifetime of the iio_buffer. IOW, we should only=20
> > > > release the channel
> > > > in iio_dmaengine_buffer_release() - in which case the current=20
> > > > implementation with the
> > > > spi_offload would also be buggy.=C2=A0=20
> > >=20
> > > The buffer can outlive the iio device driver that created the buffer?=
=C2=A0=20
> >=20
> > Yes, it can as the IIO device itself. In case a userspace app has an op=
en=20
> > FD for the buffer chardev, we get a reference that is only released whe=
n=20
> > the FD is closed (which can outlive the device behind bound to its=20
> > driver). That is why we nullify indio_dev->info and check for it on the=
=20
> > read() and write() fops.
> >=20
> > FWIW, I raised concerns about this in the past (as we don't have any lo=
ck=20
> > in those paths) but Jonathan rightfully wanted to see a real race. And =
I=20
> > was too lazy to try and reproduce one but I'm still fairly sure we have=
=20
> > theoretical (at least) races in those paths. And one of them could be (=
I=20
> > think) concurrently hitting a DMA submit block while the device is bein=
g=20
> > unbound. In that case the DMA chan would be already released and we cou=
ld=20
> > still try to initiate a transfer. I did not check if that would crash o=
r=20
> > something but it should still not happen.
> >=20
> There are a few places where I've been meaning to have another look
> at our protections during unregister. May well be problems hiding here
> and in general the thinking on how to do this in the kernel has slowly
> been changing so we might be able to clean things up in general.
>=20

Yeah, I'm fairly sure things like [1] are not enough in preventing potentia=
l nasty
races (though they should be hard to trigger). OTOH, in [2], we do have pro=
per
locking.

Simple solution would be to use the info lock in the buffer read() and writ=
e() paths.
I do realize that's a fastpath but I don't think that would be such a conte=
nded lock.
But we can surely do better and RCU could be a good candidate for this (we =
could do
something similar to what gpiolib is doing) and I wouldn't expect it to be =
that
complicated to implement. Biggest issue by making info a __rcu pointer woul=
d be to
change all IIO drivers to set the pointer with rcu_assign_pointer(). Though=
 during
probe there's no potential race so what we have today should be fine (just =
not sure
if things like sparse would not complain about the "raw" assignment).

[1]: https://elixir.bootlin.com/linux/v6.12-rc4/source/drivers/iio/industri=
alio-buffer.c#L176
[2]: https://elixir.bootlin.com/linux/v6.12-rc4/source/drivers/iio/industri=
alio-core.c#L1825


- Nuno S=C3=A1



