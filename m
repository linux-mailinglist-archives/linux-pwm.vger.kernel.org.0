Return-Path: <linux-pwm+bounces-7601-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F83DC40A98
	for <lists+linux-pwm@lfdr.de>; Fri, 07 Nov 2025 16:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92293A9E2C
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Nov 2025 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248FD322551;
	Fri,  7 Nov 2025 15:48:57 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5894B261588
	for <linux-pwm@vger.kernel.org>; Fri,  7 Nov 2025 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530537; cv=none; b=fRHH3enOedmsRj8Fa+vLuSo54kuOQnPGQizUoc7HYEXSfGFCu6JYXdMU2s2I2cq+IhT5x65BGZ9hIPT0vEjx1jFEfM7zCAxKw1JPMUM1dQ5f1iQJFT6zyiZ9T1R39F0GUMPIrAsl84RGWnq6OX+tW4vxAEGPeHcDv3F5UbkEIlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530537; c=relaxed/simple;
	bh=NDEH5s9tkXaml4bnZXmxi+KpRoZxflbXTn8hmlbtc68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z21BdhBsZEDhI8UFa7gOx4gkSw+dzyyse68W8mtoN+p3GB+BvcJof2fplWLRfW5rX48I/AuFcm5irhzMp9rk1wnpGY/nWgAm7/RGdF7lANnzGQ69g86MFaeA/hOgeYuBVSP0GKbEzhWo04sXJUo2w9XsSWR0nSXDwhY2vdljj48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1vHOhh-0003vL-EO; Fri, 07 Nov 2025 16:48:45 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1vHOhg-007YOX-2q;
	Fri, 07 Nov 2025 16:48:44 +0100
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1vHOhg-006qle-2T;
	Fri, 07 Nov 2025 16:48:44 +0100
Date: Fri, 7 Nov 2025 16:48:44 +0100
From: Michael Grzeschik <mgr@pengutronix.de>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Daniel Thompson <danielt@kernel.org>, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Pengutronix <kernel@pengutronix.de>, linux-pwm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: apply the initial backlight state
 with sane defaults
Message-ID: <aQ4U3LHBQ7WcYKUd@pengutronix.de>
References: <20250731-blpwm-v1-1-0171fd31bff9@pengutronix.de>
 <aQNRK5ksNDMMve0x@aspen.lan>
 <t6wtfnmnclnzwdpbmdcalvyf3mulmpexnryolxkygqkpx7vdwz@dqwbwvlzawrr>
 <aQ4HY5Hncv1fvxVk@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/DGy73+seDFVJgbs"
Content-Disposition: inline
In-Reply-To: <aQ4HY5Hncv1fvxVk@aspen.lan>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--/DGy73+seDFVJgbs
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2025 at 02:51:15PM +0000, Daniel Thompson wrote:
>On Fri, Nov 07, 2025 at 09:00:33AM +0100, Uwe Kleine-K=F6nig wrote:
>> On Thu, Oct 30, 2025 at 11:51:07AM +0000, Daniel Thompson wrote:
>> > On Thu, Jul 31, 2025 at 10:47:18AM +0200, Michael Grzeschik wrote:
>> > > Currently when calling pwm_apply_might_sleep in the probe routine
>> > > the pwm will be configured with an not fully defined state.
>> > >
>> > > The duty_cycle is not yet set in that moment. There is a final
>> > > backlight_update_status call that will have a properly setup state.
>> > > However this change in the backlight can create a short flicker if t=
he
>> > > backlight was already preinitialised.
>> > >
>> > > We fix the flicker by moving the pwm_apply after the default duty_cy=
cle
>> > > can be calculated.
>> > >
>> > > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> >
>> > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
>>
>> I guess this tag resulted in Lee picking up the change. I wonder if you
>> share my concern and who's responsibility it is now to address it.
>
>You mean the ordering the backlight registration versus setting the
>properties in the probe method?
>
>I definitely share the concern that there's a short window where
>something could request a brightness via sysfs and then have it
>overwritten by the remains of the probe method. Likewise I can't see
>why there would be any problem moving the call to
>pwm_backlight_initial_power_state() before the backlight is registered.
>Thus I'd be happy to see the backlight registered later in the probe
>method.
>
>On the other hand I don't see any problem calling
>backlight_update_status() from the probe method. This is a relatively
>common approach in backlight drivers to impose the initial brightness
>on the hardware without needing extra code paths.
>backlight_update_status() is guarded with a mutex and should be
>idempotent for most drivers. Therefore it is OK even if something gets
>in via sysfs and provokes an update before the probe method has started
>it's own update.
>
>In terms of who should follow up I've got no strong opinions on that.
>It's worth noting that I don't own any hardware that uses a PWM
>backlight so I'm not in a position to test it!

Depending on the setup of the hardware, calling pwm_apply_might_sleep
inbetween before having a fixed definition of how the pwm should be
setup, makes the backlight flicker. Therefor it is better to touch
it as late as possible.

Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--/DGy73+seDFVJgbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmkOFNkACgkQC+njFXoe
LGSKTQ//bm8FDOeYWnsvF9jE4OYmkN9C6U7e/pvbXazGuOH2vAskda9idMA38/4d
8w4cTUgMUCU3IzaTBXOnDC1Zsh1baUbrknKw40Zfp80S9GWubKljfkpjh8OANL8a
JP0SL+txKMAp0wC5KfNR1j4fDqwiYhTnc+G8nTL5idsmXuVWYOxKTydGJ/PHG2l5
1DEsDBKHMpA1p9m+oSlGuE4P0GjB/mQseJYvyS4GSVlI+PlqqR58PUSPqpCDQFVA
4kwvXbFnhZbuFTlgFUoCrZfHKO1CMCuEH384v2QoJiAl9P0jWsbWEOkf5CAqRRU9
CSA9R4ZOQ834QBhDUdCsTyhMPuSmex5tGLmvkeqtcq16n5SkJzL8BMYHGQHl8RQN
oI3/rwNIGJKGGWumv3kHIJsCcnDAcFS+cDgGbVdFfF+dpsGWiCO3BWCXXO7KMH4l
cWl2fUk9FgYAyqB8pUSFEmNdbx0/yIhtKjvSUq5ZTrwqtevSa67hpAijc8G+VorT
7l7f6Evl+iuQisHKRkdKgcpgWsRyekdnYa6JwVGak5oIj2FeymkxVY4+uMEBKaD9
8uP4/zJ1wMCMC6U/n87nzL/VR9oXDPtoM8LFeFF6BwQ5KuPxudKAVbTnm1P0NTmg
IpO5OUhlXOu4eQcEIFv7iJ8CVF7vvUcHNz0FSJIJHIm1sh8/Mn0=
=nlcW
-----END PGP SIGNATURE-----

--/DGy73+seDFVJgbs--

