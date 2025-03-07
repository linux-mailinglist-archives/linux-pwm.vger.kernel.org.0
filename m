Return-Path: <linux-pwm+bounces-5124-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B569A56EB4
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Mar 2025 18:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C91816ABB9
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Mar 2025 17:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4725623F41E;
	Fri,  7 Mar 2025 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0K1jrRm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A48E219A8D;
	Fri,  7 Mar 2025 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741367287; cv=none; b=nBvIm7snk27RJdN7oyKMCVYY9gdjfjuajUHWC1RBjukD2snSw9Cek0K56lKepNGKdiw1CbLOrnfsMAB4BaGOozLD2BwhQ5MtzOwMsuJeuOZP6IIWOiNbHh5polsOPAmS1N0av13N7jvoYrKHt3KYVAR+G6rDyMp8DUkgpc3hM2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741367287; c=relaxed/simple;
	bh=EAinxqSqYdnbbnkb1uHxYXPyfcX7MUeugdwP+4COtn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Av9uKkoILi5ROIyWb9m90AgUBhdhrYQ5gL0eq2/dr1TFh67DY+Uc4xc+lqoWdaEP6JHYAO+vLdmoChO+sLPuvW1UaZ5jxg/9BOWJ8SRk6IW7mGDBYsOj659yBaE7p5iexOXjhrfnnCCFpsd+GL+iD+s03QHx8H1vUnoOZ+gIlbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0K1jrRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C231C4CEE2;
	Fri,  7 Mar 2025 17:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741367286;
	bh=EAinxqSqYdnbbnkb1uHxYXPyfcX7MUeugdwP+4COtn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h0K1jrRmxiAUJWS03xTcfLzFu2VVktzzAj9NYVtmVTFXOAx5R78Q5ipUEkNKGAOJ3
	 Mi5z8WBddzSpRXrQMw9JXzLPBt3Rrq7gXS0zkcn4iHMD5Q/pvKxdPb+1dc5yAdXVZS
	 ZoxZcgg4EABtlcq+N6NhcQYsIZshHZ8I7hlEJ7UgkUSYonGY1libiBHLJ7ItMZErpd
	 1gDQfsl9uZeNC/qPIFlot9LCDH37RKNYhTzG2vMCWVXuDni4CvWK0zuhaEawyZ+lqN
	 cFHmgWTJGYlXeT6G4F+hqtSwKsCOB9+Kt2XzWrGcXGrnKA2QEPw49M9to2iOn0mgnm
	 y70NMXdpwmeJw==
Date: Fri, 7 Mar 2025 18:07:47 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Jonas Karlman <jonas@kwiboo.se>, Yao Zi <ziyao@disroot.org>, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: rockchip: Add rockchip,rk3528-pwm
Message-ID: <pnlkcc2rl7fegltovgtvp4xdxhonw72rclvhn7qmvb7xyuullm@xf5x6lcigji3>
References: <20250307120004.959980-1-amadeus@jmu.edu.cn>
 <20250307120004.959980-2-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4uzxop7jt47pbx4n"
Content-Disposition: inline
In-Reply-To: <20250307120004.959980-2-amadeus@jmu.edu.cn>


--4uzxop7jt47pbx4n
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] dt-bindings: pwm: rockchip: Add rockchip,rk3528-pwm
MIME-Version: 1.0

Hello,

On Fri, Mar 07, 2025 at 08:00:03PM +0800, Chukun Pan wrote:
> Document pwm compatible for rk3528 which is fallback compatible
> of rk3328-pwm group.
>=20
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

to prevent binding warnings it's probably sensible to let both patches
go in via the same tree at the same time. Feel free to take the binding
patch via rockchip/arm-soc.

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Thanks
Uwe

--4uzxop7jt47pbx4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfLJ9kACgkQj4D7WH0S
/k5higf+OtJXTgkdDcHKWNOd31O7K9VCUQJDc9jVPE6elaMvtBo5dwg6YPmSENkq
ytj0JsR4nNH7OBlOWgTMI9uiAzueeTr7kqAngX/xQknxRsHHljJJYmlWlDz5RJj1
T5uEfryN3ghnCz4YZhcSCA8VAk1AYpyipEdsVsGAAZ5GaNTUwOQ6RYuzPZTh377G
WMROK/e9xoWg5g+WZAdCV9TMstu6EDVzzWke7HfR3D3ToxiTGuB2tsM+LQHw90xg
R/wVXYjbb7sgvIdyV3d/cF6/0m/o+yXnBEubhcNEUSUXsFkVRS2X5b2vJxIuvj3P
LwEhsNNCCJ0w4nC/Xs/LVJfHstbt+g==
=W8Nn
-----END PGP SIGNATURE-----

--4uzxop7jt47pbx4n--

