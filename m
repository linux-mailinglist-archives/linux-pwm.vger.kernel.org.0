Return-Path: <linux-pwm+bounces-5216-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302C1A67099
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 10:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975F417CAF6
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 09:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842BB1F8BC8;
	Tue, 18 Mar 2025 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gERZE2J6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C071F09A4;
	Tue, 18 Mar 2025 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291924; cv=none; b=OVyAcA8C8zIC6LKvSpBwMIfpNCnWS+ZBT0scTMi38VHwv5rcRe51wEvlEGU0/zLza8G5ivHkHAEUJWm+J2p9GdSHH1c7CP4IvrvCiwVjHxjxLg3X+aEB4l7GgQC2huV2TwLFkZiLQ1NXV6NYU8GYtU2jmhVC7oTn19Blwwh0iAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291924; c=relaxed/simple;
	bh=rIv8VlVOxSuJur5JDCw3pSvHApUCZsZ5GDJ7zqykz5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uV8KZIbqnvAMgRHyDVl+6prZwgJxxfz1SjQ6e7bNMTKrIbrpX4jh41ZKPNl+3QBZL49/24yvpt2KQ913t6F529e83ubiqbsr88eG6jOKYwX4SYjJlmAvroZCl8r1qJuGhh3otgFcEj6eEXFu5Wvx4BrRFn2n2vujC6vSKJ8rl2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gERZE2J6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE103C4CEE9;
	Tue, 18 Mar 2025 09:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742291923;
	bh=rIv8VlVOxSuJur5JDCw3pSvHApUCZsZ5GDJ7zqykz5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gERZE2J6zooGvuswzdC7FPECEuSDJ0Wrvm2iREzU/ZYNrTWiGWd2P86/GPPUDj8L5
	 V4I3oGCRk3DKOtCBGOwZrag7KsjlP7vStV2EyaW5Q5Lrsh7/hgtmJYEzT0uFrJ/YmY
	 1UKw4WDZFHUtIAJPkKGOxFxqmPzJ2nVPK+3XH9VYqTcA6IYIexEbBq3Uhlu3l18S6T
	 xgOWTUs2woAlYX14MQJ6P0GGtu3735CwE2einMfYM5dsEnfmtCBxFmZCiiZx5iN0ZE
	 XI/ceP6aUXiZMR5wpI8l+X/1JN3UudDEeEafmbHva+qyUUFSK9keln0tw2Bw8hPrPs
	 TcQQizKS8sBvQ==
Date: Tue, 18 Mar 2025 10:58:40 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Maud Spierings <maud_spierings@hotmail.com>
Cc: william.qiu@starfivetech.com, hal.feng@starfivetech.com, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, p.zabel@pengutronix.de
Subject: Re: [PATCH v17] pwm: opencores: Add PWM driver support
Message-ID: <a4qprb2s7kqzhgewf54oxelrr4inuka5ozsadqybnft3moe6xy@kigsy6zevieq>
References: <20250106103540.10079-1-william.qiu@starfivetech.com>
 <VE1P189MB1024E9669B8CFCB943D633E7E3102@VE1P189MB1024.EURP189.PROD.OUTLOOK.COM>
 <7kfpvipnkirfacy3ro3qb3cmbw5fv5dlyjh3qowc4juvmcb2jj@43zpytio2273>
 <AM7P189MB10091DAF204BB660E619A01FE3112@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ro5b6furdfkkey7o"
Content-Disposition: inline
In-Reply-To: <AM7P189MB10091DAF204BB660E619A01FE3112@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>


--ro5b6furdfkkey7o
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v17] pwm: opencores: Add PWM driver support
MIME-Version: 1.0

Hello Maud,

On Tue, Jan 07, 2025 at 07:37:13AM +0100, Maud Spierings wrote:
> I did some more digging, took a look at the pwm-backlight driver in the
> vendor kernel, and it seems there are some tweaks there [1] (all the way =
at
> the bottom). And it explains some things, first off why it didn't error
> before without the inverted polarity, because it sets this value in the
> pwm-backlight driver in that kernel.
>=20
> but the interesting line is this one:
> |brightness =3D (u8)~brightness;

Huh, that confirms my prejudice that vendor trees are bad. Even in
combination with

	state.polarity =3D PWM_POLARITY_INVERSED;

in the probe function this is horrible. This effectively renders your
testing useless.

Best regards
Uwe

--ro5b6furdfkkey7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfZQ84ACgkQj4D7WH0S
/k6VrAgAs7IYKuIcq+df0vCZcvdH57zh+VQ4IIA2Zhc9LvCKh1bZjgWhWPvCMRlv
4TEJCwFA2Ntm40UMoHLfFhZ6DQ1NN3t5tsz93X79HgukqzZxztDi+4EfLirRMat/
t+xvVJ0N6G7fE4j2f/Yh2MAmjPyOVxNnOTdVAYU2mYqKJ5fSXlXbih2bF8MTV/o9
U5WXd65P4+IhyXhpzlGfZn7UumTLNGXiu5cNed10Am6c5ePfhECQoOdurqo1+a90
xLHBVrE76Rq5PRPxR+EH9yRqZJoDppAGs+M1CRw4C0a2BN07Ll/k3r/DkmPzYYK1
OvIqo78K1mt4o9OO+gttoGV+1aBkfA==
=aEVk
-----END PGP SIGNATURE-----

--ro5b6furdfkkey7o--

