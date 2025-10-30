Return-Path: <linux-pwm+bounces-7558-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DA3C21FAB
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 20:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23F3188E046
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 19:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753E22F7ABF;
	Thu, 30 Oct 2025 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYGe84ji"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2794D2EBBA8;
	Thu, 30 Oct 2025 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761852896; cv=none; b=EDC122gabTpC+yCbMTFBwqRaauijBOSYDmhwFqBxNqeD9U22cTnHpbXr2U4k+I52Xm+ClKUPOV/s168gJdoIzEUeDGkZgNop23LTmQVVTvHAHe0vd5PBSpW+eIMrXHNgR7PD1foCD1FW8flYQBrXfU4L4vQ2KCQt6h3zYtFu1BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761852896; c=relaxed/simple;
	bh=u7izXQ3wPPcYbabEIwH3XaJBThWvY/6UuY2aNLFSoE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9bf+wLxLq6mX26WVO5zL6IoXeDmtw7maejoJT/LlUNKBFTQJieZZRFxaBhMFYtwUaVGVIuSIqxldQkvRT4qY6Jg52GGnpxWjqlu46AexVMSsUr0axeKdsh3fwOI9mXab8086seX8dpZk7uyPy0h4d4y4b27vcroFnw2Q5KZQT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYGe84ji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CFEC4CEF8;
	Thu, 30 Oct 2025 19:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761852893;
	bh=u7izXQ3wPPcYbabEIwH3XaJBThWvY/6UuY2aNLFSoE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYGe84ji/aEwlKP8FLkWS1kZYQr7XE97WFRNJv9vlGVl4+4M/+ZOuUCoSjom2P/Ak
	 QpCKPfFqgqg3Eo0AaQlbYdqQGCpGnO5bCaTFzr6P1Sgcvz+Oz+iFOstzZmMbdckWOZ
	 IHlYw/ZELzO3CyVktJ78dHH/FaRRpSb8UZNo+Y5KYIrAukFGyr214E7bTliAiVC2Xh
	 FEUii2idoB6XqXmzHxRAa2jsNBdRj7FW8zNTFGqsYkZUZ+CHEAPFOFTAxGneQ6hbH9
	 whkMDkhNp0LY1K2QbX4L6hI4fopn5SQw9K4mFgl8ERdE80RMVJkwFx97vOgTbI/+gJ
	 1proj76yVVo1g==
Date: Thu, 30 Oct 2025 19:34:45 +0000
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
Subject: Re: [PATCH v6 09/11] arm64: dts: mediatek: Add MT6319 PMIC Support
Message-ID: <20251030-koala-junkie-70fb384ea8fa@spud>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
 <20251030134541.784011-10-jh.hsu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o9A33WtK87+9N+BC"
Content-Disposition: inline
In-Reply-To: <20251030134541.784011-10-jh.hsu@mediatek.com>


--o9A33WtK87+9N+BC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 09:44:41PM +0800, Jack Hsu wrote:
> Add support for MediaTek MT6319 PMIC IC
>=20
> Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6319.dtsi | 66 ++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6319.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/mediatek/mt6319.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt6319.dtsi
> new file mode 100644
> index 000000000000..8b2386547508
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6319.dtsi
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + */
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi {
> +	mt6319_7: mt6319@7 {

Shouldn't this be something like "pmic@" or "regulator@"? mt6319 is not
a type of device. The binding example uses pmic.

--o9A33WtK87+9N+BC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQO91QAKCRB4tDGHoIJi
0t6NAP9IS23k9Qe99Xvmhv4pliASX5+mZhV0LmOOxTyFVhscSwD8CfJtc+em4iHf
aav/lefrQodh6kOrOzcbTtDk5DZbEAg=
=V4Y+
-----END PGP SIGNATURE-----

--o9A33WtK87+9N+BC--

