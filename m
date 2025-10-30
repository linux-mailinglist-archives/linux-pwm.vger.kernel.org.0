Return-Path: <linux-pwm+bounces-7553-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C10C21F21
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 20:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA891A23C07
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 19:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1425E285C8C;
	Thu, 30 Oct 2025 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAKjHX5O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB3F23AB9D;
	Thu, 30 Oct 2025 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761852631; cv=none; b=DOtCa2VSePImDzbDk1g9jBoYSsfYclqDFPGfRUKcLJXpHGZob2AVTG5ipaphLVXoC1HWtmgSyRZugT9acIAbO/ompjxdW1wwlU9NYDq8w8DxTEqL4SIITitN1A78O5liXtEkI0nsohnOfzy2LAymTtSMYPxkCCxifDn1/LEDtp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761852631; c=relaxed/simple;
	bh=nYGjhJwEqmxzcSFikUVbtFMd/p8IUSgYcJ+tdQK27QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5nb12C73bgSlfDIuGXDtbvJzUVQtw5ZE8DeOTGsD+1AiwdcJCEe5U9iCcRFE+9lmMITC6HPC7Uv8dI+NigpusBTAjscvZT9/X6y3JLHbDLMP2GaoOtoXPaCo2NEjqaH76fW3/hbiUkT6FjNxqCxiU3RxoYi+3g38OGvLfjKLuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAKjHX5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0193C4CEF1;
	Thu, 30 Oct 2025 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761852630;
	bh=nYGjhJwEqmxzcSFikUVbtFMd/p8IUSgYcJ+tdQK27QY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gAKjHX5O8ABQzM+cbFJGRu3y+jMKCB9XR2FMAJIaDe+oz9RnOfaN1sjlO4zXV6kVj
	 VsjXGuwa5NPe5cODsKJzQW1ApJ0WKgKd2Q29iTk1ZayF/zp1oEBqVJKpmLTiNxSegR
	 iL4lcP8PskdJnxn+DAk5kG/tCMgRDxQ+uxMaL+BId3jclthsJk1kIMck2djOqiJKBQ
	 6+6qgSw3AfP1wbqCFyEe9w3yNC92mn0mx+VwCY9BE8TvMsm5tttG+8XXUFWOGguOCD
	 Hds4Wa/pSyXEGW5oSVXaPeD6rUVvb8J0WbkqFT8F6NKCopRXDTLDU/1BODRQOWCgLH
	 p/v6GoQUqyjgA==
Date: Thu, 30 Oct 2025 19:30:22 +0000
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
Subject: Re: [PATCH v6 06/11] dt-bindings: timer: Support MediaTek MT8189 evb
 board timer
Message-ID: <20251030-dumpster-sister-9d42b3c2321f@spud>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
 <20251030134541.784011-7-jh.hsu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lSql5Dbd6t0I6d4Y"
Content-Disposition: inline
In-Reply-To: <20251030134541.784011-7-jh.hsu@mediatek.com>


--lSql5Dbd6t0I6d4Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 09:44:38PM +0800, Jack Hsu wrote:
> add compatible string for mt8189 evb board dts node of timer
>=20
> Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--lSql5Dbd6t0I6d4Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQO8zgAKCRB4tDGHoIJi
0jXjAQDA+75TI4KHzqt7u0J0FuY4d5XRYH8bZz9Os1JW1zjBfgEA9No7V3Q7tT/A
8ontfDIfylzdLSCBQd9DeKbMg/lTHAM=
=eiVu
-----END PGP SIGNATURE-----

--lSql5Dbd6t0I6d4Y--

