Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189F4275770
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Sep 2020 13:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgIWLtI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Sep 2020 07:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgIWLtI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Sep 2020 07:49:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32773C0613CE;
        Wed, 23 Sep 2020 04:49:08 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c18so20689493wrm.9;
        Wed, 23 Sep 2020 04:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xcpSQylZVass3NdVUR+fUKGWCQtuxHSPEZvRki2sRWM=;
        b=UmrEKcsUIoC/OWk6yWtL7XQ/OjCjvHMd6s/gXJ0XywmLQbQLv9Uyq35hxNrEyRAkIU
         CkOiWdH6UD9M63TW5UiU4kK4uRIujsDR+B22GeD/djtK+2gcAfFBTV4VArAtQ3avw7jB
         zdA054vthAjIZ0Lyx5ZtOWAVJkNulRzDVO7BdVjfC7lGQlgFllYcyrMcE4d2f8QJQFrE
         7/sL4am7jRtpeDElgB+qCGnkiXAOo+jI39LdqmaG9thn5kTkc9YAZlpKAFj0ECGWeuXz
         L0C4pBPOcUN9RIxN7jH2r3b4EGGQiAHy5lQH5OAyRN/3vgdG6EzPi/ged1YUYauLiotF
         oxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xcpSQylZVass3NdVUR+fUKGWCQtuxHSPEZvRki2sRWM=;
        b=CjrA3MvgDI7x1+LNO4tzhIzqKGCiTBEzMX+58upY9FWJLOVGtyttx3Iqdg5H7tubye
         ihCGp2oI3maqWMR4P5085wbaObjNvNcWsGn6NjMqloGm1CrTLdpZB8RowuLNEx8b6END
         9gelxDqxp8aIkPAsHjCpkbfAmKGesqAQMJ6IVaaKvj3BiZL11MCQJWM6kqwX2wVEzArr
         ZV7zbvHMXVsUBdG/D2rdo+/mqBmX1RrVYUNdz4zwcseqg+eBYdtAC2WMZPO3iqHkMxD8
         nCa65DGPqOdrVFRcwiSdO2JR3iAV3jru8VSn02lO08XKYCo5WrzdTc6G0FSiH1m8kN0q
         F5lA==
X-Gm-Message-State: AOAM531OaUonlqbPTm6pFVl6aU3OIC6VX46fMyKx8g7UrcA1Y+xRK4sk
        /3HkYaVi75LvbbTu6JD7a7Y=
X-Google-Smtp-Source: ABdhPJxAcT+rNYyHT9mJRhCm5uS6bNC9paqnXdtFgAcN/tQYQb9+TtoasN/Gfb9gOPC1LONT+cwvWA==
X-Received: by 2002:adf:ec87:: with SMTP id z7mr425752wrn.57.1600861746822;
        Wed, 23 Sep 2020 04:49:06 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id r21sm6701283wrc.70.2020.09.23.04.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 04:49:05 -0700 (PDT)
