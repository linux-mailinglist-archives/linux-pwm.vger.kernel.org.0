Return-Path: <linux-pwm+bounces-7560-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177F2C220C5
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 20:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED27402C6F
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 19:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306E43115AF;
	Thu, 30 Oct 2025 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYRixxz6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43C72F12AF;
	Thu, 30 Oct 2025 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853584; cv=none; b=u5ZNaeFvNEZuTE2eb1eifZSjMeUZVVLP3Zc5GoI465Vf4046GKQeN0dkNRbwbyNwzeC2HDX3h3/65SIVWSoaoQ/GUWSV0PdQmfjeLQa76w4dbrVcXWhSVVi1dGvxAMudijceOmmrf5IKr9ak1sx5GdZ8tSNnYtRC9lwtnOvuRjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853584; c=relaxed/simple;
	bh=GV2XRPs93TwYftizCqQPTtAV3OHflrc4UhVM50o3qOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqXzCoLQwhEiKFOvG8eleW49DNe/BxHYUE4FTSxrvXwutVFSvSB7dPclRpYCoaURMuN+a0pvOFlowJ/CYdn6vjXULIcalhmasHTJYxbPavjXWYIhV4YGGNC0jWmSaiIesX1LT8hY5TyJGNZT/QJaJhENoEyXC//ETy8EkBiqwBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYRixxz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C70C4CEF1;
	Thu, 30 Oct 2025 19:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761853583;
	bh=GV2XRPs93TwYftizCqQPTtAV3OHflrc4UhVM50o3qOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYRixxz68G0B3WvSiTR45ogAq1hCd3hip6IbAr/vpLSvMQXPh5bqwKR3fHwvAiato
	 k9lLxJ9Ol9IrjuTPLH4cv014bh8GtkT3rSxRQSzbQzx7GkYZcsUhrgxsizNlJgfS9i
	 HssBlKBGGA9AOg0QdRsEjZoWkCmbgCCOZ4gdieHpstJL7HQCGPUCYACe6CBFZz0F4d
	 6UXn0RZmedORIu4k14ErbNgOuNfJAnYjpVCE+h4NoJ6JbM+yxnmxzHC2wvJucQp0YT
	 VqQi6/6Mr7HsE+WssAKVJA6F01m+5MK27cfqtX7ZQzSTFWGDgznlUEZqL507BbeBkm
	 CZB2fDXCDdykg==
Date: Thu, 30 Oct 2025 19:46:15 +0000
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
Subject: Re: [PATCH v6 10/11] arm64: dts: mediatek: add properties for MT6359
Message-ID: <20251030-boaster-chewing-61d458aa6c9e@spud>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
 <20251030134541.784011-11-jh.hsu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qjInnEs/qoh/Iqxq"
Content-Disposition: inline
In-Reply-To: <20251030134541.784011-11-jh.hsu@mediatek.com>


