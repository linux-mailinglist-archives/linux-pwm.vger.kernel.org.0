Return-Path: <linux-pwm+bounces-8245-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCciNl7as2mzbgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8245-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 10:35:26 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D22628094D
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 10:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5AE830039BA
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A5B34C9B7;
	Fri, 13 Mar 2026 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1fgZWhZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315EA296BD1;
	Fri, 13 Mar 2026 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394524; cv=none; b=AZykKVIgHy2/YMOtlaideNVoIxfHJCG9TuiwHj4BUP0OswAkv91Ckwd4X2ThIWh8Hj+/+G0XhCJceBLeTHs3YKRmFaQgTFUML3y+Gxk70WAAI+7ttP5693vCvbdBfQFGIDftJGc1zWB0uFZ4kLiM8QvVE996atC5B5/63+73KMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394524; c=relaxed/simple;
	bh=jaB+1CakNZgWgLrsSvJqdBRaLxvtHjkvfKNSDntfPoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCi45HuezeAfPZbrJ2HG8NT4oUUiYJwilnC40VuHikxHnV0zRIdNlXcn0/Y3EGo6z9Mw3RyFxDJpHljpGHHgILf2C3wTwiYgiOSXBGtmlqszjkGsHgvmTqwFCDJo1/ir8HN0Y3fgQv1O2AXg3zocy0oyXFNJJhFa9FWWvqZv5lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1fgZWhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DF5C19421;
	Fri, 13 Mar 2026 09:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773394523;
	bh=jaB+1CakNZgWgLrsSvJqdBRaLxvtHjkvfKNSDntfPoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1fgZWhZiIRWBUrXltVDt8581ft4q34SrHwj3008V6kojox6NwIQD8/daWrJnEXgr
	 d/JpICTQFLUC1+P/Qn8AqDvitk7M1HBldKls0yOgd+sH9Y9cAuIeM7U7CBxetqTiLz
	 P4+KyonaeKEacI3+zCW9Lqf/M4dlWDh0tnPEu39paHM3ulkwd/uOSpC8Ic1M9vRZ4g
	 l7FaEWk9Sr2y3sIEudvjxvCBs82Jgr4ymbiMhcNrKh+9EZvOC3br+Z9YVHx+fsLbea
	 E4RSLoa6nYE3tFTe9+nKUST1bsF6D3ncHXFJfyqA8v7FCEpZjNZkqy6tTXrAVotAVK
	 yPrX9Z/uIS0CQ==
Date: Fri, 13 Mar 2026 10:35:21 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add support for AD5706R DAC
Message-ID: <abPZ79S_ME8p6s9V@monoceros>
References: <20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wagw2cm65uqxofpr"
Content-Disposition: inline
In-Reply-To: <20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8245-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,analog.com:email,analog.com:url]
X-Rspamd-Queue-Id: 7D22628094D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--wagw2cm65uqxofpr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/3] Add support for AD5706R DAC
MIME-Version: 1.0

Hello,

On Wed, Mar 11, 2026 at 08:23:16AM +0800, Alexis Czezar Torreno wrote:
> This series adds support for the Analog Devices AD5706R, a 4-channel
> 16-bit current output digital-to-analog converter with SPI interface.
>=20
> The AD5706R features:
>   - 4 independent current output DAC channels
>   - Configurable output ranges (50mA, 150mA, 200mA, 300mA)
>   - Hardware and software LDAC trigger with configurable edge selection
>   - Toggle and dither modes per channel
>   - Internal or external voltage reference selection
>   - PWM-controlled LDAC
>   - Dynamic change SPI speed
>=20
> The driver exposes standard IIO raw/scale/offset channel attributes for
> DAC output control, sampling frequency for PWM-based LDAC timing, and
> extended attributes for device configuration including output range
> selection, trigger mode, and multiplexer output.
>=20
> This driver is developed and tested on the Cora Z7S platform using
> the AXI SPI Engine and AXI CLKGEN IP cores. The 'clocks' property
> enables dynamic SPI clock rate management via the CLKGEN.
>=20
> Datasheet: https://www.analog.com/en/products/ad5706r.html
>=20
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>

This series was Cc:d to me an linux-pwm, however I don't spot any usage
of the pwm subsystem. If you still see some relevance for my feedback,
please highlight what I'm missing here.

Best regards
Uwe

--wagw2cm65uqxofpr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmz2lcACgkQj4D7WH0S
/k5AlAf+MpLrNXwY63GRMuOxGThV9deu2QgL+NB9DyCH+4Z3FDfD3MUCBdSEvEnY
Kn1vlqOmHXzSEXZ+05bRCa2qp+YhfWGtbbjiGmNwhgFSCFe6IG6I+CTRUFgKOEEc
rm0TMWhfvA+7ugiv10Qi2kW7ivKvyPqlZXXF/gc8hV4x6wOJKQ1jWqImpi9Jqp/O
vHvpff7A0CIHUTkktCEYO2SJq4bRUGXFRd2s0zgB6Dh5sK8a48ZVn8saCxuZv2vW
BL5oxjBwSg7xvOJnwmkbEhFV5PQcx+SxULxroZJqdas7DNM7m+6l23RHAdJ9RvF6
5KDJoyImdMVZyPM2JRNsIv01kMpl5g==
=HW+P
-----END PGP SIGNATURE-----

--wagw2cm65uqxofpr--

