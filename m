Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F6D22E666
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 09:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgG0HU2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 03:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgG0HU1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 03:20:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD26BC0619D2
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jul 2020 00:20:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z17so11332015edr.9
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jul 2020 00:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rELFPxk/Ym/uhPafE6823k2g0ZGP6zKqx8cBaiY1/14=;
        b=Y1N0ciGJnued3kfbnQUvWlUhFCABY3+ahXL6/vK+UKV3VrGWVZ/SSNjQLgpR0YftO5
         LPBsCcB2HvNZuLvvEXpUes5zFNNkIN8dQNQcgr6NrtnESin7Yewn8UcSvRV+vCDtQM1p
         jBg6vuW8SCr5XQYW6vSCI+X+kwQk+vInvsVSyGTjN4CvwyZ9M3P5hZE9MHJSY/2BedAN
         8M5cM/286E/bqSMmcLV83+nDsX6XfTd4paZcyldq+h3Lj2INVWbBJSNn4q8Lv5HR14Ga
         UpMua87S7GIjvWebeQD2IjjuMjpXtlg/sMuG+wqvCaEK2KZcIMlAj3o3Iinp2+kA1tof
         PkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rELFPxk/Ym/uhPafE6823k2g0ZGP6zKqx8cBaiY1/14=;
        b=jUl8qBSObdhnpm/DjAqqHdDYvhkM53ztr8NXDTRvLIXsywltNlh61BHecYkaLe6Iwy
         cQhLjbtP6+dlXbAIpHYHa/kmIoVtCHWK2UAYowHUdYksCv1LhwMiM3d3fIrCyfzyKa10
         KowSw2+APr8v6NXzqND4L9Og4vy9rgKxEbzZT1piZyAQo8HGr82mzxsN2MJuVMaYQCS5
         SDCVafv34lxzfGK1PGgwegPemf+RlQdKPDDileT5Rkf8C7s3qAIYCV2ELirbHW6Q/nGT
         /vVfyD4AL3fI4JWyt1yvqkpFHHHdNJBS0ted8PiEDsFhdYIE1cPCfBpsDdB8RwU94ayT
         WFHg==
X-Gm-Message-State: AOAM530y0aepjCCC2l46i3DIzoKETEMJKeRR5XAt9FUn7uA7h+3mF2Lm
        ZtsdR1daiQs9LZibp8qUGJE=
X-Google-Smtp-Source: ABdhPJwAhvrU0ZOgZjYa8DnA0Uv1UOHGq6SkgVKKE7gn7dy4l3R2cs4h6WtlLsmQacY4F2bsKKQwcA==
X-Received: by 2002:aa7:c3d6:: with SMTP id l22mr19961712edr.148.1595834424240;
        Mon, 27 Jul 2020 00:20:24 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id s16sm5207564ejr.31.2020.07.27.00.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 00:20:22 -0700 (PDT)
Date:   Mon, 27 Jul 2020 09:20:21 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Konstantin Ryabitsev via RT 
        <kernel-helpdesk@rt.linuxfoundation.org>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Subject: Re: [Kernel.org Helpdesk #89942] Re: adding linux-pwm archives to
 lore.kernel.org?
Message-ID: <20200727072021.GA2780715@ulmo>
References: <20200213102618.x5j6kfvqmdbx2pr2@pengutronix.de>
 <20200523170558.h2brqlf2jx4kee6y@pengutronix.de>
 <20200613141533.ak3nyo5hu636evwq@taurus.defre.kleine-koenig.org>
 <20200709092659.drrmvv53qs2q4lid@pengutronix.de>
 <rt-4.4.0-1686-1594286826-1167.89942-6-0@linuxfoundation>
 <010101734f397f00-39d54a81-d06d-4947-b9fc-332e9f9b46d5-000000@us-west-2.amazonses.com>
 <20200723172702.nirnet6tbmwuwd57@pengutronix.de>
 <010101737cb6d988-bb70d517-bbf8-44b0-aa3d-4f9eed9101f3-000000@us-west-2.amazonses.com>
 <20200723173841.4geg4blngc2fwp4z@chatter.i7.local>
 <010101737cc18b4b-3c78b41c-309e-4d62-b6af-fd0536291eab-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <010101737cc18b4b-3c78b41c-309e-4d62-b6af-fd0536291eab-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 05:38:45PM +0000, Konstantin Ryabitsev via RT wrote:
> On Thu, Jul 23, 2020 at 05:27:04PM +0000, Uwe Kleine-K=C3=B6nig via RT wr=
ote:
> > > I'm sorry, apparently I screwed up and didn't assign this ticket to
> > > anyone when it came in. I was dutifully ignoring follow-ups, as I'd
> > > assumed someone else would be responding.
> > >=20
> > > Chris, I've properly assigned it to you now -- can you please
> > > prioritise this request, as time allows?
> >=20
> > Last week I thought this is a no-brainer now and will be done in a few
> > hours. It seems I was wrong :-|
>=20
> I do appreciate your patience. There is a lot of other work happening at=
=20
> the IT team, so your request for adding a mailing list archive has to=20
> contend for staff resources with many other ongoing projects.

We've made do without the archive up to now, so I think we can wait a
bit longer. I think Uwe might just be worried that this fell through the
cracks again. If it didn't, I'm sure we can be patient for a bit longer.

Thierry

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8egDIACgkQ3SOs138+
s6GEjA/+PxXnV7IQlSNwQVAiz65WQ4oJF0tLycsiivRJ/jyxBpWQoxo36NcDkyJy
uR2WBIGRvFZFS2PaJ8axVZCATy0CX8Mx4fSR7sAIqu0x0GIRrSxUA1OFJ9DdKdvT
uiohdGb6CKGw2tno8gQfmdTWMpb/ECA5pS40H2yQ8NzxNtLIPSLZw1gmx89zoe2Y
1XOKH9fMAKq37exyakujZ57QKIJrvCSwC6XxzvTBZWTv14JQqDAgpwadKmEkgvwk
dqEy+p8oOhgCekGUd+UsfqfoItTLXvUVEyZXTBxP/OePAR1SUZuErG6VaOr/jEnm
z2OC17jXrgeS2owDht1d/ymVO/xmeMloWdLXdZcW1SIFv8EgPtEFiacxmoTZVDw/
rM2x3xm4M8d2DaWvL3AF8EmummSrp0Zt9Jn+DzQA9nP4cd+zMbS+hytNpOVEfNF8
BNO5WbUzCXrYsAi7EqZ3Gtxl4d2OgM+dh4WoBnVCe7U7HKbFjrk7BDVujzQtCCX4
QUGi4vCGadplszpUk2GEMtv00t6Qoehd30x5yEGGWskTGtxZsVKuyHCmxReHVLn4
iNp5gEFPkipSWbuVKoY2O1ZRI6H47oSnYoLiLUXHH7LmNw8jCPEk/Uxaju3Z+t61
ch69eXAnYgqWZCwRH/RubxT6CWABevWCIVC+iFKMJHpgJyezmWM=
=KMNp
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
