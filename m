Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657142AE0AD
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Nov 2020 21:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbgKJU3u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Nov 2020 15:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgKJU3u (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Nov 2020 15:29:50 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23C0C0613D1;
        Tue, 10 Nov 2020 12:29:49 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id o15so6309612wru.6;
        Tue, 10 Nov 2020 12:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4UXj0aXdW9gXaNBBvnJpHZtjacZH9uKxyGzpJYlr7t4=;
        b=sTcZcafRBAwE0yIsddr2dFLOortA+s27nvOdZeGKb6Eq67xLZXBrxT0nlEn6pCubIT
         SzNoVlehdE+t5A5buZP+wZ51MmbBBsTYcnfX0qf1Ondf898N2xJ3taCXq8fx7LhJ2fs/
         M3sYTmj00ydu559CwYbTxxHqTI+XqAPhZx+x1RxzwlqbBonBgY7TyLIEMqicUPVSwwpz
         gc9FMPztTzMzG9EYa6oieb2JV48Xvv4bpdAbg/qRMpyn8RM9cwvIKpyxSeWjGCiAvPRg
         jgIS7PcR6EnU3/p9gTewAs0PmS2ayPzGRvWtFRTmSOU+V++e1CapccOj3WBigIkObAhh
         AZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4UXj0aXdW9gXaNBBvnJpHZtjacZH9uKxyGzpJYlr7t4=;
        b=ltInj/g5hfdtEG35sUuL2Wbr7zzl1tRRE8Dy4kN1RGaoj6eeGRiC/iM+9S4Vg6rN1O
         4c6d5n8pz5NfDEyZFucxw5Egqqe4YcfisZpC+6ztq+RpO1wnxhztr887JAVnTQMJ1fnu
         YODNPHNZfl1eH12HzmBMM2YpvECJ3zENTznZmQGO0fUWLOUmLfptPZYYrH4k+XEbjPO3
         BD0GTzw+/sTqclS9V8InVcctx4A5vcgr2deuIbgi1Sz3y5q2xraSNI/iebXQOlFePcMO
         cuVeCUNPzN3OM721ApFF3DsNKqdElK9kc/sVOTkiaeS50kAladrThf5N4y0516t9Nz0A
         JBDg==
X-Gm-Message-State: AOAM530HIlmVmCb6OPX4uForcLI1bc8QmFS/DDLLf+6JZQDIhNdQzIY0
        CP+4L9t+ybPfX1SczWy7QCw=
X-Google-Smtp-Source: ABdhPJxddKGmvX3lF2VeI+NI5a9C3RoiI7Kkqb2se1T0igyLh489t/U0Lhfpf8FMjo9WY08okPm0oQ==
X-Received: by 2002:a5d:444c:: with SMTP id x12mr13847357wrr.6.1605040188325;
        Tue, 10 Nov 2020 12:29:48 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id v19sm4044143wmj.31.2020.11.10.12.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 12:29:47 -0800 (PST)
Date:   Tue, 10 Nov 2020 21:29:45 +0100
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
Subject: Re: [PATCH v1 11/30] drm/tegra: dc: Support OPP and SoC core voltage
 scaling
Message-ID: <20201110202945.GF2375022@ulmo>
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-12-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Content-Disposition: inline
In-Reply-To: <20201104234427.26477-12-digetx@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2020 at 02:44:08AM +0300, Dmitry Osipenko wrote:
> Add OPP and SoC core voltage scaling support to the display controller
> driver. This is required for enabling system-wide DVFS on older Tegra
> SoCs.
>=20
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/Kconfig |   1 +
>  drivers/gpu/drm/tegra/dc.c    | 138 +++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/tegra/dc.h    |   5 ++
>  3 files changed, 143 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
> index 1650a448eabd..9eec4c3fbd3b 100644
> --- a/drivers/gpu/drm/tegra/Kconfig
> +++ b/drivers/gpu/drm/tegra/Kconfig
> @@ -12,6 +12,7 @@ config DRM_TEGRA
>  	select INTERCONNECT
>  	select IOMMU_IOVA
>  	select CEC_CORE if CEC_NOTIFIER
> +	select PM_OPP
>  	help
>  	  Choose this option if you have an NVIDIA Tegra SoC.
> =20
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index fd7c8828652d..babcb66a335b 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -11,9 +11,13 @@
>  #include <linux/interconnect.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
> =20
> +#include <soc/tegra/common.h>
> +#include <soc/tegra/fuse.h>
>  #include <soc/tegra/pmc.h>
> =20
>  #include <drm/drm_atomic.h>
> @@ -1699,6 +1703,55 @@ int tegra_dc_state_setup_clock(struct tegra_dc *dc,
>  	return 0;
>  }
> =20
> +static void tegra_dc_update_voltage_state(struct tegra_dc *dc,
> +					  struct tegra_dc_state *state)
> +{
> +	struct dev_pm_opp *opp;
> +	unsigned long rate;
> +	int err, min_uV;
> +
> +	/* OPP usage is optional */
> +	if (!dc->opp_table)
> +		return;
> +
> +	/* calculate actual pixel clock rate which depends on internal divider =
*/
> +	rate =3D DIV_ROUND_UP(clk_get_rate(dc->clk) * 2, state->div + 2);
> +
> +	/* find suitable OPP for the rate */
> +	opp =3D dev_pm_opp_find_freq_ceil(dc->dev, &rate);
> +
> +	if (opp =3D=3D ERR_PTR(-ERANGE))
> +		opp =3D dev_pm_opp_find_freq_floor(dc->dev, &rate);
> +
> +	if (IS_ERR(opp)) {
> +		dev_err(dc->dev, "failed to find OPP for %lu Hz: %ld\n",
> +			rate, PTR_ERR(opp));
> +		return;
> +	}
> +
> +	min_uV =3D dev_pm_opp_get_voltage(opp);
> +	dev_pm_opp_put(opp);
> +
> +	/*
> +	 * Voltage scaling is optional and trying to set voltage for a dummy
> +	 * regulator will error out.
> +	 */
> +	if (!device_property_present(dc->dev, "core-supply"))
> +		return;

This is a potentially heavy operation, so I think we should avoid that
here. How about you use devm_regulator_get_optional() in ->probe()? That
returns -ENODEV if no regulator was specified, in which case you can set
dc->core_reg =3D NULL and use that as the condition here.

> +
> +	/*
> +	 * Note that the minimum core voltage depends on the pixel clock
> +	 * rate (which depends on internal clock divider of CRTC) and not on
> +	 * the rate of the display controller clock. This is why we're not
> +	 * using dev_pm_opp_set_rate() API and instead are managing the
> +	 * voltage by ourselves.
> +	 */
> +	err =3D regulator_set_voltage(dc->core_reg, min_uV, INT_MAX);
> +	if (err)
> +		dev_err(dc->dev, "failed to set CORE voltage to %duV: %d\n",
> +			min_uV, err);
> +}

Also, I'd prefer if the flow here was more linear, such as:

	if (dc->core_reg) {
		err =3D regulator_set_voltage(...);
		...
	}

> +
>  static void tegra_dc_commit_state(struct tegra_dc *dc,
>  				  struct tegra_dc_state *state)
>  {
> @@ -1738,6 +1791,8 @@ static void tegra_dc_commit_state(struct tegra_dc *=
dc,
>  	if (err < 0)
>  		dev_err(dc->dev, "failed to set clock %pC to %lu Hz: %d\n",
>  			dc->clk, state->pclk, err);
> +
> +	tegra_dc_update_voltage_state(dc, state);
>  }
> =20
>  static void tegra_dc_stop(struct tegra_dc *dc)
> @@ -2521,6 +2576,7 @@ static int tegra_dc_runtime_suspend(struct host1x_c=
lient *client)
> =20
>  	clk_disable_unprepare(dc->clk);
>  	pm_runtime_put_sync(dev);
> +	regulator_disable(dc->core_reg);
> =20
>  	return 0;
>  }
> @@ -2531,10 +2587,16 @@ static int tegra_dc_runtime_resume(struct host1x_=
client *client)
>  	struct device *dev =3D client->dev;
>  	int err;
> =20
> +	err =3D regulator_enable(dc->core_reg);
> +	if (err < 0) {
> +		dev_err(dev, "failed to enable CORE regulator: %d\n", err);
> +		return err;
> +	}
> +
>  	err =3D pm_runtime_get_sync(dev);
>  	if (err < 0) {
>  		dev_err(dev, "failed to get runtime PM: %d\n", err);
> -		return err;
> +		goto disable_regulator;
>  	}
> =20
>  	if (dc->soc->has_powergate) {
> @@ -2564,6 +2626,9 @@ static int tegra_dc_runtime_resume(struct host1x_cl=
ient *client)
>  	clk_disable_unprepare(dc->clk);
>  put_rpm:
>  	pm_runtime_put_sync(dev);
> +disable_regulator:
> +	regulator_disable(dc->core_reg);
> +
>  	return err;
>  }
> =20
> @@ -2879,6 +2944,72 @@ static int tegra_dc_couple(struct tegra_dc *dc)
>  	return 0;
>  }
> =20
> +static void tegra_dc_deinit_opp_table(void *data)
> +{
> +	struct tegra_dc *dc =3D data;
> +
> +	dev_pm_opp_of_remove_table(dc->dev);
> +	dev_pm_opp_put_supported_hw(dc->opp_table);
> +	dev_pm_opp_put_regulators(dc->opp_table);
> +}
> +
> +static int devm_tegra_dc_opp_table_init(struct tegra_dc *dc)
> +{
> +	struct opp_table *hw_opp_table;
> +	u32 hw_version;
> +	int err;
> +
> +	/* voltage scaling is optional */
> +	dc->core_reg =3D devm_regulator_get(dc->dev, "core");
> +	if (IS_ERR(dc->core_reg))
> +		return dev_err_probe(dc->dev, PTR_ERR(dc->core_reg),
> +				     "failed to get CORE regulator\n");
> +
> +	/* legacy device-trees don't have OPP table */
> +	if (!device_property_present(dc->dev, "operating-points-v2"))
> +		return 0;

"Legacy" is a bit confusing here. For one, no device trees currently
have these tables and secondly, for newer SoCs we may never need them.

> +
> +	dc->opp_table =3D dev_pm_opp_get_opp_table(dc->dev);
> +	if (IS_ERR(dc->opp_table))
> +		return dev_err_probe(dc->dev, PTR_ERR(dc->opp_table),
> +				     "failed to prepare OPP table\n");
> +
> +	if (of_machine_is_compatible("nvidia,tegra20"))
> +		hw_version =3D BIT(tegra_sku_info.soc_process_id);
> +	else
> +		hw_version =3D BIT(tegra_sku_info.soc_speedo_id);
> +
> +	hw_opp_table =3D dev_pm_opp_set_supported_hw(dc->dev, &hw_version, 1);
> +	err =3D PTR_ERR_OR_ZERO(hw_opp_table);

What's the point of this? A more canonical version would be:

	if (IS_ERR(hw_opp_table)) {
		err =3D PTR_ERR(hw_opp_table);
		dev_err(dc->dev, ...);
		goto put_table;
	}

That uses the same number of lines but is much easier to read, in my
opinion, because it is the canonical form.

> +	if (err) {
> +		dev_err(dc->dev, "failed to set supported HW: %d\n", err);
> +		goto put_table;
> +	}
> +
> +	err =3D dev_pm_opp_of_add_table(dc->dev);
> +	if (err) {
> +		dev_err(dc->dev, "failed to add OPP table: %d\n", err);
> +		goto put_hw;
> +	}
> +
> +	err =3D devm_add_action(dc->dev, tegra_dc_deinit_opp_table, dc);
> +	if (err)
> +		goto remove_table;

Do these functions return positive values? If not, I'd prefer if this
check was more explicit (i.e. err < 0) for consistency with the rest of
this code.

> +
> +	dev_info(dc->dev, "OPP HW ver. 0x%x\n", hw_version);
> +
> +	return 0;
> +
> +remove_table:
> +	dev_pm_opp_of_remove_table(dc->dev);
> +put_hw:
> +	dev_pm_opp_put_supported_hw(dc->opp_table);
> +put_table:
> +	dev_pm_opp_put_opp_table(dc->opp_table);
> +
> +	return err;
> +}
> +
>  static int tegra_dc_probe(struct platform_device *pdev)
>  {
>  	struct tegra_dc *dc;
> @@ -2937,6 +3068,10 @@ static int tegra_dc_probe(struct platform_device *=
pdev)
>  		tegra_powergate_power_off(dc->powergate);
>  	}
> =20
> +	err =3D devm_tegra_dc_opp_table_init(dc);
> +	if (err < 0)
> +		return err;
> +
>  	dc->regs =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(dc->regs))
>  		return PTR_ERR(dc->regs);
> @@ -3007,6 +3142,7 @@ struct platform_driver tegra_dc_driver =3D {
>  	.driver =3D {
>  		.name =3D "tegra-dc",
>  		.of_match_table =3D tegra_dc_of_match,
> +		.sync_state =3D tegra_soc_device_sync_state,
>  	},
>  	.probe =3D tegra_dc_probe,
>  	.remove =3D tegra_dc_remove,
> diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
> index ba4ed35139fb..fd774fc5c2e4 100644
> --- a/drivers/gpu/drm/tegra/dc.h
> +++ b/drivers/gpu/drm/tegra/dc.h
> @@ -13,6 +13,8 @@
> =20
>  #include "drm.h"
> =20
> +struct opp_table;
> +struct regulator;
>  struct tegra_output;
> =20
>  #define TEGRA_DC_LEGACY_PLANES_NUM	6
> @@ -107,6 +109,9 @@ struct tegra_dc {
>  	struct drm_info_list *debugfs_files;
> =20
>  	const struct tegra_dc_soc_info *soc;
> +
> +	struct opp_table *opp_table;
> +	struct regulator *core_reg;

We typically use a _supply suffix on regulators to avoid confusing this
with "register".

Thierry

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+q+DYACgkQ3SOs138+
s6G78Q/+JFiMC7fMw8IFFXbA54oa6iXWSOb0LxFKh2Bk0v6WFM2XYACVU/vtNeCY
NCwaZ5tdDUbTWQpy4tUW17Fm+iqyCmcuiv7LZkL3yEDhmh9obmZiDWuNwZIlSBss
lZ/l2EQ7pvj9WwVXQGzej3C4rafihGVqQ4TKlhLz/ouAVCn5wU6u1vXP7IH0fcG7
ZC/11F8IiaSdB111P0YdASAvdp7Vxg4XPXUlXDJDQkr84jYPJpRWs9+6nPnYOeJD
n55nOMFi7/TOxOxwWYQoqIWXWU46IQH2zh8Nh90z8rXUvJUHsA5USKCghGanXyLK
G22wH+pgvEWPOBIQ6aguvCZj0uG5gFUUYSjhMzy+9fDzY67iz9wyOC2ORJ4h3t8d
gxUyN/01vaOgC+UfDY0eGETNa5JSZ7BNJv+hwUeYT9SGMfmDx+Mxbk9OcE66yuFo
1GymePPA+aq4zfhlGUBg/BjjmdvrzLhozXbmBdOiDa8zvTJ0OSxlKC3Rj12mN/uf
PQA/ULnBkKy50qbYg9PqL2vyotwutEEtToOO+kEd7M52LtK8idjYihnlbKoSDwPi
ceieP/AHMjTA83kLuzIPqdiFZqitNgjUfxb8+KaZ+0NdqlaS0lOnn3ajK6CXg0/q
idTcYAD7bt7hHwjyBkxp/N34EWzbZw0EtTdg4p5JgGgVO+//cPs=
=hrR9
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
