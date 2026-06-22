Return-Path: <linux-pwm+bounces-9344-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jr54Mss/OWoDpQcAu9opvQ
	(envelope-from <linux-pwm+bounces-9344-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jun 2026 15:59:39 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CBD6B01A9
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jun 2026 15:59:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BzJFqr4v;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9344-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9344-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5AC4D3029AE4
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jun 2026 13:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D4B3B7756;
	Mon, 22 Jun 2026 13:58:59 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B0A3B52E9;
	Mon, 22 Jun 2026 13:58:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136739; cv=none; b=qrGLa/gC2weEueYN8IoYgVFI+d7qefIDNwcELKwICv7HrlK4kmBUYeCVIANnc1tTrJ6DaOxmUpsWUIhcPgMXXBGPcorX7fRsH2VPiK5tEVUUNCvt6fume5wDkQ6YV3hwPa+LY/YF1fHAudApRA9BXeRAIcxgKysuxnecV/Bd+ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136739; c=relaxed/simple;
	bh=RMuryjbqR4QGFPnaiMmHflqcTDGukwORBKhd4cxIM8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0LyUJ7gaStOfgwo9TjelmX3i20oxOi0W5MiwGtJdxL+55bz5eygWLESDjcLudC+6DwLObePOBziVrtdC2G+M3zfGIGFo9yK1gmk3tdAki1R9qaPxqW5f/2HOoy5fuWhsqC31FgAJAIL6EtFAfplK2rv2wtHTF9gSHSmRVyt10Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzJFqr4v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EA5071F000E9;
	Mon, 22 Jun 2026 13:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782136738;
	bh=ma7GG9JqqkbvKJpNf62is11NvQwdnoPTxdQj7gsd56s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BzJFqr4vfL4LAA28ZP0WfCkRAMw0nJl3cCS1oudoPaqrsOQB8tsElTGEbUVZXGmR9
	 phxyzt6p6IieO3qcqqKInF8QHWuQl806Ym0IyztdN+8W1aIKNxw35gAtCP5OmQE9nr
	 C4gSIF6LnpyJhgqYJ3W3gjbK88quNuDdNeHTb1P2lpQY3yO9e+IrJ5LKAIj7uuGt6O
	 QeNR6EuXX5k88Q8wyf05GJ4+hrfjPwSse0+bBdsp5hH0Z6I4nRHFYykDDUTgcdpXCB
	 KidJeE7rkZL5Y4hm6sUeBREpoTos2KlK3KBCpTeQfaypFlK3FTUfJscnd9f+QKKHrA
	 c8tKY76cBH7zw==
Date: Mon, 22 Jun 2026 15:58:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pwm: loongson: Fix low pulse buffer register handling
Message-ID: <ajk5jfEGCAj9QXGO@monoceros>
References: <20260616-pwm-loongson-fix-v1-0-491dbf260a7f@gmail.com>
 <20260616-pwm-loongson-fix-v1-1-491dbf260a7f@gmail.com>
 <ajLDoiFEO_8Y5_1S@monoceros>
 <CAJhJPsWZptQobeTOORjhMvpX_BWVs8xzh3+L2mr5mZbSbdXYeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="egnkms35dxt752db"
Content-Disposition: inline
In-Reply-To: <CAJhJPsWZptQobeTOORjhMvpX_BWVs8xzh3+L2mr5mZbSbdXYeg@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:keguang.zhang@gmail.com,m:zhoubinbin@loongson.cn,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:keguangzhang@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9344-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[monoceros:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69CBD6B01A9


--egnkms35dxt752db
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] pwm: loongson: Fix low pulse buffer register handling
MIME-Version: 1.0

On Sat, Jun 20, 2026 at 04:22:55PM +0800, Keguang Zhang wrote:
> On Thu, Jun 18, 2026 at 12:04=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@=
kernel.org> wrote:
> >
> > On Tue, Jun 16, 2026 at 07:13:17PM +0800, Keguang Zhang via B4 Relay wr=
ote:
> > > From: Keguang Zhang <keguang.zhang@gmail.com>
> > >
> > > The Loongson PWM register at offset 0x4 is documented as the Low
> > > Pulse Buffer Register, which stores the low pulse width rather than
> > > the duty cycle.
> > >
> > > However, this register was incorrectly defined and treated as a
> > > duty-cycle register. As a result, the duty cycle and low pulse cycle
> > > are swapped in the generated PWM waveform.
> > >
> > > Program the low pulse (period - duty) into the register and
> > > adjust pwm_loongson_get_state() accordingly when reconstructing the
> > > duty cycle.
> > >
> > > Also return -ERANGE when the requested period exceeds the hardware
> > > 32-bit limit instead of silently truncating the value.
> >
> > This is the intended behaviour.
> >
> > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > ---
> > >  drivers/pwm/pwm-loongson.c | 29 ++++++++++++++---------------
> > >  1 file changed, 14 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> > > index 31a57edecfd0..dc77f82fd888 100644
> > > --- a/drivers/pwm/pwm-loongson.c
> > > +++ b/drivers/pwm/pwm-loongson.c
> > > @@ -22,6 +22,7 @@
> > >   */
> > >
> > >  #include <linux/acpi.h>
> > > +#include <linux/bitfield.h>
> > >  #include <linux/clk.h>
> > >  #include <linux/device.h>
> > >  #include <linux/init.h>
> > > @@ -33,10 +34,12 @@
> > >  #include <linux/units.h>
> > >
> > >  /* Loongson PWM registers */
> > > -#define LOONGSON_PWM_REG_DUTY                0x4 /* Low Pulse Buffer=
 Register */
> > > +#define LOONGSON_PWM_REG_LOW         0x4 /* Low Pulse Buffer Registe=
r */
> > >  #define LOONGSON_PWM_REG_PERIOD              0x8 /* Pulse Period Buf=
fer Register */
> > >  #define LOONGSON_PWM_REG_CTRL                0xc /* Control Register=
 */
> > >
> > > +#define LOONGSON_PWM_MAX_PERIOD              GENMASK(31, 0)
> > > +
> > >  /* Control register bits */
> > >  #define LOONGSON_PWM_CTRL_REG_EN     BIT(0)  /* Counter Enable Bit */
> > >  #define LOONGSON_PWM_CTRL_REG_OE     BIT(3)  /* Pulse Output Enable =
Control Bit, Valid Low */
> > > @@ -118,20 +121,16 @@ static int pwm_loongson_enable(struct pwm_chip =
*chip, struct pwm_device *pwm)
> > >  static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> > >                              u64 duty_ns, u64 period_ns)
> > >  {
> > > -     u64 duty, period;
> > > +     u64 low, period;
> > >       struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip=
);
> > >
> > > -     /* duty =3D duty_ns * ddata->clk_rate / NSEC_PER_SEC */
> > > -     duty =3D mul_u64_u64_div_u64(duty_ns, ddata->clk_rate, NSEC_PER=
_SEC);
> > > -     if (duty > U32_MAX)
> > > -             duty =3D U32_MAX;
> > > -
> > > -     /* period =3D period_ns * ddata->clk_rate / NSEC_PER_SEC */
> > >       period =3D mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NSEC=
_PER_SEC);
> > > -     if (period > U32_MAX)
> > > -             period =3D U32_MAX;
> > > +     if ((!FIELD_FIT(LOONGSON_PWM_MAX_PERIOD, period)))
> > > +             return -ERANGE;
> >
> > As noted above, this is wrong. If period is too big, you're supposed to
> > pick the biggest possible period and not return an error.
> >
>=20
> Understood. However, in this case the difference between the requested
> and actual
> period can become quite significant. Returning success means userspace
> may assume the requested configuration was applied while the generated
> waveform is substantially different.
>=20
> Wouldn't returning an error be preferable in such cases, as it makes the
> hardware limitation visible to userspace instead of silently applying a
> different configuration?

