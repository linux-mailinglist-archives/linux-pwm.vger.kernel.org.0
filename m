Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66415EDD78
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Sep 2022 15:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiI1NGm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Sep 2022 09:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiI1NGl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Sep 2022 09:06:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9059FA89;
        Wed, 28 Sep 2022 06:06:38 -0700 (PDT)
Received: from mercury (dyndsl-095-033-171-230.ewe-ip-backbone.de [95.33.171.230])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C26096602289;
        Wed, 28 Sep 2022 14:06:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664370396;
        bh=c9JtjBwjFF79SmCgeSuVKQRi+U2ANa35gBatTDWdXx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OOelG3G2yNH+GLL44hnU0wzqsyItfNvfy8eFzQKq1odX4RcRFcjdDim/XLNURgyJv
         +CAYnDW57CdWTzAmA5aLnbeoM/GYE1NGAULfWDTEhasSIt8CIitWPD1G5sXB1AkLHa
         KAW7kt0aTg9Hj9pP0Nb9DF8S59Alp6kDDy3DvR8N6JADp+zFSRq/1FR8xgx6MYIqR2
         4w8GS4ZzSZrKtvW1Gb+XdFzKUrbTl7/gCeURe7/L8B26cqpId3HoGFW2MH8U5YuvSn
         DLge7QGIojTzHD38pPj3kjwZZGB1T25Z45xNLNhs6aAQbeys/WfBZzun1gd7xAQrqh
         rfYpzC14Y5NjA==
Received: by mercury (Postfix, from userid 1000)
        id 70F9F106033C; Wed, 28 Sep 2022 15:06:34 +0200 (CEST)
Date:   Wed, 28 Sep 2022 15:06:34 +0200
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
Message-ID: <20220928130634.x5cfkwegwgqer2xx@mercury.elektranox.org>
References: <20220901135523.52151-1-sebastian.reichel@collabora.com>
 <1662059695.095333.2226883.nullmailer@robh.at.kernel.org>
 <20220913091202.2oawzrq2u5iiz6hq@pengutronix.de>
 <20220913141601.fi6pl2xdo4xmtw6t@mercury.elektranox.org>
 <YzQ0jTmJCBwV+x2y@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f2ysunquf6nsloxy"
Content-Disposition: inline
In-Reply-To: <YzQ0jTmJCBwV+x2y@orome>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--f2ysunquf6nsloxy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 28, 2022 at 01:48:29PM +0200, Thierry Reding wrote:
> On Tue, Sep 13, 2022 at 04:16:01PM +0200, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Tue, Sep 13, 2022 at 11:12:02AM +0200, Uwe Kleine-K=F6nig wrote:
> > > Hello Rob,
> > >=20
> > > On Thu, Sep 01, 2022 at 02:14:55PM -0500, Rob Herring wrote:
> > > > On Thu, 01 Sep 2022 15:55:23 +0200, Sebastian Reichel wrote:
> > > > > Add "rockchip,rk3588-pwm" compatible string for PWM nodes found
> > > > > on a rk3588 platform.
> > > > >=20
> > > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > > > ---
> > > > > No driver changes required.
> > > > > ---
> > > > >  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >=20
> > > >=20
> > > > Running 'make dtbs_check' with the schema in this patch gives the
> > > > following warnings. Consider if they are expected or the schema is
> > > > incorrect. These may not be new warnings.
> > > >=20
> > > > Note that it is not yet a requirement to have 0 warnings for dtbs_c=
heck.
> > > > This will change in the future.
> > >=20
> > > Is this a list of *new* warnings, or is the report (somewhat) orthogo=
nal
> > > to the actual change and you just used the opportunity that someone
> > > touched the pwm-rockchip binding to point out that there is some clea=
nup
> > > to do?
> > >=20
> > > > Full log is available here: https://patchwork.ozlabs.org/patch/
> > >=20
> > > Hm, that gives me a 404.
> >=20
> > This is an existing problem with the rv1108 binding.
> > The rk3588 does not have pwm interrupts.
>=20
> Can somebody go and fix that, then?

I assume this will be taken care of with the rk3128 patchset, since
that is affected anyways:

https://lore.kernel.org/linux-pwm/f5dd0ee4-d97e-d878-ffde-c06e9b233e38@gmai=
l.com/

-- Sebastian

--f2ysunquf6nsloxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmM0RtQACgkQ2O7X88g7
+prpdw/8CDA0maCo1deheKUSy8nfdV6SmgJMk9rAjqdItMm4h+mcp3HE1UBP0YB6
QKATRpGvPYE7fkcxCNQouS7jpcZUy/wKeVrZBMRQ/KFa+FhaqxMi3s71GO43EH82
pLegd52EYc5FrKJnEPDi9zWjEDw/qrQcrTT8xp4bFfeuo+Fpwl/xB6CniCCQhOVo
rvI2s/SVjZjBSj4XUF4pkbEFBOwZorajRS/apfYUceMStner4ORF4ltxQFVFeXrq
oVxRnkrgXCVhmHRRtyyXAsLtQ/7AciTZC0VlyQM9/f/Il97YKgYOX9r/YfjnvKlG
vLFEFHZHLvt8bpgAHNlQIZSR5LifKmZFsOcegd3wuTfXETtFAYPK9p2oExp8WWJf
FbTQD6thpSHOpT4ZvFl/UT4s5izLQAa4nfSSIVrMOpk/9ZHgrSJegrBK6LneJE1Z
0JKAxS8JyF4R5iNVPH4j/UsAhrbeCfz/NY8XD0AFMMRiYit+75VwaUa3lPAYqW+6
NCct/u7HPCRvqqek+qlbs17jO1XQPwEGmIF9ukgf36bPC0mGEv/ZS9C45KrEaB3l
hvJ0ZQ7DglTsB5i8ejmNj2zMq1eU+Hn/zMQILcraiVi46+1adEHjQVFuZBKu+Ayf
SY+pydPmmBBCSJS5bkhYEF7UHGW/fMDew7zLIAziw68K2tWAt44=
=n053
-----END PGP SIGNATURE-----

--f2ysunquf6nsloxy--
