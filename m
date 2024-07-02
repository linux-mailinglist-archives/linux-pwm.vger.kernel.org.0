Return-Path: <linux-pwm+bounces-2660-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5D992413D
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jul 2024 16:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C6028308A
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jul 2024 14:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EBF1BA071;
	Tue,  2 Jul 2024 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nyoc9E8y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7D71E48A;
	Tue,  2 Jul 2024 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931726; cv=none; b=V8ieW2diysIdlm9/VHAwVOnfCWmKrNgyt1No9Vi2JXtm8cv8qn/6gXz1qDBHOKlfi5Hg5NzY7IoTPz0v807i90qxndtZEQsM1eVBpXIikxpz6+LHMujOBw/AQAw9JZT+pZHaQj9+2Vvhw+bt9feRPhL3CXrg4mTgzC3zk7VDX80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931726; c=relaxed/simple;
	bh=1MV2LBIpYnHur1473Z/6SWuY34VimUF3ZyaNYTHCq90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9FPcRGmPSAGqNI33xcTipEiAfoDn5oB+v1h+xOC4cH8d9yMopu+L3TZE+O6XTWZbwVr8akqWMgArGuh0PDAT9ZvD0MSGQRjam9YpiC+6LezIrKkG8Kx9PeRpjxQgFg6Wul3pUi6iCvha2WHz8a2DO5o5ibPspB6IT/SgVawhxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nyoc9E8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7645DC116B1;
	Tue,  2 Jul 2024 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719931725;
	bh=1MV2LBIpYnHur1473Z/6SWuY34VimUF3ZyaNYTHCq90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nyoc9E8yZ4DLHNiJA6xVw4vmFe9ZGX35IGDW/BMgniFE6IdcXplffmc1OfY955AcO
	 Kj6yEmm6Hs/NMVjWA3iaDC2pNjhsPj1KHK8Ogp5swy4r9YVfvfX3th/PHs+6n2LCcP
	 xnxay2Ywo+48FpEofYf6arKUH3e5Ot15MqiLuNUHBgSenEF4IByRivZqedmLLv9SbG
	 A1C8+CC4gXldRGjjKYWwUJzKbREZRUUrm/iQz/EUh+lqA8elgvkIaGsU8R5Rnt2xYG
	 mu0dEYIbLW1R8GMvt6gWxiPIq9R9De5HP3mo2J0Y4+Sei2TW8v3QCilqvVnppeOwiA
	 iGes98dx/pgYA==
Date: Tue, 2 Jul 2024 15:48:40 +0100
From: Conor Dooley <conor@kernel.org>
To: George Stark <gnstark@salutedevices.com>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, neil.armstrong@linaro.org,
	khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, hkallweit1@gmail.com,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@salutedevices.com,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: amlogic: Add new bindings for
 meson A1 PWM
Message-ID: <20240702-buffer-ambiance-0f67d200870e@spud>
References: <20240702123425.584610-1-gnstark@salutedevices.com>
 <20240702123425.584610-2-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nRr6YWAxpDJ00vSZ"
Content-Disposition: inline
In-Reply-To: <20240702123425.584610-2-gnstark@salutedevices.com>


--nRr6YWAxpDJ00vSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 03:34:24PM +0300, George Stark wrote:
> The chip has 3 dual-channel PWM modules PWM_AB, PWM_CD, PWM_EF.
>=20
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--nRr6YWAxpDJ00vSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoQTSAAKCRB4tDGHoIJi
0r7SAQC5Hma9PkKbFzlUlSYfiHnSmtZwMhClanjoia/DInk/hgEA18h+uTkmnfxy
j7fsr5rJ4broGzTxfe/+CCznWlCZiAY=
=iaWS
-----END PGP SIGNATURE-----

--nRr6YWAxpDJ00vSZ--

