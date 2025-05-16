Return-Path: <linux-pwm+bounces-6001-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A69EAB98B4
	for <lists+linux-pwm@lfdr.de>; Fri, 16 May 2025 11:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B592501A98
	for <lists+linux-pwm@lfdr.de>; Fri, 16 May 2025 09:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B01E22DA07;
	Fri, 16 May 2025 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUVBMoQD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C006222592;
	Fri, 16 May 2025 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747387476; cv=none; b=Me8oh+eXkqgk0+ZuTAD1u6Wg/N+fc6F+rHiAzYXjlC8EQqM4QbKMhCuKRYI40id8bsWZKxFSlrWDpiKXHoHbUfNoW+6W3/mQD7UQqlp2gbBplRRW3E0eMhjFps4RDINGo2thDNFInlHA0q5mPpXRpX4JzkpKIEtax8WthtI6Vpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747387476; c=relaxed/simple;
	bh=pTcNOg+J4pTuaSi6FGbTNmcNN8Yox9jHEVvxg9j7gto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGGDEM9Sy8Tkp0s/iz4nRrhiDtz0Uzv6VSyRRLFs/IIfBrLnSyOKry7l882LfyeFejwIjYwhXdjjszmf2ainipxiTnUb0Ril6sBFsbhCltCUltIhXn4OYmM3lDh8tdVLsjztFtAaXzg7qeDgGxjBfAi8LA8jqXbPEi+YnZGU4bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUVBMoQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64150C4CEE4;
	Fri, 16 May 2025 09:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747387475;
	bh=pTcNOg+J4pTuaSi6FGbTNmcNN8Yox9jHEVvxg9j7gto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LUVBMoQDH76Nor+q+vsS8FsU/DmPtdJ4M3/zOKgVkGi0zp8xQ6gbzpafdLRlxgS35
	 Xu+oNfuiqTL4sstHl7tl90Meb1Zt3Gw49g+p2RM6JplgX8DWIQMPrJQSL09lqpJCOp
	 wJTij9XrOXG0fawaMpR5ULwkN/PcPs9sTUiawqEwZpuT9nnaOJLC8fAA2x0+QJ7QbR
	 Jf4g1qC24GP6GHubKbd1rf2qr++XOx/rPQASOh6zfuWa6QLPU4mdIiteBWvePUDZbc
	 /EPbPZybrYLJF5NshIj3/S9Jf93HgPRR4Z6zzVjZ54Jq8/h2wgiojuBlVYb/0rRHMH
	 HaFOpEWCj4RGQ==
Date: Fri, 16 May 2025 11:24:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: dimitri.fedrau@liebherr.com
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH v2] pwm: mc33xs2410: add support for temperature sensors
Message-ID: <mjmrgvw7dg6wlipvku4yzaazbxomsfpr42hdvh37c3r5zybjyh@4olym5bwde45>
References: <20250515-mc33xs2410-hwmon-v2-1-8d2e78f7e30d@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="md4hhqjtrihbqqci"
Content-Disposition: inline
In-Reply-To: <20250515-mc33xs2410-hwmon-v2-1-8d2e78f7e30d@liebherr.com>


--md4hhqjtrihbqqci
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: mc33xs2410: add support for temperature sensors
MIME-Version: 1.0

Hello Dimitri,

On Thu, May 15, 2025 at 02:40:54PM +0200, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>=20
> The MC33XS2410 provides temperature sensors for the central die temperatu=
re
> and the four outputs. Additionally a common temperature warning threshold
> can be configured for the outputs. Add hwmon support for the sensors.
>=20
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
> Changes in v2:
> - Remove helper mc33xs2410_hwmon_read_out_status and report the last
>   latched status.
> - Link to v1: https://lore.kernel.org/r/20250512-mc33xs2410-hwmon-v1-1-ad=
dba77c78f9@liebherr.com
> ---

Mostly fine from my POV. I suggest to squash the following change into
your patch:

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a0c077af9c98..d9bcd1e8413e 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -425,7 +425,6 @@ config PWM_LPSS_PLATFORM
=20
 config PWM_MC33XS2410
 	tristate "MC33XS2410 PWM support"
-	depends on HWMON || HWMON=3Dn
 	depends on OF
 	depends on SPI
 	help
diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
index c1b99b114314..f5bba1a7bcc5 100644
--- a/drivers/pwm/pwm-mc33xs2410.c
+++ b/drivers/pwm/pwm-mc33xs2410.c
@@ -163,7 +163,6 @@ static int mc33xs2410_modify_reg(struct spi_device *spi=
, u8 reg, u8 mask, u8 val
 	return mc33xs2410_write_reg(spi, reg, tmp);
 }
=20
-#if IS_ENABLED(CONFIG_HWMON)
 static const struct hwmon_channel_info * const mc33xs2410_hwmon_info[] =3D=
 {
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_LABEL | HWMON_T_INPUT,
@@ -286,21 +285,20 @@ static const struct hwmon_chip_info mc33xs2410_hwmon_=
chip_info =3D {
 static int mc33xs2410_hwmon_probe(struct spi_device *spi)
 {
 	struct device *dev =3D &spi->dev;
-	struct device *hwmon;
=20
-	hwmon =3D devm_hwmon_device_register_with_info(dev, NULL, spi,
-						     &mc33xs2410_hwmon_chip_info,
-						     NULL);
+	if (IS_REACHABLE(CONFIG_HWMON)) {
+		struct device *hwmon;
=20
-	return PTR_ERR_OR_ZERO(hwmon);
-}
+		hwmon =3D devm_hwmon_device_register_with_info(dev, NULL, spi,
+							     &mc33xs2410_hwmon_chip_info,
+							     NULL);
=20
-#else
-static int mc33xs2410_hwmon_probe(struct spi_device *spi)
-{
-	return 0;
+		return PTR_ERR_OR_ZERO(hwmon);
+	} else {
+		dev_dbg(dev, "Not registering hwmon sensors\n");
+		return 0;
+	}
 }
-#endif
=20
 static u8 mc33xs2410_pwm_get_freq(u64 period)
 {
@@ -523,7 +521,11 @@ static int mc33xs2410_probe(struct spi_device *spi)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
=20
-	return mc33xs2410_hwmon_probe(spi);
+	ret =3D mc33xs2410_hwmon_probe(spi);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register hwmon sensors\n");
+
+	return 0;
 }
=20
 static const struct spi_device_id mc33xs2410_spi_id[] =3D {
Best regards
Uwe

--md4hhqjtrihbqqci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgnBE4ACgkQj4D7WH0S
/k6ldwf+P7rvywthCrMgABmoTQ5p+Hlc4ACPxZGG1iH27rTjMPAW67I6NQ6GbEiq
mmfmuzlAWq35W+YxrEU1XMawlcEzuNAnTcxdk589MOcR4gaqRZadKpkLtVROSOD6
eBMNdY7FizuCnwyId4h4dMBKn2aLuFxWdCRRFMYV8q6TsdbquHJjC2IqkU4588dk
dOPy2Aw6p7bRNOX+LHTcVM7scO8/9aQww7c/x5RSDyb6LYAhPe5aGdOLtNOwATXA
6OE8AkyvcKlm8TJVx5LLBzUI9TPIfBoAbpKxQ5Ivs/DCVz13EBEZchMb1QvOLBOO
34c9g8Crla8jnt6ZFw/zBpGPtSLGMw==
=Ul98
-----END PGP SIGNATURE-----

--md4hhqjtrihbqqci--

