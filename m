Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BA57BB655
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 13:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjJFLVB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 07:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjJFLU1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 07:20:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B21210A
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 04:20:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40651a72807so19159485e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 06 Oct 2023 04:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696591221; x=1697196021; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JyyBSlraFdXeMzitaID+HXJ+JsoFhIVPliKYx6Ii90=;
        b=f8g88D41Afxp4X5kqQrD7EYfyQSED80MmcNAdBf64p0Fgxr/K3/3jWjzUz7IRwMM/Y
         uiOFWGdbQGqC7r49n4V3ajm0BKjw2hJ/9BAt6OONxjYGZVbaOHnfItOaSyrbfDUYDfZv
         hE9K2DRAlhFmcoq/vYPorr3AM40njWNuc7eWttqVdwE36TQRF76sMbPbIkaPzPKyZXmt
         srFueuQvLIQ6KHKK7fFM9hnZ81FimzUp7hnfyDtIYxAeHkghynJ1HfCQHRvlcyGa/rTv
         +i4h5SczsbD7yqgf1V+KoobH7JLhqbt3AvcBvsegntdKCqb3u5QfJUkyBXBLZknR4urL
         AIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696591221; x=1697196021;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JyyBSlraFdXeMzitaID+HXJ+JsoFhIVPliKYx6Ii90=;
        b=oNS2/pEovPPwckKFvC0+PwyQwE8NwzZXJ1aLq373TWAJaiZMNDpgYChvhU3tqK7JJX
         Y1ubqcadq9MPhBjEBm0WvRLmnnO5bX+0YI4F8vPLv1U/AApzveaarn276OVtBUYwtv0Z
         fdvwpLtmSk6c49RuOI7GCbkr9xHsKRyPzI2g1NbNyNQcgZvvtKmG79x4/vIcMI/2vw9/
         NZGlIGJHAsMP3vaP2kh6rsc2sXY4yz84YO4blxz0fxESH0z0Uv/E+vyHwTH3RVkJNoWH
         9CR56itj3gVZbEVFAlYPvl3FrSWz7lCc4nnxJrXZ/1169eRU4vSuQDPeYKdiZTnNsOc1
         55pQ==
X-Gm-Message-State: AOJu0Yxk6X4SJaUoMV481h6/tu/yVf8V3LHBZuoWSkCtKDkjJ2Xi/Hm4
        k9ewZpsdK6sK0T5Hg/g9uxhzZvVD7KE=
X-Google-Smtp-Source: AGHT+IE6EtHnZOaWXO32o1KR7eHNvfJRCOoGBGQ5rdrzL7mgl9whgtXinTUS4prNQpFgS6+MVizRqQ==
X-Received: by 2002:a1c:7c0a:0:b0:405:92f9:b090 with SMTP id x10-20020a1c7c0a000000b0040592f9b090mr7315245wmc.14.1696591220545;
        Fri, 06 Oct 2023 04:20:20 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a11-20020adff7cb000000b00326f0ca3566sm1409843wrq.50.2023.10.06.04.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 04:20:20 -0700 (PDT)
Date:   Fri, 6 Oct 2023 13:20:18 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v1 071/101] pwm: ab8500: Store parent device in driver
 data
Message-ID: <ZR_tcmBGOOQVNSz4@orome.fritz.box>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-72-u.kleine-koenig@pengutronix.de>
 <ZR_WXxqhmRgtpA0n@orome.fritz.box>
 <20231006110951.wkmjvokvnenuypdh@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FXauv/n1IPfZaSjN"
Content-Disposition: inline
In-Reply-To: <20231006110951.wkmjvokvnenuypdh@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--FXauv/n1IPfZaSjN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 01:09:51PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Fri, Oct 06, 2023 at 11:41:51AM +0200, Thierry Reding wrote:
> > On Tue, Aug 08, 2023 at 07:19:01PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > struct pwm_chip::dev is about to change. To not have to touch this
> > > driver in the same commit as struct pwm_chip::dev, store a pointer to
> > > the parent device in driver data.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/pwm/pwm-ab8500.c | 16 +++++++++-------
> > >  1 file changed, 9 insertions(+), 7 deletions(-)
> >=20
> > You're basically adding a parent device to all driver-private data
> > structures in this and the following patches, so why not keep in in
> > struct pwm_chip and simply rename chip->dev to chip->parent?
> >=20
> > As Andy has commented, this would eventually allow the PWM core to
> > take care of certain things like runtime PM, or even only for stuff
> > like using the parent device name in info/debug/error messages.
> >=20
> > Also, you could then just make this a single large patch that renames
> > dev to parent in one go rather than making this large set even larger
> > with this kind of trivial changes.
>=20
> The idea here is (again) that I don't have to touch all drivers in the
> commit that changes struct pwm_chip.
>=20
> In the end there is such a parent pointer (pwmchip.dev.parent). Would
> you prefer a macro (say) pwmchip_parentdev that can be defined as
>=20
> 	#define pwmchip_parentdev(chip) (chip)->dev
>=20
> at the beginning and then be changed to
>=20
> 	#define pwmchip_parentdev(chip) (chip)->dev.parent
>=20
> in the right moment? That's the best idea I have here.

No, that's not necessarily better. So I think either we live with the
duplicated parent pointer (which is the same whether we keep it in the
core structure or the driver-private structure), or we just change all
the occurrences at once when the new parent is introduced. I personally
much prefer a single big patch with a lot of small one-line fixups over
30 patches that exist purely for the purpose of making patch 31 smaller.

Thierry

--FXauv/n1IPfZaSjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUf7XIACgkQ3SOs138+
s6GwsRAAotkAUSDeeQ3ncisATE9esy3XA1YkwEZ6R5jACOh3xiEwqrCFTdimhy2M
ekBrbslTfjS9LqGCVcNEstfeIWohj9qm2S1ElwWrWtZ2JPNbYAiRVN11DT6WhYsQ
rKUZAoPDNKTk6JMwRKXPVppcBHvPTMqnvvfHgV5dHr4Zsw2N7uvnq3S/s2SMIChR
aTFo6ybomEFlR/Ei3FcLz+H+TmcWaZ6HYmrgqGiZQ3WYxYzls8QaOv6zhvn272Cj
tJd3igWSlFCFZjVjCQjdi3gxo3XZ0yqcTSwpegF5UzWrtPbJcaHrY8b5L4hpLWyo
gr/oVezUCPpLahhzFvwdlKYkoRfI3bglWtPRmCFr1viqJrbDnYXByygGYA8erc11
wPcxgpXFjchOVMdZ+PDFrgMAcendVYBhY4ILHIlTW/BjhXFQr1in8qhm3K2nRStp
nN5LLubGSoNUHU8y288fL4hhk9u6CuPyy++xdWHlU8Fv7NkJY7dblqCQn7I/PnN/
PMa/ah5fSFFZEXWdhnAMpnzcZpfoWXiVv6+rTy4hXQL4OdUCogT4eAkO9bM451lr
aXD3nv1DiSqHcf2TGJwr4uodd90gMFfs4Jsy+3qO9CB/WWwkDW9RfkacrjAFz91q
6j30Ts61OBROkqDzLzuSvgm+aD87JjtD46ehcrDWnHQ2C3QbROQ=
=nK/J
-----END PGP SIGNATURE-----

--FXauv/n1IPfZaSjN--
