Return-Path: <linux-pwm+bounces-2162-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E411E8BDB33
	for <lists+linux-pwm@lfdr.de>; Tue,  7 May 2024 08:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1234B22796
	for <lists+linux-pwm@lfdr.de>; Tue,  7 May 2024 06:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14EA6EB5C;
	Tue,  7 May 2024 06:12:22 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79776D1C8
	for <linux-pwm@vger.kernel.org>; Tue,  7 May 2024 06:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715062342; cv=none; b=SHKZRWGvlrJTENOM/mMQgnReKZIDV+6cGkZbrY2THg5lMOoaAXe7qGo8ja9N5GV7u1BMhEJSz4OIO1L6q4HfPWymS1iUc0XYtpiPGEUyx9Mk8RS7tb/CGDIPpHL7TcxklcT36jFYVK9go23WtGHaeh7Y1yJSZa8iF6SCYX4pyEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715062342; c=relaxed/simple;
	bh=8XqQwsxR8w1AbRDfoVc/cG4/HZfrVaK0CB3Vrl6hQZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkSW5BEPjhbDqaZAmvpyqoOcNkx1qA0V1+n0ADvMBptoPgDQx2y9umeCcKiWX0TYS4c3dbynYaK65NbY7dnzDKyOagTcWLLG2gM+Dlc2KugR2cHpj9waNKxuJv9Kul/t9GqgHjhs8FMbIc+N25eHLgdNYqthUC4tZUrDSuz5KcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4E3k-0003eL-Bu; Tue, 07 May 2024 08:12:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4E3j-0002vF-V3; Tue, 07 May 2024 08:12:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s4E3j-00H9IA-2p;
	Tue, 07 May 2024 08:12:15 +0200
Date: Tue, 7 May 2024 08:12:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 8/8] pwm: Add support for pwmchip devices for faster and
 easier userspace access
Message-ID: <vr6abwhdc33u6tbymbu2x77lg3abqr57oi2ia34am3xu2n2ohv@xltf3jxjac3f>
References: <cover.1710670958.git.u.kleine-koenig@pengutronix.de>
 <8d3acfc431ecd431d6cced032dcb58ad2579474c.1710670958.git.u.kleine-koenig@pengutronix.de>
 <20240507011103.GA26136@rigel>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mqsg4kboz4kgd36f"
Content-Disposition: inline
In-Reply-To: <20240507011103.GA26136@rigel>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--mqsg4kboz4kgd36f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 09:11:03AM +0800, Kent Gibson wrote:
> On Sun, Mar 17, 2024 at 11:40:39AM +0100, Uwe Kleine-K=F6nig wrote:
> > With this change each pwmchip can be accessed from userspace via a
> > character device. Compared to the sysfs-API this is faster (on a
> > stm32mp157 applying a new configuration takes approx 25% only) and
> > allows to pass the whole configuration in a single ioctl.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> > new file mode 100644
> > index 000000000000..ca765bfaa68d
> > --- /dev/null
> > +++ b/include/uapi/linux/pwm.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> > +
> > +#ifndef _UAPI_PWM_H_
> > +#define _UAPI_PWM_H_
> > +
> > +#include <linux/ioctl.h>
> > +#include <linux/types.h>
> > +
> > +struct pwmchip_state {
> > +	unsigned int hwpwm;
> > +	__u64 period;
> > +	__u64 duty_cycle;
> > +	__u64 duty_offset;
> > +};
> > +
>=20
> Sorry for being late to the party, but I only ran across this thread by
> accident.
>=20
> Have you considered the implications of sizing and alignment here[1]?
>=20
> Change this to:
>=20
> struct pwmchip_state {
> 	__u32 hwpwm;
>     __u32 __pad;
> 	__u64 period;
> 	__u64 duty_cycle;
> 	__u64 duty_offset;
> };
>=20
> to clarify?

Good catch. There is some pending rework necessary for the inner
mechanism of the pwm framework that has to be done before the ioctl goes
into the mainline. So you're not (too) late with your concerns.

I'll take care of the explicit padding.

Thanks for your attention,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mqsg4kboz4kgd36f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmY5xjoACgkQj4D7WH0S
/k7JtQf/eQwwzOEjDMesUsWr8mf2IiK+jxkFKd+XfRoKXt/SIAtRAa8nz+VV4uvF
Y0XS6Im3iz2uCU6LXHfqrn46H4hb2YniD8xZp+Vp3FlSawIgXT78i7+i1s8vtoeC
DFDAAb26CHOj1TeYikn/EnN7Y9Prj01LaigzqNSlQk4Y7sUM+Z1MvZ8LAqjtZYHR
cL8jf3muM77qMM1oji58Fp+sB/N3j7VK/eWpeLO9REzAfoqOoAl9iTr4n+aZVPrk
hIPYn5wh3LU0eAtgH1dj6ETYnwJAt59IVcr3Zh93iHtJ9yAlFf7MHA5ZRYvjIruP
0nTA4/4l5BhjvPw+aXSYRJNN2GkB/A==
=Axxw
-----END PGP SIGNATURE-----

--mqsg4kboz4kgd36f--

