Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435BC5EDE4B
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Sep 2022 15:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiI1N5C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Sep 2022 09:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbiI1N46 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Sep 2022 09:56:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BAD5247D;
        Wed, 28 Sep 2022 06:56:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sd10so27361254ejc.2;
        Wed, 28 Sep 2022 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=NITJHdTB+Lv4ZdxlNq2e36da3EEH3SEz+wsBZBap0Ko=;
        b=cBvA7vpvD6VLKdgMy+ReK73i0ixVjH+NHqnLvjhsoLCDcuJ7j4bGpy992C8ogu24By
         D0PIYl3X/rb4swv7e7mHlN4hOdgCcl6rlPHiYMcKkcGGVX2DnqEINsBb/85UXkVhD24J
         iEGPeyIN6uRJJ0nyz+yaJZCLFejm0v/+UmeDQ0fTWIYJkpS305dVmK1o/3mLggEOKofN
         9ro5lrW7iOG6Av6gjuH2oOHfw5ajIpgvK1kyxuoSs3fMo6GSk55EQqHN8k5shI3HBzjO
         twCzytqBR/7i0tgdJ/btM1DNE795aQHtuiUL0C89HinhW0lVLqAPw3YDfUHkiMUdqEmm
         iazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NITJHdTB+Lv4ZdxlNq2e36da3EEH3SEz+wsBZBap0Ko=;
        b=Cpigvql3oM8rcpRrg11oPT3LdMmGQ2Lh4wDhZ/1zzh7sBl3CznKc44LT0pRpaQi97b
         m8Yoz9Bd3uoxM1lZt1Nlrsaqdc1y3XYQmWKVC3YI/BJ8uvHPdAOV1U3XeYV2y1weA5Em
         Xd+pcXtaOj9qNtxSDLpEXIJdH9OrYDp8Gz8pfW35J63pmOEYyhHYKEdaQWUH+uAAesun
         THJ6WXyvTm/R2iEjHn4Q1eRr8hf4z524oZZDlvvHXlvImRGoz2cJJoJZZY0/qMstIHFL
         xacTg8iZI3VKDuf6knDzpIjOtZKlv/6GtGYsuhn1s0ZW2cYeIjizGmp6Gh8+AW9f/tS5
         MPsA==
X-Gm-Message-State: ACrzQf3yc1BBrn9Ha+ryWOPFDhVMkmXJ+4B6QRSxMhNl+p4UFChlHlh0
        0KIbsWt4/B2je9tX0OvMWic=
X-Google-Smtp-Source: AMsMyM662loIzkObdq2jJvod/cYYA6lPcCmR5Y4oNGQxA1V5Wnd/QHbrmOdLeKgCTb+qlP08nQZCGQ==
X-Received: by 2002:a17:906:9bd3:b0:778:c8e0:fcee with SMTP id de19-20020a1709069bd300b00778c8e0fceemr27979332ejc.275.1664373414890;
        Wed, 28 Sep 2022 06:56:54 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id kv12-20020a17090778cc00b0072af4af2f46sm2436452ejc.74.2022.09.28.06.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 06:56:53 -0700 (PDT)
Date:   Wed, 28 Sep 2022 15:56:52 +0200
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
Message-ID: <YzRSpGwUQIFT2A3g@orome>
References: <20220901135523.52151-1-sebastian.reichel@collabora.com>
 <1662059695.095333.2226883.nullmailer@robh.at.kernel.org>
 <20220913091202.2oawzrq2u5iiz6hq@pengutronix.de>
 <20220913141601.fi6pl2xdo4xmtw6t@mercury.elektranox.org>
 <YzQ0jTmJCBwV+x2y@orome>
 <20220928130634.x5cfkwegwgqer2xx@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KB+NSNt/SxmW23eH"
Content-Disposition: inline
In-Reply-To: <20220928130634.x5cfkwegwgqer2xx@mercury.elektranox.org>
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


