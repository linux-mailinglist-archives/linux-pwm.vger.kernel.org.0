Return-Path: <linux-pwm+bounces-7619-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 528E9C4F5E1
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Nov 2025 19:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1688341579
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Nov 2025 18:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C4728468D;
	Tue, 11 Nov 2025 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoxZ2qIT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FBD2798F8;
	Tue, 11 Nov 2025 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884232; cv=none; b=X2h1omWYUQsJt8X+MInld4L6Co7W7xU5uLq8LDpKMZ1ZEz0OsvHO7d/OXv7gRbhtjibccO9QdXskIG2PdwU0db8A12Nm4aM5LgghNfSwCIWgYQQtkTKpCTVLa5cj1BPlkmX1jeqv5woWu7npms1ET42suYvxh43VziTEsFK30OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884232; c=relaxed/simple;
	bh=mirE0FVC1aFCsQq2eMehFBIBONouR+WUmeEdSPLLXaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4pbBvf6LnY9krM64BcUDBtxo/7m7TkG1kiVB0J4q8Nb5UTXwC5Kqd0t8fipX4KH8rARN6Xk3qno/CABi4mnsrT3i4cLgzfyc3OAbj6ZDvsGbiuwPbagfMyCbEX9b/NCdXTKFkdhhChuLtrZzcVC/1D3nlFYulHwLaeq7ZTL2cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoxZ2qIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B8BC4CEF5;
	Tue, 11 Nov 2025 18:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762884232;
	bh=mirE0FVC1aFCsQq2eMehFBIBONouR+WUmeEdSPLLXaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoxZ2qITmDCIv3Aw71Gtor6BXmxZ1wnoHiUP/IBntzbdAFxQ9XxovK8QSj2aDPfZf
	 8IqPCAlCuq0F29Cbyszl60cwbOySqlX8Rj5fwBoLkDonymsRi7FtTTer6S+8EI4kqM
	 /ut0BcYpYH4KdK4sZNYt0ARyTafsLbJsT2J1vKYwJE48dIlDpf49nt492SCsRajbeb
	 N7w7bHAXlZp2gWqVuLabvi9TMqJAmHGuMrDDhb1WkFwSw2R9+XPQRX4y7EiAn/1Y0P
	 pkrI36WZ83pDlW7P7nW0wY6+KaIUsVMglj8ztkQuZyvx7fRB8f45cARtGA3HLG7lmq
	 XpVhTSucBjALg==
Date: Tue, 11 Nov 2025 18:03:43 +0000
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
Subject: Re: [PATCH v7 8/9] arm64: dts: mediatek: update rtc properties for
 MT6359
Message-ID: <20251111-heroism-greasily-fb01345ae609@spud>
References: <20251111070031.305281-1-jh.hsu@mediatek.com>
 <20251111070031.305281-9-jh.hsu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wFCZWHo1MJf80ONG"
Content-Disposition: inline
In-Reply-To: <20251111070031.305281-9-jh.hsu@mediatek.com>


--wFCZWHo1MJf80ONG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 02:59:22PM +0800, Jack Hsu wrote:
> Update properties of rtc for mt6359 PMIC
>=20
> Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>
>=20
> ---
> Changs in v7:
>  - remove mt635x-auadc.h
>  - remove fg nodes
>=20
> ---
>  arch/arm64/boot/dts/mediatek/mt6359.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt6359.dtsi
> index 467d8a4c2aa7..fe737254c091 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6359.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
> @@ -302,6 +302,9 @@ mt6359_vsram_others_sshub_ldo: ldo_vsram_others_sshub=
 {
> =20
>  		mt6359rtc: rtc {
>  			compatible =3D "mediatek,mt6358-rtc";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			status =3D "disabled";

Okay, this looks a lot better now. Still missing an explanation of why
it has been moved to disabled though, especially since you just go and
re-enable it (without adding child devices that use the address/size
cells).
pw-bot: changes-requested

>  		};
>  	};
>  };
> --=20
> 2.45.2
>=20

--wFCZWHo1MJf80ONG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRN6fwAKCRB4tDGHoIJi
0uoFAQDNm4ule8p2MhE3JjSHzEvgFm4U+PmD7w7D5a6po+6lFQD+MjosiBlNJq1z
mhXOc0fMS+qD6LGsDwugFT6pPQ4lzwA=
=+aBt
-----END PGP SIGNATURE-----

--wFCZWHo1MJf80ONG--

