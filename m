Return-Path: <linux-pwm+bounces-8936-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLZTCIrzCWomvgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8936-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 18:57:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8C3562570
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 18:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11A6B3002302
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 16:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A26834E774;
	Sun, 17 May 2026 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoE6v/gP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BA52DB781;
	Sun, 17 May 2026 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779037064; cv=none; b=R+AU3F3qQJGwZ39z5Ve0YJlCJN6wZeQTvml7HwsueHxWEoZ0ZkadqodHfvEcNdmDFrIAVLbiuMvWfCVFCoRhOzfv++UnkZHL2iVIHFP3YbvcmFmRn7vdTjrNlHG9t6x1eNGoFMKD+Xr4xXW9iWxsJ4qHur/OKlyABn15ynEagRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779037064; c=relaxed/simple;
	bh=PMcHT5ZHobjYwWhgDFQaflRfbCCg4L8Ustalhh0HCbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxAHiU+DYGb6AlG/GU2SHrGonn3mn+urLnPdI/MQkbURPLjHbImz/0xfxZGYTmMF9pn7L7Cg0uGM0XoIrVICAAM+xy246xMDfI8YYuGTChqwsYsM/0HfiBx5dNlemG4JUAft7dhq1xyvD5q9VIKKkeH3p1pBkWxaNHzxHMdIbIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoE6v/gP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470BFC2BCB0;
	Sun, 17 May 2026 16:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779037063;
	bh=PMcHT5ZHobjYwWhgDFQaflRfbCCg4L8Ustalhh0HCbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KoE6v/gPoGvn4j5E8LoAt8XIslIQYFC8AAO4V5nEjvWSJxLhfVVcwDYQKyTU74aLZ
	 UwUUpDyY8undeAXinU6it7sEM+KqeCSE4IL47PueUsZ/plWmARKbRo2+/nf9S4nRXr
	 7yy9blwZOIazjBLSlzFXjC08z2PBdiiXg6RS6/anXLagdjIsgAr4FDVdbWS3nk5bR8
	 toAarHF1djgWCTg3pk11DsPfMyAyT9g16XJ68lY0BJpXrhuIn6m+DYx40U2YFssl4R
	 Z97hDeC19Iv5G2GGBdAx5G2B8KoJA2VgVtsvikQtQnZ8MYDij83saSjbZYRVH+YAOB
	 6T074Jjv1dDUg==
Date: Sun, 17 May 2026 18:57:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v5 4/9] pwm: rzg2l-gpt: Convert to waveform callbacks
Message-ID: <agnynFUowrOA6oqH@monoceros>
References: <20260420104332.153640-5-biju.das.jz@bp.renesas.com>
 <TYRPR01MB156193428AFA2FE631556EEDA852F2@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <aec2GeV_aP6rOtFg@monoceros>
 <TY3PR01MB11346D2A5AD3D030E806594CF862B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hhc5aex5cenulhdj"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346D2A5AD3D030E806594CF862B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Rspamd-Queue-Id: AF8C3562570
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8936-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[renesas.com,gmail.com,vger.kernel.org,glider.be,bp.renesas.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--hhc5aex5cenulhdj
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 4/9] pwm: rzg2l-gpt: Convert to waveform callbacks
MIME-Version: 1.0

Hello Biju,

