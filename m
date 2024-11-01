Return-Path: <linux-pwm+bounces-4002-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FE29B9693
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 18:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5481D281E93
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 17:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B411CC179;
	Fri,  1 Nov 2024 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrWXqw2l"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A2B84E1C;
	Fri,  1 Nov 2024 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482355; cv=none; b=mCRGXUhVs9V77NZo3yib2dCfM71/TqvlBQKpciEkHY5SYw+uRCUw7UZ8PYJGfsLdNhalaEQ4W00+LDneoMlDX92hCvOZPFCofspBkciyaIdXQivYq/eG+qrK8oUDwkilmKQ3etbMzJPTu2nF6yv6LBjE3L7+an8im9lKa9qFIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482355; c=relaxed/simple;
	bh=TBvAl6JwjlFw9tXtrS/PEMIswlFCQXaZiHrErj6MXUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCjV9VRf7pwC9AVphXznCNHP1QaCXP4ENTbjbC02/6i1mDSKLu9S2CwXDztBN8aWJBAFLK2QcfrrmJNg5WBGHL4O5K962eME6TDaXAcXnUN7QUVcC6V+UjUlpm/RRN7RhJ6viPPYaczD/f8j0CKrPk0eD+hXzj3raoJxweH8QZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrWXqw2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E84C4CED1;
	Fri,  1 Nov 2024 17:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730482354;
	bh=TBvAl6JwjlFw9tXtrS/PEMIswlFCQXaZiHrErj6MXUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OrWXqw2lUOsFBtj20dBa5dnuFNP0ZFvvjJMSTHp18F8FK9gjwaSpdNSvC9tLr0XW/
	 7HNRkDVtYeZtarVzdx9MCJ2u4g1fFqxqmd3XVxSvXYfK91vGELXrZiVu1LV5HYSdGC
	 IEA1k+uRYGUxz2U7NDm2wQJ3uka3v3JfbSU19wJgOFl7brZbqNj5rLk3ssIM+BPcLx
	 wpA/vaEpg7QgN/N3zSsFiNXDqRfFp7YICFZzQoQl8+2mwrXzUm7CnAFQIQpJKr5qO2
	 gX8o/6yws99zxCw0xfYQXo1MXp9vtG6wDqGdU28zAuikQgTkOFIk/TUvchXy5oXJDM
	 b2EoPolNJ+okQ==
Date: Fri, 1 Nov 2024 17:32:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Guillaume Stols
 <gstols@baylibre.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ad7606: finish pwm_get_state_hw() TODO
Message-ID: <20241101173228.1db50f7c@jic23-huawei>
In-Reply-To: <iajs2rk7odutqwoih4h6besd4b4nnksap6om5r7i2cw5arqcip@rvztnliokuk3>
References: <20241029-pwm-export-pwm_get_state_hw-v2-0-03ba063a3230@baylibre.com>
	<20241029-pwm-export-pwm_get_state_hw-v2-2-03ba063a3230@baylibre.com>
	<iajs2rk7odutqwoih4h6besd4b4nnksap6om5r7i2cw5arqcip@rvztnliokuk3>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Oct 2024 09:28:01 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> On Tue, Oct 29, 2024 at 04:18:50PM -0500, David Lechner wrote:
> > Replace the call to pwm_get_state() with a call to pwm_get_state_hw() in
> > the ad7606 driver. This allows reading the sampling_frequency attribute
> > to return the rate the hardware is actually running at rather than the
> > rate that was requested. These may differ when the hardware isn't
> > capable of running at exactly the requested frequency.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >=20
> > I went ahead and made this patch since it is trivial, but it would be
> > nice to get a Tested-by from Guillaume to make sure it actually works
> > as expected.
> > ---
> >  drivers/iio/adc/ad7606.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> > index 8b2046baaa3e..1581eb31b8f9 100644
> > --- a/drivers/iio/adc/ad7606.c
> > +++ b/drivers/iio/adc/ad7606.c
> > @@ -762,11 +762,9 @@ static int ad7606_read_raw(struct iio_dev *indio_d=
ev,
> >  		*val =3D st->oversampling;
> >  		return IIO_VAL_INT;
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> > -		/*
> > -		 * TODO: return the real frequency intead of the requested one once
> > -		 * pwm_get_state_hw comes upstream.
> > -		 */
> > -		pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> > +		ret =3D pwm_get_state_hw(st->cnvst_pwm, &cnvst_pwm_state);
> > +		if (ret < 0)
> > +			return ret;
> >  		*val =3D DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, cnvst_pwm_state.period);
> >  		return IIO_VAL_INT;
> >  	} =20
>=20
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
Probably not something we need to hurry so assuming it is fine, please
send again after the merge window.

>=20
> There is a slight inconsistency compared to ad7606_set_sampling_freq():
>=20
> ad7606_set_sampling_freq uses
>=20
> 	cnvst_pwm_state.period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
>=20
> . So if cnvst_pwm_state.period happens to be 3 ns then reading
> the freq value yields 333333333, but if you feed freq=3D333333333 into
> ad7606_set_sampling_freq() it sets period =3D 4.
>=20
> To fix that you'd better use a plain / here in ad7606_read_raw().
> (Note that with using round-closest for both there are still corner
> cases, e.g. period =3D 31796 ns yields freq =3D 31450.496917851302 but
> setting freq =3D 31450 yields 31796.50238473768 and so 31797.)

Ouch.

>=20
> Best regards
> Uwe


