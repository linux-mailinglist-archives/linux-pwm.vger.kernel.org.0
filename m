Return-Path: <linux-pwm+bounces-7599-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F6AC3ED9D
	for <lists+linux-pwm@lfdr.de>; Fri, 07 Nov 2025 09:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337523AEDAE
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Nov 2025 08:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D70030F94E;
	Fri,  7 Nov 2025 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcNo7yOZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656CA30F944;
	Fri,  7 Nov 2025 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502436; cv=none; b=LhZlCmnpgPZtI57zWC/jEHStEC+4XKXnO5E3teHL/0zM4s24a3pSjt7+OiXT0lONYnY7H/GTSSc6e++XRdMA9yLDnqq25jBFfc2ERKrwuuYZvLcRjnoruVD7a260UOn+yDSuhBWlhz4ekZMDsTmZdgsqQyLBlcEXyeZ8BX12Ijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502436; c=relaxed/simple;
	bh=P7ZsXVZ5D+nou8fyFSMubqNvS7kqSRhtQ9PwJwCoJkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6sAjUAFkqHjjVdtqxbO+bAHHIepSJ0YA/AhCXcKDqFmgPL3H9VsSr83xJPbmK6S1TbTKbchq3fuBNk0tZ6ltDrdTIbOeIXH/uRBn2p/qQepagsnX7lKDYrF8ec38VVmzJ8l8uP89yvzBzatGJM5Rel6aYkhjUvMVFYyGFQhEZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcNo7yOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3FCC19425;
	Fri,  7 Nov 2025 08:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762502435;
	bh=P7ZsXVZ5D+nou8fyFSMubqNvS7kqSRhtQ9PwJwCoJkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcNo7yOZT1jkpyWS4u6YnPy1HO10kxTlk7MC4tbkaKMsqRxBk5gwqAxAWfYFkBZyR
	 vd9RLqUR1f72CsIpW+c8NZdsIywk7YrQAtyy57r/uPSGo0BMezEBL3MtggnvTWuFGT
	 3VFLcZaEMp2Rfn5mt37yLuY6gY28paY0j03PDdmFGDWHM2jSOMl67g7KOnrmIxBAL3
	 L2h4uuC9d6i77RZJkl3rqdxl7XQpV1YiuKrxPgAcUmw4vJxjLyJL1SsJBKW7ymQKBE
	 Tlh7wAMDwIVRMLgpil8+OIRdicO0HI64UHu58bwxskFdZuh2IWtyRO8fz5PWR3dBxi
	 2GkbeX6NPpyZg==
Date: Fri, 7 Nov 2025 09:00:33 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Daniel Thompson <danielt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>, 
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	Pengutronix <kernel@pengutronix.de>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: apply the initial backlight state
 with sane defaults
Message-ID: <t6wtfnmnclnzwdpbmdcalvyf3mulmpexnryolxkygqkpx7vdwz@dqwbwvlzawrr>
References: <20250731-blpwm-v1-1-0171fd31bff9@pengutronix.de>
 <aQNRK5ksNDMMve0x@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qigqjtkdfszv4wy2"
Content-Disposition: inline
In-Reply-To: <aQNRK5ksNDMMve0x@aspen.lan>


--qigqjtkdfszv4wy2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] backlight: pwm_bl: apply the initial backlight state
 with sane defaults
MIME-Version: 1.0

On Thu, Oct 30, 2025 at 11:51:07AM +0000, Daniel Thompson wrote:
> On Thu, Jul 31, 2025 at 10:47:18AM +0200, Michael Grzeschik wrote:
> > Currently when calling pwm_apply_might_sleep in the probe routine
> > the pwm will be configured with an not fully defined state.
> >
> > The duty_cycle is not yet set in that moment. There is a final
> > backlight_update_status call that will have a properly setup state.
> > However this change in the backlight can create a short flicker if the
> > backlight was already preinitialised.
> >
> > We fix the flicker by moving the pwm_apply after the default duty_cycle
> > can be calculated.
> >
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>=20
> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>

I guess this tag resulted in Lee picking up the change. I wonder if you
share my concern and who's responsibility it is now to address it.

Best regards
Uwe

--qigqjtkdfszv4wy2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkNpx4ACgkQj4D7WH0S
/k50PAf+IL1eJnMB5Bc+pOBZif5QNae5oi/5ejE0PPkWIN339t1izDRdG7l7rxI5
sFlCu92yzN97wTnCfw5cxG1oXvWCeKGICnsHpOSQz7S4qKBGlLKND1ZMrvNzlrF1
8gDDGpIht68sLPqKS71QEp9AWXUEwIU9NNRfKQPFURkbrmb3y0Z09Oxys1aADOCu
3q9jLSveFh5pdwAAIdcwpYnPNyOopVZAwdClNk0p1yhrpfc6UDHHRjMiZMgQr1Zo
1YMYSwDjQpFpvPXwoqkJjqf0yw7fFONQ+Ou53DBl6STPb7Z2RGenxV1CVZyUWWSc
KDlsKS4KzVLDGPqdERwCEXlCx3sGPg==
=2JkS
-----END PGP SIGNATURE-----

--qigqjtkdfszv4wy2--

