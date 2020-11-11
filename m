Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E72AFA3C
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 22:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgKKVOi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 16:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgKKVOh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 16:14:37 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E24C0613D1;
        Wed, 11 Nov 2020 13:14:37 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so3508877wmg.3;
        Wed, 11 Nov 2020 13:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bY6vAZ0tSmVBFVA037gzrHtbWFO6SEFgmLPgtYjY22g=;
        b=PCJJ9Z/MM17eDD5kZkQcWeB6SBIS1/Ucd1SMiZuYXSCwrZoxludcCx9XmzK9Jq0KSC
         iGOCQfDcOoHL48VBqF204XCc3nyUdjmwxu36jTyGUzwaDbzM0YWViZk0oKqzZIhHNLFy
         h7kLKoXIuE5Kx8oUF3iYT6VLFjGeC/uRY5P9Ndu4IXjJ2aez3I89Vb+pOgF30Sm52JgW
         BcAaQpvMKLsfNS0I2kZYxx2chfOO41Nd44Clo7oXuy5A2cDfE+zYFalOE8zj8IOskMab
         2NoJZpiqqhnT0A9f3OSL6YjKYD38HGGkE8IzaxIDnZjPji/9hom0IdFMsRBaXZE1ABNK
         mvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bY6vAZ0tSmVBFVA037gzrHtbWFO6SEFgmLPgtYjY22g=;
        b=J9sv5rxN8jpi9M/Z9Iif28ibwrHouBEI7eucUreYir/bYE/LTFmJemPCie1rDhFret
         jPRIWRqr882tLBcoXDLznG/ez8QInfrrr006HXHVW1L0NU3VTUwB/IoWjdoyqJlUwV8S
         cHzCPCLcQTtqtL6bFxEyPlxxavOLcgknHd89FDUcwW/YrN5Imnpktg5JGELx5KdEN16A
         fIRN4A4jpgaNacRw08T+T5pzfL96QlXB+W2cUrinXmZIDAIjR6MszOfW+OyHLzU67Y84
         Qj99sMyhQUJoJ8JWHwocYT7pZZa77VD2JKOVlVjO39gs3khjbgJBhmQzLpKaWeatrvl6
         BTDg==
X-Gm-Message-State: AOAM530cANF8TasKCl9EtOtaoPj1WA1GMTD9YtQY7U838w3Ozpgl8iKD
        Ss8Qeh7/L12EMHYdbLbB4rs=
X-Google-Smtp-Source: ABdhPJwIQVD9sMCTm7j2oLshwB0nlaXclMyL3UfR34Z7VTGFy9XFFHdUAWCJmMVJq2MgFNhkn8yM8g==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr6083297wmc.172.1605129276237;
        Wed, 11 Nov 2020 13:14:36 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id t5sm3991082wmg.19.2020.11.11.13.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 13:14:34 -0800 (PST)
Date:   Wed, 11 Nov 2020 22:14:32 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com
Subject: Re: [PATCH v15 0/2] pwm: intel: Add PWM driver for a new SoC
Message-ID: <20201111211432.GA571441@ulmo>
References: <cover.1604555266.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <cover.1604555266.git.rahul.tanwar@linux.intel.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2020 at 01:49:38PM +0800, Rahul Tanwar wrote:
> Patch 1 adds dt binding document in YAML format.
> Patch 2 add PWM fan controller driver for LGM SoC.
>=20
> v15:
> - Rebase to latest linux 5.10-rc2
>=20
> v14:
> - Address below review concerns from Uwe Kleine-K?nig.
>  * Add limitations info about fixed 2-wire mode support.
>  * Rename clk/reset _disable function names to _release.
>  * Remove clk & rst from driver data structure. Instead
>    use them as arguments.
>  * Add pwm_chip.base =3D -1.
> - Resolve missing MODULE_LICENSE warning.
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
>  drivers/pwm/pwm-intel-lgm.c                        | 244 +++++++++++++++=
++++++
>  4 files changed, 300 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.y=
aml
>  create mode 100644 drivers/pwm/pwm-intel-lgm.c

Both patches applied, thanks.

Thierry

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+sVDQACgkQ3SOs138+
s6FAgA//bkEboSKJlHm6SeyDedY/54jZJJ743Gsg3m+KrPwS1JvLILrLuZDSCWxC
zdAG6+2OSeKTbtZn0dcNkG6/v3ng1mKMqCYhJrXOFPWwaBT8TmrvBaAOY9UJIr3E
aWXjN7AogW6U8zOAK08T5S18hlwxdPZIVUcs6fheSbeEzb9ux2rNiCtNbY0LCJah
nqp+3TLfR6b6lyd7vgB2iM8Ut2won9M21ig2HiNAST/+ixV7AyW/ejSmy62QcY+K
iDOOO6h7VfNt5DUSqNkdA0OBGZPcrKKgHD2UqKpSc0rywEaAGlOn2RhsjK9/x5Ru
9VZhvpQGHLK9yNeS9746EKeE07gMocaHqGXGhh57ltxHFGbm9m79of+SHJB6JzEM
NxJqQo7Bb2WZVkHaDsk1vkO7KhZ5nitcEUvI8T1lD/Id5eF8F03ghzCrc7OYp4fo
KlWTNj5F/4sc/IcF55sayceqQu/jKigKgfVIr2ur/o7z81ykh99Ghvm5cGSRfpO/
2xqBPvYvmhFgumuY+fUKWJzePJxXmAyt3DHWFhL8kfj3sdChTgua8BdgMYurbxLz
f6i4KH3yHm3lZWXovGFv3LzeCKGGGcLYPI/jvKGyEXeT5b4/u5ksrOHMiOVE8xXW
H4sY+Is81ABh8dVXsKdhWgPId1//jrUPgISYPDlBhh/P5n3UMlU=
=MrmB
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