--KB+NSNt/SxmW23eH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2022 at 03:06:34PM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> On Wed, Sep 28, 2022 at 01:48:29PM +0200, Thierry Reding wrote:
> > On Tue, Sep 13, 2022 at 04:16:01PM +0200, Sebastian Reichel wrote:
> > > Hi,
> > >=20
> > > On Tue, Sep 13, 2022 at 11:12:02AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > Hello Rob,
> > > >=20
> > > > On Thu, Sep 01, 2022 at 02:14:55PM -0500, Rob Herring wrote:
> > > > > On Thu, 01 Sep 2022 15:55:23 +0200, Sebastian Reichel wrote:
> > > > > > Add "rockchip,rk3588-pwm" compatible string for PWM nodes found
> > > > > > on a rk3588 platform.
> > > > > >=20
> > > > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.c=
om>
> > > > > > ---
> > > > > > No driver changes required.
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >=20
> > > > >=20
> > > > > Running 'make dtbs_check' with the schema in this patch gives the
> > > > > following warnings. Consider if they are expected or the schema is
> > > > > incorrect. These may not be new warnings.
> > > > >=20
> > > > > Note that it is not yet a requirement to have 0 warnings for dtbs=
_check.
> > > > > This will change in the future.
> > > >=20
> > > > Is this a list of *new* warnings, or is the report (somewhat) ortho=
gonal
> > > > to the actual change and you just used the opportunity that someone
> > > > touched the pwm-rockchip binding to point out that there is some cl=
eanup
> > > > to do?
> > > >=20
> > > > > Full log is available here: https://patchwork.ozlabs.org/patch/
> > > >=20
> > > > Hm, that gives me a 404.
> > >=20
> > > This is an existing problem with the rv1108 binding.
> > > The rk3588 does not have pwm interrupts.
> >=20
> > Can somebody go and fix that, then?
>=20
> I assume this will be taken care of with the rk3128 patchset, since
> that is affected anyways:
>=20
> https://lore.kernel.org/linux-pwm/f5dd0ee4-d97e-d878-ffde-c06e9b233e38@gm=
ail.com/

That patch is already acked and I've pulled it in, so better make it a
separate patch.

The point I was trying to make is that somebody needs to fix this,
otherwise the automated checks are not going to be useful. So saying
things like "this is an existing problem and the new compatible is not
affected" is not helpful.

Thierry

--KB+NSNt/SxmW23eH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0UqQACgkQ3SOs138+
s6HhJg/9H9mzZqDA/iGGUXTdr3g5Wu3TWv2PholqP+c/mBRjbpoiaZ3nCygx7nwm
u0IqOMwOt3il0WNH4en0R1MQKIDC5c1zHSIHDtUMqb9oJrIQWWimevXWr+/ed3IM
dgV4DCU4O+V6oDroOA2q2z+8lHB9yeCxFc/9jDoYI8kOMxh4HsPmRqQ3BQG1lCjD
xDVTbqeVrmwHzjxqWmtVm3penUvrLDgLpjRFvk3RYj2krrJ5AhmrRwMFBej9PCg1
p3vv+hNKTUZYENe55UqgDw9996HGigM3dnLXDdOjpO/39Xu/Zem12VsE7kbNeY2n
DDDuVvuGA7jiyg6BvB0OnjicNj+2RTyhlVF44hF2SAplCPRFsmrZS5HepZQEIRPb
O3JrH62+YYnwaojIoCJRQfEwFSUiQ3Os0O7HB5yeG0Hr6Zro9VP7GIX8/7KalJRD
6vCtxkxrZiIFgHCPXlEPmys4jRa3HAew6A74nG5eZDnG4+7WaIAFNox+sF2PmbqD
5yG5yE3eovuMixINSmy3la5L533acwGIFHFcGkeudhuN4YCnFCq1MAZ8mVQb0x0V
zHN4XiGc/Z5OrmrYe1h4wKOtE+E2JJatfigoqSDanG7mhGxtZjsZHDYdqTY4kqAc
aDaJN4yX/OvJiTo5LO7mU8c0I78epPaxjql+d2mnDq9W1QhFbfE=
=IwQz
-----END PGP SIGNATURE-----

--KB+NSNt/SxmW23eH--
