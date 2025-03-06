Return-Path: <linux-pwm+bounces-5113-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 217AEA559D7
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Mar 2025 23:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F0318961CE
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Mar 2025 22:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F7E27C853;
	Thu,  6 Mar 2025 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXpdDUed"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C231F4185;
	Thu,  6 Mar 2025 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300448; cv=none; b=QzvUuBsraGUo4ONYqQ+CfCNF78z33hdnTDrYpzmN7i9rDYMVaq/BtI/SxW/nuS+nuzElwj25IZs+pmWtSoQMpR37OssAzt7jsVBGSFH9Fk7bKUlus8+ztHC+2Ew31hfIOF5RkY/qsBKXCL0SHviUjVmdG90BdYACsxsO0niT2ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300448; c=relaxed/simple;
	bh=CXCKeZkp6dZsmf/hiWK30FF5AgD2Ai6Q0+7StDdRcMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cg7oWiV//jDtNbxL7aEcBZ62wdoIznG2XjVO44ncKOTfztFJlfi2bYyRmfjN2AM9+P54MNRXG6d58aH3SrXGe4kjqeqMRbP548rrE8CtKOoiDgvu/lVY35xgUps0HwYe5sevN9Y/bnVBHuNm2CI/W/oU+xsejNVsN2KH+fLaxr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXpdDUed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7C4C4CEE0;
	Thu,  6 Mar 2025 22:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741300447;
	bh=CXCKeZkp6dZsmf/hiWK30FF5AgD2Ai6Q0+7StDdRcMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bXpdDUedTk+W+Me0w8gH+5QKskkivlz9zFAWKMHGDU/4f4zoCpwAzcx73uMcOYxjC
	 gS5r+t1IlVxZ+KFqVW0qEmproX4Kwwh4KvKh1sw3TyGupseCn4Z7uRx9TlxIW4wupb
	 w6eia0vtwQoOWQU4SywH+efsg3khqKYHJ2213ATsQa9q3UFE3NvwwSKzZaUSxGYPnt
	 SDC59ggUXSqxYnf3gGdB7Lq1jy5IunpcUXVXNTxOAiyOIwsyYUdZEO1KyTOIt/R+/1
	 7btsw9s3/SMVG33gFxfmO0euvst7prNjh38A3lDgae35FGd4UnMRxG/YWmNXkOasfC
	 8TqbjXVw8zkow==
Date: Thu, 6 Mar 2025 23:34:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: neil.armstrong@linaro.org
Cc: Abel Vesa <abel.vesa@linaro.org>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, 
	Kamal Wadhwa <quic_kamalw@quicinc.com>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] leds: rgb: leds-qcom-lpg: Compute PWM value based on
 period instead
Message-ID: <6abeyzvb6iyqd2z3phemoesk3c7n7ye5ybcpe6wtlepl3jhimu@g74ptgnq5wkv>
References: <20250303-leds-qcom-lpg-compute-pwm-value-using-period-v1-1-833e729e3da2@linaro.org>
 <ylnkjxnukss7askv7ip5htrb4tyjzhpw7jim2se6rloleq5h6w@ngk7lbk26hxj>
 <Z8bGHV4PIkY4te6V@linaro.org>
 <5uk75v3cpy2hymdgjyvqdwyda34t2pn7jqyupyvhmqgo3wlxkl@uim4lth7lipa>
 <Z8hgj11p+TY1546x@linaro.org>
 <997d4cf8-5256-4413-8059-569451962a83@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a7hxg7ecmf44lnyx"
Content-Disposition: inline
In-Reply-To: <997d4cf8-5256-4413-8059-569451962a83@linaro.org>


--a7hxg7ecmf44lnyx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC] leds: rgb: leds-qcom-lpg: Compute PWM value based on
 period instead
MIME-Version: 1.0

Hello Neil,

On Wed, Mar 05, 2025 at 03:42:56PM +0100, neil.armstrong@linaro.org wrote:
> On 05/03/2025 15:32, Abel Vesa wrote:
> > On 25-03-04 16:38:57, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Mar 04, 2025 at 11:21:33AM +0200, Abel Vesa wrote:
> > > > On 25-03-04 07:24:32, Uwe Kleine-K=C3=B6nig wrote:
> > > > > I guess you spend some time understanding the workings of the dri=
ver and
> > > > > you also have an example request that results in a hardware
> > > > > configuration you don't like. Please share the latter to a) suppo=
rt your
> > > > > case and b) make it easier for your reviewers to judge if your ch=
ange is
> > > > > indeed an improvement.
> > > >=20
> > > > Sure, will bring up the 5ms period scenario again.
> > > >=20
> > > > When the consumer requests a period of 5ms, the closest the HW can =
do in
> > > > this case is actually 4.26ms. Since the PWM API will continue to as=
k for
> > > > duty cycle values based on the 5ms period, for any duty cycle value
> > > > between 4.26ms and 5ms, the resulting PWM value will be above 255, =
which
> > > > has been selected as best resolution for the 4.26ms best matched pe=
riod.
> > > >=20
> > > > For example, when 5ms duty cycle value is requested, it will result=
 in a
