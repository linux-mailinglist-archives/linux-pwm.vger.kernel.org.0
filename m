Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225EB3F2B53
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Aug 2021 13:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240229AbhHTLgM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Aug 2021 07:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbhHTLgL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Aug 2021 07:36:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADDEC061575;
        Fri, 20 Aug 2021 04:35:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r7so13893248wrs.0;
        Fri, 20 Aug 2021 04:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7qGosWaKh11oWOcCgshsG0Nfcb0R2B68Vc9n9Xrsm7o=;
        b=pJjkJuRqNuBvbQzTgFslCt3bj10J1IWor4AsVtpaHryDZh2aS0KtjoeN2q3T2+IC25
         afss3YxWjFlcGp6XVHPDhYk62bYEaRZ4E8J+/AwL8jpqTF9q4jeKk0xrbQASAZ96DQz/
         S/8gO27exThFcPxQtb2GgaSudPkLKDYrD84z8GW7Mp1SkVvdmWft5mCcYbSQiRvusErQ
         O4M8HCwNaG/WrT3xxYSVKrmyn8yGmsqvSW6+kUZwfH+Ouov+dsa1Fmh4TMxWwBUJB6lH
         i+HWwBn/8gm3sqEU0a+93UZObWzbCavx0NzYXCTsKJXXY6jxZeQOfng13uaaOrgKioZZ
         /iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7qGosWaKh11oWOcCgshsG0Nfcb0R2B68Vc9n9Xrsm7o=;
        b=OcoI4w7gSsaoqjULf/NwPDIKxk6mJ2hKC0AaX9M8/8OxQXANt5vdPnZ9u3OmzP/Pk+
         /xwKL71KLePSxwHR3e2HjqxhT/i27PJWjSXYN5Cp0AUtsJqv3DAykD7TH0QN6XtX8sy0
         olY/Iii3CeB7LXYkMqXi00YDJQzkexPTm1K4Efd8LO40omPjOyoGW4tkVUAgQ08lwin1
         NXTNSHvf5Rxx5yGyQ5G2EY0yO0EcdB5jUlRiw2iYRH+up7TbcsMY9h04VWcA44iZL/63
         10HwqOhiEa/KeU9JP0zbZSiBBdF3PhaSk5gaxny8JJcXLXYtrt9qYAZxtxRSTwSO7UF9
         xedQ==
X-Gm-Message-State: AOAM533utRjKd5OBY7ayq+d/XfiNbJj8mTKz+SkSDCWPOwyxIiOiOXiY
        4xzRyowisjOzi6QnqiDxgJ4=
X-Google-Smtp-Source: ABdhPJyoN3WSjSwctvMCy+aqbczA8zLxDdXIzPcCL2jhFI6NlzE0Pft0oWicQD5+trN05vwGyG8E3w==
X-Received: by 2002:a5d:6301:: with SMTP id i1mr9302053wru.423.1629459331771;
        Fri, 20 Aug 2021 04:35:31 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id h16sm5827669wre.52.2021.08.20.04.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 04:35:30 -0700 (PDT)
Date:   Fri, 20 Aug 2021 13:35:29 +0200
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
Subject: Re: [PATCH v8 20/34] mmc: sdhci-tegra: Add runtime PM and OPP support
Message-ID: <YR+TgfCHKOPS3Ng8@orome.fritz.box>
References: <20210817012754.8710-1-digetx@gmail.com>
 <20210817012754.8710-21-digetx@gmail.com>
 <YR6O9Om+HzMMG8AR@orome.fritz.box>
 <05b7ff28-4c01-fb56-deeb-595a5797394b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h9ktlEsLda++zsG1"
Content-Disposition: inline
In-Reply-To: <05b7ff28-4c01-fb56-deeb-595a5797394b@gmail.com>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--h9ktlEsLda++zsG1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 20, 2021 at 01:37:13AM +0300, Dmitry Osipenko wrote:
> 19.08.2021 20:03, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Tue, Aug 17, 2021 at 04:27:40AM +0300, Dmitry Osipenko wrote:
> >> The SDHCI on Tegra belongs to the core power domain and we're going to
> >> enable GENPD support for the core domain. Now SDHCI must be resumed us=
ing
> >> runtime PM API in order to initialize the SDHCI power state. The SDHCI
> >> clock rate must be changed using OPP API that will reconfigure the pow=
er
> >> domain performance state in accordance to the rate. Add runtime PM and=
 OPP