That sounds good, but doesn't work consistently and without surprises.

Assuming a clk_rate of 24 MHz the maximal period is

	0xffffffff / (24000000 Hz) =3D 178956970625 ns

=2E

Then with your suggestion implemented (as I understand it) the mapping
=66rom requested period to actual period looks as follows::

	178956970624 ns -> 178956970583.33334 ns
	178956970625 ns -> 178956970625 ns
	...
	178956970666 ns -> 178956970625 ns
	178956970667 ns -> -ERANGE

=46rom the consumer's point of view, how do you motivate that 178956970666
still works while 178956970667 doesn't? IMHO the only consequent
implementation then is to let 178956970626 already return an error.
But then it's surprising again, that when requesting 178956970624 ns
you get 178956970583.33334 ns on loongson, while for a hardware that has
178956970583.33334 ns as its maximal period, it's an error.

That consideration convinced me back then to not return an error for too
high values, which is the only sane option left then (unless I missed
something?)

With the waveform API you can query the capabilities and thus prevent
consumer surprises.

Best regards
Uwe

--egnkms35dxt752db
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmo5P50ACgkQj4D7WH0S
/k6T1wf9GGm302qe+ByOBi+g1fDJcpF8XWPGX/2iWM4hZo9ypUwJ/ulDu1GDwieM
zee83kmb+ilzcdiUm0JVaaXWy/JMQaSU5Aofl1Jyy8zqcN5Ue8oMfGoU0ljfIHsq
vLPjeD79/D3Cv0Fck/Kb3abjN5ZVCUCYFoOxaLIDqwEvYPNg+PR+yy7TXQPSPV47
GkMm1Zr4nPlXvHtmJAotHgst8zuw+zQZzFg0Wtl0htoRDQwK8vLRU6isOuIVR8cj
pC7Yx37cgcRMiLd+caPiwnZz4T3Qa5gKLPneN6ZJ3Gci6kXFd4fOTv1kQZPVrezp
lhzJB5UCrEVDlXhcdG9D5IRfq1mSxQ==
=8rCR
-----END PGP SIGNATURE-----

--egnkms35dxt752db--

