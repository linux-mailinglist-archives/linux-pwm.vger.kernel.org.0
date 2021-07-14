Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CCC3C7F73
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Jul 2021 09:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbhGNHkQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Jul 2021 03:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbhGNHkQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Jul 2021 03:40:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4700C06175F
        for <linux-pwm@vger.kernel.org>; Wed, 14 Jul 2021 00:37:23 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v5so1976104wrt.3
        for <linux-pwm@vger.kernel.org>; Wed, 14 Jul 2021 00:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M2XQX2JrTCnmC5WERgQQ8d57fVEce2otyLtBYxk1Qv8=;
        b=QYN/rSp3h4/y+Rp5f3SbdOLRnXf9ItDs4JBiKZJW+N9WDuJsUZkPjWfqsTnUQO6LC8
         HrxDu4a3fYVJBqVOjhxlL8rw67gIrUnFTY5HePW+XISGxFGFKOvksonEpXxSt3wlQFmo
         a8PdbmJtH/wnI7mT1RXD6Zax8CQFkNbFdO/Y71v1P8m/8Vxrgc2Pv+YHhM26bn2atxOv
         auUA5m35Yvk3iL+im9HupgzzPF/u1yz8TJuk/fOm3TCpU1EpH7+0yM2qkgm4WgFZ4DJf
         LpQ/uJgDsXpuvcq/CV2PbPtnL6/TtL21immqrNLRNvKXYlPO8cloBG7NFPKOWmLPiQvs
         1wTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M2XQX2JrTCnmC5WERgQQ8d57fVEce2otyLtBYxk1Qv8=;
        b=lP/vlvdV88AjEV2vqkFEfhRS+avtEBUw3ECeK1TIzErbwMbb4WxEjPLCTUaRop9I/i
         ZMgFf2hn0YAktvNhtyN4JI0v49DqR8W2DsGAp3RGUhk9BJIsvHYn+oaoe8y76sTDmGqb
         Ygc1kCrmDFJTtv/KosSRgDy4KYAUgJzbOQoWmXooiYjp6MsUr3s7yFeIMSL+Sesi3pgC
         +OHT5PEeeAj0iazQi5p76UcSR+8Ir9/2Yjk9+JnlR4cbaZsOcKdLHbfoYQZAaw1Ffr+4
         MYd5esLUorCwQ6o6keC9cb9K98Xs+YETbr/xJPuENTz62up0Pvwnz/aIGcpKlXNumsd4
         7fwg==
X-Gm-Message-State: AOAM5317qHxpMZnLnWHPCME5T5kswSpLadvnDnnrkknQcG+yd8OaEc29
        1ZfUw8A9yDk5JBweJBEobjI=
X-Google-Smtp-Source: ABdhPJxtSH4UmLfziQYT7RzdzzqK1fSRy67b7jaiEXpMOc5IOyI4fnhraMdeJq0ruKG6UBDVB9bmXg==
X-Received: by 2002:a5d:410b:: with SMTP id l11mr11143110wrp.173.1626248242286;
        Wed, 14 Jul 2021 00:37:22 -0700 (PDT)
Received: from localhost (p200300e41f023e00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f02:3e00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id t9sm1434810wrq.92.2021.07.14.00.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 00:37:20 -0700 (PDT)
Date:   Wed, 14 Jul 2021 09:39:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Baolin Wang <baolin.wang@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Thomas Hebb <tommyhebb@gmail.com>, kernel@pengutronix.de,
        Orson Zhai <orsonzhai@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/5] pwm: Ensure configuring period and duty_cycle isn't
 wrongly skipped
Message-ID: <YO6UqKr72AE/KuvK@orome.fritz.box>
References: <20210701082755.332593-1-u.kleine-koenig@pengutronix.de>
 <20210708123639.vrck33kc534yrnsq@pengutronix.de>
 <YOcGkoQ4jb0G92Iz@orome.fritz.box>
 <20210714063901.5fmsinbhxoxvxhkf@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w/fuqfFopAcujXTI"
Content-Disposition: inline
In-Reply-To: <20210714063901.5fmsinbhxoxvxhkf@pengutronix.de>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--w/fuqfFopAcujXTI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 14, 2021 at 08:39:01AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Thu, Jul 08, 2021 at 04:07:14PM +0200, Thierry Reding wrote:
> > On Thu, Jul 08, 2021 at 02:36:39PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello Thierry,
> > >=20
> > > On Thu, Jul 01, 2021 at 10:27:50AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > Geert Uytterhoeven found a regression in one of my patches. The same
> > > > problem exists in several further commits. The respective drivers a=
re
> > > > fixed in this series.
> > > >=20
> > > > The affected commits for the first patch is already in v5.4, so this
> > > > patch should maybe backported to stable.
> > > > The others are in Thierry's for-next branch only.
> > >=20
> > > These four broken patches were now included in your pull request to
> > > Linus for v5.14-rc1 but these fixes were not. I wonder that the
> > > regression Geert reported made you back out the offending commit but =
you
> > > didn't care for the four identical problems in pwm-spear, pwm-tiecap,
> > > pwm-berlin and pwm-ep93xx. Did you miss this series?
> >=20
> > Ugh... this is a nice big mess now. In retrospect I should've just
> > backed out all those patches. Or rather not have applied them in the
> > first place until they got a Tested-by.
> >=20
> > I'll pull in this series and will send this as a follow-up pull request.
>=20
> I saw you applied the series to your for-next branch, so next is fixed
> since next-20210709. I wonder what makes you wait sending these to
> Linus.

Given the mess that this caused I didn't feel comfortable pushing this
to Linus immediately and instead give people a bit of time to find any
potential issues in linux-next first.

I'm going to send the pull request later today.

Thierry

--w/fuqfFopAcujXTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmDulKgACgkQ3SOs138+
s6GYBw//Q8v5yL5y65nMuvZR33/yZpt68BrvItui5/wHfesnhslW4E8+FgR96O16
zzZpjMEt9220zjxS/QGTBMn4FqIFtQ+UFyR8JlPXwmrYK7N8zPGM2jF537PUiA/W
qWqVzdLhEeHilamiBNBLllawjWqskkSICE0A1BQoEdkilvUyCmeTpgyeSbJt9p/U
NnOcpZyy6C0jTi3oUziyBXO5eSmTZZ3GtkpruW09ff3MTFoPZiDF3TuRtLWdMKnK
vFCKUlG57iJ/9/9+0oWPgdklC0t6gp+EkK2h+BEJCNAfGQZByHtaDCSJsRTEANHf
kgR8FSkjfwaKaShF6NPtkWGKEOS9CA872/Yen6eGHO41IpG7oudXSWLgXPSFHbYc
psPB9hbtaZfHNfBlqk208s9vO7IyvIImvsyiRUlAA0az6wMCH8R02DR8QTi5j8eD
KATiKAAv+kW7+PHirxHrA2tis2bvK5R8ef/VirOYT4EH5BOiR6KclwRkjmRBzU1h
wZY1tAIdIfskUC5TOZsXvzeMEzRlx0HrVj77E/YcyViZTC2Qx2ejcwTgZnL9nbNZ
+uDX2YTJYcKkesJ68NDnE4vuZ+skwbXnkQcxplBcg5H1T7sjOgVsy+dwN5aQ1Roc
PjrLsd4UoOj0KE8lTTg9zx6M1Q7Q10nnXyO/leUNiCTBR47hd5A=
=aQ1j
-----END PGP SIGNATURE-----

--w/fuqfFopAcujXTI--