> > > > PWM value of 300, which overflows the 255 selected resolution.
> > >=20
> > > this is the bug you have to fix then. The PWM value (that defines the
> > > duty cycle) has to be calculated based on .period =3D 4.26 ms and cap=
ped
> > > at 255. So assuming that 0 yields a duty cycle of 0 ms and 255 yields
> > > 4.26 ms, a request for .duty_cycle =3D 4; + .period =3D 5 should resu=
lt in an
> > > actual .duty_cycle =3D 239 / 255 * 4.26 ms =3D 3.992705882352941 ms;
> > > + .period =3D 4.26 ms.
> >=20
> > OK then. The patchset that fixes this according to your suggestion is
> > already on the list (re-spun):
> >=20
> > https://lore.kernel.org/all/20250305-leds-qcom-lpg-fix-max-pwm-on-hi-re=
s-v4-0-bfe124a53a9f@linaro.org/

Yeah, I thought so. It's in my review queue.

> > > > > > So change the way the PWM value is determined as a ratio betwee=
n the
> > > > > > requested period and duty cycle, mapped on the resolution inter=
val.
> > > > >=20
> > > > > Is the intention here that (for the picked period) a duty_cycle is
> > > > > selected that approximates the requested relative duty_cycle (i.e.
> > > > > .duty_cycle / .period)?
> > > >=20
> > > > Yes, that exactly what the intention is.
> > > >=20
> > > > > If it's that: Nack. This might be the right thing for your use ca=
se, but
> > > > > it's wrong for others, it complicates the driver because you have=
 spend
> > > > > more effort in the calculation and (from my POV even worse) the d=
river's
> > > > > behaviour deviates from the usual one for pwm drivers. I admit th=
ere are
> > > > > some other lowlevel pwm drivers that are not aligned to the proce=
dure I
> > > > > described that should be used to determine the register settings =
for a
> > > > > given request. But I target a common behaviour of all pwm drivers
> > > > > because that is the only way the pwm API functions can make a pro=
mise to
> > > > > its consumers about the resulting behaviour. Reaching this is dif=
ficult,
> > > > > because some consumers might depend on the "broken" behaviour of =
a given
> > > > > lowlevel driver (and also because analysing a driver to check and=
 fix
> > > > > its behaviour is an effort). But "fixing" a driver to deviate fro=
m the
> > > > > declared right behaviour is wrong and includes all downsides that=
 make
> > > > > me hesitate to align the old drivers to the common policy.
> > > >=20
> > > > OK, fair enough. But I still don't get what you expect from the pro=
vider
> > > > that can't give the exact requested period. Do you expect the consu=
mer
> > > > to request a period, then provider compute a best matched one, whic=
h in
> > > > our case is pretty far, and then still give exact duty cycle values=
 ?
> > > >=20
> > > > Like: request 5ms period, get 4.26ms instead, then request 4ms duty
> > > > cycle and get exact 4ms duty cycle when measured, instead of a
> > > > proportional value to the best matched period?
> > >=20
> > > Yes.
> > > > If so, then what happens when consumer asks for 5ms duty cycle?
> > > > Everything above the 4.26ms will just represent 100% duty cycle.
> > >=20
> > > Yes.
> >=20
> > I still think this is wrong.

Well, if you asked for .period =3D 5ms and .duty_cycle =3D 5ms you even
asked for a 100% relative duty cycle. So while I agree that you don't
usually get exactly what you requested, this is a bad example to rant
about.

> I also think this is very wrong, duty_cycle is a factor of the period,
> so if the HW gives a lower period, the term Pulse Width Modulation implies
> the ratio between the "duty_cycle" and the period is important,
> not the exact duration of the components of the modulation.

In Linux .duty_cycle was expressed in ns and not relative to period.
Apart from that being a historic choice that is hard to change, IMHO
this is a sane choice because in the kernel we have to stick to integer
math and then if you want to express a relative duty_cycle you probably
have to pick a divisor D such that .rel_duty_cycle =3D n represents a
relative duty_cycle of n / D. What to pick for D? 100 to get percent as
unit? Something bigger to increase precision? A power of two to match
usual hardwares but make it less intuitive for humans? Also note that
for some hardwares the "natural" divisor is 255.
=20
> So is this a defect of the PWM API ? why would the API insist on
> having an exact duty_cycle and a random period ?

The way to determine the actual hardware dependent settings for a
requested pair of duty_cycle and period is IMHO straight forward, so
duty_cycle selection isn't more exact than the one for period and period
isn't more random than the one for duty_cycle. It can also happen the
other way round that your request results in an near exact match for
period and a big deviation for duty_cycle. So judging the defects of the
PWM API from just one example is short-sighted.

But still I hear you and the rules were defined as they are as a
trade-off between consumer needs, needed complexity in lowlevel
drivers and what most drivers already did at that time.

Regarding consumer needs: I agree that most consumers care about the
relative duty_cycle. But there are exceptions. I remember a motor where
the absolute length of the duty_cycle defines the rotation speed and the
period was more or less irrelevant. While here the point mostly goes to
"keep relative duty_cycle", it's still a "you cannot please everyone"
situation.

