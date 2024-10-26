Return-Path: <linux-pwm+bounces-3916-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA129B1998
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Oct 2024 17:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3861F20F28
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Oct 2024 15:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CB113CFA8;
	Sat, 26 Oct 2024 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROUfwoHD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5AD25776;
	Sat, 26 Oct 2024 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729957776; cv=none; b=DjV5mXi84IrpglJUHV4dLZAP9lnt7KbNrOWIsedGAYOHWPSLUjyv9jCvZ/R1c9OtCyq6xdTb3v05+mgkqtxG0s89NkVCAIEEOyyVzfCTP9ZRYf9OfnnpzqwILsIJFUMQ7677UNaiQWPfqtlohofwi3K5Zq/PB8rPUX2TOwgOuT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729957776; c=relaxed/simple;
	bh=lns98+PNciQorhbT1dyC64/JqvwqnmfplPF/UxapmYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K89bI+TvTR+yYNzs2zs4OjxxTH2a0cekdhD/HYIQj5XSev4RaYKTUZ8JWXX5IREd8QJbvrsgsryKGRi50JsEWq9nCMCi8IC9rA4Dgz7xaSvMs/T2HsW2WZx49Zphf/p1THHLI8qAOweQ5+hkTj2IAkHbRwb4c8J/N00Z8VDVDR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROUfwoHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E480C4CEC6;
	Sat, 26 Oct 2024 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729957776;
	bh=lns98+PNciQorhbT1dyC64/JqvwqnmfplPF/UxapmYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ROUfwoHDWiK8mPfUlFGxqlOtakOkhw2HygLVFt7HDlldWbU+UuhGbQCXH8YBOekiG
	 K0s0qItWQ1mhjVXQnbLbTi042ZAYqNc18ubPW9hBtAGRhQT4baOsX09uaU5sHAqADO
	 QaRdlZjxH90okNbth+ddZ/J4LHY6W/FtfVfL6+imwA4xfVrlkC+Ne11Weto+xkOlFZ
	 WZ4bJ2R94mvvLPVR4Ps7SP5zVjVzoYpa16vI4DVjd6vISzLvIKNw8f5iXs8ezwtJF7
	 JHxPKNiwG2keiqilGDWJ8n2GxEkxC9Y+y9+VwDa4lGsjzVLX3dznTHuZJHfVVVrhnl
	 5I3tezRU6VV4w==
Date: Sat, 26 Oct 2024 16:48:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH RFC v4 11/15] iio: buffer-dmaengine: add
 devm_iio_dmaengine_buffer_setup_ext2()
Message-ID: <20241026164815.47de1ffa@jic23-huawei>
In-Reply-To: <dc52cda0-47d9-4cbf-a68e-0af304edc32e@gmail.com>
References: <dc52cda0-47d9-4cbf-a68e-0af304edc32e@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Oct 2024 20:40:42 +0200 (GMT+02:00)
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> Oct 25, 2024 18:42:02 David Lechner <dlechner@baylibre.com>:
>=20
> > On 10/25/24 8:24 AM, Nuno S=C3=A1 wrote: =20
> >> I still need to look better at this but I do have one though already=20
> >> :)
> >>
> >> On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote: =20
> >>> Add a new devm_iio_dmaengine_buffer_setup_ext2() function to handle
> >>> cases where the DMA channel is managed by the caller rather than=20
> >>> being
> >>> requested and released by the iio_dmaengine module.
> >>>
> >>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >>> ---
> >>>
> >>> v4 changes:
> >>> * This replaces "iio: buffer-dmaengine: generalize requesting DMA=20
> >>> channel"
> >>> --- =20
> >
> > ...
> > =20
> >>> @@ -282,12 +281,38 @@ void iio_dmaengine_buffer_free(struct=20
> >>> iio_buffer *buffer)
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_buffer_to_dmaengine_bu=
ffer(buffer);
> >>> =C2=A0
> >>> =C2=A0=C2=A0=C2=A0 iio_dma_buffer_exit(&dmaengine_buffer->queue);
> >>> -=C2=A0=C2=A0 dma_release_channel(dmaengine_buffer->chan);
> >>> -
> >>> =C2=A0=C2=A0=C2=A0 iio_buffer_put(buffer);
> >>> +
> >>> +=C2=A0=C2=A0 if (dmaengine_buffer->owns_chan)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_release_channel(dmaengine_b=
uffer->chan); =20
> >>
> >> Not sure if I agree much with this owns_chan flag. The way I see it,=20
> >> we should always
> >> handover the lifetime of the DMA channel to the IIO DMA framework.=20
> >> Note that even the
> >> device you pass in for both requesting the channel of the spi_offload=
=C2=A0=20
> >> and for
> >> setting up the DMA buffer is the same (and i suspect it will always=20
> >> be) so I would
> >> not go with the trouble. And with this assumption we could simplify a=
=20
> >> bit more the
> >> spi implementation. =20
> >
> > I tried something like this in v3 but Jonathan didn't seem to like it.
> >
> > https://lore.kernel.org/all/20240727144303.4a8604cb@jic23-huawei/
> > =20
> >>
> >> And not even related but I even suspect the current implementation=20
> >> could be
> >> problematic. Basically I'm suspecting that the lifetime of the DMA=20
> >> channel should be
> >> attached to the lifetime of the iio_buffer. IOW, we should only=20
> >> release the channel
> >> in iio_dmaengine_buffer_release() - in which case the current=20
> >> implementation with the
> >> spi_offload would also be buggy. =20
> >
> > The buffer can outlive the iio device driver that created the buffer? =
=20
>=20
> Yes, it can as the IIO device itself. In case a userspace app has an open=
=20
> FD for the buffer chardev, we get a reference that is only released when=
=20
> the FD is closed (which can outlive the device behind bound to its=20
> driver). That is why we nullify indio_dev->info and check for it on the=20
> read() and write() fops.
>=20
> FWIW, I raised concerns about this in the past (as we don't have any lock=
=20
> in those paths) but Jonathan rightfully wanted to see a real race. And I=
=20
> was too lazy to try and reproduce one but I'm still fairly sure we have=20
> theoretical (at least) races in those paths. And one of them could be (I=
=20
> think) concurrently hitting a DMA submit block while the device is being=
=20
> unbound. In that case the DMA chan would be already released and we could=
=20
> still try to initiate a transfer. I did not check if that would crash or=
=20
> something but it should still not happen.
>=20
There are a few places where I've been meaning to have another look
at our protections during unregister. May well be problems hiding here
and in general the thinking on how to do this in the kernel has slowly
been changing so we might be able to clean things up in general.

I 'think' the person who looked at this in most depth was Lars-Peter but
long long ago!

Jonathan


> - Nuno S=C3=A1


