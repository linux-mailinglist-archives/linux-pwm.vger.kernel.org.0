Return-Path: <linux-pwm+bounces-7305-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39445B54E16
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Sep 2025 14:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181F41651CA
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Sep 2025 12:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6974C307481;
	Fri, 12 Sep 2025 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU55n742"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB64305E09;
	Fri, 12 Sep 2025 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680348; cv=none; b=UsBqz8zv0230Dol8/Kbh+38VNns7hGnkIqpcZiPFXjev5xQweWVEvm9lyAdsaI6Ms18YoyloWoca/whelk/ZMmCZ6X9P3rzx5D0sOtT/gcPCagcSNh3mtdMczRUCHFF1WEtulX9WmZJUqvIvX6nCkLMc/AR1rVMg/a9cNPJyB1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680348; c=relaxed/simple;
	bh=FcB/j8jpTTeuUgVYhkcDadPRSSv9aTjPsQanKoFiqeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDp5XO/7ZpvYLT+tQHXkiZdpAK/Bg5Ve0fXDnSrbA1dXjOxsx8GcZN2pruAjJzmrU1frK2cRqBF7cW4PQ95IlwyzujWDTIQfFoTzXn2qYwBXJeP8tfJwhezkoOr1U3gVOY6wDGOtXSq3G146LqcNZUk5nK+vrWfJEpyOvk5V4YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IU55n742; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6500C4CEF1;
	Fri, 12 Sep 2025 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757680347;
	bh=FcB/j8jpTTeuUgVYhkcDadPRSSv9aTjPsQanKoFiqeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IU55n7424YFkl7R89fO1ro6rbYLpxDoWNnQ5RDwzGZWkFpFRaYy8xKAyncIsgmwFs
	 kWBrthguK+Q5SPbSQhIUOQuMGZs2CTi99sKx6wWvPO59ZWte07N8oZ8ZpqutdTCrVN
	 a5anbr6R+aR9xvPhr+Mbuw+xreZXEmvSPvD+h/54KYPbjc+cNs58BnOWFLTFC7iQd6
	 mTu7HzR3N0ASRwQWStFHRMTFgnACZD/UG+bcpITx9z6Pv4gI3zTwmeai//yb+YifXM
	 L4Mb1vchumZCk4NBZ7l45o9JleaftTyPT7v4JtMGzBBH19TCfIAX4TlwEBKk5Q/MfI
	 HfN37v8XYCwsQ==
Date: Fri, 12 Sep 2025 14:32:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2] pwm: rzg2l-gpt: Implementation of the waveform
 callbacks
Message-ID: <6gvpdndagee54h7gr3uqm37rfu4yk2owffxwtszyjvnic2vqvl@pbp3jqcfrzox>
References: <20250814115022.73732-1-biju.das.jz@bp.renesas.com>
 <jb6vcdv3553kbvuzuxdmx7tyxcpmnkaqszks3n4apmt43an6d2@mr4lyezd5a7s>
 <TY3PR01MB1134600B9DF5AA79AE121CD148609A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sgmdvzmvjcipahsk"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB1134600B9DF5AA79AE121CD148609A@TY3PR01MB11346.jpnprd01.prod.outlook.com>


--sgmdvzmvjcipahsk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: rzg2l-gpt: Implementation of the waveform
 callbacks
MIME-Version: 1.0

Hello Biju,

On Thu, Sep 11, 2025 at 09:46:38AM +0000, Biju Das wrote:
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> > Sent: 09 September 2025 16:19
> > On Thu, Aug 14, 2025 at 12:50:20PM +0100, Biju wrote:
> > > -/* Caller holds the lock while calling rzg2l_gpt_config() */ -static
> > > int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > > -			    const struct pwm_state *state)
> > > +static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
> > > +					 struct pwm_device *pwm,
> > > +					 const struct pwm_waveform *wf,
> > > +					 void *_wfhw)
> > > +
> > >  {
> > >  	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > > -	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> > > +	struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
> > >  	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > >  	u64 period_ticks, duty_ticks;
> > >  	unsigned long pv, dc;
> > > -	u8 prescale;
> > > +
> > > +	guard(mutex)(&rzg2l_gpt->lock);
> > > +	if (wf->period_length_ns =3D=3D 0) {
> > > +		*wfhw =3D (struct rzg2l_gpt_waveform){
> > > +			.gtpr =3D 0,
> > > +			.gtccr =3D 0,
> > > +			.prescale =3D 0,
> > > +		};
> > > +
> > > +		return 0;
> > > +	}
> > >
> > >  	/* Limit period/duty cycle to max value supported by the HW */
> > > -	period_ticks =3D mul_u64_u64_div_u64(state->period, rzg2l_gpt->rate=
_khz, USEC_PER_SEC);
> > > +	period_ticks =3D mul_u64_u64_div_u64(wf->period_length_ns,
> > > +rzg2l_gpt->rate_khz, USEC_PER_SEC);
> > >  	if (period_ticks > RZG2L_MAX_TICKS)
> > >  		period_ticks =3D RZG2L_MAX_TICKS;
> > >  	/*
> >=20
> > The code that follows here needs adaption. Other than .apply(),
> > .round_waveform_tohw() is supposed to not fail if the requested period =
is too small but use the
> > smallest possible value then (and return 1).
>=20
>=20
> You mean something like below
>=20
>         if (rzg2l_gpt->channel_request_count[ch] > 1) {
>                 if (period_ticks < rzg2l_gpt->period_ticks[ch])
> -                       return -EBUSY;
> +                       is_small_second_period =3D true;
>                 else
>                         period_ticks =3D rzg2l_gpt->period_ticks[ch];
>         }
> @@ -272,6 +276,9 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_c=
hip *chip,
>         wfhw->prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period=
_ticks);
>         pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
>         wfhw->gtpr =3D pv;
> +       if (is_small_second_period)
> +               return 1;

Just locking at the diff: Yes, that looks about right. I guess you also
need `period_ticks =3D rzg2l_gpt->period_ticks[ch]` in the
is_small_second_period=3D=3Dtrue case.

Best regards
Uwe

--sgmdvzmvjcipahsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjEEtQACgkQj4D7WH0S
/k4mgQf/YqaB99nCURNqmLX97YX5q/F71+F4Alf4Z9rlAXZp1XgbqQTbSJseZD7C
8v+bAiYTi0PAYWrOgOwjoulGqZWyBmdnvk4gmz9Vz/TO6LZfWS0rI2irQihBkvPh
ILfdAkVLBQdCz2nDHgVEbYMxSMa92fb++ME/1JyK9GbLkowESioKi3hzaj/uB1UJ
OD5bidc7+wBPXa9ULO4DclTTVz5rWx6h5alJD8GW/nZokHZK408s3iSRbo3mudia
qQs3Z96ch0F5mXjI+wOfQy7WWNxRu4aFuMvapKjtlOaU+reOJZY7meaIcWOo7tgZ
PlQJFIFIGjDzlGZ4vvTJulGCtCAOhg==
=UeFn
-----END PGP SIGNATURE-----

--sgmdvzmvjcipahsk--