> >> support to the SDHCI driver.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/mmc/host/sdhci-tegra.c | 146 ++++++++++++++++++++++++---------
> >>  1 file changed, 105 insertions(+), 41 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-t=
egra.c
> >> index 387ce9cdbd7c..a3583359c972 100644
> >> --- a/drivers/mmc/host/sdhci-tegra.c
> >> +++ b/drivers/mmc/host/sdhci-tegra.c
> >> @@ -15,6 +15,8 @@
> >>  #include <linux/of.h>
> >>  #include <linux/of_device.h>
> >>  #include <linux/pinctrl/consumer.h>
> >> +#include <linux/pm_opp.h>
> >> +#include <linux/pm_runtime.h>
> >>  #include <linux/regulator/consumer.h>
> >>  #include <linux/reset.h>
> >>  #include <linux/mmc/card.h>
> >> @@ -24,6 +26,8 @@
> >>  #include <linux/gpio/consumer.h>
> >>  #include <linux/ktime.h>
> >> =20
> >> +#include <soc/tegra/common.h>
> >> +
> >>  #include "sdhci-pltfm.h"
> >>  #include "cqhci.h"
> >> =20
> >> @@ -123,6 +127,12 @@
> >>  					 SDHCI_TRNS_BLK_CNT_EN | \
> >>  					 SDHCI_TRNS_DMA)
> >> =20
> >> +enum {
> >> +	TEGRA_CLK_BULK_SDHCI,
> >> +	TEGRA_CLK_BULK_TMCLK,
> >> +	TEGRA_CLK_BULK_NUM,
> >> +};
> >> +
> >>  struct sdhci_tegra_soc_data {
> >>  	const struct sdhci_pltfm_data *pdata;
> >>  	u64 dma_mask;
> >> @@ -171,6 +181,8 @@ struct sdhci_tegra {
> >>  	bool enable_hwcq;
> >>  	unsigned long curr_clk_rate;
> >>  	u8 tuned_tap_delay;
> >> +
> >> +	struct clk_bulk_data clocks[TEGRA_CLK_BULK_NUM];
> >=20
> > This doesn't seem worth it to me. There's a lot of churn in this driver
> > that's only needed to convert this to the clk_bulk API and it makes the
> > code a lot more difficult to read, in my opinion.
> >=20
> > It looks like the only benefit that this gives us is that runtime
> > suspend and resume become a few lines shorter.
>=20
> The driver probe code looks cleaner with that. You should be looking at
> the final result and not at the patch to see it.

I did look at the final result and didn't find it cleaner at all. =3D)

Thierry

--h9ktlEsLda++zsG1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmEfk4EACgkQ3SOs138+
s6F3jw//bCxA9hEPesNMHKw4DuCcMLkDCrPDepqzmAtYTxYXAZ84Ew/eL3dNAgWN
c38Br+txYTqqwVdvXCcgbNBNlXVZNYe1sQuA5Z2QV+jV5THuPndcg9KR5YEVqXY7
pkwghsThOI6NO0FRptkWaXygT5nY92FqrHtbNHRC6RBtHIeKFuGD8bfMbuGJ5TNA
B4YzO+xQ466F7X8sqOBzi11Z/PtJSRWJLyX9kf7T93vLOVMmeKfFWnXsC8nWAaxV
NOaOpqnQYhfDA/8F7a5ORuNdgs1/i/XPSysh7WwZNskzUdtD2sUKfd9CVjHFrI5F
L5qpwssH4E0j7M0nrPK4glvergJ0TfYU65/QsNZMED9S/qqYk+1R/J3o1bzvu6Xi
wcRoOKIC4AhCyb9Oy/A/wnf5crMWzb3lx+mLhFgjTaSRnJcnoEAeS5GM8m3KwxP4
zViWmXApMhHLKBOatf3Qg64/IpNUTP6vPxRaLmyNbOzJGas8p37VAp+J0E3Riacr
gDFpfs+lQMc+jJtYN/Ra2P/TXbFtM+zsf2HtmZUMWAy1LRAjkF6o7TUxmHN3YJ9H
A15xryC+kyleZd9ejlwSDtieIKXVP23syOMcx/k5kUpGOTUth7MHJ1zFAB2fUUMv
NwSM8zDAH6Og9fNK4dVJYj2PpNoFx7zTe2kwvkuyYsLYwehYp2c=
=LzE6
-----END PGP SIGNATURE-----

--h9ktlEsLda++zsG1--
