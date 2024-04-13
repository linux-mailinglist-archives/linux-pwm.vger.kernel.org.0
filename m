Return-Path: <linux-pwm+bounces-1926-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36358A3BA0
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Apr 2024 10:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBF1283FEF
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Apr 2024 08:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CB91CD06;
	Sat, 13 Apr 2024 08:27:05 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FF41E4B2
	for <linux-pwm@vger.kernel.org>; Sat, 13 Apr 2024 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712996824; cv=none; b=bE3g1c2KpsnwwL7OpPVnEDZvOpQnB+AfiGsAjB3K/tl5TX1tA8JGWpGN3/fLNFyQRHyTkWml9nwGzag8hZC3JlXjqNiz4MhqE4Ns0oeaMX6WWcfdoFbYQg2dmAfictRAQJTA7q2B+OCdJDr2QM9KA7iG+yKxfDaBfHBTxoVLzlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712996824; c=relaxed/simple;
	bh=1q8q9DEtpVmsq3+dZA9/B2EvqO7zaCzCTTsc2TEguVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNAgLMJpXpPwCZ+ymyh6qmqxxJXb/ccMNN1PEsxtufYLm+E0nAWbbupplunD1o3Udek8HKWTiSK601weBRduOQ5rUYOWycr2kdtyaXL5j8TOJfdzRkvTX4cYGNIejR5Xzz6ScQSJu7PWLmr1+9FBUP6GlIziXs8MKkWz/GI69f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvYiq-0000uh-Ou; Sat, 13 Apr 2024 10:26:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvYip-00C1vX-A3; Sat, 13 Apr 2024 10:26:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvYip-000fem-0j;
	Sat, 13 Apr 2024 10:26:51 +0200
Date: Sat, 13 Apr 2024 10:26:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: linux-pwm@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: stm32: Add error messages in .probe()'s error paths
Message-ID: <ie5i4re2clgqqvjhwiur62mi6qwzvzxmtlonjuje2uhxhk76ce@ygptew53hs66>
References: <20240315145443.982807-2-u.kleine-koenig@pengutronix.de>
 <861cb184-42ee-4f27-9b0c-3129d52cc706@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wlkga23boekqkkvw"
Content-Disposition: inline
In-Reply-To: <861cb184-42ee-4f27-9b0c-3129d52cc706@foss.st.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--wlkga23boekqkkvw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 05:39:34PM +0100, Fabrice Gasnier wrote:
> On 3/15/24 15:54, Uwe Kleine-K=F6nig wrote:
> > Giving an indication about the problem if probing a device fails is a
> > nice move. Do that for the stm32 pwm driver.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Hi Uwe,
>=20
> Thanks for your patch, you can add my:
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks, I applied it to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
with your review tag.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wlkga23boekqkkvw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYaQcoACgkQj4D7WH0S
/k6iTwf/RgV6QkMSL+jZfc6zc21tIOoDNv8ph8teLWvLRqT2YmxNkMWWYp9H/mUM
g3sOeLL4jojQgE2HgByWiGcRc+PLT7DgG8DAWlk2OQwVmGOhGLWbP0QoFQjuovUZ
sJkkIpc+LSsFAfO2BkU9nk4vVPvz9NdNGmCIel1+nd7GhZsLNgZT8j8VCkLK5ykx
JYbiMrXF++KBJjxg5myzW1X6sGm5cdkhZUsqFuF2Hy/OntafNlnNrVirywQNSG7y
7tF/g02CGB/EoO1DRPxstnhT8V9x1zykH/kXpZbz17w64o9C9oWCn+JZMcrJZHyJ
E0oU4gqPSgMS91ICeg9nBJaz0o/tGg==
=L8fg
-----END PGP SIGNATURE-----

--wlkga23boekqkkvw--

