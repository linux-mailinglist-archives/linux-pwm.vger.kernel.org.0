Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064AB5EF61C
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Sep 2022 15:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiI2NLB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Sep 2022 09:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbiI2NLA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Sep 2022 09:11:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4AB1CB15;
        Thu, 29 Sep 2022 06:10:57 -0700 (PDT)
Received: from mercury (dyndsl-037-138-185-092.ewe-ip-backbone.de [37.138.185.92])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5F99B660035A;
        Thu, 29 Sep 2022 14:10:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664457056;
        bh=YN0HXeldX7lu2CDgzDa8aXPTXqKCxKzZBEHVex6achI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DdlalBG9CHYJha4gAaS0XoX+ae1bJ+wOylnWStp162evoXW+xGd/ZoKpe1y2NdydA
         kHhsqCeiHin5A/+nVHuZYRg89gtvGwNpW+jMltgDmb6/OEbZ96MWbIMXlR+0hFfsi/
         5MahGT4amI11vWIzH+Zp3jU6jNuj0YmW0pGF7B9M7Lj3ufD3c+r0T7vuc9BAvZ5fkH
         cOPxAucPsv4QKiRmYoHCDeHQAY2MOYLQxDdVuKDZOyGLV0izgig2xogG5dUkx8YftO
         WxamgFc+1aeKnXb1jQ7qIYuW1m7/TvNaYNrXqZr1hW2jAjbw/Fx3UQgD4VmuQb+kiN
         nhYFBoNlhVEzQ==
Received: by mercury (Postfix, from userid 1000)
        id 8ABDA106093B; Thu, 29 Sep 2022 15:10:53 +0200 (CEST)
Date:   Thu, 29 Sep 2022 15:10:53 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-pwm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: pwm: rockchip: Add description for
 rk3588
Message-ID: <20220929131053.gujqusy5wx6lp3p7@mercury.elektranox.org>
References: <20220901135523.52151-1-sebastian.reichel@collabora.com>
 <1662059695.095333.2226883.nullmailer@robh.at.kernel.org>
 <20220913091202.2oawzrq2u5iiz6hq@pengutronix.de>
 <20220913141601.fi6pl2xdo4xmtw6t@mercury.elektranox.org>
 <66b5b616-ae9f-a1aa-e2b5-450f570cfcdd@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qov4d3yszrkvywp3"
Content-Disposition: inline
In-Reply-To: <66b5b616-ae9f-a1aa-e2b5-450f570cfcdd@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qov4d3yszrkvywp3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 28, 2022 at 08:29:35PM +0200, Johan Jonker wrote:
> On 9/13/22 16:16, Sebastian Reichel wrote:
> > On Tue, Sep 13, 2022 at 11:12:02AM +0200, Uwe Kleine-K=F6nig wrote:
> >> Hello Rob,
> >>
> >> On Thu, Sep 01, 2022 at 02:14:55PM -0500, Rob Herring wrote:
> >>> On Thu, 01 Sep 2022 15:55:23 +0200, Sebastian Reichel wrote:
> >>>> Add "rockchip,rk3588-pwm" compatible string for PWM nodes found
> >>>> on a rk3588 platform.
> >>>>
> >>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >>>> ---
> >>>> No driver changes required.
> >>>> ---
> >>>>  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
> >>>>  1 file changed, 1 insertion(+)
> >>>>
> >>>
> >>> Running 'make dtbs_check' with the schema in this patch gives the
> >>> following warnings. Consider if they are expected or the schema is
> >>> incorrect. These may not be new warnings.
> >>>
> >>> Note that it is not yet a requirement to have 0 warnings for dtbs_che=
ck.
> >>> This will change in the future.
> >>
> >> Is this a list of *new* warnings, or is the report (somewhat) orthogon=
al
> >> to the actual change and you just used the opportunity that someone
> >> touched the pwm-rockchip binding to point out that there is some clean=
up
> >> to do?
> >>
> >>> Full log is available here: https://patchwork.ozlabs.org/patch/
> >>
> >> Hm, that gives me a 404.
> >=20
>=20
> > This is an existing problem with the rv1108 binding.
> > The rk3588 does not have pwm interrupts.
>=20
> Hi,
>=20
> Could you recheck?
>=20
> From Rockchip=A0RK3588=A0Datasheet=A0V0.1-20210727.pdf:

