Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA4D454AC0
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Nov 2021 17:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbhKQQS3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 17 Nov 2021 11:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbhKQQS2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Nov 2021 11:18:28 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E910BC061570
        for <linux-pwm@vger.kernel.org>; Wed, 17 Nov 2021 08:15:29 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a9so5720933wrr.8
        for <linux-pwm@vger.kernel.org>; Wed, 17 Nov 2021 08:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GwowMeyAZfMZzmRrt1Fil3aT9sYrg6xjGMjICwMuqMc=;
        b=jmdfCKUccwLkSfRSoD3XXsEVa7gQdRpcDbBjeu1rRRcEBdggXK50wBPOybYii7MSLD
         /SAeeKIibFLhB+UlZADxRCd/nSqIEQYc8+CnR1D1g9nZBc89pGRvklhGyEfcZR8Bq2ql
         O9udUSGjXh6QTSy0aXukhwgFlGdpZrCmF6ofVCpEgipO7sUX2fGojbqfQiEmlmQBXY6H
         +e4ekDD5NCXUDG7ldT2ekdEOxVtruUDDapJLe31sIOJxLpYHAce9UQEm1EbnKs13nJk4
         sl1/Wcw//ukeccyCg5G+juvM4C0XHdXBgB/ImtH5G0xppmSar/z+TqT5Mk+Ff726sQ9H
         PniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GwowMeyAZfMZzmRrt1Fil3aT9sYrg6xjGMjICwMuqMc=;
        b=dRUjLbk6j3YhYOwSNmjzdYNj6SD5Dqn5ZQgMCCDHKzUlbSaWGScfPHiJ6JJ02I+MrJ
         dWo/Ac7kTsDWK9MPsZUfq1n0agMd/34cNH2IJ0MlIGWzO+ESHg+oOv3ned3h0rWDLlVx
         rViERO6SdzJvRykuBpGdN8liQDc3ZBWDbHbcQ6V9ufg7J+QRCr8j/DrpqEvogK7HL8Hk
         sLm3UL1/q4QD44ctEcJztXyi8UUyUHT+A84sg4HOSOeCZzRaMY/Tmqy3uZXhrnSv5a9M
         M0WIiDWnbIJMzIRJJTEzdU5Q2yh8oi6DhOlZGOPHTqYLxyUJsotKIcPs1zR3iVxjr3vM
         jasg==
X-Gm-Message-State: AOAM533TmH3dUMJcXsNw89wFbc+sbrFzbSO5JzdXL6soZ4eWWyQ1bsh6
        WbKuVns6tXJH5H5iG91PkiNkmKwNMX8yQA==
X-Google-Smtp-Source: ABdhPJz3bm/mE5f5qecvJR8LWnSIqyhARud+uFG6cGYPb5nGF6RajcH7pZCe4+ZPxiu2FYUZfQm5Tg==
X-Received: by 2002:a5d:5986:: with SMTP id n6mr22288359wri.297.1637165728503;
        Wed, 17 Nov 2021 08:15:28 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id ay21sm6153113wmb.7.2021.11.17.08.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 08:15:27 -0800 (PST)
Date:   Wed, 17 Nov 2021 17:15:24 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH] pwm: img: Implement .apply() callback
Message-ID: <YZUqnKIpDwswKKCO@orome.fritz.box>
References: <20211029105617.210178-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fJOb5jJrcmZIicHy"
Content-Disposition: inline
In-Reply-To: <20211029105617.210178-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fJOb5jJrcmZIicHy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 29, 2021 at 12:56:17PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> To eventually get rid of all legacy drivers convert this driver to the
> modern world implementing .apply(). This just pushes down a slightly
> optimized variant of how legacy drivers are handled in the core.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-img.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)

I'm not sure if this type of conversion is all that useful, but I've
applied this anyway, thanks.

Thierry

--fJOb5jJrcmZIicHy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGVKpwACgkQ3SOs138+
s6GWmxAAuwahFtGiP7CCL7NX+UGTHS11soEb8ddTSbO3u1Lyjrsr5/jmFJF20H6k
h7HYPPc42yNe7ONfboZQLdXMhgOI41JGGpFd26h3NiDrngZEEOVf1pZG4NeZApye
cDUy7SdPFRu1gsPvhN24r3nOz7R8DMaqvT3OCMxtFLWc4SOjVR4GKImtCKUpBoyT
/0FCw7//niu6C6q2qGp5mQlENofDGnCsEtrN9IkMtXAGPaiiYAJmioy3n3UHpEQt
+tB8STgtc915OjHyb6Bh69Ux7ICO1TsYDE15Zgr4+ed+OJ6yxUS9trwh74DlOhDS
8HyorIdoqf1NHb5GcU3omA19EkWxmrXkrLrEvB6Mqj9RWa/Q0w/c/9zEiGO5ARPm
j/811av5fcbTozHAJDfdzCiNhqeIiW4SSfo3xl8cvucHuxttkF2packRMIst+S7/
4ZExfaDd34M/AXlcyzsTwCZ1KK/9a1iBog34/+bMVdX/mlKnqRhuRLRG5nXNKkyx
tQeG60lC5R+c0ZoJ7Gtd6ZLyRqvvFw50C8LosFzs6f5vOfbW1Xy/BPNF10lEMa0c
ZJ3s4bopUrUGn/VAH8tBjMHcd3b10bLvfEv1km/v9ONwhf4HcuKmpstyH3gHtBy8
7MuxqSOkmPGRXymm5Nas0MwRUdPDxZEpTQY4KDRgN30K5oi/6IE=
=uyV8
-----END PGP SIGNATURE-----

--fJOb5jJrcmZIicHy--
