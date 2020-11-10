Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662A92AE10E
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Nov 2020 21:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbgKJUvD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Nov 2020 15:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJUvC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Nov 2020 15:51:02 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2AAC0613D1;
        Tue, 10 Nov 2020 12:51:01 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so14209859wrc.11;
        Tue, 10 Nov 2020 12:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7HIcKzFu5PUUQcFiE5YVq2OrMCSk+O2P2oBdDfJbjm4=;
        b=p3IuKkDXlF3/hpGET8e431R9TjI8VmaD+tYyRxHQGfyz1Zii2UqQIUz90t+lwWNG3V
         BSvrTnzMRaDza3nj7lIX82CRMGAvsjEdjNzfHjEnvpAFxV5wVG9/Tdztnp70jZFTX9n7
         XVoGGmB3AUEEriWlJRtubCXxQZ+7IfKCFRLa1Bs/eq7/b3hujUOOe/nhApmQ3zZBcQr6
         XTN4tHq9WBwGu9zozNsOUEZcudsB0kAiBu+SsVkmAu2gY+R5sjJku3BNQyWBpCWiG0dn
         F9Q53i5FcdYDhmSQYf/6sS4PokOHp+ScuogduJxME0MCnBiwFP3QWlpGVvuQch6XGJqx
         df+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7HIcKzFu5PUUQcFiE5YVq2OrMCSk+O2P2oBdDfJbjm4=;
        b=V/NHP2WbXVovV9P8XI6d8spuqAj6J4vGunak1qh/2ENHWRJzfoAPfwTrlb/naj3HCX
         hlfkFjsaEAVzoqbm0j3XxyJkqL8HEpqSuGi6bGLPWVBbiurlX1/N494VF4Pnn843fGba
         Yhuapk6UsAbWWZcNTLbqQ3MeZVPlWp2BThv/oKmpOD8F9qMymp/sIl8PxFVm+RQttNsG
         3XkVFWaHeKxWqDiTh8om4Be2Tja9+Y9deVZpcP/P3KeV7zbgJrvFfDq370BfQ7X2BSRj
         9/S++B4mt3ZGtKfOx8pEREsQbB8wechvFBoC3t+5Cm1YcZ3O+mfMm0u4VZ/hMz6wBgqo
         0wQw==
X-Gm-Message-State: AOAM531SasjoXAENlgwHamyZkY1QKIFDSVWkrxCJrqFsHQK8KtWNl1S3
        6hgrcaj3VLRRWKWd/OQO8uM=
X-Google-Smtp-Source: ABdhPJxzIEmPPnLANkIp2K03g8rC5eaOPrtyiZGMeuwPXYl02/6Hg+v9qU2Prx3ft4ivHx0jS/Q3dA==
X-Received: by 2002:a5d:51c2:: with SMTP id n2mr12551938wrv.326.1605041460687;
        Tue, 10 Nov 2020 12:51:00 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id z5sm18029459wrw.87.2020.11.10.12.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 12:50:59 -0800 (PST)
Date:   Tue, 10 Nov 2020 21:50:57 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 18/30] pwm: tegra: Support OPP and core voltage scaling
Message-ID: <20201110205057.GH2375022@ulmo>
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-19-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v2Uk6McLiE8OV1El"
Content-Disposition: inline
In-Reply-To: <20201104234427.26477-19-digetx@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--v2Uk6McLiE8OV1El
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2020 at 02:44:15AM +0300, Dmitry Osipenko wrote:
[...]
> +static void tegra_pwm_deinit_opp_table(void *data)
> +{
> +	struct device *dev = data;
> +	struct opp_table *opp_table;
> +
> +	opp_table = dev_pm_opp_get_opp_table(dev);
> +	dev_pm_opp_of_remove_table(dev);
> +	dev_pm_opp_put_regulators(opp_table);
> +	dev_pm_opp_put_opp_table(opp_table);
> +}
> +
> +static int devm_tegra_pwm_init_opp_table(struct device *dev)
> +{
> +	struct opp_table *opp_table;
> +	const char *rname = "core";
> +	int err;
> +
> +	/* voltage scaling is optional */
> +	if (device_property_present(dev, "core-supply"))
> +		opp_table = dev_pm_opp_set_regulators(dev, &rname, 1);
> +	else
> +		opp_table = dev_pm_opp_get_opp_table(dev);
> +
> +	if (IS_ERR(opp_table))
> +		return dev_err_probe(dev, PTR_ERR(opp_table),
> +				     "failed to prepare OPP table\n");
> +
> +	/*
> +	 * OPP table presence is optional and we want the set_rate() of OPP
> +	 * API to work similarly to clk_set_rate() if table is missing in a
> +	 * device-tree.  The add_table() errors out if OPP is missing in DT.
> +	 */
> +	if (device_property_present(dev, "operating-points-v2")) {
> +		err = dev_pm_opp_of_add_table(dev);
> +		if (err) {
> +			dev_err(dev, "failed to add OPP table: %d\n", err);
> +			goto put_table;
> +		}
> +	}
> +
> +	err = devm_add_action(dev, tegra_pwm_deinit_opp_table, dev);
> +	if (err)
> +		goto remove_table;
> +
> +	return 0;
> +
> +remove_table:
> +	dev_pm_opp_of_remove_table(dev);
> +put_table:
> +	dev_pm_opp_put_regulators(opp_table);
> +
> +	return err;
> +}

These two functions seem to be heavily boilerplate across all these
drivers. Have you considered splitting these out into separate helpers?

Thierry

--v2Uk6McLiE8OV1El
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+q/TEACgkQ3SOs138+
s6FEeBAAokltgZ7HHYhhwbbWHXNUkzO/NUlYWsInWSSKGta8fNY21NFKFf6nxcqg
ysIyLPN9dv8a9saNwqn3LEtMcfrRlwhNI22SJT9qeJccG/FrVSt9wPszq4Sm/6+/
XjySJpMVvKGnrZTlrDIqTPjxnocpBDumCM+jSDtNH/VPaGozHg1Zx0qh8/beFTmv
Vtb0OcnD4qtkufaD0UNVfgFgwtFA3kRYS4cn6HfvqtjefLPSoQPAsdm7Bv4k7x5c
KT12aYsPstalOtHu+FLiNVpazIpRiQcf1r4C/NtBsZcakeN5yuDe5TjP81BWYYmL
q2d7TSeKz7bETNVkYlHJYDjvmDKdxfSaCkZYzfrHZlGIIFkDVUldkWLqi3g7SFe8
SZTVRmWNiXrs6yvvJLLATV+By1fXEUHT+5EncaaS2KKWIER/rkBfZaTU5sm1Dh2e
1uYKgu1HT00/215AdNLi/QpUSCMoP+RUixydwl9b0+dkJ5mbcY3Zyqz0iyFKEPg6
EnkFO/edSWtmvQeFqqapWBfvO7ilH+yrlO8usp0A4pFhHFrs5D7k+oij9lDKVDPO
LT092WpWBVzCxAYioMUGADderKfCTP3Tp4W5Lw9Tp2zyHG6Qze+UsbvNoPwYhb8G
l0UKpbDA7nfIhJ3zrFcENxPPGXWP7aDaL8sG6HnZ5FQZoyj/w2Y=
=OvzO
-----END PGP SIGNATURE-----

--v2Uk6McLiE8OV1El--
