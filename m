Return-Path: <linux-pwm+bounces-3947-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4CA9B36A2
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 17:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326E71C22082
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679081DEFF8;
	Mon, 28 Oct 2024 16:36:07 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE4C1DEFE7;
	Mon, 28 Oct 2024 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133367; cv=none; b=Qz5a4wIi810Ccnn9eE3HNH76xBycJnghTYNCascVxJxguU44HaxPSdci1q9IUo3E/h91XWVNS2EBZQW4CZo86TOPbFOovdb8wM3gzJInv3xTtlphWwvnHVd6L9krkCkQXQbEH7QfjippovBEYmWmvz6UfgfTJ1r3bPkaOjQSgWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133367; c=relaxed/simple;
	bh=UDx/iEGQPI7t3zxgnvP2uv3nUUxGQrG+5V3rxQbcVCc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhpIJ4CMwDM+I4O632OupldSDm8BiUu1zECnJi1Dk0Td+341c6Z1r/mi/l/fo8e0BFr5XytE8VF/i214HpMR0GTOd1NlU4/l+mcWeJiOXthTtvNq9Sm1Kfy+1Ymuryr32+AfjeJNtjgnLtNpaGdIS/16uFygvq/Lvy/SR7k9Oig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xcf5q0Wqlz6LDY9;
	Tue, 29 Oct 2024 00:31:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 785B3140429;
	Tue, 29 Oct 2024 00:35:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 28 Oct
 2024 17:35:58 +0100
Date: Mon, 28 Oct 2024 16:35:56 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, "David
 Jander" <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>
Subject: Re: [PATCH RFC v4 11/15] iio: buffer-dmaengine: add
 devm_iio_dmaengine_buffer_setup_ext2()
Message-ID: <20241028163556.00007ca8@Huawei.com>
In-Reply-To: <6671d95514e39e59dfda04a7a7ed1b83df001477.camel@gmail.com>
References: <dc52cda0-47d9-4cbf-a68e-0af304edc32e@gmail.com>
	<20241026164815.47de1ffa@jic23-huawei>
	<6671d95514e39e59dfda04a7a7ed1b83df001477.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Oct 2024 12:08:49 +0100
Nuno S=E1 <noname.nuno@gmail.com> wrote:

