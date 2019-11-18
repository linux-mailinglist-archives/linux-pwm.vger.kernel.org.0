Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4AEE100383
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 12:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfKRLGp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 06:06:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:49026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfKRLGo (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 18 Nov 2019 06:06:44 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E708C2071B;
        Mon, 18 Nov 2019 11:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574075203;
        bh=YoYaR1M+lDGoxsiTxlkwf8DP5q8rsGTY5JiNj2sqbTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvOTFqZH2Tm1IT+xFFdw4YD99+QWWIdABD05lu0lHbZBaBKCA/Ywwd570/CiD6Gst
         t/0k/2k9OU1IVNON0R9u22AYCXnxTTTY4vvIVhOBU/Rah0/yagTbbfE2PvBE3aUb3V
         QYibqUrEB0TinljLpUp9D0s8kmzVi/hnd/c/Whw4=
Date:   Mon, 18 Nov 2019 12:06:40 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 1/8] dt-bindings: pwm: allwinner: Add H6 PWM
 description
Message-ID: <20191118110640.GE4345@gilmour.lan>
References: <20191118110034.19444-1-peron.clem@gmail.com>
 <20191118110034.19444-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YE4mVuFar47/lB0E"
Content-Disposition: inline
In-Reply-To: <20191118110034.19444-2-peron.clem@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--YE4mVuFar47/lB0E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 18, 2019 at 12:00:27PM +0100, Cl=E9ment P=E9ron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>
> H6 PWM block is basically the same as A20 PWM, except that it also has
> bus clock and reset line which needs to be handled accordingly.
>
> Expand Allwinner PWM binding with H6 PWM specifics.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pw=
m.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> index 0ac52f83a58c..1bae446febbb 100644
> --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> @@ -30,13 +30,51 @@ properties:
>        - items:
>            - const: allwinner,sun50i-h5-pwm
>            - const: allwinner,sun5i-a13-pwm
> +      - const: allwinner,sun50i-h6-pwm
>
>    reg:
>      maxItems: 1
>
>    clocks:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description: Module Clock
> +      - description: Bus Clock
> +
> +  # Even though it only applies to subschemas under the conditionals,
> +  # not listing them here will trigger a warning because of the
> +  # additionalsProperties set to false.
> +  clock-names: true
> +
> +  resets:
>      maxItems: 1
>
> +  if:
> +    properties:
> +      compatible:
> +        contains:
> +          const: allwinner,sun50i-h6-pwm
> +
> +  then:
> +    properties:
> +      clocks:
> +        maxItems: 2
> +
> +      clock-names:
> +        items:
> +          - const: mod
> +          - const: bus
> +
> +    required:
> +      - clock-names
> +      - resets
> +
> +  else:
> +    properties:
> +      clocks:
> +        maxItems: 1
> +

Sorry for not noticing this earlier, but this should be at the topmost
level

Maxime

--YE4mVuFar47/lB0E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXdJ7QAAKCRDj7w1vZxhR
xUZpAQDf57xL+KiMJD5aQ0XQT0XHFOYAwW8cCUu/FgXYpgJmjwEAqJZh4AHN3JSQ
09PXO0+LTVk76RQKjiW46/vLtI+iIgo=
=u4lN
-----END PGP SIGNATURE-----

--YE4mVuFar47/lB0E--
