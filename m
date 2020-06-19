Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FCE2001D9
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jun 2020 08:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgFSGOR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 19 Jun 2020 02:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgFSGOR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 19 Jun 2020 02:14:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F059C06174E
        for <linux-pwm@vger.kernel.org>; Thu, 18 Jun 2020 23:14:17 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jmAI1-00021N-Vn; Fri, 19 Jun 2020 08:14:13 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jmAI1-0003j4-BN; Fri, 19 Jun 2020 08:14:13 +0200
Date:   Fri, 19 Jun 2020 08:14:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com
Subject: Re: [PATCH v2 1/2] Add DT bindings YAML schema for PWM fan
 controller of LGM SoC
Message-ID: <20200619061413.424lqchj77qopyyl@taurus.defre.kleine-koenig.org>
References: <cover.1592474693.git.rahul.tanwar@linux.intel.com>
 <804603fe7d363b09e123ff8bb03486542af28c3c.1592474693.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ryah7d65y6lyq3px"
Content-Disposition: inline
In-Reply-To: <804603fe7d363b09e123ff8bb03486542af28c3c.1592474693.git.rahul.tanwar@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ryah7d65y6lyq3px
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jun 18, 2020 at 08:05:12PM +0800, Rahul Tanwar wrote:
> Intel's LGM(Lightning Mountain) SoC contains a PWM fan controller
> which is only used to control the fan attached to the system. This
> PWM controller does not have any other consumer other than fan.
> Add DT bindings documentation for this PWM fan controller.
>=20
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     | 57 ++++++++++++++++=
++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.y=
aml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml b/D=
ocumentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
> new file mode 100644
> index 000000000000..e71cc25e4e6a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/intel,lgm-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LGM SoC PWM fan controller
> +
> +maintainers:
> +  - Rahul Tanwar <rahul.tanwar@intel.com>
> +
> +properties:
> +  compatible:
> +    const: intel,lgm-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  intel,fan-wire:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: Specifies fan mode

The default when unspecified is 2.

> +
> +  intel,tach-plus:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: Specifies fan tach pulse periods

Only used with fan-wire =3D 4, default =3D 2.

> +
> +  intel,max-rpm:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: Specifies maximum RPM of fan attached to the system

Ditto.

Consistent with my concern that the fan code should not be part of the
PWM driver I wonder if this representation that mixes fan and PWM is
nice enough to be set in stone.

If we decide to keep it as is I wonder if we should drop #pwm-cells as
the hardware doesn't allow other uses for this PWM (IIUC) and so
referencing this node doesn't make sense.

> +required:
> +  - compatible
> +  - reg
> +  - "#pwm-cells"
> +  - clocks
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm: pwm@e0d00000 {
> +        compatible =3D "intel,lgm-pwm";
> +        reg =3D <0xe0d00000 0x30>;
> +        #pwm-cells =3D <2>;
> +        clocks =3D <&cgu0 126>;
> +        resets =3D <&rcu0 0x30 21>;
> +    };

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ryah7d65y6lyq3px
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7sV7IACgkQwfwUeK3K
7AlUaQf+O5K63siGJabUxgjvmh9A5fzQL9AiGpByNXarNI6qVzq9QRjY1lWXCumE
DonTm54RLZtZn7iySlahtQ7wG4deqYoMW2BzSDAhm5HpXOz/+yw8ldhNs7604cgz
GylSGQgV79htDsPC2XN2CojSiCq74S3pfnwBH5rrfqgNGSCntpr9LRCS3VtMg+74
55/iw/oLwMqcI3YHT0+WqqpsWUal9sdLHws1f1yEfbagcdpoZfgqfiQ7Cgn3HyD4
orcHfmnLgCY7BFaU4T4Xe51E4G02F02FryWguCi+EU+UMu1y2EW/6p+J2Kj+zlM6
1Ze+Svaokl2MYJELwu/EcV0ab1COaA==
=ILAt
-----END PGP SIGNATURE-----

--ryah7d65y6lyq3px--
