Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036C042A3C5
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Oct 2021 14:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbhJLMFP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 Oct 2021 08:05:15 -0400
Received: from www.zeus03.de ([194.117.254.33]:43250 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236281AbhJLMFO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 12 Oct 2021 08:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=7O0H5EJxVRUljGYlAvs6NTuwkAAs
        L0Ejam/d5Je6CfY=; b=pe7NEqDuo5mLStb5UvIdR9sJLUtT/CjmM5BKvrZUKI19
        7KAKOQhuMrfBuSkdFeWUfuZUCSZt8+mFboRWGL5ELyJT890yj1p0Dc3GiDcCHTAs
        eDKgQFEl+4WKAjNEhPYFjQi57OprbwELBlx/VgyW6ZhZckx1GMeEHx6yAnqFNp8=
Received: (qmail 204041 invoked from network); 12 Oct 2021 14:03:11 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Oct 2021 14:03:11 +0200
X-UD-Smtp-Session: l3s3148p1@JcEsoSbOorQgAwDPXw9GANTxpJbLr/qt
Date:   Tue, 12 Oct 2021 14:03:11 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH] dt-bindings: pwm: tpu: Add R-Car V3U device tree bindings
Message-ID: <YWV5f/DOH3tHN6V9@kunai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
References: <20210901090719.35375-1-wsa+renesas@sang-engineering.com>
 <YTE71AmRgTzhW2PZ@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nvp/hY2zytipy8RT"
Content-Disposition: inline
In-Reply-To: <YTE71AmRgTzhW2PZ@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Nvp/hY2zytipy8RT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,=20

> > Add device tree bindings for TPU with the PWM controller found
> > on R-Car V3U SoCs.
> >=20
> > Signed-off-by: Duc Nguyen <duc.nguyen.ub@renesas.com>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
>=20
> Acked-by: Rob Herring <robh@kernel.org>

Could you kindly apply this one (like the one for M3-W+), too?

Thanks,

   Wolfram


--Nvp/hY2zytipy8RT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmFleX8ACgkQFA3kzBSg
KbYUwhAAmDtM8pNsZMGKV9mFkszYLvGdXGLuuAWq63lN03mmv9Tm9gS18vCg02mX
pCfNmEYWrc8dwTr4sAJPTZiHpO5QADh41pBBQSxmOADMO7cLhf9kqv6S+T09F6+2
+ouTMGhUL4dIboxlxlSaBCqup0BkI5eaU0krzcgHnTPHMzvmlow1CL0urM2EfuBZ
cqVGD2Tgt2tozT8micnm8b5RNt04p0XlMjzSch/i9KV1IzRcnbItXSUzX+nxgnJg
Br/JbrR1lhP3/OaKuaNvusrEHLufftVFcFBs/NlW59/OC0O4nf36wikfGzBx506d
C59M70pne69XZVHfBpAmiRN8VkbjqKuOKDBbYJF1/tUTUun9xzOWmv5x5PtL2JvE
HJkyF4lJvh1RYW6/gbvhNeVWA+O3BpGCAInJAveIYVV2NFQjtsF9sAQlqLtJtPBh
MnQ7l78Q+KoWl3qbP3uHIpTgTu8c40mt28bg+HP3sssoKjkfjmx7ItcoyRgnuvpH
9/mUK5Zz75UfNwIpHZEBhOR89c1dMghih1TyUYI0vVJI9To3r+9A9khcLQngWCcD
/uHqW111Ftc5ZvHm4YONS61ACDfapySEEIRr9FimpGNenedIpJTlJfhaXIRris+F
NxrLUQMZDkpxJM1LxhzIQl5w/aAbg6Q1ODD+/G/FrcYta2bLnWc=
=is8t
-----END PGP SIGNATURE-----

--Nvp/hY2zytipy8RT--
