Return-Path: <linux-pwm+bounces-7630-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3CBC5CC64
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 12:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA17A4F61F4
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 11:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FAD30F95A;
	Fri, 14 Nov 2025 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0En2mcr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC39D2ED151;
	Fri, 14 Nov 2025 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763118217; cv=none; b=cg4Qzax+Tnnayv/5b0iMc0gZXIrI/iez0ZfCyLaRI12QG91g01QkopTspcBO52u+nWHxuSwfu++VoLa1zuxBZOi0RdLd5PNRWxpjQ7Lj47rSnhFYsxgUrwyxjUI6BlLIAvSJ2WaPkkZQEiywWAWopPAtBBpYurX42CVFyoMKTeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763118217; c=relaxed/simple;
	bh=z9rDUhMLuGiHedTdGsxliOHj3wd3fApDZWqUFbOCWC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuPaMqwV/0PjaaCfz+wJLT5xQYmlJoPLtzR4scazi4gN7dCtSfR0SFyUGM4xhikCalxLocAIXnvxlFUMyui55hyFfRCPu0/5w9R59PsjyXI7/9eIjIQEevSY4GgmDu719SQIGB/Qv5oW5sBNdE8ByhgvwJ4MDg7o3Yzp0t7uT14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0En2mcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8CEC4CEFB;
	Fri, 14 Nov 2025 11:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763118216;
	bh=z9rDUhMLuGiHedTdGsxliOHj3wd3fApDZWqUFbOCWC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F0En2mcrY3DNujOm05aP0V7JlNdBc3XYcJw8Wn12qZ9LZC3yGIaw0bAv6PG/ihgIg
	 y0N0AwK9FHQq4zhpE8C6hw11JEX2QEpoVDo18X522R8sxK1A+Oeb36FeoUToCqLTjm
	 8riTsncr4rreSf7FYGrRjwIn/Zt9AqlaNGQ/UH5xgskJ6SsAyEM5mnbY1Ydy6uoRGE
	 N2JTG+5QTz1BbZn0LKRMFY7671SKuUH/I0wGj/+vZavN1JLo+h6ljBtqxHByqkV3Aa
	 5VHqFA0tZZ6BGYEWxmGuEqyypqVbDubyn24spJUDVGb3RUy3ft+OP2RAxmkEjm3mCl
	 BrNm3nmmFJ/kQ==
Date: Fri, 14 Nov 2025 12:03:34 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: ziniu.wang_1@nxp.com, laurent.pinchart@ideasonboard.com, 
	nuno.sa@analog.com, lee@kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH] pwm: adp5585: correct mismatched pwm chip info
Message-ID: <umvpvqkbv2w7cqg533xpvira66qdxqa2bjpnzymeic72st42qb@6f7bgychfrzw>
References: <20251114065308.2074893-1-ziniu.wang_1@nxp.com>
 <jqsmjigr65kqhlk3buybrcurllqxlad6zkkuwo3tea5uqopqzl@ldwbjsndltpk>
 <34af5576a5e779a279975dd9fb8be7c2b233f661.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sczwbepgumef37do"
Content-Disposition: inline
In-Reply-To: <34af5576a5e779a279975dd9fb8be7c2b233f661.camel@gmail.com>


--sczwbepgumef37do
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: adp5585: correct mismatched pwm chip info
MIME-Version: 1.0

Hello Nuno,

On Fri, Nov 14, 2025 at 09:46:43AM +0000, Nuno S=E1 wrote:
> On Fri, 2025-11-14 at 10:30 +0100, Uwe Kleine-K=F6nig wrote:
> > On Fri, Nov 14, 2025 at 02:53:08PM +0800, ziniu.wang_1@nxp.com=A0wrote:
> > > From: Luke Wang <ziniu.wang_1@nxp.com>
> > >=20
> > > The register addresses of ADP5585 and ADP5589 are reversed.
> >=20
> > My German feeling for the English language suggests:
> > s/reversed/swapped/.

I applied this substitution and dropped the empty line between Fixes:
and the first Signed-off-by: line.

> > I wonder how that didn't pop up during development of 75024f97e82e. I
> > would expect that the driver doesn't work correctly in a very obvious
> > way without this change?! I tend to want to send this to Linus before
> > 6.18, but the question makes me wonder if I'm correct with that
> > urgency. Any insights?
>=20
> Yeah, this one I kind of asked for Liu to test it (as I was not testing t=
he PWM bits)
> and he did tested it [2]. But it was v2 and that series had some more ite=
rations. So
> I suspect that I messed up along the way and the last version of the seri=
es was not
> tested (for the PWM bits).
>=20
> [2]: https://lore.kernel.org/linux-gpio/3efb68e2-7091-47e1-81a2-39930da5a=
427@nxp.com/

OK, so I guess it is sensible to get it into 6.18. I applied it for
next (i.e.

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

) and will send it to Linus mid next week in the assumption that no
issues pop up.

Best regards
Uwe

--sczwbepgumef37do
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkXDIMACgkQj4D7WH0S
/k4ZNQf/dfJFVv2RNUcTNcsIm9E3seeBAAPaOC+P0lX6m+x24pS3vq0mTrYMh8gl
99hpNMcpbGQerLN+QnJ6Jh0D5ITbs11HsiThG2cS10WKzImFtf9OY6S11AM1VYqy
WJ/rtrLvLVB1Oi6glWxzFQFDMka6DzzC4knrNiQM/xF4bkmpy48pOTr4S5T+0C5I
9VNheXKxUsT1RcZfXQeXYgDokI05AC9UkmKRvg4BnSAtGPJqrQ8qfGYncXMgfUdY
sMc8Fza+xrejy13uneSeq0eTKB9qa0nKdD1mBHbqtXmxsIeSH2p/CN7XdieHPHPS
sDPumvDt3/qRzYBkjSO+tglEwXRIkQ==
=lQTy
-----END PGP SIGNATURE-----

--sczwbepgumef37do--

