Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AAB7BB6F0
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 13:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjJFLvF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 07:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjJFLvE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 07:51:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BB8C5
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 04:51:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c1c66876aso384026366b.2
        for <linux-pwm@vger.kernel.org>; Fri, 06 Oct 2023 04:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696593060; x=1697197860; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4mT/CpTGUROomwav1+PGBteUZVf6wRhTfAmU1/UVtM=;
        b=Az5kNeUE+/u7nXi7HPfk4/eYmSdb+jI2v4VihvUUacEfZH7s1uQjqY2PpYchjZ20Rl
         eEMyfmPRiqQq4ZJwplSGIUmtgKHVky9sT2bOASiBlg79RU3Dgp06T4mdiJpxmsh3N9Cg
         shrEVpO2oCoLbgEOyjpML+fGXt4hQ7XNwYngGt2AhVjXAwO8dTNCIYQpF9wh1ZzHVE48
         EtLUA63HzkdMS5R+qyMfCV5+dqeXBvrY4pzRfgs0kSrUqyITCONoMYx4xUXfUjd+C74N
         0rGAMMOEazn6qHCx6ahkZc2dBLkyUNLpf6PEGFNtBtLf+eZN+CKcSJIifc+2yzSzQiYX
         GtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696593060; x=1697197860;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4mT/CpTGUROomwav1+PGBteUZVf6wRhTfAmU1/UVtM=;
        b=KHdV8Me2I7WGmeReMaTObtMH9qk4xx922dAofWNWhWSfJxVW2/pRyg2FSxCEd6T0/0
         8k8YZ4X5qmOv60eY+sOlWLSSn2vV6vm9BV0gBM7pLJjAvzE8r6CQ/u79fPjoaV2Fx3dd
         VWlQkHG+9v9Jcw1gtPRbDbyQm8UetZGWtxEgkMTdYozKQTGA7r6In7Id5scZlzdXXLid
         yTNGv24U/ZpjwAmIBeMEVUlJ56yE4cFc0hbasqt0rk+cj9U0EkmJQEWzT6mLvfosPIMN
         AhXMsBZweW+31+H2X4ETjCC58cgdadmNDwwNqqmGZ9HSOjNVoyD3VnYl8i9EB7yv8Agl
         iKOw==
X-Gm-Message-State: AOJu0YxaNoxkvBoAmgrMsHikOy0CFBgDiAv5C2OLIwumEKx/nLiLPEpC
        AhwptoQo4qj47u1+urdOjO0=
X-Google-Smtp-Source: AGHT+IH/JoMkIDYTCmFTsLgYZOHaxQ0d37NE6lg/WH4+rYk0nStc49V+itrjMCcydNYTzs6AqlJ6VQ==
X-Received: by 2002:a17:906:210:b0:9b9:f47e:bf33 with SMTP id 16-20020a170906021000b009b9f47ebf33mr2816256ejd.70.1696593059537;
        Fri, 06 Oct 2023 04:50:59 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id si5-20020a170906cec500b009875a6d28b0sm2752645ejb.51.2023.10.06.04.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 04:50:59 -0700 (PDT)
Date:   Fri, 6 Oct 2023 13:50:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v1 000/101] pwm: Fix lifetime issues for pwm_chips
Message-ID: <ZR_0ob6D5XHbWgNG@orome.fritz.box>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <ZR_RQ-PMqfrDPGwE@orome.fritz.box>
 <20231006104102.4k4ivgw7na2o2f2q@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8FQc9QjC88cBChPo"
Content-Disposition: inline
In-Reply-To: <20231006104102.4k4ivgw7na2o2f2q@pengutronix.de>
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


--8FQc9QjC88cBChPo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 12:41:02PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Fri, Oct 06, 2023 at 11:20:03AM +0200, Thierry Reding wrote:
> > On Tue, Aug 08, 2023 at 07:17:50PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > this series addresses the issues I reported already earlier to this
> > > list[1]. It is based on pwm/for-next and several patches I already se=
nt
> > > out, too. Maybe some of these have to be reworked (e.g. Thierry alrea=
dy
> > > signalled not to like the patches dropping runtime error messages) but
> > > in the expectation that I will have to create a v2 for this series, t=
oo
> > > and it actually fixes a race condition, I sent the patches out for
> > > review anyhow. For the same reason I didn't Cc: all the individual
> > > maintainers.
> > >=20
> > > If you want to actually test I suggest you fetch my complete history
> > > from
> > >=20
> > > 	https://git.pengutronix.de/git/ukl/linux pwm-lifetime-tracking
> > >=20
> > > .=20
> > >=20
> > > In the end drivers have to allocate their pwm_chip using
> > > pwmchip_alloc(). This is important for the memory backing the pwm_chip
> > > being able to have a longer life than the driver.
> >=20
> > Couldn't we achieve the same thing by just making sure that drivers
> > don't use any of the device-managed APIs to do this? That seems like a
> > slightly less intrusive way of doing things.
>=20
> The device-managed APIs are not the problem here. If you allocate in
> .probe and free in .remove there is a problem. (And that's exactly what
> the device managed APIs do.)

