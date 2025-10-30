Return-Path: <linux-pwm+bounces-7557-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFD8C21F96
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 20:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F06554EE1AB
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 19:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE07D2E9EAD;
	Thu, 30 Oct 2025 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4l5oyeq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81B12236E1;
	Thu, 30 Oct 2025 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761852774; cv=none; b=p19V3IMNWgK99T1hvHHDUtSsbzpLjo5uApPC61HMj3cCE5Wu62sGz1DwuyKgKs+mKqVrEz6vqTHUY0bRbPb5AJTNjNZMPr9O0yRPDj6QDyMMW0ruMlaSGLv9lmQf4wyLbBNtJbHNmWxF2syHTTHfwnwrEYApZs0jpRc7ZY+j+/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761852774; c=relaxed/simple;
	bh=4n7sme1iF4g2hhvf9X/e7qQUJ4ibim25muvzqWoOG3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6R5dziU646yQdgq3HTOFPXviuwV379RwBLJnYaay1MSAM6VZXssW5rPfWpJe9wNPN2J/oyHYC+tNpH9fFImfcfCe6BMRMbTeQnie1MsHMt9stc+TiKNkqjtCJMTvusNVqfO520ERPoZLPwTKpthWDxsukHq2VhZWW2ZNrtsfZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4l5oyeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5859C4CEF8;
	Thu, 30 Oct 2025 19:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761852772;
	bh=4n7sme1iF4g2hhvf9X/e7qQUJ4ibim25muvzqWoOG3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M4l5oyeqUD5T97Qpn1bYW3dJuG2Uici5Gl99AZwrNc0fYj6UeU3BBtxHeyn/VNgtz
	 RbdAprQvXmULrCJZzetDZ+hLEyqCW+P2eR8seRlddYctcnrcmD7CDu5fc+XZvZMdHE
	 a7vpwbRQXhjMTdtTdlXOQw3hPgKWjoNodB1Frsc/AJeZRhC2e1MHvuAqltTL9VCrqX
	 XKdg+IcIKYWi09erboLp3P96eOu0plibQvbWLoJuZQeApd0YkheCdk9K2sfBYzqHhh
	 A3CR/scgcdkJ4UjbLHuv/jLWLCQ84HjF/o17wp1MbeysgWETFoVk7QdUzQ2/S7omNl
	 PmF0d9lvgFxLQ==
Date: Thu, 30 Oct 2025 19:32:44 +0000
From: Conor Dooley <conor@kernel.org>
To: Jack Hsu <jh.hsu@mediatek.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, srini@kernel.org,
	ukleinek@kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de,
	chunfeng.yun@mediatek.com, wim@linux-watchdog.org,
	linux@roeck-us.net, sean.wang@mediatek.com,
	zhiyong.tao@mediatek.com, andrew-ct.chen@mediatek.com,
	lala.lin@mediatek.com, jitao.shi@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pwm@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6 08/11] dt-bindings: watchdog: Support MediaTek MT8189
 evb board wdt
Message-ID: <20251030-nineteen-borax-3af2d0992a6c@spud>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
 <20251030134541.784011-9-jh.hsu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jEAHuqhaXpLF8bhH"
Content-Disposition: inline
In-Reply-To: <20251030134541.784011-9-jh.hsu@mediatek.com>


--jEAHuqhaXpLF8bhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 09:44:40PM +0800, Jack Hsu wrote:
> modify dt-binding for support mt8189 evb board dts node of wdt
>=20
> Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--jEAHuqhaXpLF8bhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQO9XAAKCRB4tDGHoIJi
0qHRAQDCFtCgcqZHWVGl5YvVbluDGPKQ4cXF+4HIiF+utD1OYwEAw0ZIC7Gzj+SU
4Jjl6hGbPuD3ZBPBTv1ZYvtGOUUN4go=
=hW2I
-----END PGP SIGNATURE-----

--jEAHuqhaXpLF8bhH--

