Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73A37BB5F6
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 13:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjJFLIX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 07:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjJFLIX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 07:08:23 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0165ACA
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 04:08:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32483535e51so1932497f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 06 Oct 2023 04:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696590500; x=1697195300; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/99Z0BykU5TVAp8HXvrR2i0b5yltJ6+LxYwCmXkmOAs=;
        b=ad8DZIsUdxJIU1rqXuXhR1d2CrYrEjilAhhjAEMfyJ0+bz5fe3GPUC6yrGCz1yO/UH
         6Km7thi/aHGt46ZxKWRrjfxXRakJ3E/V8RHIsQq9HvnHE8z+kvhufv8H3DCgjGjYUfBU
         A/AQNQ5bRAcPafWJGkFpwVSiKmiEEv0bHESUnVBJWZlhqCGKur124jg9x70opLaEZQtp
         C/C0OKoi3YNX6Tt1h+ZOUsLImBl5FXXlh/2z1yWUznr0kpcRX8umUfvslH5QulqZCf1/
         vA5iGiOk4VSW0jv3yOxyoS4jDHRUADfJ56lImMnf/sFgEPv++MMUttmU3UK9VYmFC76o
         4pKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696590500; x=1697195300;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/99Z0BykU5TVAp8HXvrR2i0b5yltJ6+LxYwCmXkmOAs=;
        b=kuecN2cSuxyuAgitT1WvA/kt1VdPwxP8HtIHQ7xJTQpcyMq8Cf6+a773iJKUtpBIWj
         1pkkNwxzeAGPcl5+rfDFo/ueq3NICB0Vxjt4G9oLfy8shObXIwpjUNF+zA9XoHwXqfP8
         Uw6dmIMJLCWY6LSPGPKgbyTUkiLsF1wp2dOsKofZ1OiyylUw/JyJJQUIXVezEc60FIWB
         kpPibCcc9RlF7IKKJ/gQK95K8nd7B36XP0k1cNdpPCg9pUZo7hXqsPoErxnD5dacubkE
         WE1Xou7kgsBkoMEgtrUG4uYIUMPoFcOgIpA9Cqt9bjhwiJpEx8xcLmlhxg03q2ZVB8LV
         F4Pg==
X-Gm-Message-State: AOJu0Yy0oxj3D6LO1t3mQy5ktKn85qVlNtu60F8GZ/OvmNjlTGEaVBwK
        AtBz8W+dyLkv8jDFE9vrZFyyZsIUiBQ=
X-Google-Smtp-Source: AGHT+IEZ4NyAlWIEqaq0VwzuSuENNBFM02pTwhgMglfC5daMjKELWfJIith7t6ukcSaC2vKmX95lMw==
X-Received: by 2002:a5d:6a07:0:b0:321:7844:de44 with SMTP id m7-20020a5d6a07000000b003217844de44mr7182886wru.45.1696590500080;
        Fri, 06 Oct 2023 04:08:20 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d4ace000000b00327cd5e5ac1sm1408988wrs.1.2023.10.06.04.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 04:08:19 -0700 (PDT)
Date:   Fri, 6 Oct 2023 13:08:18 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v1 001/101] pwm: Provide devm_pwmchip_alloc() function
Message-ID: <ZR_qoncG_Dma-Lnq@orome.fritz.box>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-2-u.kleine-koenig@pengutronix.de>
 <ZR_SJW9vxOYoAC6N@orome.fritz.box>
 <20231006105626.xu5ztizlk44iyl3u@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eQYISqwppwVfl8DX"
Content-Disposition: inline
In-Reply-To: <20231006105626.xu5ztizlk44iyl3u@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--eQYISqwppwVfl8DX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 12:56:26PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Fri, Oct 06, 2023 at 11:23:49AM +0200, Thierry Reding wrote:
> > On Tue, Aug 08, 2023 at 07:17:51PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > +struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned =
int npwm, size_t sizeof_priv)
> > > +{
> > > +	struct pwm_chip *chip;
> > > +	size_t alloc_size;
> > > +	unsigned int i;
> > > +
> > > +	alloc_size =3D sizeof(*chip) + sizeof_priv;
> > > +
> > > +	chip =3D devm_kzalloc(parent, alloc_size, GFP_KERNEL);
> >=20
> > Are you sure this works the way you want it to? If you allocate using
> > device-managed functions, this memory will be released when the driver
> > is unbound from the device, so we're basically back to square one,
> > aren't we?
>=20
> After this patch the problem with broken lifetimes isn't fixed. Today
> the way the pwm_chip is allocated is a problem in each driver. With this
> function (that indeed suffers from the same problem) the issue can be
> shifted from each individual driver to this function (patches #2 - #69).
> Then the lifetime tracking can get fixed in a single place without
> touching all drivers in one single commit (patches #70, #100 and #101).
> With the whole series applied this devm_kzalloc is indeed gone -- this
> can however only happen when all drivers use devm_pwmchip_alloc().
>=20
> If you have a better idea how to split such a conversion in managable
> and reviewable patches, I'm all ears.

Is there anything that would prevent us from merging the really
interesting bits from patch 100 into this first patch? It might make
the first patch a bit larger, but at the same time it would immediately
become clear why this is useful rather than 99 patches of churn without
actual improvements.

Thierry

--eQYISqwppwVfl8DX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUf6qEACgkQ3SOs138+
s6HeJg/+LnRriJzApWzUBlYYQpbYtsal4VkkBlSKZX6Z2s0k5J60YfeXJFeJDJD3
GV60Yqu6JY30+sDENq1JC3FLIFisAmNx3nMj0E68Xm1EIMWWWuQb/1sJy348HYZa
T0eqEW8GvbVu20HZVChW0Vr0CB7aj9KkCEj70P2knktzmamWS+X2jo6gH4itHKDv
MhVnamaCS+ZU7vaYRBAalL2SgFS/axsqbGw8yrQfaj3bJNsvSK9L3f7EiOrnUjvm
91tcBwBa6IjNSaPwqENQBV8GGK3LQLv/35PC03kFg8pa/qBtaCEJ2TXo20HXw2hZ
kf22n+/CQSLhcp6kVN2LImMA1wtFwg+nhIgt6iUjn/pAz8Z4dp0HEmmWn3m0uP7q
qOHfvJUpT6EBocVXwvQ2QBgnQl8PhNQQVlqHOlU3hqHhlB6uukpWB6nHwIrZYrsu
uHSyVRyQeOPh8iX6UdlS0LSTeksTmLttciPRd/REuVHNWazW8q7eBzwyR+scvBjP
r/BcXajxuIaUylD5YuzEri8C0FUfMjQh0l+ph5onpIOtynf0OImZKIlX2QZj9rnC
5f+rpwrtKu5SXBf0yaNdZ44PcFmZLwyJ5ZD9si/wgrkSCEPllZFYtTyBeQgzWC7j
WLJjII1EYaZ8/yTQ1chuQfx18V5wzyDo1HjEyD/S8093usLPCK0=
=ZOLK
-----END PGP SIGNATURE-----

--eQYISqwppwVfl8DX--
