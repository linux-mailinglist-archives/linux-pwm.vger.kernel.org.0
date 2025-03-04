Return-Path: <linux-pwm+bounces-5071-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23312A4E528
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 17:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0CA3BD52A
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 15:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B810628FFD3;
	Tue,  4 Mar 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZD+JurH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873BD28FFD1;
	Tue,  4 Mar 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102741; cv=none; b=SPlmKBO0CRxkKTEmBbd1wmtWIO8O4OPY7zFpWeeS8JauaE6uFs6lYtppvtDHw5NPuNUiMOxbUcke5phHQ3Lhqlg5oVbCT0SJvxeObY2NLuHaSrsbl4sCUeXTYchEoWydpgkHfS58QBVu765x0/MaNqYLXF3ePjzPfD8uH2hmKLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102741; c=relaxed/simple;
	bh=LmmUDES04mGNUWw2sZpLxKlKIEhol4VSewPbqfeMwjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAv4kJITcn9VHQ/wFqvGnVm5+fIWKHb0+U959f6o7qRdkkZHSLrsaBw/biMZMs7vm0u/ojvDgm8uB9Szyge9nBRF/uJTKo2MLFE9+B9FOCO58bSiRVjbrZAS5/ckyg84rm9AnMqeoWftKZySsuI5zlfdw1Wt8czWcgF1gxkHm7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZD+JurH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52463C4CEE9;
	Tue,  4 Mar 2025 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741102741;
	bh=LmmUDES04mGNUWw2sZpLxKlKIEhol4VSewPbqfeMwjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZD+JurHongg1WwduqAxWTQ69tyw66IF/3nzgBX1onoxvJlLBhoHhhMqMJWAuygVv
	 /67gnTJruEMl5+W/PQDjbmpwPTuC0UR9tmXqNj18L2RnNkWRvSZEzb8ZaMuhLi0PUK
	 zJpdLlcqYaW0CASb6ji1B/rP3M5P0casgYYXquFsdXn4haNsP5xIjFrtZpb8Dat9l1
	 dehXeU/7j9r/MQsXCFtDr5O6IHxuVClJi7L6bgOQST9sgvYKEyn8SrSclDTu5ryrOV
	 8TExnjqcIcQIRRWAPmu498leI/mCu9d/K09tIegF/PUAffHNGpYn8nJ6Tvkvuz8j1+
	 KSOR9OSe2qWqg==
Date: Tue, 4 Mar 2025 16:38:57 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, Kamal Wadhwa <quic_kamalw@quicinc.com>, 
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] leds: rgb: leds-qcom-lpg: Compute PWM value based on
 period instead
Message-ID: <5uk75v3cpy2hymdgjyvqdwyda34t2pn7jqyupyvhmqgo3wlxkl@uim4lth7lipa>
References: <20250303-leds-qcom-lpg-compute-pwm-value-using-period-v1-1-833e729e3da2@linaro.org>
 <ylnkjxnukss7askv7ip5htrb4tyjzhpw7jim2se6rloleq5h6w@ngk7lbk26hxj>
 <Z8bGHV4PIkY4te6V@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jxjluywedohfii7r"
Content-Disposition: inline
In-Reply-To: <Z8bGHV4PIkY4te6V@linaro.org>


--jxjluywedohfii7r
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC] leds: rgb: leds-qcom-lpg: Compute PWM value based on
 period instead
MIME-Version: 1.0

On Tue, Mar 04, 2025 at 11:21:33AM +0200, Abel Vesa wrote:
> On 25-03-04 07:24:32, Uwe Kleine-K=F6nig wrote:
> > Hello Abel,
> >=20
> > On Mon, Mar 03, 2025 at 06:14:36PM +0200, Abel Vesa wrote:
> > > Currently, the implementation computes the best matched period based
> > > on the requested one, by looping through all possible register
> > > configurations. The best matched period is below the requested period.
> >=20
> > The best matched period *isn't above* the requested one. An exact match
> > is fine.
> >=20
>=20
> Yep, that's better. Will re-word.
>=20
> > > This means the PWM consumer could request duty cycle values between
> > > the best matched period and the requested period, which with the curr=
ent
> > > implementation for computing the PWM value, it will result in values =
out
> > > of range with respect to the selected resolution.
> >=20
> > I still don't understand what you mean with resolution here.
>=20
> Resolution in this context means the number of bits the PWM value
> (register value) is represented in. Currently, the driver supporst two PWM
> HW subtypes: normal and Hi-Res. Normal ones recently got support for chan=
ging
> the resolution between 6 bits or 9 bits. The high resolution ones support
> anything between 8 bits and 15 bits.
>=20
> >=20
> > I guess you spend some time understanding the workings of the driver and
> > you also have an example request that results in a hardware
> > configuration you don't like. Please share the latter to a) support your
> > case and b) make it easier for your reviewers to judge if your change is
> > indeed an improvement.
>=20
> Sure, will bring up the 5ms period scenario again.
>=20
> When the consumer requests a period of 5ms, the closest the HW can do in
> this case is actually 4.26ms. Since the PWM API will continue to ask for
> duty cycle values based on the 5ms period, for any duty cycle value
> between 4.26ms and 5ms, the resulting PWM value will be above 255, which
> has been selected as best resolution for the 4.26ms best matched period.
>=20
> For example, when 5ms duty cycle value is requested, it will result in a
> PWM value of 300, which overflows the 255 selected resolution.