On Fri, Apr 24, 2026 at 09:01:51AM +0000, Biju Das wrote:
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> > Sent: 21 April 2026 09:41
> > Subject: Re: [PATCH v5 4/9] pwm: rzg2l-gpt: Convert to waveform callbac=
ks
> >=20
> > On Mon, Apr 20, 2026 at 05:55:07PM +0000, Cosmin-Gabriel Tanislav wrote:
> > > > @@ -291,21 +286,26 @@ static int rzg2l_gpt_config(struct pwm_chip *=
chip, struct pwm_device *pwm,
> > > >  	if (rzg2l_gpt->channel_request_count[ch] > 1) {
> > > >  		u8 sibling_ch =3D rzg2l_gpt_sibling(pwm->hwpwm);
> > > >
> > > > -		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch)) {
> > > > +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch, NULL)) {
> > > >  			if (period_ticks < rzg2l_gpt->period_ticks[ch])
> > > > -				return -EBUSY;
> > > > +				is_small_second_period =3D true;
> > > >
> > > >  			period_ticks =3D rzg2l_gpt->period_ticks[ch];
> > > >  		}
> > > >  	}
> > > >
> > > > -	prescale =3D rzg2l_gpt_calculate_prescale(period_ticks);
> > > > -	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
> > > > +	wfhw->prescale =3D rzg2l_gpt_calculate_prescale(period_ticks);
> > > > +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
> > > > +	wfhw->gtpr =3D pv;
> > > > +	wfhw->gtccr =3D 0;
> > > > +	if (is_small_second_period)
> > > > +		return 1;
> > > >
> > > > -	duty_ticks =3D mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->=
rate_khz, USEC_PER_SEC);
> > > > -	if (duty_ticks > period_ticks)
> > > > -		duty_ticks =3D period_ticks;
> > > > -	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, prescale);
> > > > +	duty_ticks =3D mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt-=
>rate_khz, USEC_PER_SEC);
> > > > +	if (duty_ticks > RZG2L_MAX_TICKS)
> > > > +		duty_ticks =3D RZG2L_MAX_TICKS;
> > >
> > > I know this change from > period_ticks to > RZG2L_MAX_TICKS has been
> > > suggested by you, Uwe, but is this correct if period_ticks was set to
> > > a smaller value in the earlier sibling channel condition?
> >=20
> > Indeed this is irritating. I assume I missed that and take the blame fo=
r the wrong suggestions.
> > Depending on how hardware copes with such a configuration it might be o=
k to keep the code as is, but a
> > comment would be justified in this case.
>=20
> Please confirm
>=20
>  /*
>   * duty_ticks were clampled to match either period_ticks of this

I think it's "clamped"

>   * channel or an active sibling channel's period_ticks.
>   */
> if (duty_ticks > period_ticks)
> 	duty_ticks =3D period_ticks;

I think the comment is not needed in this case. (I only wanted a comment
if the comparison against RZG2L_MAX_TICKS was kept.)

> > > >  	/*
> > > >  	 * GPT counter is shared by multiple channels, we cache the period
> > > > ticks @@ -314,6 +314,61 @@ static int rzg2l_gpt_config(struct pwm_c=
hip *chip, struct pwm_device
> > *pwm,
> > > >  	 */
> > > >  	rzg2l_gpt->period_ticks[ch] =3D period_ticks;
> > > >
> > >
> > > This should be part of rzg2l_gpt_write_waveform().
>=20
> Also, if we move this to rzg2l_gpt_write_waveform() there is a rounding
> error possible as we need to use hardware register to calculate
> rzg2l_gpt->period_ticks[ch].
>=20
> Can you please confirm, is it ok for you?

I don't understand that. Why is there a rounding error possible? The
relevant thing here is that a call to the two rounding callbacks is not
supposed to change internal state of the driver or even the hardware.

Best regards
Uwe

--hhc5aex5cenulhdj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoJ84IACgkQj4D7WH0S
/k7Kpwf/UaHuPFk53WwcjQyhKqtg7TsmRF+6xbikSU6GOY5a3heaIoNXoi4xjduD
mQCLpxzX8e5ejlvsGmHInOm0LUDLXUtNq+9rS7BWUbFX6AnXsONbkhhLFHpFiaSU
e0JJr4Z9qcM8t9Ep3gHFc2l5Ofd8sW/tdc5UkmHo1x96SU9rxsdfXPbjxeVwH4+A
xymwVu8vkq/lcQZ7nWuHFAqt9ujSggaXh6W5OZ2t2gLfSDSuuugn5zTRHzDuQZ+K
HCbpq5StSFbEqKlW94qE/QKMj2Lx1Lwc+SfcR7q/DRuWn3LtkR0gSwD70i34IosO
/DzMKFxuiXOdCW1txcqbL/qdYC1Rqw==
=WCET
-----END PGP SIGNATURE-----

--hhc5aex5cenulhdj--

