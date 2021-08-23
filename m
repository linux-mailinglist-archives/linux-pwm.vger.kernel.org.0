Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC68F3F4C6D
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Aug 2021 16:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhHWOdu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Aug 2021 10:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhHWOdt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Aug 2021 10:33:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79958C061575;
        Mon, 23 Aug 2021 07:33:06 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id q11-20020a7bce8b0000b02902e6880d0accso14275161wmj.0;
        Mon, 23 Aug 2021 07:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kKNTgN3mFZPjHxMm9PJkyaGLg0UeM0w5/suyeTcMCds=;
        b=Ez/HiDH3tFmVC4uKBvHgtFzVhf5NyUU42y+5Lk7iQk7CbnDkPYMGOlaMnc0A7HLBJw
         eWugtLu8U4/9o5aEJf48iw+G6cKxrmqxzYQvyXaTFxF/VLYSaCfpeh/+AGmp8SBxu1lB
         qm3zidvf28w2SRNDLu8OhnQzo5muVjjRhaIGvozxNPOQrjNBvXf8nq85yo6HQzlBKLmU
         nzja6sHIhvGl2u+EqnRtgSQJl/7h2YONt5JGKSF2dBwOkwinufFPGqE+7KXbsWH7nTD8
         XY3kngutJ1H7lJa8xJhpA6dHcDU3twBm/CLhiMZ/5aYAACW7FswYmospyPXglG3MHnPd
         fAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kKNTgN3mFZPjHxMm9PJkyaGLg0UeM0w5/suyeTcMCds=;
        b=rDtbzYDFMVsFnjXCieQ4cdWvmM7zUm7mAEtu7ImVM7zmvTv67kriqvSr5O/0zWV8d2
         jAalhv/L1snUONg+A2zewcAeD4PVcJYTqYVG+bI+SH666caSWi0K961y4wT/RMQRnuTi
         wh53F7lJ/AAleyMAjP9+gITzLAK49B4D+uvhvvqD+I7LQWtkPscycSsZcWZEYacOweqX
         fItgMygJnPyXf/d9b9yuWHO4lCXtEj4EvJkysMdj+aGnk4a52obsGhrfHRm/+wnTi6MZ
         A5qsJmhCHgeT8qhdjZAFiYDx/5tggPEDI7BclB/Up5cZYawz395JjGtr0PbIC1y6Twvd
         rOrA==
X-Gm-Message-State: AOAM531PRWTDcpOsE5f4gZFA3JUKvlXU7GvZRKKb6GQ6W/QfidFssnMV
        58iuJAMB3+7CX3GUviVGCyk=
X-Google-Smtp-Source: ABdhPJxBq4Nvsa0gnzzH4WFHk2SbkxyCPoHtvepGuqxwqRXVQN0QX9rC0+5h+ZD3D695iv58bgjotw==
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr16739221wme.125.1629729185109;
        Mon, 23 Aug 2021 07:33:05 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id w18sm16192391wrg.68.2021.08.23.07.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 07:33:03 -0700 (PDT)
Date:   Mon, 23 Aug 2021 16:33:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v8 07/34] clk: tegra: Support runtime PM and power domain
Message-ID: <YSOxnqiia+FqfOX6@orome.fritz.box>
References: <20210817012754.8710-8-digetx@gmail.com>
 <YR0UBi/ejy+oF4Hm@orome.fritz.box>
 <da7356cb-05ee-ba84-8a7c-6e69d853a805@gmail.com>
 <YR04YHGEluqLIZeo@orome.fritz.box>
 <ad99db08-4696-1636-5829-5260f93dc681@gmail.com>
 <YR6Mvips3HAntDy0@orome.fritz.box>
 <e17bbe8d-7c0f-fc3d-03c7-d75c54c24a43@gmail.com>
 <YR+VDZzTihmpENp6@orome.fritz.box>
 <CAPDyKFpJ+TK0w1GZEA7G=rtAjq5ipmVR4P0wy7uHiEGVWRk5yA@mail.gmail.com>
 <89ea1694-be9e-7654-abeb-22de0ca5255a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PvC9h3QplaOMl/PL"
