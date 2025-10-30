Return-Path: <linux-pwm+bounces-7559-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1FAC21FD5
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 20:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C7B188F713
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 19:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA802F999A;
	Thu, 30 Oct 2025 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+pDSTIt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D2E1F2C34;
	Thu, 30 Oct 2025 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853024; cv=none; b=YUpYZOK0/prCZNwYKpAQAF2+RmP3ZqlY3FlKfJYXA3nRsjc4lLn+XD8sIF7xnWCGXZl29YOrMi/uxUQubLOCXX2YWPIQsU62pDvMQOVwU8Bi4k3C17uIdGeAOgAODdVAv7r2L/9hFIqilJ3qdPY7GffgWpie3cCcForxzwQ3wBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853024; c=relaxed/simple;
	bh=cpZ1I3+S5/XVwqUT6dgPylr0jeq60xgFoi1myi53Tiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmXsQ41SR4udc/ndv2Qw0Z4xeccTccftVn1ggqurQpehundk/z/qNPs/Bv+vx6ajBTnrbwEFA9hKZBWBnwcTTRQKE9tArFF159bzSf2s6WjowoQHHXqJJ2GE9apSG/9cggpZf4tpb5iPEWOF264JmPmriGWdY18FRUq0P1I9rj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+pDSTIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F201EC4CEF8;
	Thu, 30 Oct 2025 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761853023;
	bh=cpZ1I3+S5/XVwqUT6dgPylr0jeq60xgFoi1myi53Tiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+pDSTItJF6/3r8htJ72319bDfdj0sbb6VzZL2M2S3fwN4Jlf52FgKJrt9+og5zB+
	 uwqx969gR4VBPP5s2oyyqdfaxcxMki/NiaKZuLzYcu/3PJMrodmbZaPKhs92Qn0ft7
	 TkMzFOa0nUS0shQDeb7nTCV52ULHGSCQLOEcPTWZfapvhk6flxqXeDbw3oh3camP+q
	 zVT5ZmqKaWJcvWR6UkQ82ZyIlBFjS8JKhcLMDMymVpC9DeW8WxbEG/I51oMxmGrGdn
	 reXRFb8eJUtYX3RpVmYOiyCwp7n7Hj9PdPEfxcQDx7eN+n98+7JxoFc9G02pDx1wJ7
	 94GJ+82cn8YyA==
Date: Thu, 30 Oct 2025 19:36:55 +0000
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
Subject: Re: [PATCH v6 04/11] dt-bindings: pwm: Support MediaTek MT8189 evb
 board disp-pwm
Message-ID: <20251030-astrology-handcraft-f5dbd0d7447d@spud>
References: <20251030134541.784011-1-jh.hsu@mediatek.com>
 <20251030134541.784011-5-jh.hsu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1MS9yLIDP8XDYgds"
Content-Disposition: inline
In-Reply-To: <20251030134541.784011-5-jh.hsu@mediatek.com>


--1MS9yLIDP8XDYgds
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 09:44:36PM +0800, Jack Hsu wrote:
> add compatible string for mt8189 evb board dts node of disp-pwm
>=20

This commit message isn't accurate, and that makes me wonder if the
others are. This has nothing to do with the "evb board", this compatible
is for the mt8189, on whatever board it happens to be on. Please drop
all mention of the evb board from commit messages.
With it gone,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

> Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml=
 b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> index 68ef30414325..22712769518b 100644
> --- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> +++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> @@ -30,6 +30,7 @@ properties:
>                - mediatek,mt6893-disp-pwm
>                - mediatek,mt8186-disp-pwm
>                - mediatek,mt8188-disp-pwm
> +              - mediatek,mt8189-disp-pwm
>                - mediatek,mt8192-disp-pwm
>                - mediatek,mt8195-disp-pwm
>                - mediatek,mt8365-disp-pwm
> --=20
> 2.45.2
>=20

--1MS9yLIDP8XDYgds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQO+VwAKCRB4tDGHoIJi
0iaeAP0d36mjcuHToJU3ymuF4OSb07S7VjuxPoFWiBn9oj3bUAD+Pu38NPa1oQI+
XbASB7XJkhq3c/nA1t7oZLhX6+1YtAY=
=Hxxe
-----END PGP SIGNATURE-----

--1MS9yLIDP8XDYgds--

