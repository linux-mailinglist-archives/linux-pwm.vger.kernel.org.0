Return-Path: <linux-pwm+bounces-1118-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CD68403F5
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jan 2024 12:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632611C22D29
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jan 2024 11:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA705BACB;
	Mon, 29 Jan 2024 11:41:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E435BADE
	for <linux-pwm@vger.kernel.org>; Mon, 29 Jan 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528511; cv=none; b=S1ygZg7i6/9DqWvlw39bMabGr7Y3/ZoAhSEfN8vi10TaH9kwMEnYfFjsDqIDaxPnZ2YcmAC+I3irQVk8GOUzsnaYM8H00W+G8iHGAcSXhMoFOShu+2bCZZPkSOJDlNUOYTd64cMom1JILDaHkulWkaSxsFvuWZSK1oKFFwYohlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528511; c=relaxed/simple;
	bh=2lI29vGxeH+es7wJEpP9RobhcZAprA3yoPRF1BvBlW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k98x2ZJsbqVLn8a1gfX0GE7aMCBvgNvmYSnOlnB+fFbULfbZyAmUYZgY1+qEbOnE4Ma7y2pYB1Z+cPcGTZfPrz5zv0CQ/T86f1urnjQD6tKdQ20NcfZyGIChWu2l3ABWqd2+epch6z/a6gZsGrNpN26q0PhOnlX1N7p0gqz6xSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rUQ1K-0006sh-Ut; Mon, 29 Jan 2024 12:41:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rUQ1K-0039xJ-1f; Mon, 29 Jan 2024 12:41:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rUQ1J-00As6C-35;
	Mon, 29 Jan 2024 12:41:45 +0100
Date: Mon, 29 Jan 2024 12:41:45 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Johan Jonker <jbx6244@yandex.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: pwm: rockchip: Allow "interrupts" prooperty
Message-ID: <dsq5f77dkwfzjegisz6waaqln4b4hbyhoafeygsisdhfzjy2ud@v4pdwvkkupbh>
References: <20240106142654.1262758-2-u.kleine-koenig@pengutronix.de>
 <7dea73a6-d733-4cd2-b2d5-02f09e2a6dd9@linaro.org>
 <94ad0f59-4095-40ee-963d-4ac379fc8852@yandex.com>
 <cvvifoctmgdsgqfadqbhgywfw2ff57fz33w26hghf5kyo5j5sw@mj75xtvczr2h>
 <210132de-a46b-4f9f-8546-0c36d8a34665@linaro.org>
 <5swqcqpc5zwa3bfhuoyjnymozyzy3lgurnbsurebybj2c7fck3@ycwk2ugo2ouf>
 <b03fc42e-653a-49b2-8835-6cfb7a7bb39e@yandex.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p7u3kwx5lvuf6mxa"
Content-Disposition: inline
In-Reply-To: <b03fc42e-653a-49b2-8835-6cfb7a7bb39e@yandex.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--p7u3kwx5lvuf6mxa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Johan,

On Wed, Jan 24, 2024 at 10:40:15AM +0100, Johan Jonker wrote:
> The interrupt registers are located outside the PWM range and have nothin=
g to do with the PWM driver.
> Adding them to a PWM binding is just bogus.
> They are a left over from the manufacturer tree that use them in a IR det=
ection driver.
> Heiko keeps them because someone outside mainline kernel might use them?
> They should be removed and remodeled in a new sort of MFD node that handl=
es all operating 3 modes.

After some more feedback on irc, I sent a patch removing the interrupts
property. However I failed to Cc: you on it. This first patch catched
your attention even without you being explicitly Cc:d, so I hoped the
new patch also hit your inbox. Find it at

	https://lore.kernel.org/linux-pwm/20240129113205.2453029-2-u.kleine-koenig=
@pengutronix.de

and tell me if you want a bounce.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--p7u3kwx5lvuf6mxa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmW3jvgACgkQj4D7WH0S
/k7cyQf+KF/024MjeRRDq7JoTp/gABQjsEkdql+YPSGnbFims+m61aWadom2WbqE
7IcSORlT/w7ttWXcxIFT6YidFwhUVrmNSoDkMNigX6epHthh8gtb5gxf/v9s8aUr
Zgw8xt9+n8xo5Bcod5719qMm3wE28ke7pbP2Lb30iy/K9hUia7uprlCdWH/RpNos
/sA2QUvMonssEiE7blvZ1ipy7TOmG+duWbrOy++BqGQHhG6uSeI5yBlrS7a6L6sl
QC39LKKfAVxLoA+517BjxlOGjI9DAXZn8HXi4K/ZQZ8seMOI4yITzYJ0SJKssraa
e9L5x42WcyuSgxoU+W7JfE41L329bA==
=8zBU
-----END PGP SIGNATURE-----

--p7u3kwx5lvuf6mxa--

