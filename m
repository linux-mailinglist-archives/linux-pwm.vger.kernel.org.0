Return-Path: <linux-pwm+bounces-3469-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5440E990748
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 17:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB54CB2257B
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 15:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFA61AA785;
	Fri,  4 Oct 2024 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN2wHc3l"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D001D9A65;
	Fri,  4 Oct 2024 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055145; cv=none; b=Ydk8kUibMjrxUyWNtaSPLazFbiu+6qpDSXAniJqYsHWYSX96szt3sYEVKqMTYc5jwQU0mIWghWmK1XPuEFdw2wF01TE1zFYH+u/60X9U5nwqcms3ABwJwZj05xnN2fY1bd2iVfva9SIPqq0D6TDDWY5gD6amWi8yPC5u6Rud+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055145; c=relaxed/simple;
	bh=dD5eDkooA+Ex+iOJP1TfV+XBZ6LzXb1q2bQOSb1wOR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKH3RTfbIu1DAl0VYhk0JFe/VxG2e3+HGHh7tDyTLJ0O8vr1Eho55IjYuELeIhlSMkUrFAJM+eJINAKnPWifIlJCj4cghCtFudCsKWbctm70S820guMiX7Ci0TWf03AKtBKE55igROXPb2JHO3dUdtb3orfz9lEw9+WBNasjrR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN2wHc3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3EEC4CEC6;
	Fri,  4 Oct 2024 15:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728055145;
	bh=dD5eDkooA+Ex+iOJP1TfV+XBZ6LzXb1q2bQOSb1wOR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BN2wHc3lP8DgDuHmh1XEeafshXW3bH/+cAOCmwKqQs3d/p/My2rGRs9mZfvoz12EY
	 41G1vt1s6XY+HSVR5DiRpmkcjc7/wz9nLKw2vgVidRW3nW7H6XpMv7bgkY3e51hUNt
	 l1Qz8TCUj7c687rW094KYQxK+E2GV79y4BuR2LO4qI/OybH5tHBSSy2b30onU51tL4
	 1k76F9Q+O1IaPKLpgy4z6H4xD+dgeQg5As5kPk4+pMEBJI5TwNezuAkh86CXaDVC6q
	 yngD5k5OIp+3WoKFq2u16oZYD7r46oKtxtrExfB63WpXzlxp77QTcdtBaX5LHCu80J
	 LuqHNTGSGXJWQ==
Date: Fri, 4 Oct 2024 16:18:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 5/7] dt-bindings: iio: adc: add ad485x
Message-ID: <20241004-elixir-italicize-b7c339903ab7@spud>
References: <20241004140922.233939-1-antoniu.miclaus@analog.com>
 <20241004140922.233939-5-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L8pXIauJ0N/ie8Sx"
Content-Disposition: inline
In-Reply-To: <20241004140922.233939-5-antoniu.miclaus@analog.com>


--L8pXIauJ0N/ie8Sx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2024 at 05:07:54PM +0300, Antoniu Miclaus wrote:
> Add devicetree bindings for ad485x family.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
>  - link all public parts in the description
>  - add $ref: /schemas/spi/spi-peripheral-props.yaml#
>  - add vee-supply
>  - add vddl-supply
>  - add description for pwms
>  - add pd-gpios
>  - update spi-max-frequency value
>  - make vddh-supply optional, not required.
>  - update example based on new properties added.
>  - fix typos in commit message/title.
>  - update year to 2024
>  - drop "DAS" and "device driver" from bindings description.
>  .../bindings/iio/adc/adi,ad485x.yaml          | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad485x.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml
> new file mode 100644
> index 000000000000..899a65504f12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml

With a filename matching a compatible,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--L8pXIauJ0N/ie8Sx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZwAHYgAKCRB4tDGHoIJi
0q31AP4z8Ye1WaISeqNGwUvkApurW7SFE1T1HbG/d5koitug7AEAjJlaen6+2Fow
/3oQ7tpZyEvfVkraqxSQvIRDjjQrwgM=
=7XWM
-----END PGP SIGNATURE-----

--L8pXIauJ0N/ie8Sx--

