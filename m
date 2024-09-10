Return-Path: <linux-pwm+bounces-3190-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A04973CFE
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 18:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397B0283EA3
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 16:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689F319FA77;
	Tue, 10 Sep 2024 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aak9+NUd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A03C2AEF1;
	Tue, 10 Sep 2024 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984534; cv=none; b=CKiX1aywBRsDvdPnAEnaMZ0LT3oELAjkDRM0z17MO7tAZeqnrKXkgrEzQvUw4Us0alL3EnrFlEposCB9R9jtcZzZEISIwbq8YyGJCwxLv0UI54dmsZV1V//iebFv/C3RHTvIecwy+nJUq7Bg2KJTTX/XkpQ8BxRjoUsdIuogbFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984534; c=relaxed/simple;
	bh=Izu951Sl9t2/R5OLHami79GgbINGuYVw9e04vhzirIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piUSUT+wXj01yqui+xfrOjMv3umSkbs1o+O3rCADtaX8YwMyLX14FSzycdjhKilQjYjQyWljHfKubptjxTwhgKJLHss4DkYGRXgup0dmQHYvOtIUEuA+e+tZw3c2FcGSmSYRaMNzU0SGIwjPzrMmpYRi2lLCHXmZEHgIqVHQnbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aak9+NUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CF6C4CEC3;
	Tue, 10 Sep 2024 16:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725984533;
	bh=Izu951Sl9t2/R5OLHami79GgbINGuYVw9e04vhzirIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aak9+NUdwOtEelTeAYRYCgqaTI7v898hkuQZ14wneZHbota+fjdl0Z9+E3C1rl2yo
	 bUviukvri0YZDUzG6ATWCuXLkjGJz9kwFROCzrtU8VNmg5lV5B1f4KDi9IWHIT72TM
	 s9rQeg9gNAPDN3p16PaEk/W4nemi5/8lERDzLOH9ZzBUuymcTfBplkMvRQIu+uqUF/
	 mqYycX3ieZpJEyZhfA8ma3xqgrTWRJvj3ZM4o94WHnW21x1MFSYUudlvffO0QZqfEW
	 ZYiH+Z2WC7dpetwy7ze4pqxBZd5RA3RbBuiT4gC3njhM7kF7VPEB5yG6gyS5CwUekm
	 kanee57Fk/nwQ==
Date: Tue, 10 Sep 2024 17:08:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: George Stark <gnstark@salutedevices.com>, Rob Herring <robh@kernel.org>,
	conor+dt@kernel.org, krzk+dt@kernel.org, neil.armstrong@linaro.org,
	khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, hkallweit1@gmail.com,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@salutedevices.com,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: pwm: amlogic: Add new bindings for
 meson A1 PWM
Message-ID: <20240910-kerchief-custody-a0741f9a256c@spud>
References: <20240710234116.2370655-1-gnstark@salutedevices.com>
 <20240710234116.2370655-3-gnstark@salutedevices.com>
 <20240712125219.GA472311-robh@kernel.org>
 <55f73e79-2d21-48ba-8486-26ee168c7bc3@salutedevices.com>
 <20240725-excursion-waving-0e0ad54006d4@spud>
 <ak53ha3kltm24s45n5pczvibtltzocg33inpnro4bjeolu25re@33lae7y7qzvw>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GfjYjimy2LOyoHtK"
Content-Disposition: inline
In-Reply-To: <ak53ha3kltm24s45n5pczvibtltzocg33inpnro4bjeolu25re@33lae7y7qzvw>


--GfjYjimy2LOyoHtK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 10:01:39AM +0200, Uwe Kleine-K=F6nig wrote:
> On Thu, Jul 25, 2024 at 03:08:53PM +0100, Conor Dooley wrote:
> > On Fri, Jul 12, 2024 at 06:12:26PM +0300, George Stark wrote:
> > > Hello Rob, Conor
> > >=20
> > > On 7/12/24 15:52, Rob Herring wrote:
> > > > On Thu, Jul 11, 2024 at 02:41:15AM +0300, George Stark wrote:
> > > > > The chip has 3 dual-channel PWM modules PWM_AB, PWM_CD, PWM_EF.
> > > > >=20
> > > > > Signed-off-by: George Stark <gnstark@salutedevices.com>
> > > > > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > > >=20
> > > > Missing ack from Conor. When you submit new versions, it is your
> > > > responsibility to add tags.
> > >=20
> > > I had Conor's ack in my mind but his response was related to the
> > > squashed patch (a1 compatible + power domains) and the current patch =
was
> > > a bit different that's why I didn't dare to add the ack.
> > >=20
> > > Conor, do you mind if I resend this patch (and may be [PATCH v4 1/3])
> > > with your ack?
> >=20
> > Ye, both are fine :+1:
>=20
> I interpreted that as an ack for patches 1 and 2 and applied these to
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fo=
r-next
> . I guess that interpretation is fine, please tell me if not.

Yah, I was okaying my ack being added to both patches in a resend.

--GfjYjimy2LOyoHtK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuBvDQAKCRB4tDGHoIJi
0hgwAP9JpE/xlF+q9oXUlWavKoI1Z11cHC528mE+fTzlDB/QGgEA3kEAQDDGtmlX
1TMFRdnlnCWQIn11dhQluJFv6qn3nQ4=
=v7N1
-----END PGP SIGNATURE-----

--GfjYjimy2LOyoHtK--