Heh... so you're saying that device-managed APIs are the problem here.
Yes, without device-managed APIs you still need to make sure you don't
free while the PWM devices are still in use, but at least you then have
that option.

My point was that with device-managed APIs, freeing memory at ->remove()
comes built-in. Hence why it's confusing to see that this series keeps
using device-managed APIs while claiming to address lifetime issues.

> So no, you cannot. The thing is the struct pwm_chip must stay around until
> the last reference is dropped. So you need some kind of reference
> counting. The canonical way to do that is using a struct device.
>=20
> You can try to hide it from the low-level drivers (as gpio does) at the
> cost that you have the driver allocated structure separate from the
> reference counted memory under framework control. The cost is more
> overhead because you have >1 memory chunk (memory fragmentation, less
> cache locality) and more pointers. IMHO the cleaner way is to not hide

Single-chunk allocations can also lead to less cache locality, depending
on the size of your allocations. For instance if you primarily use small
driver-specific data structures, those may fit into the cache while a
combined data structure that consists of the core structure plus driver-
private data may need to be split across multiple cache lines, and you
may not end up using something like the core structure a lot of the
time.

Anyway, I'm not sure PWM is the kind of subsystem where cache locality
is something we need to be concerned about.

> it and have the explicit handling needed in the drivers be not error
> prone (as spi does).
>=20
> I agree the switch suggested here is intrusive, but the "new way" a
> driver has to look like is fine, so I'd not hesitate here.
>=20
> > > The motivation for this series is to prepare the pwm framework to add=
 a
> > > character device for each pwm_chip for easier and faster access to PW=
Ms
> > > from userspace compared to the sysfs API. For such an extension proper
> > > lifetime tracking is important, too, as such a device can still be op=
en
> > > if a PWM disappears.
> >=20
> > As I mentioned before, I'd like to see at least a prototype of the
> > character device patches before I merge this series. There's a whole lot
> > of churn here and without the character device support it's hard to
> > justify.
>=20
> The character device stuff is only one reason to get the lifetime
> tracking right. See that oops I can trigger today that is fixed by this
> series.

My recollection is that you need to inject a 5 second sleep into an
apply function in order to trigger this, which is not something you
would usually do, or that someone could trigger by accident. Yes, it
might be theoretically possible to run into this, but so far nobody
has reported this to be an actual problem in practice.

Also, as you have mentioned before, other mechanisms should already
take care of tearing things down properly. If that's not happening for
some reason, that's probably what we should investigate. It'd probably
be less intrusive than 100 patches with churn in every driver.

I'm not saying we don't need this, just trying to put it into
perspective.

Thierry

--8FQc9QjC88cBChPo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUf9J4ACgkQ3SOs138+
s6EY1BAAmzVg8nfu3deD6bMv0HSJjSeIm6GnnoE2sHmV6O2MFLFFiPHd13riomDq
VCntb+m2UlcBTAIX1oTuHhxIwXbxqDxlvzLY52t572DIVW7Qo7uFS2nd7R0zXyhf
mJifHUxzJt+3kh1nCCyATa4otZiv04sw76lSX1lOSM3I/paeVR0eRpC5wJ2LzvZJ
3Rh4a6+vy7D3VWQUrNN3OUIVhK1RFcHgCZLI1ZHMUOZ2M85FdXBuy9ixzhmijngL
dIKxTyJjZlkwCXiyqYvDMMLz6KwF9MqcHMSOVq+3XYCuMdAqdY727Jclxh8AWNHj
HfxlvMSQgjqi1GOUapScJZY6AJEULQueQTecfjoQpcqKx2gCKwgTt7nTHmEeObfv
sbiIzcJcCWpRkSyoen4NaqpEnTRL/yKNEsUrOW174fgMOxkLNmiSwpnBMoP1xHUK
cdfGEKcfbFHulTppmdlD4M4v57mZkKCyS9jVodcOaHSG6mzGiJ+Iy9hPMckUIixa
RiYn4+GLolnAllKsRfTjsoplWqFNKSeWgMls7ZWOTzosVlZODGXn0pGhjo/jdQJ4
OoCrOPXFa8xijptuyzkM35CEBw67O7AzZdP+xkLHxaBO5hx9zZGWSClMk6PBS/Xw
nnrCUjz1xCRWfLeWDqYom6hPKQGti4KsChbZiTbB3fHoLskEboI=
=GSnu
-----END PGP SIGNATURE-----

--8FQc9QjC88cBChPo--
