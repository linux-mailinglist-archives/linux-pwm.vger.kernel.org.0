Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6803445AF
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 14:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhCVN0T (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 09:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhCVNZ6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 09:25:58 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D70BC061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 06:25:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y6so19346143eds.1
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 06:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eYep3zQiXnT8/dwX0wEmTauGIccPY573DOrq4fJJRoU=;
        b=uFuOmkLVWaX/J11dY4rMkeofDAzvsjdK9z5cxYhtgJL+4ZqeVSTJDZbW2Z7Rb0vA1u
         8Q812UGEPxuD+guMjMczTWHoi59GfzLwmkNBbO5vvOYpI2pZxkE1WwZGMYz6pNhNA8/A
         uAVVaf5yKtpo29IAYALPESpcJ8I/Fh5OawUeoE6fYiEvmx+J4edbTBU4GJcbTZRFY2Gj
         m2u7VsGVPyZ5pFLBq38ueUw58A0TBUca/8Xq2Lz+9qxMJiD/FudHAYAJlYfip67IJ25w
         r5Ks+731q+0O9UKtnqUc4FHklOLX0MUQ3re8QLYvfzX7mcgrBtLe7Fa37N6WmVyaLMyS
         uCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eYep3zQiXnT8/dwX0wEmTauGIccPY573DOrq4fJJRoU=;
        b=KBzZG6i1OF/qGttqjK+KF87O/CwLvNnm6U3se5EbKvlGnVz/pVWhaImy9IuzDt6L4/
         wNX6lz+AmF/XMrBPmz4V434UTYygR4Rz8opb4nLi88u2CYTpnrIs4J4CTyIi6Rj0NYF8
         2kF8L0XywMirI7J2RXOLQ2fG7UKSM9YYJy21tZFTh/SBj7D7/3JpcPIx7wjBlFc8Dj/g
         rm1mWbrUJh8mlEr2RCFoa4tc0lTYnjDR5g/PxFF394sl3VUknN1zsmbo/OolWY4J8KVW
         GvsQin4eS8quppKleWh7bbmojSn4DKVX7gD1pLa7UGvmSvRBCN3btTrz6I9KJgxBF5mZ
         dIGw==
X-Gm-Message-State: AOAM5301kd5NwCl/ATIHTq3P8I+r+lSnsYhDadNE3sHeTAMks5kKnFvT
        VUde/U7pGgE+gceTtja4cB8=
X-Google-Smtp-Source: ABdhPJx1hQbT03Mgmzx0TjruQkbM1Sr0cBRwfxqJ4nMKAPCIOiUITPIL9nD414sG1I0P1cZlRzQPMA==
X-Received: by 2002:a05:6402:1713:: with SMTP id y19mr24521548edu.52.1616419556219;
        Mon, 22 Mar 2021 06:25:56 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id z9sm11839878edr.75.2021.03.22.06.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 06:25:55 -0700 (PDT)
Date:   Mon, 22 Mar 2021 14:26:13 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 00/14] pwm: Patches I consider ready for the next merge
 window
Message-ID: <YFia9Q4lLIlKdEmf@orome.fritz.box>
References: <20210319102852.101209-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RAw7BUgoawcLbZGg"
Content-Disposition: inline
In-Reply-To: <20210319102852.101209-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--RAw7BUgoawcLbZGg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 19, 2021 at 11:28:38AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> this is the set of patches that are open on the list for some time.
> Lee suggested to resend them.
>=20
> @Thierry: I'm unsure what is the best way to nag. Is it really
> resending? Or does this just result mostly in overhead because the
> patches are still open in patchwork and it adds copies to your mailbox?
> (Another downside is that taking the patches from this thread results in
> recording a newer Author Date compared to picking up the originals.)

I use patchwork extensively for tracking, so merely resending patches so
that they float to the top of my inbox isn't useful in itself. Patches
do, by the way, float to the top of my inbox when you just reply to them
(e.g. by pinging). Resending a particular series is fine because it's
then easy to mark the old version as "superseded". Sending a collection
of patch such as this is a bit more annoying because now the duplicates
are spread about a bit more in patchwork, so it's a bit more work to get
patchwork cleaned up. But it's not that bad, so no harm done.

Usually when I look at patchwork I will look at the A/F/R/T column and
the more flags I see there, the more likely I will be to go and apply
it. Anything else I will go and look at myself and comment and/or apply
or sometimes wait for someone else to review.

Perhaps a better way to nag me would be to delegate patches that you've
reviewed or think are ready to me, which would make them stand out more
among the others.

Thierry

--RAw7BUgoawcLbZGg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYmvMACgkQ3SOs138+
s6FDdg/+Na/sulqZKX7NhQzvgpRVNAmEAsq/Rq/W9Jewyke95EuO0M9vFtGBFthH
n1sUc6QSgS8N0A+BVqXkXatU24WJJpsndwc1vEuCsX2h+lp1ZSs/WnEMC5OQ67SZ
al4AmgxWuqM6agT58Vr3dFV52plZQw1B9Ov54WG+12y/Lam5e3oX+nnIHIpRcn1q
p/EzpRywCJ451146kmSU9VY7CgGZpAQZMOs7WMXO0fFD0QtWclxc9OS9d3oaSYhN
LhQVjPaIUGC9Ln+2h+KltH6dxL0bw742YLnRcoQqv1tqrG490axusbxjY47lulX6
vQ/ZC4VPaE6m3RWhiGIcSn2uD7h9IUEXDlplln3FDiXvU75jj8EtTWwlQVzrB0cj
bokoNbm8xrSLZH2qKBLsQ98e2ytba4WsBqfroX2kJ5gl+fV92hlBjfNHDMSRY2ud
kIrUPoqs6yovCqE+efQ43h8icuDvVV9R9jLSnXANTdIOE6tsspnUHouO+4f/iGoL
YCkZ/7xpyivQOfDlXulhzibRoLHzO9fD+NBjqnp1pXwS7RfKblrRW0pfgDfFAMjy
hFfJSh6TPhSj22Z22exB7O+fMAwnmQ34wKX40dU5Eg209i46nsVfgCdQC2JdbAAR
1s26J5qYxltmSj3hZsMFfpze8TyCMEQ0qZjTIsfXAOu5CBbcur4=
=2r/6
-----END PGP SIGNATURE-----

--RAw7BUgoawcLbZGg--
