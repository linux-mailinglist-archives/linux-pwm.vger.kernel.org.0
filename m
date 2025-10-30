Return-Path: <linux-pwm+bounces-7552-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB56C21F0C
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 20:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A76D4E23AA
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 19:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4620628469F;
	Thu, 30 Oct 2025 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="up8YvZK9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ADB1A8F84;
	Thu, 30 Oct 2025 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761852609; cv=none; b=g4qs71lVqzSj78Lyo5+1tkL5PxTljT+26PhbbkifEHfxk0kErAiq4C6aTo6759VvHNxEPwFKXueGpe8ziXbkVZEckYTrwXdc4hCT5hLjRpGYyOlJ4efl41KTGNcdZN8fONina+LgQJbYbLIAmuxjHAa1fBQL+G6zYTXyElfl6Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761852609; c=relaxed/simple;
	bh=gpvPz8Evg1uqXZ9QqUcwXD9sbXxzCo0XoLf7Z7zGoCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qu4Bbr738qwiEgsv8nrRFhkQbY5FrVfmtJUup5PkKCSOJ+BI1Fnn2muEd9UUiWNi+u2cO/UoFfb5oAMrDOGNKgAUOXmf63NdT/9xDLi0xNAYVyBGoV44RKAwMRkLBUGACHax8u5bD42O89jihyNvNfrdFHvyZF8NFaRG6AYbsL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=up8YvZK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99D8C4CEF1;
	Thu, 30 Oct 2025 19:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761852608;
	bh=gpvPz8Evg1uqXZ9QqUcwXD9sbXxzCo0XoLf7Z7zGoCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=up8YvZK9QS2dUL4OocBLKevKS4IIseSnRAaQV3qK8jrwgpzO24eHxQdwkpF+yxAyL
	 PQO9nzoWvAvHZ6ho/VcFj2LgQrJ14z/f40WqLMF/Pw7hbEnqwMFrX7p5SsDSD1Al8C
	 hNltFy+QHKC24egmoXqgho9Ddq3+KypkJldzoAzOl6oJvWxYC4XY1dnEdcgiUnwqMc
	 /GM/1e2dDzx3FgrCv6F74//wOlYBEVOsFXOeaeEHT6SkaXRKDPiAgR2SoqtgqRqLie
	 Mkpj7G7tIxJw3hhANOcmtIn/TyJzd1hADvQV3EGklU6/nfgZkTI70rDCbMDw9vLtSV
	 Z4lJqn6HgdWzQ==
Date: Thu, 30 Oct 2025 19:30:00 +0000
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
Subject: Re: [PATCH v6 01/11] dt-bindings: arm: Add compatible for MediaTek
 MT8189
Message-ID: <20251030-unaligned-effort-0758c4d0e42c@spud>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
 <20251030134541.784011-2-jh.hsu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G4VLCKuvwTCyd6EE"
Content-Disposition: inline
In-Reply-To: <20251030134541.784011-2-jh.hsu@mediatek.com>


--G4VLCKuvwTCyd6EE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 09:44:33PM +0800, Jack Hsu wrote:
> This commit adds dt-binding documentation for the MediaTek MT8189
> reference board.
>=20
> Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--G4VLCKuvwTCyd6EE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQO8uAAKCRB4tDGHoIJi
0mJiAP4j0BV9X7Mo0HwHRId91we5S3x0+Bj2sMUgTli8nbZSJwEArA5lXdfdiW2f
FLUaAC9puo5RzUlkLzKDy/em1sA+RQM=
=dGpl
-----END PGP SIGNATURE-----

--G4VLCKuvwTCyd6EE--

