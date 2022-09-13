Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5845B7091
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Sep 2022 16:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiIMO3o (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Sep 2022 10:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiIMO2Q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Sep 2022 10:28:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7347C696C2;
        Tue, 13 Sep 2022 07:17:45 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BA7026601D9A;
        Tue, 13 Sep 2022 15:16:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663078568;
        bh=mRoPwpjQcUUbUIKpdCQyR+owj2sdafBgbPCpLIq/+Ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V9fuNlLbgCAXcV2XaZc49MWoCnpPJ0bhkYxxdRnlVH035u4RoYiza+SuDv9D1tpaz
         3J5qtuLmcz8WE6vKoV+SwX3OqgZkFg7cdiC/tvY1UTyH3QjOeMYHbnwsprTNJUri9w
         2WLr/hOICBRzAB2+lfUwnbJc96k7DvM56RvANF1EnvTJsHSwla/muxJPqy/4bpAHBR
         ZXF46vY8f+wKL4ANxz8pz2k92sNiuZKPTy6WTQeZKacekdai1JuGDXwOd1b2jrhsG7
         /3taMMG9nyiZFJ4SUudgQLFmIdBvv/ep15oXb8QPWzGhCUJExqFXHsiaqeG4YiUwef
         tF5mEKFQr/OvQ==
Received: by mercury (Postfix, from userid 1000)
        id C4DA7106084A; Tue, 13 Sep 2022 16:16:01 +0200 (CEST)
Date:   Tue, 13 Sep 2022 16:16:01 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-pwm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: pwm: rockchip: Add description for
 rk3588
Message-ID: <20220913141601.fi6pl2xdo4xmtw6t@mercury.elektranox.org>
References: <20220901135523.52151-1-sebastian.reichel@collabora.com>
 <1662059695.095333.2226883.nullmailer@robh.at.kernel.org>
 <20220913091202.2oawzrq2u5iiz6hq@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tdr3an426f7oezro"
Content-Disposition: inline
In-Reply-To: <20220913091202.2oawzrq2u5iiz6hq@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--tdr3an426f7oezro
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 13, 2022 at 11:12:02AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Rob,
>=20
> On Thu, Sep 01, 2022 at 02:14:55PM -0500, Rob Herring wrote:
> > On Thu, 01 Sep 2022 15:55:23 +0200, Sebastian Reichel wrote:
> > > Add "rockchip,rk3588-pwm" compatible string for PWM nodes found
> > > on a rk3588 platform.
> > >=20
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > > No driver changes required.
> > > ---
> > >  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> >=20
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> >=20
> > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > This will change in the future.
>=20
> Is this a list of *new* warnings, or is the report (somewhat) orthogonal
> to the actual change and you just used the opportunity that someone
> touched the pwm-rockchip binding to point out that there is some cleanup
> to do?
>=20
> > Full log is available here: https://patchwork.ozlabs.org/patch/
>=20
> Hm, that gives me a 404.

This is an existing problem with the rv1108 binding.
The rk3588 does not have pwm interrupts.

-- Sebastian

--tdr3an426f7oezro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMgkJ0ACgkQ2O7X88g7
+prkLQ/9Gkep9qH4kpsXxRPkrfygxsuWupzScYbLee97gluIQ/gGre8GVM4X8S5y
0H8LpCaKrFZFI/djWDPLNorxl4w1sjykPr45Uh6kQ0Q03tNeg6SvD/SS5IRUQtaZ
v9C7n77C8jtTTa8NFf8VnFAPiO0mSWqhXdNp/w/YYec49iWsOAxKa33RWhQepK/i
JdrMhEzPicpJ5oxDb4eja2zcRYhMHKoUKgG3lWqZgTHu0C+LnhTm03Zu6G2y1dTe
Hq8p1+RIOLarjjyXpgXjQxxCDOoACzW8VZpI1Yn+BLhvCH22JMyPO0apEN37So6Z
QQhjeCLdKLa/bYR/OmbQDVgfQwIUXFLwCNMgpaiaa2NfV0ffZSOgLwRvb0Rf2qtr
cVPWzWBZkOWANaZRSqX+WPen4NApJ03jyBqnO440ABYCdLDh80wLMCubdOzJKzfN
wK1GMlQLHI3tJhSWnDxaZYC1v6am5XuF9ntfxtB/w1DmsU1SO6LuX7XuePdioMKw
dEkbLDH4DoJjIjdBSFcUE0Yq2cfTY1VAPmywcFxWwNEd4ekuljSZBUXc+LIqwgRu
CQDepthj988SJL8Y4qRxEfIaEk/r5+mrwF+dqbZiaLP3bzlQ+UvAn9GPSzTDoasA
PRjPI7CvycBYlBXPUZrVahjPSJR739efhq+MOGcM0X0kPw7Qok4=
=IzMu
-----END PGP SIGNATURE-----

--tdr3an426f7oezro--
