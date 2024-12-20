Return-Path: <linux-pwm+bounces-4415-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4FA9F8BFD
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 06:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED751895C39
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 05:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E4013D8A4;
	Fri, 20 Dec 2024 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9i5tpIg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815E1259487;
	Fri, 20 Dec 2024 05:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734673877; cv=none; b=uGp0U05hUKrf/kBKw8AU/3DFzW0PPyaqkbxk60W2apIdFwZOMDLky/E9ujM8+6Nqfsl/gSVzGZtiboEteEeCElbDsz+J0NfqH4v/+LfJyB+q/Z2LQSmmMHy2VG1NrZj0OLNIu9+iSEzFgChZlDQacKrycw+nJpuAbrq+hfajwvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734673877; c=relaxed/simple;
	bh=D5aq2XDE54pHMRzTUpMhb+flRYpPDeqhjlA0GP9Pj6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i154ZXRB4Dn3FFSGfkrEw2mF/838O62MCTZcfQN9p172FwMimLdBPRN7iFI+lpnBZ5GiXIdacnXD2U4NxsXS7kLmTtq1HI69jeRo5U0i0yYYyGn6ivSesGMswj96FtMgoE+i8gFP3qaGb92C0EnuIkFgBvKPP5zYafKyNOkotX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9i5tpIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7330FC4CECD;
	Fri, 20 Dec 2024 05:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734673876;
	bh=D5aq2XDE54pHMRzTUpMhb+flRYpPDeqhjlA0GP9Pj6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9i5tpIgNAQggVKHqhubMnOib2gfU3vTNgIav3thcFI0zDrwKUNcfrDMkJK+NVkC+
	 O2EBJVF6cuJkulVv75peNY78H/JPe+naudUrH6IHRE9iO18+yC4f2At5XfKuSFvdmD
	 +jwHtixIvWGQ/yzr4LKmn8ualpP6JmbvLjSt8IuY8ra7mKyo2bisFY2Ovq77xlPl9Q
	 NQF7Nk9Nj6rqd6tuWrLWS0KEL0yUlGw1Csn3Cs6jXOiDko68jZaXVxQ6aEA72ux7l2
	 IY59T1j5Nir49E73ei0+CRN4on77/mAqlrcGtbkpyBpBANttwIjwsGTj1S0E3fQj+u
	 gl8mDTPSF/7Ug==
Date: Fri, 20 Dec 2024 06:51:12 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: mathieu.dubois-briand@bootlin.com
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	=?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 4/8] pwm: max7360: Add MAX7360 PWM support
Message-ID: <a6gpiriu4n5c324pkl354uews5prlqsrapoxupu5liu6fd5ruc@swtw4eebk7et>
References: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
 <20241219-mdb-max7360-support-v1-4-8e8317584121@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e4chtsryu42byqjg"
Content-Disposition: inline
In-Reply-To: <20241219-mdb-max7360-support-v1-4-8e8317584121@bootlin.com>


--e4chtsryu42byqjg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 4/8] pwm: max7360: Add MAX7360 PWM support
MIME-Version: 1.0

Hello again,

On Thu, Dec 19, 2024 at 05:21:21PM +0100, mathieu.dubois-briand@bootlin.com wrote:
> diff --git a/drivers/pwm/pwm-max7360.c b/drivers/pwm/pwm-max7360.c
> new file mode 100644
> index 000000000000..b1cde3e86864
> --- /dev/null
> +++ b/drivers/pwm/pwm-max7360.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2024 Bootlin
> + *

I forgot: Please also add a paragraph here describing the relevant
features here in the format that several other drivers use. Such that

	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/*.c

emits it. Relevant are at least:

 - Only supports normal polarity

 - How does it behave on disable? (Constant low? Freeze at the level
   where it just happens to be? High-Z?)

 - How does it behave on reconfiguration? (counter reset? Mixed output
   possible?

Best regards
Uwe

--e4chtsryu42byqjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdlBc4ACgkQj4D7WH0S
/k4wLQf/ZF43my2VAHklfKYPgAWvnGO8I5IbtTF7p+pgr8YrZqEWjE5ifrEXbalr
cMbBw8pEy5l4v9MG2chRsFf7T66d8EHahp79VR/oXXTmAfxkQJu+Abj/OEO0FKom
6/cf01iw020NLDgpwKLaeYwT+0OoxJDfWoSxE0oiaObWepcff/UtZPmttQlEL8AD
Dt/HLdH9FWntErA9EE/MGw8Dd54d0rQoMC9XtMFyLctPojHzh5JLmcDK8ogiP6WA
Qe9dQaA4XtBSphFsuwutAb+Tbxtr+e1AAg8tWj0B5dOLvUromss1ScfBaOt2YMGd
TGxZX6lms0IlAt/a7G/jyCntlPk+tQ==
=ie24
-----END PGP SIGNATURE-----

--e4chtsryu42byqjg--