Indeed. Looks like I missed the PWM interrupts because the list
of interrupts is in two columns in the datasheet and I only looked
through the first one assuming it was one long line. I should have
checked this more carefully. Sorry about that.

> =3D=3D=3D
> ARM: dts: rk3288: add the interrupts property for PWM=20
> https://github.com/rockchip-linux/kernel/commit/16b7b284618d1652e694f6286=
f575ce82f5f03e5
>=20
> Comment:
> At the moment, we can find the remotectl pwm is needed on box.
> We can add the property for all PWMs. AFAIK, the pwm driver don't use it
> but the drivers/input/remotectl/rockchip_pwm_remotectl.c
> =3D=3D=3D

rk3288 !=3D rk3588. That's a different SoC. The downstream kernel I
used is this one and does not describe the interrupts:

https://github.com/radxa/kernel/tree/stable-5.10-rock5/arch/arm64/boot/dts/=
rockchip

I suppose we have these options:

1. Remove the 'interrupts' property from any upstream rockchip DT,
   since they are not used by SW? They can always be properly
   introduced without breaking backwards compatibility.

2. Describe 'interrupts' in the DT binding as optional with
   description to shut up the warning and otherwise ignore the
   problem until somebody has code to use the interrupts.

3. Same as 2, but also add the interrupts for rk356x and rk3588
   even though they are not used at the moment.

4. Describe 'interrupts' as mandatory in the DT binding for any
   rockchip SoC that has them and add them in DT. Considering
   normal PWM usage does not need them at all that seems wrong
   to me.

-- Sebastian

--qov4d3yszrkvywp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmM1mVoACgkQ2O7X88g7
+pokQBAAqhup1AfHwBLA0RoqPBI4qhTOeFeQeX9dHHFtHtb8z2JpRSYrCI4mkPvs
Ma2TVmcVTQ5+iUjfT8DJvmFbehmS37YjWVWAFgJCpj4hdokjotvQ6/UJOWnE/WUD
uEKk3fCUDt61QR1bOtNOuRMFm5XAUZJ8dcPNu4Wkgk8fDz8e0x/s1JCOViNtgtHL
KO6Xp/3wY6nBVE+lLHpZMUI+gYLtdhD30oS2NkCrvmiMJhR/THQVrhCuO58bVxQr
WC66LFxeVHcUQpwF5AwLqE8jqQTLPgAeNZ4nCH/cgzAJpPCk+Uv7fsXzV6wSRzAe
z21pKMWLTOonvz5YR0eBrE8ua1z6uZtdjMlrjxrDwHezf9cA0LRuYi2Xle1HQddU
lqN2079fy0yJ5FPxBJJLvBa67MjVrmQWF/+qlaMK89467A450jbPer4AnKA/v4Jf
6IqFUmsF4MhGB9o0f3JDyn2/x9dMEK3SUnQ5mrLAoAgXT/EU5S0r8Vvu7SFv1gb0
ADQEWIhkPUwJHH6O8usJGGMqApTKJgcyIZQgdamCirDcpZ0fsPIy5bl6RXhuLSRY
lrqDjy5SD2fZ9YB5KlazI4ibiVWR8xBsd9Srfj0XY1+OW5ennWzrwWqI3llP16O4
MfgGe2+FHxvaDfVtHDRM0RJiRWy8MNzLbRwNOEZgoMwfhzqsf/k=
=FjJ4
-----END PGP SIGNATURE-----

--qov4d3yszrkvywp3--
