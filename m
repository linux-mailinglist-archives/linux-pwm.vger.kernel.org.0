Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66F75EE13A
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Sep 2022 18:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiI1QLj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Sep 2022 12:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiI1QLi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Sep 2022 12:11:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8497B794;
        Wed, 28 Sep 2022 09:11:36 -0700 (PDT)
Received: from mercury (dyndsl-095-033-171-230.ewe-ip-backbone.de [95.33.171.230])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 22BA5660229A;
        Wed, 28 Sep 2022 17:11:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664381495;
        bh=qHyTJA3FBFD3jqcxgKZgATb1mrrugrAS6HDjPax1FxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/FBy72KLxBgTEBiSyFlrRCbV/G4OKLY5LTlnsE+gwKJHuVTp2j2rhdrAoWvbtiaE
         0DUrU+z6T07yz3NTBD5olie/x+t117UCUDww67czIC/jU+gzGwzP6SWtu+k5sx1y3U
         /R8aZGSlXccGEhimaolTdZszzbF19P0jC7epkJMQ6UpYvHRUBy0OjCo9jyMjzQSZPI
         6dSZlto0EpGTC7fnakWxjRHL/KmTwgL1yJMvrrkzbDdWn2+NYMV/WA9YZpU1sYxCty
         1qEvGwR/ZTpME/SV7MLI8IcXC9QY6KGA56Vv/qGE0s1YSN9aBOXBrhD9smuAMcmG3X
         fDrXD+NY/1Nnw==
Received: by mercury (Postfix, from userid 1000)
        id C0E08106033C; Wed, 28 Sep 2022 18:11:32 +0200 (CEST)
Date:   Wed, 28 Sep 2022 18:11:32 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-pwm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: pwm: rockchip: Add description for
 rk3588
Message-ID: <20220928161132.nltfcgdxxnuebldv@mercury.elektranox.org>
References: <20220901135523.52151-1-sebastian.reichel@collabora.com>
 <1662059695.095333.2226883.nullmailer@robh.at.kernel.org>
 <20220913091202.2oawzrq2u5iiz6hq@pengutronix.de>
 <20220913141601.fi6pl2xdo4xmtw6t@mercury.elektranox.org>
 <YzQ0jTmJCBwV+x2y@orome>
 <20220928130634.x5cfkwegwgqer2xx@mercury.elektranox.org>
 <YzRSpGwUQIFT2A3g@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="54cjpvuozfgyppeg"
Content-Disposition: inline
In-Reply-To: <YzRSpGwUQIFT2A3g@orome>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--54cjpvuozfgyppeg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 28, 2022 at 03:56:52PM +0200, Thierry Reding wrote:
> On Wed, Sep 28, 2022 at 03:06:34PM +0200, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Wed, Sep 28, 2022 at 01:48:29PM +0200, Thierry Reding wrote:
> > > On Tue, Sep 13, 2022 at 04:16:01PM +0200, Sebastian Reichel wrote:
> > > > Hi,
> > > >=20
> > > > On Tue, Sep 13, 2022 at 11:12:02AM +0200, Uwe Kleine-K=F6nig wrote:
> > > > > Hello Rob,
> > > > >=20
> > > > > On Thu, Sep 01, 2022 at 02:14:55PM -0500, Rob Herring wrote:
> > > > > > On Thu, 01 Sep 2022 15:55:23 +0200, Sebastian Reichel wrote:
> > > > > > > Add "rockchip,rk3588-pwm" compatible string for PWM nodes fou=
nd
> > > > > > > on a rk3588 platform.
> > > > > > >=20
> > > > > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora=
=2Ecom>
> > > > > > > ---
> > > > > > > No driver changes required.
> > > > > > > ---
> > > > > > >  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
> > > > > > >  1 file changed, 1 insertion(+)
> > > > > > >=20
> > > > > >=20
> > > > > > Running 'make dtbs_check' with the schema in this patch gives t=
he
> > > > > > following warnings. Consider if they are expected or the schema=
 is
> > > > > > incorrect. These may not be new warnings.
> > > > > >=20
> > > > > > Note that it is not yet a requirement to have 0 warnings for dt=
bs_check.
> > > > > > This will change in the future.
> > > > >=20
> > > > > Is this a list of *new* warnings, or is the report (somewhat) ort=
hogonal
> > > > > to the actual change and you just used the opportunity that someo=
ne
> > > > > touched the pwm-rockchip binding to point out that there is some =
cleanup
> > > > > to do?
> > > > >=20
> > > > > > Full log is available here: https://patchwork.ozlabs.org/patch/
> > > > >=20
> > > > > Hm, that gives me a 404.
> > > >=20
> > > > This is an existing problem with the rv1108 binding.
> > > > The rk3588 does not have pwm interrupts.
> > >=20
> > > Can somebody go and fix that, then?
> >=20
> > I assume this will be taken care of with the rk3128 patchset, since
> > that is affected anyways:
> >=20
> > https://lore.kernel.org/linux-pwm/f5dd0ee4-d97e-d878-ffde-c06e9b233e38@=
gmail.com/
>=20
> That patch is already acked and I've pulled it in, so better make it a
> separate patch.
>=20
> The point I was trying to make is that somebody needs to fix this,
> otherwise the automated checks are not going to be useful. So saying
> things like "this is an existing problem and the new compatible is not
> affected" is not helpful.

The point I'm making is: I do not have that hardware. I only have
rk3588, which has no interrupts and I don't know anything about
rv1108.

Based on the driver and the bindings I would just remove the
interrupts from DT; but I can't do any testing beyond compile
testing.

-- Sebastian

--54cjpvuozfgyppeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmM0cioACgkQ2O7X88g7
+prUKg//QL3sLDMsnXNj4vCRGavaxog4wd5iPpNGGdMBcTdEFpp67/3pqSp3lnei
HpCq4wSgElYEv4pZsme3QmrBsC6jTZNtw+M0ZFXene6iJiU7mPPoHgAIaUG51LR+
r7iPf6iZIJ7llmvehPuCRHmK3WxvOnTPllCmrJNhsajb720RheuUNYnKPRyjyACU
kn99tc1lDh0zJ/upVoorgwLI1smWkbWR9QUw41qkPnnuNFkJBzLjxSy8bFQNWFcc
qIgq3oC+h/82AqIvI/sevNcvQBRSXh585hA7dlYxCt4RFPLWzJTDMSmeDtapCxMN
ealcCUYln6xLPGJQLlzgOF1/HYLCq7xrIhyk1KYQtosCSvZ9kzDFKx5GOCCzngIC
/rVc/pm5T/eG4IYP1xpLagmvVPC52MrkcgVmvOQUhRROW8QSrzhTlEQuEhVNmzgu
wJNCTwfoaKFe1FCrtLm+0q9Y6bwAgtTUINptq3yo4NyCtCb80WqBNvMficSd3yDJ
hgbmecx/99vqm/GjOlBAvifqozUqm+5Frb6IVsge6ZlGoygJUu7WbQQGxJy/0wOs
5VZOjci6baC9/jjQjJKRfWKz0GOKvwbk/wSY7Wayv1g4+8plqD7La9tc6+zOzMHR
a4EOeRylGUbGtqbdzoQ09Mvrp18atAa/HWooD4CcXYOA35TolLc=
=nsg1
-----END PGP SIGNATURE-----

--54cjpvuozfgyppeg--