> On Sat, 2024-10-26 at 16:48 +0100, Jonathan Cameron wrote:
> > On Fri, 25 Oct 2024 20:40:42 +0200 (GMT+02:00)
> > Nuno S=E1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > Oct 25, 2024 18:42:02 David Lechner <dlechner@baylibre.com>:
> > >  =20
> > > > On 10/25/24 8:24 AM, Nuno S=E1 wrote:=A0  =20
> > > > > I still need to look better at this but I do have one though alre=
ady=20
> > > > > :)
> > > > >=20
> > > > > On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote:=A0  =20
> > > > > > Add a new devm_iio_dmaengine_buffer_setup_ext2() function to ha=
ndle
> > > > > > cases where the DMA channel is managed by the caller rather tha=
n=20
> > > > > > being
> > > > > > requested and released by the iio_dmaengine module.
> > > > > >=20
> > > > > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > > > > ---
> > > > > >=20
> > > > > > v4 changes:
> > > > > > * This replaces "iio: buffer-dmaengine: generalize requesting D=
MA=20
> > > > > > channel"
> > > > > > ---=A0  =20
> > > >=20
> > > > ...
> > > > =A0 =20
> > > > > > @@ -282,12 +281,38 @@ void iio_dmaengine_buffer_free(struct=20
> > > > > > iio_buffer *buffer)
> > > > > > =A0=A0=A0=A0=A0=A0=A0 iio_buffer_to_dmaengine_buffer(buffer);
> > > > > > =A0
> > > > > > =A0=A0=A0 iio_dma_buffer_exit(&dmaengine_buffer->queue);
> > > > > > -=A0=A0 dma_release_channel(dmaengine_buffer->chan);
> > > > > > -
> > > > > > =A0=A0=A0 iio_buffer_put(buffer);
> > > > > > +
> > > > > > +=A0=A0 if (dmaengine_buffer->owns_chan)
> > > > > > +=A0=A0=A0=A0=A0=A0 dma_release_channel(dmaengine_buffer->chan)=
;=A0  =20
> > > > >=20
> > > > > Not sure if I agree much with this owns_chan flag. The way I see =
it,=20
> > > > > we should always
> > > > > handover the lifetime of the DMA channel to the IIO DMA framework=
.=20
> > > > > Note that even the
> > > > > device you pass in for both requesting the channel of the spi_off=
load=A0=20
> > > > > and for
> > > > > setting up the DMA buffer is the same (and i suspect it will alwa=
ys=20
> > > > > be) so I would
> > > > > not go with the trouble. And with this assumption we could simpli=
fy a=20
> > > > > bit more the
> > > > > spi implementation.=A0  =20
> > > >=20
> > > > I tried something like this in v3 but Jonathan didn't seem to like =
it.
> > > >=20
> > > > https://lore.kernel.org/all/20240727144303.4a8604cb@jic23-huawei/
> > > > =A0 =20
> > > > >=20
> > > > > And not even related but I even suspect the current implementatio=
n=20
> > > > > could be
> > > > > problematic. Basically I'm suspecting that the lifetime of the DM=
A=20
> > > > > channel should be
> > > > > attached to the lifetime of the iio_buffer. IOW, we should only=20
> > > > > release the channel
> > > > > in iio_dmaengine_buffer_release() - in which case the current=20
> > > > > implementation with the
> > > > > spi_offload would also be buggy.=A0  =20
> > > >=20
> > > > The buffer can outlive the iio device driver that created the buffe=
r?=A0  =20
> > >=20
> > > Yes, it can as the IIO device itself. In case a userspace app has an =
open=20
> > > FD for the buffer chardev, we get a reference that is only released w=
hen=20
> > > the FD is closed (which can outlive the device behind bound to its=20
> > > driver). That is why we nullify indio_dev->info and check for it on t=
he=20
> > > read() and write() fops.
> > >=20
> > > FWIW, I raised concerns about this in the past (as we don't have any =
lock=20
> > > in those paths) but Jonathan rightfully wanted to see a real race. An=
d I=20
> > > was too lazy to try and reproduce one but I'm still fairly sure we ha=
ve=20
> > > theoretical (at least) races in those paths. And one of them could be=
 (I=20
> > > think) concurrently hitting a DMA submit block while the device is be=
ing=20
> > > unbound. In that case the DMA chan would be already released and we c=
ould=20
> > > still try to initiate a transfer. I did not check if that would crash=
 or=20
> > > something but it should still not happen.
> > >  =20
> > There are a few places where I've been meaning to have another look
> > at our protections during unregister. May well be problems hiding here
> > and in general the thinking on how to do this in the kernel has slowly
> > been changing so we might be able to clean things up in general.
> >  =20
>=20
> Yeah, I'm fairly sure things like [1] are not enough in preventing potent=
ial nasty
> races (though they should be hard to trigger). OTOH, in [2], we do have p=
roper
> locking.
>=20
> Simple solution would be to use the info lock in the buffer read() and wr=
ite() paths.
> I do realize that's a fastpath but I don't think that would be such a con=
tended lock.
> But we can surely do better and RCU could be a good candidate for this (w=
e could do
> something similar to what gpiolib is doing) and I wouldn't expect it to b=
e that
> complicated to implement. Biggest issue by making info a __rcu pointer wo=
uld be to
> change all IIO drivers to set the pointer with rcu_assign_pointer(). Thou=
gh during
> probe there's no potential race so what we have today should be fine (jus=
t not sure
> if things like sparse would not complain about the "raw" assignment).

Not tried it, but could probably do something cheeky in iio_device_register=
()
using a second pointer (maybe in a union with the first ;)

So I agree, smells bad but I've not chased far enough to know how real the =
problems
are.  In many cases the read only accesses are to data, not to hardware so =
'might'
be fine. I'm just not sure.  I'll try and get time for a close look but won=
't
be until towards the end of November.

Jonathan

>=20
> [1]: https://elixir.bootlin.com/linux/v6.12-rc4/source/drivers/iio/indust=
rialio-buffer.c#L176
> [2]: https://elixir.bootlin.com/linux/v6.12-rc4/source/drivers/iio/indust=
rialio-core.c#L1825
>=20
>=20
> - Nuno S=E1
>=20
>=20
>=20
>=20