Content-Disposition: inline
In-Reply-To: <89ea1694-be9e-7654-abeb-22de0ca5255a@gmail.com>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--PvC9h3QplaOMl/PL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 21, 2021 at 08:45:54PM +0300, Dmitry Osipenko wrote:
> 20.08.2021 16:08, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
> >> I suppose if there's really no good way of doing this other than
> >> providing a struct device, then so be it. I think the cleaned up sysfs
> >> shown in the summary above looks much better than what the original
> >> would've looked like.
> >>
> >> Perhaps an additional tweak to that would be to not create platform
> >> devices. Instead, just create struct device. Those really have
> >> everything you need (.of_node, and can be used with RPM and GENPD). As=
 I
> >> mentioned earlier, platform device implies a CPU-memory-mapped bus,
> >> which this clearly isn't. It's kind of a separate "bus" if you want, so
> >> just using struct device directly seems more appropriate.
> >=20
> > Just a heads up. If you don't use a platform device or have a driver
> > associated with it for probing, you need to manage the attachment to
> > genpd yourself. That means calling one of the dev_pm_domain_attach*()
> > APIs, but that's perfectly fine, ofcourse.
> >=20
> >>
> >> We did something similar for XUSB pads, see drivers/phy/tegra/xusb.[ch]
> >> for an example of how that was done. I think you can do something
> >> similar here.
>=20
> We need a platform device because we have a platform device driver that
> must be bound to the device, otherwise PMC driver state won't be synced
> since it it's synced after all drivers of devices that reference PMC
> node in DT are probed.

I think the causality is the wrong way around. It's more likely that you
added the platform driver because you have a platform device that you
want to bind against.

You can have drivers bind to other types of devices, although it's a bit
more work than abusing platform devices for it.

There's the "auxiliary" bus that seems like it would be a somewhat
better fit (see Documentation/driver-api/auxiliary_bus.rst), though it
doesn't look like this fits the purpose exactly. I think a custom bus
(or perhaps something that could be deployed more broadly across CCF)
would be more appropriate.

Looking around, it seems like clk/imx and clk/samsung abuse the platform
bus in a similar way, so they would benefit from a "clk" bus as well.

Thierry

--PvC9h3QplaOMl/PL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmEjsZsACgkQ3SOs138+
s6HWKw//TNblAAi6ou9PE5WJAlqkp8eN3KFkESiKa0yzPJmK4PheTbR+7TxztdtD
v78kTE37Wr/vLdqlIV3gfL9ZjFiYhBJinwopw7zGhYIru1NVclli3In+/nQdUoGe
vqQOmq0yycyituaGXERlH9HrODsY9IG3DP4XqTd9bBz1JfexxnEVxHvXdzWmoQ/i
pHg7547O5QhpmEMurZ+anNAFCw9J9QhltISWXBSZdl1HDXBF7u7yABLXLggp6RFm
xJN7I3DdVVYkB091DX8wfW19TXaDcZ4eOtNQ1PdpfL1FgeRhLm48VYhB1CQhSWcs
+uyGzqS2dROvSyoUCXqUxYr4NdijJX17VOpO8BVWcpJMQo97EDNxa6Ga92TmXAV4
o+NEivB2893mE0b268rDZ128qhimB7qfM9UT8XFuOWTHiwtGanWBQ/OQ0VYBDVvn
qArreV+6jLdYLjqAiq6DYDoT3s9gVp/xvWfp9F+PW6YlUPldiEUx0eTDK31T4nx2
xRnoASYIbUDfcHvOQWTmwFm1YLxDad/c+oNuCuFjNtG1P8EzRmmkwz4FU0J4uLGd
kTxIyxpRrHp1A2gFthkPvtvrucMlVXW/pTMMCSZtPafWNdhQgCohiy0wnW6pI9sg
v4qJ6n+ieKZRQw1RlSLliu81UJk/CcANuJDeI3CknDm79oVZQDA=
=YrRu
-----END PGP SIGNATURE-----

--PvC9h3QplaOMl/PL--