Date:   Wed, 23 Sep 2020 13:49:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com, rtanwar@maxlinear.com
Subject: Re: [PATCH v13 0/2] pwm: intel: Add PWM driver for a new SoC
Message-ID: <20200923114904.GC1846003@ulmo>
References: <cover.1600158087.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <cover.1600158087.git.rahul.tanwar@linux.intel.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 04:23:35PM +0800, Rahul Tanwar wrote:
> Patch 1 adds dt binding document in YAML format.
> Patch 2 add PWM fan controller driver for LGM SoC.
>=20
> v13:
> - Address below review concerns (Philipp Zabel)
>  * Make unnecessary 2 line comment as 1 line comment.
>  * Move reset_deassert at the last after clk_enable.
>  * Remove unnecessary return ret statement from .remove()
> - Move platform_set_drvdata() at the top of probe.=20
>=20
> v12:
> - Rebase to linux 5.9-rc4
> - Add Reviewed-by tags from Andy Shevchenko & Rob Herring.
>=20
> v11:
> - Address below review concerns (Andy Shevchenko)
>   * Fix a issue with dev_err_probe() usage & improve the usage.
>   * Fix & improve a ordering issue with clk_enable/disable &
>     reset_control assert/deassert.
>=20
> v10:
> - Removed unused of_device.h and added platform_device.h
>   & mod_devicetable.h
>=20
> v9:
> - Address code quality related review concerns (Andy Shevchenko)
> - Use devm_add_action_or_reset() instead of explicit unwind calls.
>=20
> v8:
> - Remove fan related optional properties usage, keep
>   them as default. If needed, change pwm-fan driver
>   separately in future to add them as generic properties.
>=20
> v7:
> - Address code quality related review concerns.
> - Rename fan related property to pwm-*.
> - Fix one make dt_binding_check reported error.
>=20
> v6:
> - Readjust .apply op as per review feedback.
> - Add back pwm-cells property to resolve make dt_binding_check error.
>   pwm-cells is a required property for PWM driver.
> - Add back fan related optional properties.
>=20
> v5:
> - Address below review concerns from Uwe Kleine-K?nig.
>   * Improve comments about Limitations.
>   * Use return value of regmap_update_bits if container function returns
>     error code.
>   * Modify .apply op to have strict checking for fixed period supported
>     by PWM HW.
>   * Use u64 as type when use min_t for duty_cycle.
>   * Add reset_control_assert() in failure case in probe where it was miss=
ing
>     earlier.
> - Remove fan specific optional properties from pwm dt binding document (R=
ob Herring)
>=20
> v4:
> - Address below review concerns from Uwe Kleine-K?nig.
>   * Improve notes and limitations comments.
>   * Add common prefixes for all #defines.
>   * Modify/Improve logic in .apply & .get_state ops as advised.
>   * Skip error messages in probe when error is -EPROBE_DEFER.
>   * Add dependencies in Kconfig (OF & HAS_IOMEM) and add select REGMAP_MM=
IO.
>   * Address other code quality related review concerns.
> - Fix make dt_binding_check reported error in YAML file.
>=20
> v3:
> - Address below review concerns from Uwe Kleine-K?nig.
>   * Remove fan rpm calibration task from the driver.
>   * Modify apply op as per the review feedback.
>   * Add roundup & round down where necessary.
>   * Address other misc code quality related review concerns.
>   * Use devm_reset_control_get_exclusive(). (Philipp Zabel)
>   * Improve dt binding document.
>=20
> v2:
> - Address below review concerns from Uwe Kleine-K?nig.
>   * Add notes and limitations about PWM HW.
>   * Rename all functions and structure to lgm_pwm_*=20
>   * Readjust space aligninment in structure fields to single space.
>   * Switch to using apply instead of config/enable/disable.
>   * Address other code quality related concerns.
>   * Rebase to 5.8-rc1.
> - Address review concerns in dt binding YAML from Rob Herring.
>=20
> v1:
> - Initial version.
>=20
>=20
> Rahul Tanwar (2):
>   Add DT bindings YAML schema for PWM fan controller of LGM SoC
>   Add PWM fan controller driver for LGM SoC
>=20
>  .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     |  44 ++++
>  drivers/pwm/Kconfig                                |  11 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-intel-lgm.c                        | 246 +++++++++++++++=
++++++
>  4 files changed, 302 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.y=
aml
>  create mode 100644 drivers/pwm/pwm-intel-lgm.c

Applied, thanks.

Thierry

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9rNi8ACgkQ3SOs138+
s6HwnBAArskR0yz5OMZXvQIsOf0DPZ7o/wKJQj0e4TK8j2KVw10EKOC39xjiZKDj
CYMbbE2ww6eBsFs4ddv+dJXoGA3Ht6qrtqB28rbOzVfffLAHFQKtu/FkDeV0ZVKV
+fqtL3Er+hmfasFgUDBgvINzgnqPfV3zDrLZYRbOBo5OaqBW06KZhi4w3FqJSOp9
jrLzCWGdB2bPZorBWk56J2s8oBe4tlZ0EvecG9iMiPeovY64vQFqAEYDIcO+BXhy
hoHmLyMJ94Q2wJk9uxAStZMpoYEtY4I7Yr2owHCxm88ENUytaVHCWjkEN+oRLbxG
B2Qh0Ci5kXzFK3yFVeBm+X18ucy1yhGR1xG1YCl7Tv8YR23vjFigCAFRBqktjkW1
2nsUtb2vSUstvrnydO3/WCubsVLwZvw8ICTckkOwudXjAiwAZkbl65Sc1IRWUBPz
0aQHAC5fZfRcXPUbpw53tdOit7Vpg6DrvEKUxhHa7rLwD09TQn+TLpDgAXnJOoiX
WjMlBhKzpT/RulJ8Tf3cbVv6TFNqAx/lx4I3+E6kMxOXsdXm7kGSvbKWsJ220uLv
QYu+6DiFsbK1I2tfli866E8038+ExBXbPTQ3Q8NVdLjwDUxOgkcaEqPG+3cGDM6Q
/e/TZsBTCZwz/Qeo/AsJg3oerPgdelVtra1RYseBQAC5OFu4NnI=
=Ifnt
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
