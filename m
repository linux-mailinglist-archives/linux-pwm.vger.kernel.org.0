Return-Path: <linux-pwm+bounces-2911-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 821FF93C3BE
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2024 16:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412B1281017
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jul 2024 14:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D7A19B5B1;
	Thu, 25 Jul 2024 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRIDgccQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464C519B3D7;
	Thu, 25 Jul 2024 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916539; cv=none; b=dwUtfmhZdpOUO1fJ7WHYUvYEoG58EKvDsgNWO2QzSNcFf2M5D5ynpy8xHgOaEn9ZLLYRHqHfr6neGfuyLcQQVT7yWYS8ZOF+EWkLXhUx4z+knCq0DsztG0CBzCK5CcDAqi794ULWOuNUhytoB9HP5KgoZZppfRxdn8maAopOatM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916539; c=relaxed/simple;
	bh=lCkNGP6BwpG3qp3Mm4CGq2Fx3/FD3ZVT8U9NcNF2ZJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYUMDNbkoIHS9R7dcOyhxTb2bDUQdWAu7TmWJwrfs4w6rydTNVQ4extCiudqPRoVBymGMcJX/uB3SllTkCi5Hmu8NmgO4I88wdRNRl/5zu1HCUtDywAs1/1SwsXPwhq9jS0EvBjGxheggYppgMKzQc+B66h9gbqvJJpPwVB0Hrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRIDgccQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879A0C116B1;
	Thu, 25 Jul 2024 14:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721916538;
	bh=lCkNGP6BwpG3qp3Mm4CGq2Fx3/FD3ZVT8U9NcNF2ZJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HRIDgccQOj8PnzY095nsGqPT+mr4nIFriPRvqY82nshh1uLiOZYK3veF4IiVsrtwN
	 hoWDA5r3xn6rracah49kemGE3ZJZ5EZipJzl5jgLiMn7GsbuguSU4lKZ7XEXzE4h1q
	 MqaeDW5wP6d7/oYkg9PiS8yS5TVBWLxNsHAFybO1ikJ595vi9KDoiix7RCWqXqa8vh
	 p9HyatcVePjVfsXhEIqrJspJBlQ5jo7Ete2I87+BVR+2l4kkLRKnJ3w+viPwv1FT0B
	 8pMsWk0Uo9R+HR689xsCD0gzk0iYJSgrz9FoYiOoAKwX72V9Od615xYGTOLw30++Wp
	 2TDlIUWQrfRzA==
Date: Thu, 25 Jul 2024 15:08:53 +0100
From: Conor Dooley <conor@kernel.org>
To: George Stark <gnstark@salutedevices.com>
Cc: Rob Herring <robh@kernel.org>, conor+dt@kernel.org, ukleinek@kernel.org,
	krzk+dt@kernel.org, neil.armstrong@linaro.org, khilman@baylibre.com,
	jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
	hkallweit1@gmail.com, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@salutedevices.com,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: pwm: amlogic: Add new bindings for
 meson A1 PWM
Message-ID: <20240725-excursion-waving-0e0ad54006d4@spud>
References: <20240710234116.2370655-1-gnstark@salutedevices.com>
 <20240710234116.2370655-3-gnstark@salutedevices.com>
 <20240712125219.GA472311-robh@kernel.org>
 <55f73e79-2d21-48ba-8486-26ee168c7bc3@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AEa+sma8hE8p4pQ+"
Content-Disposition: inline
In-Reply-To: <55f73e79-2d21-48ba-8486-26ee168c7bc3@salutedevices.com>


--AEa+sma8hE8p4pQ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 06:12:26PM +0300, George Stark wrote:
> Hello Rob, Conor
>=20
> On 7/12/24 15:52, Rob Herring wrote:
> > On Thu, Jul 11, 2024 at 02:41:15AM +0300, George Stark wrote:
> > > The chip has 3 dual-channel PWM modules PWM_AB, PWM_CD, PWM_EF.
> > >=20
> > > Signed-off-by: George Stark <gnstark@salutedevices.com>
> > > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> >=20
> > Missing ack from Conor. When you submit new versions, it is your
> > responsibility to add tags.
>=20
> I had Conor's ack in my mind but his response was related to the
> squashed patch (a1 compatible + power domains) and the current patch was
> a bit different that's why I didn't dare to add the ack.
>=20
> Conor, do you mind if I resend this patch (and may be [PATCH v4 1/3])
> with your ack?

Ye, both are fine :+1:

--AEa+sma8hE8p4pQ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqJccgAKCRB4tDGHoIJi
0sHPAQDeOLhDsX5+jGRVXKBfRLGLispOYdy49zQvALwWzLRdLAEAi40OY1ZWJZ9t
kiSLOzkb9TUhQHF/25tOvwTZdfuUbgM=
=Hrx7
-----END PGP SIGNATURE-----

--AEa+sma8hE8p4pQ+--

