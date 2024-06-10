Return-Path: <linux-pwm+bounces-2396-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7700C901E29
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 11:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6BC280C98
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 09:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B602335A7;
	Mon, 10 Jun 2024 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="z+bWmg2s"
X-Original-To: linux-pwm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D625055887
	for <linux-pwm@vger.kernel.org>; Mon, 10 Jun 2024 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011592; cv=none; b=SCAGbet5U565LpC+76ZulA++HMdvXseW86IXU2Qf8H5uhpbbw8ZayvmEtQg0vEGy3Edjfgu+zqxMm7BTsCTUzykLtE7cGatDxSyXv4XG50Q8UxsHolNzU2pgvZ4PQobV4ZKv7ApZD4c6+zVgtCZnbjkC8yWealD08wHHDr8RdKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011592; c=relaxed/simple;
	bh=lW9oyedb8IGn15q/bioYfjF9kND/sMSUush0x/8KIH0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTJhRpQEv97lXIH7Yx7VRZtDqm8v/NiK1UYEWCf97BnSfSLaYPg86QkeoJ9ASg/RKvuDKsRnacERdyqMrEEGBvd69tXVpkdeVJiwHZ74LXcvP6mOSCLq0al5TLUDobMdtOHsVACOLiA/T26jiKxDHMaH3ym8ZIac0HJf3prfOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=z+bWmg2s; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718011591; x=1749547591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lW9oyedb8IGn15q/bioYfjF9kND/sMSUush0x/8KIH0=;
  b=z+bWmg2sdMIgkKs3UVfXGdRodJOUAzDptdKX7Hea7SGkOq76PDxxrwSH
   faIIH+Uj/At1U75obgMuW0+8pgsefYXui1HeJIxFdCg/YeWx5QsGOMdWa
   KwcnDY/sYGcbGaquU8Tn47MJRtrzmpdkfCwO4oaWTIbic/YzVUDLvZ2eU
   KjxbZEEtOR9oaWkr0Ib+VDjmlAGDOGpU9aGvFKbrkZg/T2Ch/6HgpMVOQ
   XT0qd6B1dknmLmlaf5f8WwUmftGx3qvhdaBksvLCcfPQKbXJSMweQ427J
   4zFNxgDXYWM5FRKXyMjfFQmt57Wwb8nRrKR9fFNazWQeN4GTyPDhPyv+L
   A==;
X-CSE-ConnectionGUID: CzxDyEoyTl613Fd8FCzROw==
X-CSE-MsgGUID: AMrbPrcHQvuVCp0WqnDFhA==
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="asc'?scan'208";a="258051081"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jun 2024 02:26:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 10 Jun 2024 02:25:59 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 10 Jun 2024 02:25:57 -0700
Date: Mon, 10 Jun 2024 10:25:41 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, Trevor Gamblin
	<tgamblin@baylibre.com>, Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 2/2] pwm: axi-pwmgen: Make use of regmap_clear_bits()
Message-ID: <20240610-device-fifty-ec8e24fe7ff3@wendy>
References: <20240606164047.534741-4-u.kleine-koenig@baylibre.com>
 <20240606164047.534741-6-u.kleine-koenig@baylibre.com>
 <3755faec8dc7048da880ef6b924ed2e5a224bfef.camel@gmail.com>
 <no6gyqovcjrzcior5lym6qtb7ya4abgcspe2mebpvfc2bl3f4i@h3x64l7pomhf>
 <20240610-fineness-discern-e8b21551e149@wendy>
 <56jdqmach5s4vkv72mpg6pdz5vr5j3fixmjpzyf5vt74ijvmaw@lt6c2icqf5rj>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PGhBiDibnN1h8njY"
Content-Disposition: inline
In-Reply-To: <56jdqmach5s4vkv72mpg6pdz5vr5j3fixmjpzyf5vt74ijvmaw@lt6c2icqf5rj>

--PGhBiDibnN1h8njY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 10:32:13AM +0200, Uwe Kleine-K=F6nig wrote:
> On Mon, Jun 10, 2024 at 09:00:53AM +0100, Conor Dooley wrote:
> > On Mon, Jun 10, 2024 at 07:53:33AM +0200, Uwe Kleine-K=F6nig wrote:
> > > Hello Nuno,
> > >=20
> > > On Fri, Jun 07, 2024 at 08:40:32AM +0200, Nuno S=E1 wrote:
> > > > On Thu, 2024-06-06 at 18:40 +0200, Uwe Kleine-K=F6nig wrote:
> > > > > Instead of using regmap_update_bits() and passing val=3D0, better=
 use
> > > > > regmap_clear_bits().
> > > > >=20
> > > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > > > > ---
> > > >=20
> > > > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > Thanks for looking at the patch. When I apply it (using b4) I get
> > > however:
> > >=20
> > > NOTE: some trailers ignored due to from/email mismatches:
> > >     ! Trailer: Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > >      Msg From: Nuno S=E1 <noname.nuno@gmail.com>
> > >=20
> > > I'll add it anyhow, but it would be great if you fixed your workflow =
to
> > > have the sender match the address in the tag.
> >=20
> > I'm curious, given I do this all the time, do you not see similar issues
> > for me?
>=20
> Never noticed that for you. Maybe that's a new check in b4? I recently
> reinstalled my devel machine, so I likely have a new version even if the
> upstream change is a bit older already.

Nah, I think that's been in b4 for as long as I have been using it, even
when I used the old version from debian. Maybe my use of patatt is the
reason or some exemption for kernel.org addresses.

--PGhBiDibnN1h8njY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmbGlQAKCRB4tDGHoIJi
0mCYAQDgrN3FMXb3+UNL0uPW78ebD/BkVtF7rMVld3YvO0wnIAD9HC6G2AhXzh5o
BC0dufyhQR6Qhxdi+TwOz5lt3E33WQY=
=OR3a
-----END PGP SIGNATURE-----

--PGhBiDibnN1h8njY--

