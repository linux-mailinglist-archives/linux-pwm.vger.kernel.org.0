Return-Path: <linux-pwm+bounces-8662-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ENpFBA452no5QEAu9opvQ
	(envelope-from <linux-pwm+bounces-8662-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Apr 2026 10:40:48 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B692B438484
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Apr 2026 10:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89C103000539
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Apr 2026 08:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354E83845BA;
	Tue, 21 Apr 2026 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzC6Xztf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118382BEC2C;
	Tue, 21 Apr 2026 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776760844; cv=none; b=ciPJU7J8x2s6wFZvlfwhxZopyJlSc9gBMWDeFigqXH/dTfotKps28NRBfQ5gfknj5LsfwOpz0XAl4uHLrEvvo6yLHyX5izPid1sjFTYjTDnDH1gHk5751OU0KM5XpaKuoj0QgF73n99ktQtpH1DCXGumm/MM52Xr20+TZGmkar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776760844; c=relaxed/simple;
	bh=lL3SJ4yZxxEUPCjY46/+Bu+YW/+d5zITDGjxgFXBhII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZacAs8fp5vMDCuTfjgXqA/0/IUCjvl4NXiS6G9Qu9kLubJAy6FFlGQ2YfRWzK7wTg5gc2vmt6kFKv+FjIcQi+U0qNohQfn3jxWHVlGAEagTzv3wklmn9e8aQ9IdnTU++m33p4WzalHr6OCVFtWbPXS0e1VRDo+4G7DnWnm1BK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzC6Xztf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0FAC2BCB0;
	Tue, 21 Apr 2026 08:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776760843;
	bh=lL3SJ4yZxxEUPCjY46/+Bu+YW/+d5zITDGjxgFXBhII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SzC6XztfzndYSOI55OmDnpZ/1JcxoZZ2x9Q7BXBmfsoSE4ypbyrZvxnrhM2EEszRB
	 Jw2ofqE0x6tgWwKO4RgLTIiiy1de60Dm+/BRdvUUsdIeaisJ+KwhkMME93FupDXLrZ
	 ZTADOE6UxrUdFT0QTRQOK+8N2U2bhrP94dfkpDQtHMPw1/tf3ybTq+l45u9wZJt4u4
	 YJOMNGEkAzyuQdyt+dOZsI3Pbmg8eg+IVvzr5HsjVby4tJCYG16AOicND95F/mxI5I
	 zf/0+kUBi3ATarUYyVhOdLmnrpXIen3GoFj1OacygtLrFKfMqXcaWYOI6zUN1wBpOu
	 6HwBosiIJ1G6g==
Date: Tue, 21 Apr 2026 10:40:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v5 4/9] pwm: rzg2l-gpt: Convert to waveform callbacks
Message-ID: <aec2GeV_aP6rOtFg@monoceros>
References: <20260420104332.153640-5-biju.das.jz@bp.renesas.com>
 <TYRPR01MB156193428AFA2FE631556EEDA852F2@TYRPR01MB15619.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dufzpb2udqlmhipg"
Content-Disposition: inline
In-Reply-To: <TYRPR01MB156193428AFA2FE631556EEDA852F2@TYRPR01MB15619.jpnprd01.prod.outlook.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,bp.renesas.com,vger.kernel.org,glider.be];
	TAGGED_FROM(0.00)[bounces-8662-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: B692B438484
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--dufzpb2udqlmhipg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 4/9] pwm: rzg2l-gpt: Convert to waveform callbacks
MIME-Version: 1.0

Hello Cosmin,

On Mon, Apr 20, 2026 at 05:55:07PM +0000, Cosmin-Gabriel Tanislav wrote:
> > @@ -291,21 +286,26 @@ static int rzg2l_gpt_config(struct pwm_chip *chip=
, struct pwm_device *pwm,
> >  	if (rzg2l_gpt->channel_request_count[ch] > 1) {
> >  		u8 sibling_ch =3D rzg2l_gpt_sibling(pwm->hwpwm);
> >=20
> > -		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch)) {
> > +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch, NULL)) {
> >  			if (period_ticks < rzg2l_gpt->period_ticks[ch])
> > -				return -EBUSY;
> > +				is_small_second_period =3D true;
> >=20
> >  			period_ticks =3D rzg2l_gpt->period_ticks[ch];
> >  		}
> >  	}
> >=20
> > -	prescale =3D rzg2l_gpt_calculate_prescale(period_ticks);
> > -	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
> > +	wfhw->prescale =3D rzg2l_gpt_calculate_prescale(period_ticks);
> > +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
> > +	wfhw->gtpr =3D pv;
> > +	wfhw->gtccr =3D 0;
> > +	if (is_small_second_period)
> > +		return 1;
> >=20
> > -	duty_ticks =3D mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate=
_khz, USEC_PER_SEC);
> > -	if (duty_ticks > period_ticks)
> > -		duty_ticks =3D period_ticks;
> > -	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, prescale);
> > +	duty_ticks =3D mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt->rat=
e_khz, USEC_PER_SEC);
> > +	if (duty_ticks > RZG2L_MAX_TICKS)
> > +		duty_ticks =3D RZG2L_MAX_TICKS;
>=20
> I know this change from > period_ticks to > RZG2L_MAX_TICKS has been
> suggested by you, Uwe, but is this correct if period_ticks was set to a
> smaller value in the earlier sibling channel condition?

Indeed this is irritating. I assume I missed that and take the blame for
the wrong suggestions. Depending on how hardware copes with such a
configuration it might be ok to keep the code as is, but a comment would
be justified in this case.

> >  	/*
> >  	 * GPT counter is shared by multiple channels, we cache the period ti=
cks
> > @@ -314,6 +314,61 @@ static int rzg2l_gpt_config(struct pwm_chip *chip,=
 struct pwm_device *pwm,
> >  	 */
> >  	rzg2l_gpt->period_ticks[ch] =3D period_ticks;
> >=20
>=20
> This should be part of rzg2l_gpt_write_waveform().
>=20
> Otherwise, if pwm_round_waveform_might_sleep() is called without=20
> pwm_set_waveform_might_sleep() being called immediately after with the
> rounded waveform, the software state will become out of sync with the
> hardware state.

Indeed, the tohw and fromhw callbacks must have no side effects.
There isn't a set_waveform call after each round_waveform.

Best regards
Uwe

--dufzpb2udqlmhipg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnnN/4ACgkQj4D7WH0S
/k55fwf/eQ1tR2L/cExPpeN3IcGsA/GSnPWIoXhrgRYLZ9129Yk5xZ5uEHTEQqTj
uQrEcGpmvEi8Hb/lhcU+7K949Aye1EMdmrXOSlUtTMNDNegENcfE9rnA8Ewi+auA
uxJfcWzZnlf0eFvAbvdi4qzXOEu2Hd5MwxAW3Hz4sEi8hY7KjcsXe/7y1ThVyua/
m0N88Cq056JkWGvX8wZJMq7DXGdTkAnKfjoAmsGnJF7zIuC+7OVRJmGz9W5JiuDy
rm/bw2zx9GGPrG0qYNmIkXFT+qPfG3/QpcaF8Co0TimwzntEiBQURjHOuQkB+Ww4
vVe2dEoMVQzoGPFszVXM2mmOvT/ltw==
=1ObM
-----END PGP SIGNATURE-----

--dufzpb2udqlmhipg--

