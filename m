Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9B03F1E6B
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Aug 2021 18:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhHSQzM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Aug 2021 12:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhHSQzD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Aug 2021 12:55:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4AFC061575;
        Thu, 19 Aug 2021 09:54:26 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id w24so4205722wmi.5;
        Thu, 19 Aug 2021 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aclyfjuOk/wnLMaKEbd24lKs07wjNB8D8fDVONKvAwc=;
        b=c/lGCsN6DJxg4dVOdYAwVArnnLXSoiqLPRg86sjtaNd0rST/SL2r1zNT12Xza98M67
         p2WAFotge+9e0orCQo5xhADJ8m/1ZrJ0HeuG/9nGkbZkRpyn9HaJRQVSE8gkPQbk+N3T
         OEaFriJPzFDSPWLGrR5VRrwqHEHyrGBK9GkfSMmx3z+D9ZOaoKKVOV06OsAvv7gRkm/P
         WUL8kbCGm+MEEbF+hPvUaIT3TkwAW/nc7+YlaL/q4ggf1Tc9zedWbhIiPQok6QN3kiqx
         qpIL3yKJbcA6oas7ZQsTa9V4fEuv+yMkFHCqh4H2uy+07RVCGu5Lk1eTIyRGjmTNRShE
         2aZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aclyfjuOk/wnLMaKEbd24lKs07wjNB8D8fDVONKvAwc=;
        b=ix4hgKqKl2rVey0AjF05vzlstNLCe+2YrTtYsrYQPw8KkkzKo+0bjtdrg0hOEQFHID
         pSfchqpav1rNpNslYjmfVLd8zARi55ufuoTxtXiCAP4rQa6VpXxGW3OQvBQNbzBU1Baq
         UdjB/Xw5SDwdDA+MiYRbo3uf5pXz3A2w8/tWNnwB6sRR+eMWgMrpSY6mPb3dmf8tPWMC
         WKvwT6ydc35wuyBvmhcQ66LW7AsxhytWVvrzaHJFcQmxgmkhXiKZrK1gLQLtwsoPpVa1
         qP+p9DudKgYOpDagK2ROvNF04Jk6sYH6UYYmDN0tNKIE8I6xIYHyN8FTzPpzgFnTmh+3
         ELfA==
X-Gm-Message-State: AOAM5338hfIE6ddqswwr1pdCG6ZpPzesMg0itVWjUwyyPetN80wdmKXY
        jTMpp4Gbdq3hzbCSOFZkb6E=
X-Google-Smtp-Source: ABdhPJyPJZuwXxLb6NwJ92Oy1eMbywPQn7wLJyIL+A4Q9LtkgBIuov/1upvaj/jx6Oywu1gSJikUIg==
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr14316666wmf.53.1629392065061;
        Thu, 19 Aug 2021 09:54:25 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id a11sm3459358wrw.67.2021.08.19.09.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 09:54:23 -0700 (PDT)
Date:   Thu, 19 Aug 2021 18:54:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v8 07/34] clk: tegra: Support runtime PM and power domain
Message-ID: <YR6Mvips3HAntDy0@orome.fritz.box>
References: <20210817012754.8710-1-digetx@gmail.com>
 <20210817012754.8710-8-digetx@gmail.com>
 <YR0UBi/ejy+oF4Hm@orome.fritz.box>
 <da7356cb-05ee-ba84-8a7c-6e69d853a805@gmail.com>
 <YR04YHGEluqLIZeo@orome.fritz.box>
 <ad99db08-4696-1636-5829-5260f93dc681@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fB7tjCoYfoEt7dJy"
Content-Disposition: inline
In-Reply-To: <ad99db08-4696-1636-5829-5260f93dc681@gmail.com>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fB7tjCoYfoEt7dJy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 18, 2021 at 08:11:03PM +0300, Dmitry Osipenko wrote:
> 18.08.2021 19:42, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Wed, Aug 18, 2021 at 06:05:21PM +0300, Dmitry Osipenko wrote:
> >> 18.08.2021 17:07, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Tue, Aug 17, 2021 at 04:27:27AM +0300, Dmitry Osipenko wrote:
> >>> [...]
> >>>> +struct clk *tegra_clk_register(struct clk_hw *hw)
> >>>> +{
> >>>> +	struct platform_device *pdev;
> >>>> +	struct device *dev =3D NULL;
> >>>> +	struct device_node *np;
> >>>> +	const char *dev_name;
> >>>> +
> >>>> +	np =3D tegra_clk_get_of_node(hw);
> >>>> +
> >>>> +	if (!of_device_is_available(np))
> >>>> +		goto put_node;
> >>>> +
> >>>> +	dev_name =3D kasprintf(GFP_KERNEL, "tegra_clk_%s", hw->init->name);
> >>>> +	if (!dev_name)
> >>>> +		goto put_node;
> >>>> +
> >>>> +	pdev =3D of_platform_device_create(np, dev_name, NULL);
> >>>> +	if (!pdev) {
> >>>> +		pr_err("%s: failed to create device for %pOF\n", __func__, np);
> >>>> +		kfree(dev_name);
> >>>> +		goto put_node;
> >>>> +	}
> >>>> +
> >>>> +	dev =3D &pdev->dev;
> >>>> +	pm_runtime_enable(dev);
> >>>> +put_node:
> >>>> +	of_node_put(np);
> >>>> +
> >>>> +	return clk_register(dev, hw);
> >>>> +}
> >>>
> >>> This looks wrong. Why do we need struct platform_device objects for e=
ach
> >>> of these clocks? That's going to be a massive amount of platform devi=
ces
> >>> and they will completely mess up sysfs.
> >>
> >> RPM works with a device. It's not a massive amount of devices, it's one
> >> device for T20 and four devices for T30.
> >=20
> > I'm still not sure I understand why we need to call RPM functions on a
> > clock. And even if they are few, it seems wrong to make these platform
> > devices.
>=20
> Before clock is enabled, we need to raise core voltage. After clock is
> disabled, the voltage should be dropped. CCF+RPM takes care of handling
> this for us.

