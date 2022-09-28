Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD915EDBFE
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Sep 2022 13:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiI1Lsm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Sep 2022 07:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiI1Lsh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Sep 2022 07:48:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D965300B;
        Wed, 28 Sep 2022 04:48:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r18so26529478eja.11;
        Wed, 28 Sep 2022 04:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FAnMZuS5mkc7/GZqDAnEmPbAang61hPFgfBqbFN5+NU=;
        b=HrsqF6kwxvI3TCUD+MD8KMKGyFN1SbbYLjUa8hJJmfftQkQ2wTB2jpeqJhU8+tQybD
         lkGwTsqyidGlU1FdIWKJxDCSoP82qAVnwVh9nHLg/fQ5iYIYXyj5Vcc9hwE6y8C/a7ls
         6OmhZI69qcQkezB/PEXyUj6Mtrca5IBoyXum9xwck1ouUo9037zIf/CvSeK1zrwRWXAT
         yOSQ5l1j2Dn22DiwCDI+mC3LvrMYwRPs2YEAajBUtWdNs9pCeWQ4ip9Qqh8nZR5Sphnz
         b1CejcO6Gn8kMvUwpzDyqWPtSkRMyXQoSSwO8+LElAOF3+bsulUs4GTGNZFfX3R0w0fh
         UQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FAnMZuS5mkc7/GZqDAnEmPbAang61hPFgfBqbFN5+NU=;
        b=NpxwhWiAlcZnYF82GtTgqVvlBoRLqjc+dY/VAlBaYo4mJUX/D3XSXhT52Nm9VA17re
         y6ov53xClJeK6Yo3//DjNLIqLzjoSJtyCpSPJApxHWvwKInG1vmiNAaULyAtDQMY/zeB
         4Cl6lFxrNGssOWrrboSpzdAgPvsOMwSRxZvr8sHdbA9qyisxwAlYPCMJZ1olJnObQnje
         NYv6q9FegWVaf6Krchx+tMQc1TJhY9vnKXIPNYNqBQj1lPV1XPExd+UeCL18QqSssdO9
         oIlPKuGIMxkx19uRq3Yd33VnSHPMR9PLyYqOHLKssGtRXiAd48bNHeFjikzK22Q8TXnL
         FTlA==
X-Gm-Message-State: ACrzQf2rrhCEefeLic7YTCdcj6a7V2PvS+nK9vm48R4Rtf2OmJb2gKnl
        JKwTXUpN/8PUYsmC/MrFHZ4=
X-Google-Smtp-Source: AMsMyM4WwEDB6JZJPZtN7bJ9mXlKao260GKm95+zoKZOGuPLA7uJgHvU+mzh7nNYUlp3sd2QdLDQ9Q==
X-Received: by 2002:a17:906:da85:b0:741:40a7:d08d with SMTP id xh5-20020a170906da8500b0074140a7d08dmr28764201ejb.263.1664365711886;
        Wed, 28 Sep 2022 04:48:31 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709060cd100b0077fb63da010sm2246341ejh.114.2022.09.28.04.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 04:48:30 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:48:29 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-pwm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: pwm: rockchip: Add description for
 rk3588
Message-ID: <YzQ0jTmJCBwV+x2y@orome>
References: <20220901135523.52151-1-sebastian.reichel@collabora.com>
 <1662059695.095333.2226883.nullmailer@robh.at.kernel.org>
 <20220913091202.2oawzrq2u5iiz6hq@pengutronix.de>
 <20220913141601.fi6pl2xdo4xmtw6t@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dyGexfX47caB1lpi"
Content-Disposition: inline
In-Reply-To: <20220913141601.fi6pl2xdo4xmtw6t@mercury.elektranox.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--dyGexfX47caB1lpi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 13, 2022 at 04:16:01PM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> On Tue, Sep 13, 2022 at 11:12:02AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Rob,
> >=20
> > On Thu, Sep 01, 2022 at 02:14:55PM -0500, Rob Herring wrote:
> > > On Thu, 01 Sep 2022 15:55:23 +0200, Sebastian Reichel wrote:
> > > > Add "rockchip,rk3588-pwm" compatible string for PWM nodes found
> > > > on a rk3588 platform.
> > > >=20
> > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > > ---
> > > > No driver changes required.
> > > > ---
> > > >  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >=20
> > >=20
> > > Running 'make dtbs_check' with the schema in this patch gives the
> > > following warnings. Consider if they are expected or the schema is
> > > incorrect. These may not be new warnings.
> > >=20
> > > Note that it is not yet a requirement to have 0 warnings for dtbs_che=
ck.
> > > This will change in the future.
> >=20
> > Is this a list of *new* warnings, or is the report (somewhat) orthogonal
> > to the actual change and you just used the opportunity that someone
> > touched the pwm-rockchip binding to point out that there is some cleanup
> > to do?
> >=20
> > > Full log is available here: https://patchwork.ozlabs.org/patch/
> >=20
> > Hm, that gives me a 404.
>=20
> This is an existing problem with the rv1108 binding.
> The rk3588 does not have pwm interrupts.

Can somebody go and fix that, then?

Thierry

--dyGexfX47caB1lpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0NIoACgkQ3SOs138+
s6FYPhAAkpWg63sPJIpWbx2dzxaJlV5QQ5A8JbcoHnFl5pL+PuMYkKkZkGfIRBRM
CHHt5kM8cTqOloBa+/xgvBgYEA5Bb2n8qnUZLV7IGXgo2k7Aj4aC2trSn31K3z/l
L7q3dOAAFZsR527T1Vww0iGx1tkGpet6/9MtQXvKbKG5oKrnPDDcCYaYU8kfaz3A
QiiUQKVX1f1JQ9r2mbyNPSqEaj01H+dkzXUcsG08GjQ4uAQrdp6YOvfE9VipF43D
+vrwf39nSW7pZG+bL8OLgloo9Mi88IhcBD+w/kkpVeBrQEGOmDXjs0dX+ko83pN+
9XCo2dVLdTs3l2JEaQVTLnWdRwjKvK2lrsduo/sIJxngpX3horO1N7fY4BVdAQOY
Ftv6gtqMU+KZoerFsFzEHf0nVFjOBfjYxux2ovPToXfayn1Cf0JmyIXCGDdp6lTq
yWfhVfW5cDEiRiNcrshz4G9IpH0yeaBTUrtGGBQL34WNzKVm6DZi3MWzfKyhnf8o
i+ttdQJSs7zL/qkwpGYk0ntc4/RFkkwWVWya7R1fRFFxdcWs6CXQauudnhcehBCV
zD6cacw/HFyYrsHhUt4vQpmcCdJ7myHHmS+PHSiuy6aQwgagEnCYQQfns+fBsFE/
WKykGXVi5Ta74AnZX5YPEWRzxtz9U682w5XTjHxRDJLCBZpGSck=
=KBC2
-----END PGP SIGNATURE-----

--dyGexfX47caB1lpi--
