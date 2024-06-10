Return-Path: <linux-pwm+bounces-2391-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7F1901C3F
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 10:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32588B208F9
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 08:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B7C55885;
	Mon, 10 Jun 2024 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Pkc4pH34"
X-Original-To: linux-pwm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233F5200C7
	for <linux-pwm@vger.kernel.org>; Mon, 10 Jun 2024 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718006504; cv=none; b=psLQBeo1taj8QxtZsqBVGI6eKjiWYUEbyg5x7s4N3GZV0YGtBg2mlS7an+/nT7pgjqwIQC0H8fMkV9GmOHv7MSbC8hsupspDP2ITn1VdLYp4BY1yle6IUXiJOe6fW+XgcAxUxctyJkbkxNHfbGkwuRRPoJIxECPz0Kbc0IOIfYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718006504; c=relaxed/simple;
	bh=AcoOLYYOYhwu7czy1ohQLH5iPCr9qtRss/jqYsMSr84=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CF8foObJZ/jvQSIxJ03fUwlBOV6Epan9ZCs0cE/4mslIuu19myYj0uJdX6I+tABet6i/Pi3slb/MLOBQPuwjiphmNoJ80IRb9e8trQG5/3FjBRmBsC8gERRfmrfraGBF/nIm3quOg5DYITzHEUGdXNjMLAWV8sX5tbA6uVj68Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Pkc4pH34; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718006502; x=1749542502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AcoOLYYOYhwu7czy1ohQLH5iPCr9qtRss/jqYsMSr84=;
  b=Pkc4pH34ayCzqm8FN2NzXmsdLc70mtX+lvvFZYcfpvkBrGYbSaELv2R9
   u2NPy2yfAr9LvRvnnVR7eJ1lNLRRsIx7cvrX9jsWxy6uhkwd9lbAaa2gR
   slfhvj1LRU9OPy/p/+pA6xkUitLuTm8KfSKqdcvaqWdNQVXmUcq/dOxfb
   upsgkAPZOVampueQVv5Bbxmw2gU0KzmPXnuJk46QedKvx7OlvXx/aY8if
   FOEEUiRL4/hXNX8mcujMOPcOcAXxXzgaSGIRBuJz4gOjw9Al4WS69+6mE
   Z6DmIZQ/47gzbZ7DsbDsxW1OBPSDyh7vEcjWNXwYQ90uDmk//YrtXv5SM
   g==;
X-CSE-ConnectionGUID: 8yuo9yoESK6Hl1YtyEOkwA==
X-CSE-MsgGUID: 2FwGVNHqQ+GNxz7/Nk64nQ==
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="asc'?scan'208";a="27190768"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jun 2024 01:01:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 10 Jun 2024 01:01:11 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 10 Jun 2024 01:01:10 -0700
Date: Mon, 10 Jun 2024 09:00:53 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, Trevor Gamblin
	<tgamblin@baylibre.com>, Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 2/2] pwm: axi-pwmgen: Make use of regmap_clear_bits()
Message-ID: <20240610-fineness-discern-e8b21551e149@wendy>
References: <20240606164047.534741-4-u.kleine-koenig@baylibre.com>
 <20240606164047.534741-6-u.kleine-koenig@baylibre.com>
 <3755faec8dc7048da880ef6b924ed2e5a224bfef.camel@gmail.com>
 <no6gyqovcjrzcior5lym6qtb7ya4abgcspe2mebpvfc2bl3f4i@h3x64l7pomhf>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BGtI8rbOFVzpjvgB"
Content-Disposition: inline
In-Reply-To: <no6gyqovcjrzcior5lym6qtb7ya4abgcspe2mebpvfc2bl3f4i@h3x64l7pomhf>

--BGtI8rbOFVzpjvgB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 07:53:33AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Nuno,
>=20
> On Fri, Jun 07, 2024 at 08:40:32AM +0200, Nuno S=E1 wrote:
> > On Thu, 2024-06-06 at 18:40 +0200, Uwe Kleine-K=F6nig wrote:
> > > Instead of using regmap_update_bits() and passing val=3D0, better use
> > > regmap_clear_bits().
> > >=20
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > > ---
> >=20
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
> Thanks for looking at the patch. When I apply it (using b4) I get
> however:
>=20
> NOTE: some trailers ignored due to from/email mismatches:
>     ! Trailer: Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>      Msg From: Nuno S=E1 <noname.nuno@gmail.com>
>=20
> I'll add it anyhow, but it would be great if you fixed your workflow to
> have the sender match the address in the tag.

I'm curious, given I do this all the time, do you not see similar issues
for me?

--BGtI8rbOFVzpjvgB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmaytQAKCRB4tDGHoIJi
0rl0AP9zM97pJ5xU2OqY00r86rcRlm+XDNf1FPO2RPiGFOw4YgEAuI7XFQFuiR/a
4ayugBZRigm8fX+n1nvw5LJiCpPLtwU=
=Q1Zj
-----END PGP SIGNATURE-----

--BGtI8rbOFVzpjvgB--

