Return-Path: <linux-pwm+bounces-7301-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD5AB54880
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Sep 2025 11:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77CC3A8D84
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Sep 2025 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C239C289358;
	Fri, 12 Sep 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7knwgMG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9864C537E9;
	Fri, 12 Sep 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671067; cv=none; b=GpR9CgSb38cAXkUIrH/9OdLYILwUofv60X1Ub/66Tb6xWQIfTjOBAn+ZkbrHVc5KbFsKlwqOX1b+LsTDJnf/p70u7rN7lw316lI3KWj/hKcaC3A/rjDk7pzmn3iU0xCmFQTPlDONwlefLuWbpiT4nUXVrvM6tsE1J9E8G8UAVKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671067; c=relaxed/simple;
	bh=eoLMG7fUbAuhqelboQ0DZkVM7GMPXOAqopCXQjVO3yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHrLD6E2O73lo1ErJq+TzexaGfwiXXc+UeV2OY26RWybc+ZOY5UyUAJnKJW3jOjWeiWuTtdaiukUH1hTor6i+83FE4u0WCnxPv+ZWkJ+lp4gWA2/uJDLLfrnafI65ZtZ6eZ3mnA/yS4wZVEfphtXabiIe3V5HaEjzWD8owr9nqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7knwgMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3966C4CEF1;
	Fri, 12 Sep 2025 09:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757671067;
	bh=eoLMG7fUbAuhqelboQ0DZkVM7GMPXOAqopCXQjVO3yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7knwgMGHqk2++LO6Kbt78XzSFiMB4SdVKd6WB/h13NDdvRQlSl3so3uJCuW69dtk
	 ltkt7TU0vGFPNcL3cCKq1YMl/BZZE/Y5RiKifpqBsQYibfu38U0p53+WGu2GRkjksL
	 iSklYoyxCgVs7nQzmVgq6ak0uj1f6zxDFkSgVU5kfSxb49NXVDtfu36MynB7J7g6ge
	 vMoLBy2fm3kTYgGGhE+lEqupqkbk0q/4k0UuT1My2lZxz3rfMAMqna385s6J101m6x
	 AjOgxN9coxZl6ymndAYd9Vvv+Xf37XbhwuUuGjfRYpGRol9oCUHzgv0VvtNEWoEufC
	 /sZHr18XXl91w==
Date: Fri, 12 Sep 2025 11:57:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 1/6] pwm: tiehrpwm: use GENMASK()/FIELD_PREP() for
 register fields
Message-ID: <h6izgs7fkp7wn2nets252r2cg5gvm3wllk2iuywoqlrickj4o4@gbal7tgpmpv3>
References: <dithxhozx4k6n6xu7qrunsxec2wrklj2fipp3r24tlunmj7zid@vgqvfjw7onld>
 <20250826040507.3160-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="afszd4keqywdjyaw"
Content-Disposition: inline
In-Reply-To: <20250826040507.3160-1-rafael.v.volkmer@gmail.com>


--afszd4keqywdjyaw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/6] pwm: tiehrpwm: use GENMASK()/FIELD_PREP() for
 register fields
MIME-Version: 1.0

On Tue, Aug 26, 2025 at 01:05:07AM -0300, Rafael V. Volkmer wrote:
> Hi Uwe,
>=20
> On Mon, Aug 25, 2025 at 10:27:26AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > There is another series touching this driver at
> > https://lore.kernel.org/linux-pwm/cover.1754927682.git.u.kleine-koenig@=
baylibre.com/
> > that would be great to get some testing and that I tend to apply first
> > given that it contains also fixes. I guess you didn't base your series
> > on top of that?
>=20
> You're right, I didn=E2=80=99t base my series on top of that one.
> I=E2=80=99ll test your series and can rebase mine afterwards once it land=
s,
> so we avoid conflicts.
>=20
> Thanks for pointing this out.

FTR: I applied my series now and it should appear in next on Monday. So
going forward should have become a tad easier for you.

Best regards
Uwe

--afszd4keqywdjyaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjD7pUACgkQj4D7WH0S
/k6NEQgAlJrASjg2FImsIUlB+CzhwFSGFeJIo0EBq4wMi1eLYD3ixcrku9RnC1rj
/cxcK6J5AzDtXAH9UjNWAATeyZJnqSC/q/xwusF5YI/ERTDm8+6FYRS43nVr/t0S
t7MD3l5cijcZiZ8APkBmO4bd5mBo0W/dtBMzL033ttohR0uZA0AzpvSk+QRjlhrb
WpBoUNYFPnZfnPFOoCmTWP4UCq8NnhVV5sZTYXVaVAd/GM/HwWG5dC93azok3SJ8
tcd36yx0Cn7FcN/JaE5E8sac3P0tXWTBTjCCZTRDEmzFuFfEUU7cIqpEKVnzn1Cu
6RPfxDtQccj4695ThdVuj0mQvY025w==
=9+HW
-----END PGP SIGNATURE-----

--afszd4keqywdjyaw--