That's the part that I do understand. What I don't understand is why a
clock needs to be runtime suspend/resumed. Typically we suspend/resume
devices, and doing so typically involves disabling/enabling clocks. So
I don't understand why the clocks themselves now need to be runtime
suspended/resumed.

> > Perhaps they can be simple struct device:s instead? Ideally they would
> > also be parented to the CAR so that they appear in the right place in
> > the sysfs hierarchy.
>=20
> Could you please clarify what do you mean by 'simple struct device:s'?
> These clock devices should be OF devices with a of_node and etc,
> otherwise we can't use OPP framework.

Perhaps I misunderstand the goal of the OPP framework. My understanding
was that this was to attach a table of operating points with a device so
that appropriate operating points could be selected and switched to when
the workload changes.

Typically these operating points would be roughly a clock rate and a
corresponding voltage for a regulator, so that when a certain clock rate
is requested, the regulator can be set to the matching voltage.

Hm... so is it that each of these clocks that you want to create a
platform device for has its own regulator? Because the patch series only
mentions the CORE domain, so I assumed that we would accumulate all the
clock rates for the clocks that are part of that CORE domain and then
derive a voltage to be supplied to that CORE domain.

But perhaps I just don't understand correctly how this is tied together.

> We don't have driver for CAR to bind. I guess we could try to add a
> 'dummy' CAR driver that will create sub-devices for the rpm-clocks, is
> this what you're wanting?

I got confused by the "tegra-clock" driver that this series was adding.
This is actually a driver that will bind to the virtual clocks rather
than the CAR device itself.

For some reason I had assumed that you wanted to create a CAR driver in
order to get at the struct device embedded in the CAR's platform device
and use that as the parent for all these clocks.

So even if we absolutely need some struct device for these clocks, maybe
adding that CAR driver and making the clock struct device:s children of
the CAR device will help keep a bit of a proper hierarchy in sysfs.

Thierry

--fB7tjCoYfoEt7dJy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmEejLwACgkQ3SOs138+
s6G0uxAAi5HF3oKaz4joxnoDx59LBEnAU5X2o38DOhm+0Z+W0SvoY4JXaYc4shzR
0HHeqltwuk4WFjAIHLPs+oZdeRBnN7FonvifFOkVCnm+RmlLCXGjfmeaWnkC1+6t
bAA7Mo+uxVCv07j+l63GFmVs7xbG8pGDdPM4ba6bsokC27Zx2ppqkU6oFhXyR1yu
kFnZvcZo6HcXczUzizEVMpbaI0HpPY+lWjwZsdm+iCHXea/btjo7xepzOKYlzpj8
X0C/T2wod6brm9HBkTooHyU4cvX8jJ97hDQ0yi1XrVeIAgPwQ0OvU8fVqM5TtVPl
T6cNXpUm+2rxC+Q/L9gXCXNevTm6q1czeBqGG0VxHzA5dNpyug9quy61UlDXNkok
o0I1hGuWXuK81vHCAqYSGCKOMZSqAxco3c83XeLLNxOZarf9/L1TCCSnnvFdmfEq
/glJcesV2wEMofuIje+RAg5jRQO8pqMzHN+Lw1KmfnBJrQ9K+MKBfyH0aTbKHAnN
kFM66N+AgjUgwB/sCOv0Vi3xkTstm5aGIVjF46FP9AgZpgronYTi0JNscEGOi1KG
+VbRfi/SuJHYWlkDjJjsd7I26exe4/v7WH/ZyjUgQ/8/j8TRi+oNik3O0X9gSSYj
W9DvFcJHSbCCNPKCjsPgtQivHwW/8gnMS6zgzIvKklHiq7YnNlE=
=fm7o
-----END PGP SIGNATURE-----

--fB7tjCoYfoEt7dJy--
