Return-Path: <linux-pwm+bounces-2229-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749478CCC85
	for <lists+linux-pwm@lfdr.de>; Thu, 23 May 2024 08:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBFD1F217B5
	for <lists+linux-pwm@lfdr.de>; Thu, 23 May 2024 06:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE2513C90E;
	Thu, 23 May 2024 06:51:10 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC86613C904
	for <linux-pwm@vger.kernel.org>; Thu, 23 May 2024 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447070; cv=none; b=cP6zVuqsT1+6+KsGBgStXgdcAA7smjGEmNug65wD3WgXSsKkLcDkHHfVKAAwpx6WlF7Bkw1PKRN0fMf+diZvQH9EJzW62zlfUsBgJaSz/8kYomDw7SunRtvA8QK78D07manW34B7DdOckJhPqnDTyCps17SMtU3DJp0Z0+Ts9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447070; c=relaxed/simple;
	bh=HbilW8+/QhxMpuv2I3szsbRjZe9iBLkmZfLbtsRhSQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9BgKTyQnOW5hTGp39MlLNSxu/bevOMYyUZA8VQh4iTqG7fJWmXsZ1DHOjW9yxu3HIZFLl1PU4Ue+T9prIE6g7FZTpzU9+li1jTV4P7nW3h662VpsvopXBX/PQUG6ykalvV081sjb6ZPYGKaGmzoJZ65Cvi/ybPRaF5QYiGXMjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1sA2I5-0001hf-DT; Thu, 23 May 2024 08:51:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1sA2I4-002crX-FE; Thu, 23 May 2024 08:51:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1sA2I4-00Aa6K-1G;
	Thu, 23 May 2024 08:51:04 +0200
Date: Thu, 23 May 2024 08:51:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, nuno.sa@analog.com, dlechner@baylibre.com
Subject: Re: [PATCH 1/2 v3] pwm: add duty offset support
Message-ID: <fqipplnnt2ppyjgvvg7klbnqqcn6phivziizgfbth4jauntsjo@reno3me4kr4o>
References: <20240521194916.1897909-1-tgamblin@baylibre.com>
 <20240521194916.1897909-2-tgamblin@baylibre.com>
 <73y7ovftjv35gw3sjeu3jisg7feplhyebmcnldqvszuofqnn7q@eh4lyicuhfmq>
 <8cd080ef-e1f3-4752-8f92-d61c5fd321b5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u3xcrkvxcpftqa4e"
Content-Disposition: inline
In-Reply-To: <8cd080ef-e1f3-4752-8f92-d61c5fd321b5@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--u3xcrkvxcpftqa4e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 04:06:00PM -0400, Trevor Gamblin wrote:
> Makes sense. On a related note, will your pwm/chardev branch be merged so=
on?

My plan here is to first add core support for .duty_offset, and then
only expose those chips that implement the new .apply. The reasoning is
that I want to assert that there is a consistent rounding for all
new-style drivers and thus allow chardev users to rely on these rounding
rules.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--u3xcrkvxcpftqa4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZO51cACgkQj4D7WH0S
/k6C6Qf+LTGJjBboyMSSTGF03G/zNT6JcBtkPJkyoI+Av73PPmFweSy8iuE7KtDa
W9NPdmbpbos8hJLsD9O9IUM93okpA7WSEcmyoVNAMfs7GuZNjqpMD2LrS/5NsNJv
Z0JEycpMDx5fdF45DYU2ruVXf30j40SUN3g2QaZ6/QSl/VRQx1tOR7iNmKl2VhMV
XTi35dXsdcdjkkVVB+iGxROHY7hA22V8D8NLjfDIx5dErZds2/UXPnaiPmQKTu+z
f7Y8mI0K7aZzx4fFEBMrJBSI+xZr6S2kpOxCfqaYjgL92Bl80SCrTOxioHkjsl0+
DPYIUGsisTjiVVHIHHeh97s+4XpH5w==
=DG6d
-----END PGP SIGNATURE-----

--u3xcrkvxcpftqa4e--