--qjInnEs/qoh/Iqxq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 09:44:42PM +0800, Jack Hsu wrote:
> Add properties of rtc fg (Fuel Gauge), external crystal
> and auxadc definition for mt6359 pmic.
>=20
> Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6359.dtsi | 20 ++++++++++
>  include/dt-bindings/iio/mt635x-auxadc.h  | 50 ++++++++++++++++++++++++
>  2 files changed, 70 insertions(+)
>  create mode 100644 include/dt-bindings/iio/mt635x-auxadc.h
>=20
> diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt6359.dtsi
> index 467d8a4c2aa7..cc7053bdd292 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6359.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
> @@ -3,6 +3,8 @@
>   * Copyright (C) 2022 MediaTek Inc.
>   */
> =20
> +#include <dt-bindings/iio/mt635x-auxadc.h>
> +
>  &pwrap {
>  	pmic: pmic {
>  		compatible =3D "mediatek,mt6359";
> @@ -302,6 +304,24 @@ mt6359_vsram_others_sshub_ldo: ldo_vsram_others_sshu=
b {
> =20
>  		mt6359rtc: rtc {
>  			compatible =3D "mediatek,mt6358-rtc";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			status =3D "disabled";
> +
> +			fginit: fginit {
> +				reg =3D <0 0x1>;
> +				bits =3D <0 8>;
> +			};

Uhhhh, what on earth is going on here? This is an RTC, what does
fuelgauge stuff have to do with it? Did you test this at all? What does
it even do? Very confused.

> +
> +			fgsoc: fgsoc {
> +				reg =3D <1 0x1>;
> +				bits =3D <0 8>;
> +			};
> +
> +			ext32k: ext32k {
> +				reg =3D <2 0x1>;
> +				bits =3D <6 1>;
> +			};
>  		};
>  	};
>  };
> diff --git a/include/dt-bindings/iio/mt635x-auxadc.h b/include/dt-binding=
s/iio/mt635x-auxadc.h
> new file mode 100644
> index 000000000000..69ba13a7b9ec
> --- /dev/null
> +++ b/include/dt-bindings/iio/mt635x-auxadc.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + */
> +
> +#ifndef _DT_BINDINGS_MT635X_AUXADC_H
> +#define _DT_BINDINGS_MT635X_AUXADC_H
> +
> +/* PMIC MT635x AUXADC channels */
> +#define AUXADC_BATADC				0x00
> +#define AUXADC_ISENSE				0x01
> +#define AUXADC_VCDT	    			0x02
> +#define AUXADC_BAT_TEMP				0x03
> +#define AUXADC_BATID				0x04
> +#define AUXADC_CHIP_TEMP			0x05
> +#define AUXADC_VCORE_TEMP			0x06
> +#define AUXADC_VPROC_TEMP			0x07
> +#define AUXADC_VGPU_TEMP			0x08
> +#define AUXADC_ACCDET				0x09
> +#define AUXADC_VDCXO				0x0a
> +#define AUXADC_TSX_TEMP				0x0b
> +#define AUXADC_HPOFS_CAL			0x0c
> +#define AUXADC_DCXO_TEMP			0x0d
> +#define AUXADC_VBIF		    		0x0e
> +#define AUXADC_IMP			    	0x0f
> +#define AUXADC_IMIX_R				0x10
> +#define AUXADC_VTREF				0x11
> +#define AUXADC_VSYSSNS				0x12
> +#define AUXADC_VIN1				    0x13
> +#define AUXADC_VIN2			    	0x14
> +#define AUXADC_VIN3			    	0x15
> +#define AUXADC_VIN4			    	0x16
> +#define AUXADC_VIN5			    	0x17
> +#define AUXADC_VIN6			    	0x18
> +#define AUXADC_VIN7		            0x19

What has this fine got to do with the node you're adding above? I don't
understand why this is in this patch.
There's random whitespace problems in it, and half the defines look
bizarre. This seems like it should be in the same patch as some binding
changes for an iio device? The mt635x auxadc binding doesn't even permit
anything that would use any of the properties beyond this point.

NAK.

> +
> +#define AUXADC_CHAN_MIN				AUXADC_BATADC
> +#define AUXADC_CHAN_MAX				AUXADC_VIN7
> +
> +#define ADC_PURES_100K				(0)
> +#define ADC_PURES_30K				(1)
> +#define ADC_PURES_400K				(2)
> +#define ADC_PURES_OPEN				(3)
> +
> +#define ADC_PURES_100K_MASK			(ADC_PURES_100K << 8)
> +#define ADC_PURES_30K_MASK			(ADC_PURES_30K << 8)
> +#define ADC_PURES_400K_MASK			(ADC_PURES_400K << 8)
> +#define ADC_PURES_OPEN_MASK			(ADC_PURES_OPEN << 8)
> +
> +#endif /* _DT_BINDINGS_MT635X_AUXADC_H */
> --=20
> 2.45.2
>=20

--qjInnEs/qoh/Iqxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQPAhwAKCRB4tDGHoIJi
0rESAQC+pk8ew/zg9l4Rp9iAnTnoGDOpKly9i4yhdfpXcv5AowEAvBfWYIfZ0eSw
+rZuOzIx3kHSDbDpctohV+Wb6SErqQY=
=lc/Z
-----END PGP SIGNATURE-----

--qjInnEs/qoh/Iqxq--

