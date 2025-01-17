Return-Path: <linux-pwm+bounces-4641-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFE0A14BE0
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 10:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAFAB16569D
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 09:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE3B1F91D9;
	Fri, 17 Jan 2025 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZeuHU/f"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC2B1F7918;
	Fri, 17 Jan 2025 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737105210; cv=none; b=aBlK6c9kvhRaj7C1TP13miZ5ISPZ0L45WDkJzy+sHQFaS1t3eAVvuxBhsKqtHE5xZHoJt6TYVvM+hyWdzPINykw3NVWzUmC03V982EgkvB7LO12s1yZmziQ3mLasW0aIsTJry46YBjulJGScnEJYlqZ1tAWFw4T7t6PzyPuhCUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737105210; c=relaxed/simple;
	bh=1KsnWZRM47ob0yKMHcr3DOWNHXKmXmkCHcfTemA3P6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NevEvfvmceeR0VhP3qhZNl8qI0vSrH+jSnyhOphGvXI066y7stbWOWro/2dcuowt6rxXkBo+mNe1MFPxdZcowX2x7I6jcme13KFIcvTCZBbOLNQHvOdg704+6UGiKSD131m/N7ZmFeO3ABRCDTwH5iFS7OxLyIE5nxA8aV8ag5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZeuHU/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC298C4CEDD;
	Fri, 17 Jan 2025 09:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737105210;
	bh=1KsnWZRM47ob0yKMHcr3DOWNHXKmXmkCHcfTemA3P6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZeuHU/f9vPbN64QLhtn/VzwGOWdwH0q/uNSD/FN1ZJy5+hadx0TibyxsIThbtckn
	 RvQhLly68UraAZ91Rz3JLS/Vbo7qYSpX3raWXKd7egjrSfwMBnR93SscU2HWLOLr2u
	 NO2bmlP+eLiv9/2gNGzaMWYmwu99Uu2spgYcjWSco1FJOuAriBpENruLWqsabAYs8z
	 G9/CcrbnE3r1z+TNQ4Z64EtN652OTATDImVFJ/oqncPHHGAeeWMRiOFrJ2blQYJRTE
	 GaLUKRdj3lEfvEZCbhYT8SiDZ3TpxKfQLBC5FCMjQLPyqT4HHwpwNzDHsC6S7E1uoy
	 iLiHsgAjTL0Gw==
Date: Fri, 17 Jan 2025 10:13:27 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/1] pwm: Add support for pwm nexus dt bindings
Message-ID: <si3dqghu4x5k4tc33e2263fgrmivpnub7kj5l4tyg3asmhpkyn@hz62mdvx5lt2>
References: <20250108161853.431915-1-herve.codina@bootlin.com>
 <20250117092704.2b4a1a1c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xj6j3bllxfvfxs74"
Content-Disposition: inline
In-Reply-To: <20250117092704.2b4a1a1c@bootlin.com>


--xj6j3bllxfvfxs74
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/1] pwm: Add support for pwm nexus dt bindings
MIME-Version: 1.0

Hello Herve,

On Fri, Jan 17, 2025 at 09:27:04AM +0100, Herve Codina wrote:
> I haven't receive any feedback on this patch neither the v1 nor this v2.
>=20
> Maybe an issue with the mail. Add u.kleine-koenig@baylibre.com and hope to
> have a feedback on this patch.

It's more a problem with the length of my review queue and the time I
have to spare for it. :-\

As long as your patch appears on
https://patchwork.ozlabs.org/project/linux-pwm/list/ I have it on my
radar eventually.

Best regards
Uwe

--xj6j3bllxfvfxs74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeKHzUACgkQj4D7WH0S
/k6DtQf7Bo1oDQoP0IS+wSo4v/+j+4EqbBuaZ/qxnEkiUythWhmKeuoi6GKq4ug8
34LM5M8M7xXetgLlc6QKI42CuxAOBXOFdTPhRMqJwYsRr107j0cGdS4ImOZTf+mD
d/+k0fH+aOxlkbp5pa1e60qQ4+O8feEb+8qz9RAmTuJyENE8IFbkBbrnqSmGnTBb
4MO4VjGFFx/6rP60ZL0PrPOpwO9wPTTm38jBq4rlQ2Kv9fX7Dg2ofnObMu2Oy0k3
gxyEGRaug/tv/dS9Ctn4qShsB69gsgM6xIAqxSqvAoni93WC6SSXxiSnUz7PT0I+
2K4wAbswObCSrzSfQZ7EkE7GzsOwdw==
=T0rL
-----END PGP SIGNATURE-----

--xj6j3bllxfvfxs74--