Regarding complexity: A simple PWM typically has a fixed clock input and
there is a register to define the period as a number of clock cycles.
Then there are essentially two subtypes:

 a) the duty_cycle register uses the same time base as the period
    register; and
 b) the duty_cycle register unit is relative to the period length.

Let's assume a clock input rate of 32768 Hz, so one cycle tick is
q :=3D 1 / (32768 Hz) =E2=89=85 0.030517578125 ms. So the typical PWM of ty=
pe a)
has a 16 bit register for period and another one for duty_cycle. I think
it's quite obvious that the chosen policy is very simple to implement
for such a device, so I won't go into that further. Considering the
"keep relative duty_cycle + round down" policy instead and a
request .period =3D 5ms and .duty_cycle =3D 3ms. The best match for .period
is 163q =E2=89=85 4.974365234375 ms. Then to calculate the duty_cycle you h=
ave
do determine: 163q * 3 / 5 =3D 97q =E2=89=85 2.960205078125 ms giving an ac=
tual
relative duty_cycle of 0.5950920245398773. This is quite a good fit.
Using the "use the absolute values" policy we end up with duty_cycle =3D
98q =E2=89=85 2.99072265625 (and the same period) which gives a relative
duty_cycle of 0.6012269938650306. The result is somewhat similar (with
0.6012269938650306 being a slightly better result as
0.5950920245398773?), but the calculation needed for the "use the
absolute values" is a bit simpler. In summary we can say that it's
quite natural to round down both values in the "use the absolute values"
case independent of your preferred policy, while rounding down in
combination with the "keep relative duty_cycle" policy is tends to be
worse because the duty_cycle register value is rounding down the result
of a calculation that has a rounded value as input, so precision
suffers. If your reflex now is to not always round down but sometimes(?)
round up, please consider maintenance effort: This must be reviewed and
it must be explained to driver authors. So that's not a good idea.

Now let's consider a PWM of type b) with the same input clock freq. To
be able to define the duty cycle in time units relative to the period,
the period can be a multiple of 256q and the .duty_cycle register is an
8 bit one. 256q is already above 5 ms, so to get a fairer comparison
let's assume a request of .period =3D 1280 ms and .duty_cycle =3D 768 ms
(which is the above request just scaled by 256). So period ends up being
163 * 256q =3D 1273.4375 ms. With the "use the absolute values" policy we
end up with .duty_cycle =3D 163 * 154q =E2=89=85 766.05224609375 ms giving =
an
relative duty_cycle of 0.6015625 and with the "keep relative duty_cycle"
policy you end up with .duty_cycle =3D 163 * 153q =E2=89=85 761.07788085937=
5 ms
and a relative duty_cycle of 0.59765625. In summary for b) there is
again not much difference in the resulting configurations and complexity
is again similar with a slight advantage for "keep relative duty_cycle".

Without having done a complete survey back when I decided about the
policy to pick my impression was that PWMs of type a) were more common.
Also in my impression back then the difference in complexity between the
two policies to chose among is smaller for type b) than for type a)
which gives another slight advantage to "use the absolute values".

Also looking at the drivers back then, "use the absolute values" policy
was the more common one. Additionally I didn't like the fact that for
the "keep relative duty_cycle" policy you have to base the calculation
of duty_cycle on rounded values.
So overall this made me pick the "use the absolute values" policy. And
please believe me when I say this wasn't a whim of the moment decision
but I invested quite some thought.

The example you gave is somewhat a corner case because the requested and
the actual period quite a lot---as you noticed yourself---and can be
worked around by picking a better value for .period as I wrote in my
previous mail. And no matter which policy you pick, depending on the use
case for your consumer you will be able to find such degenerated
examples.

Having said all that (and hoping that this made it better understandable
why we're where we are), there is an effort to improve here and to give
consumers a better control over what they get. (But for the needs of a
backlight this is probably overkill, so I refer again to the suggestion
to pick a period that better matches the hardware.)

Best regards
Uwe

--a7hxg7ecmf44lnyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfKIs4ACgkQj4D7WH0S
/k5G3Qf+LfPLUXjSugs3vSShRzDqiuv/8qLb3jpHnqA1pJg8wJixQ3MOVFSlWP/n
jyJbGRMO8C5fyz7EaBhhSw+HByEmhIku6zoVgVdnJzY6FHkl+ekWmxfgFflmVTEI
8OEf3TcAlVR1VsIGrj1YDorfGnjyAjhBC676mGoGxxlIEFcDzBZxqrSdeF28851n
t4gxDYoWU756+7AWBKqeQmsaK5CU9bQNj1ssayaw02oEUDwBUd7qTcogm3Iy8/uy
t752QOOkuZnaugmBf6viquQ6gf8sfVJ3CeSsaukLIO9uSSGTxiibOM4OloQcq2qo
f49rq9XZc3ymvBsUZa+NcLTQz61n9Q==
=T6yp
-----END PGP SIGNATURE-----

--a7hxg7ecmf44lnyx--