this is the bug you have to fix then. The PWM value (that defines the
duty cycle) has to be calculated based on .period =3D 4.26 ms and capped
at 255. So assuming that 0 yields a duty cycle of 0 ms and 255 yields
4.26 ms, a request for .duty_cycle =3D 4; + .period =3D 5 should result in =
an
actual .duty_cycle =3D 239 / 255 * 4.26 ms =3D 3.992705882352941 ms;
+ .period =3D 4.26 ms.

> > > So change the way the PWM value is determined as a ratio between the
> > > requested period and duty cycle, mapped on the resolution interval.
> >=20
> > Is the intention here that (for the picked period) a duty_cycle is
> > selected that approximates the requested relative duty_cycle (i.e.
> > .duty_cycle / .period)?
>=20
> Yes, that exactly what the intention is.
>=20
> > If it's that: Nack. This might be the right thing for your use case, but
> > it's wrong for others, it complicates the driver because you have spend
> > more effort in the calculation and (from my POV even worse) the driver's
> > behaviour deviates from the usual one for pwm drivers. I admit there are
> > some other lowlevel pwm drivers that are not aligned to the procedure I
> > described that should be used to determine the register settings for a
> > given request. But I target a common behaviour of all pwm drivers
> > because that is the only way the pwm API functions can make a promise to
> > its consumers about the resulting behaviour. Reaching this is difficult,
> > because some consumers might depend on the "broken" behaviour of a given
> > lowlevel driver (and also because analysing a driver to check and fix
> > its behaviour is an effort). But "fixing" a driver to deviate from the
> > declared right behaviour is wrong and includes all downsides that make
> > me hesitate to align the old drivers to the common policy.
>=20
> OK, fair enough. But I still don't get what you expect from the provider
> that can't give the exact requested period. Do you expect the consumer
> to request a period, then provider compute a best matched one, which in
> our case is pretty far, and then still give exact duty cycle values ?
>=20
> Like: request 5ms period, get 4.26ms instead, then request 4ms duty
> cycle and get exact 4ms duty cycle when measured, instead of a
> proportional value to the best matched period?

Yes.
=20
> If so, then what happens when consumer asks for 5ms duty cycle?
> Everything above the 4.26ms will just represent 100% duty cycle.

Yes.

> > The policy to pick a hardware setting is a compromise between consumer
> > needs and what is straight forward to implement for (most) hardware
> > drivers. Please stick to that. If you want more flexibility and
> > precision in your consumer, please consider converting the pwm driver to
> > the waveform API.
>=20
> That means the pwm_bl driver will have to switch to waveform API, IIUC.

Yes, if the pwm_bl driver cares about that precision it has to switch.

While the waveform API isn't expressive enough, just use 4260000 as
period in the pwm_bl device, or ignore the missing precision.

> That might break other providers for the pwm_bl consumer, wouldn't it?

Given that the consumer side of the waveform API only works with drivers
that are converted: maybe. You could fall-back to the legacy API.
=20
> > > [...]
> > > ---
> > > base-commit: 0067a4b21c9ab441bbe6bf3635b3ddd21f6ca7c3
> >=20
> > My git repo doesn't know that commit. Given that you said your patch
> > bases on that other series, this isn't surprising. Please use a publicly
> > available commit as base parameter, otherwise you (and I) don't benefit
> > from the armada of build bots because they just silently fail to test in
> > this case.
>=20
> Well, this is a pretty common practice. When the patch relies on other
> patches that haven't been merged yet, but are still on the list, you
> can't really base it on a publicly available commit.
>=20
> And the fixes patchset that this is based on is needed for this to work.
>=20
> So I really don't get how this can be done differently.

You can still use --base=3D$newestpubliccommit and git-format-patch will
at least give a chance to the build bots by emitting patch-ids for all
the commits between the public base and the start of your patch series.

Best regards
Uwe

--jxjluywedohfii7r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfHHo8ACgkQj4D7WH0S
/k7OHQf8D54fFKGPCmwFzm1pqUVRJmEfRHlxBqo84n+xLsEbGtFdc9YO/yGABfu3
zsfp5NhfT1k+EEZfKvWvICyyu3JfWCscLbEb/Xze81GU6DuKr1LG9r+1YX3NFuwZ
j3XKYd70DcZRVykUmUdDPG22tunWrSNWFYBGc432VqCvNR6eXSy5ifYndAYHxpbu
56xnutFpNZheu/G8JnsFk5bzODRBwcK2U14YXwmDrmky1nNGKTX+OEGLuBv/7CVI
svGHRH9pJ0qQuOChyTKoAFbb47qdUH5q60YCY9lQyqEBhcaXrg/2jX/O43h5yKZ0
s5oX/wYmFFPvRaijPPNFjjCyPdkivA==
=G6kq
-----END PGP SIGNATURE-----

--jxjluywedohfii7r--

