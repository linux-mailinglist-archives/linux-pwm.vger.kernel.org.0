Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAB42AF9A7
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 21:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgKKUWT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 15:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgKKUWT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 15:22:19 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD84DC0613D1;
        Wed, 11 Nov 2020 12:22:18 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so3788958wrx.5;
        Wed, 11 Nov 2020 12:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uzyN9Zqod3f0ppfoLDJllJA7ZSbvthF/vIRr6vxorLU=;
        b=VO7a4CD8uWZnWCbcJfbmoUko8Yewg6qrknZPa2fB+fn/c36xhHyJd3GXFvXkmDAhby
         ApWYMlbeI7UNl+Cpxh87lHtw0GUegGTQFg3erSY8hhTRZdpFy3vvYXjRkb9kwV8RdosB
         yEQDGs1K99WJShw2Fuk72aWlqdV60Q9TStwvtJpLitNJU6SEnn5ss+uMTR+YoIiDLP5I
         dHHsUmc8TGnTvvEjiJ1CUTogw98FeyDiuq+GfeFcJTzMJ7nVAiY7CWyO301DoUoWPzDQ
         tSwGxRuIIHhU8yBC9PzM0OT1LkRc4eHcgjaj7oPKumZKJLTuW8J+mZGM/3TAkhypHqfZ
         bwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uzyN9Zqod3f0ppfoLDJllJA7ZSbvthF/vIRr6vxorLU=;
        b=QajEg5GeBtx0RQFzhuDPQteYoYQj+l+KZMMwRkyP0sUFl6zXoiJrMUgnAV4YVPi7zL
         WE/ikB/iFqckOKda3GkL8isoWobDneejkBaiDOk4H+qU46KnD23k4i+O7175nhDYfLCb
         aajpAmgi7W/tX2nPNbgbGUs1HBJNGvUK3goLhp/Z/DJutAebv4bgiG50Sv/c2xLNW2FD
         nduyRYClyIOb4PVbeh07/nFS+MJRbzqmU7EDPwZgp+LVOjsz39oDhQgbBvCYeyih+fjq
         N434sEEvaJJcXOv+F94WiTp3326seI3/DOrNIO29XoaG11R7ISLjMJ0mjlsC8c76w0io
         RZfw==
X-Gm-Message-State: AOAM532ApIJ7NXg6wA5JikLqHLAI0R4+v9hAPd4rYT6dVuH8jKE8sDXC
        4lZkkhtidLZAxtpBYSRoGW92aJ2bS/8=
X-Google-Smtp-Source: ABdhPJzdtcEA3kQa6FkI1DjGGG35KL6jzdr7iW5WzCd017lUoRR/kKmOjdNueTzyVS6E6zwegf08PQ==
X-Received: by 2002:adf:80c8:: with SMTP id 66mr32163273wrl.415.1605126137379;
        Wed, 11 Nov 2020 12:22:17 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id t23sm3581706wmn.4.2020.11.11.12.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:22:16 -0800 (PST)
Date:   Wed, 11 Nov 2020 21:22:14 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     vijayakannan.ayyathurai@intel.com
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v14 0/2] Add PWM support for Intel Keem Bay SoC
Message-ID: <20201111202214.GK6125@ulmo>
References: <cover.1603350036.git.vijayakannan.ayyathurai@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pWJxWxNlJUNgDlXi"
Content-Disposition: inline
In-Reply-To: <cover.1603350036.git.vijayakannan.ayyathurai@intel.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--pWJxWxNlJUNgDlXi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2020 at 03:14:45PM +0800, vijayakannan.ayyathurai@intel.com=
 wrote:
> From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
>=20
> Hi,
>=20
> This patch set enables the support for PWM in the Intel Keem Bay SoC.
> Keem Bay is an ARM based SoC, and the GPIO module allows
> configuration of 6 PWM outputs.
>=20
> Patch 1 adds the PWM driver and Patch 2 is for the required
> Device Tree bindings documentation.
>=20
> This driver was tested on the Keem Bay evaluation module board.
>=20
> Thank you.
>=20
> Regards,
> Vijay
>=20
> Changes since v13:
> - Fix indentation error in dt-binding.
> - Add maintainer name in dt-binding.
>=20
> Changes since v12:
> - Use devm_add_action_or_reset() as per Andy suggestion.
> - Do the clk_prepare_enable() after all devm_ stuff as per Uwe suggestion.
> - Optimize keembay_pwm_remove function.
> - Simplify the error handling for pwmchip_add.
> - In Kconfig, Use depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)
> - Fix indentation error in dt-binding.
> - Add Uwe's Reviewed-by tag and Vijay's Co-developed-by tag.
>=20
> Changes since v11:
> - Minor variable name change to match the api needs.
> - Setup polarity as PWM_POLARITY_NORMAL.
> - Add comment for LEADIN register usage.
>=20
> Changes since v10:
> - Update low time calculation formula as per Uwe.
> - During distruct remove pwmchip first then disable the clock.
>=20
> Changes since v9:
> - Remove Reported-by tag from the commit log.
>=20
> Changes since v8:
> - Fix the compilation error reported by kernel test robot.
> - Add the tag Reported-by: kernel test robot <lkp@intel.com>
> - Minor correction in the pwm low time calculation formula.
> - Rebase with 5.9-rc7
>=20
> Changes since v7:
> - Change the dependency as ARCH_KEEMBAY instead of ARM64 in Kconfig.
> - Use DIV_ROUND_DOWN_ULL instead of DIV_ROUND_CLOSEST_ULL.
> - Update the right formula as per Uwe.
> - List the tags in chronological order.
> - Add clk_disable_unprepare in the error paths.
>=20
> Changes since v6:
> - Add reviewed-by tag
>=20
> Changes since v5:
> - Reorder symbols/Kconfig in drivers/pwm/Kconfig and drivers/pwm/Makefile
> - Use "Limitations" for consistency
> - Add clk_prepare_enable()
> - Reorder keembay_pwm_get_state() function call
> - Rework if conditional for channel disablement in .apply()
> - Remove channel disabling from .probe(), and clear LEADIN register bits
>   in .apply instead
> - Update commit message for Patch 1
>=20
> Changes since v4:
> - Add co-developed-by tag
> - Include mod_devicetable.h and remove of.h
> - Update comment with correct calulation for high/low time
> - Fix missing return from dev_err_probe
>=20
> Changes since v3:
> - Removed variable for address and calculate in place instead
> - Utilized u32_replace_bits() when updating KMB_PWM_LEADIN_OFFSET
> - Utilized dev_err_probe() for error reporting
> - Updated comments to use physical units
> - Updated error check for pwmchip_add()
>=20
> Changes since v2:
> - Include documentation about HW limitation/behaviour
> - Use hex values for KMB_PWM_COUNT_MAX
> - Redefine register macros
> - Utilize FIELD_GET/FIELD_PREP for calculating pwm_l/h_count and
>   pwm_count
> - Round up duty cycle/period values
> - Get current hardware state in .apply instead of cached values
> - Do a polarity check before .enabled
> - Round high time/low time to closest value
> - Set enable bit in KMB_PWM_LEADIN_OFFSET to 0 in probe
> - Correct the naming for MODULE_ALIAS
> - Add additionalProperties: false in DT bindings
>=20
> Changes since v1:
> - Updated licensing info, "clocks" property and example in DT bindings
> - Updated name of DT bindings document to match compatible string
> - Removed 1 patch for addition of new sysfs attribute "count"
> - Added support for COMPILE_TEST in Kconfig
> - Updated naming of defines and regmap attribute
> - Updated calculation of waveform high time and low time
> - Added range checking for waveform high/low time
> - Implemented .get_state
> - Removed register writes for lead-in and count values (left to default)
> - Updated register access to single-access
> - Folded keembay_pwm_enable/disable_channel,
>   keembay_pwm_config_period/duty_cycle,
>   and keembay_pwm_config into keembay_pwm_apply
> - Updated error messages/error codes
> - Removed pwm_disable from keembay_pwm_remove
> - Removed clk_prepare/clk_enable/clk_disable from driver
>=20
> Lai, Poey Seng (1):
>   pwm: Add PWM driver for Intel Keem Bay
>=20
> Vineetha G. Jaya Kumaran (1):
>   dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM
>=20
>  .../bindings/pwm/intel,keembay-pwm.yaml       |  47 ++++
>  drivers/pwm/Kconfig                           |   9 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-keembay.c                     | 240 ++++++++++++++++++
>  4 files changed, 297 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,keembay-p=
wm.yaml
>  create mode 100644 drivers/pwm/pwm-keembay.c

Both patches applied, though I did change the ordering so that
checkpatch doesn't complain about the compatible string not being
defined. I also changed the -ENOSYS error code to -EINVAL for the
unsupported polarity case because checkpatch doesn't like it when
we use -ENOSYS other than for system calls.

I'm also going to follow up with a patch that makes the return value
more consistent for these cases in other drivers.

Thierry

--pWJxWxNlJUNgDlXi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+sR/YACgkQ3SOs138+
s6Hjsg/9HRdH8LLepkcD+9j414Otw4ZY9WnXElSoVlAZc+6J47pyMQZwzUPI6cIt
IHgaLDZVz+DBYo6zJEZVre2o5FRHUWobkMAmW+3Vw1KUd3AH9YnGPfxKXFD9bFfV
Fg2Tg1tF0HmdwhhaVOhD9NqeyrdA8pYdcXKsJwuoBzJxbWnd1pAqwCxLZ5bAhn5O
JQ7Aldp1fj+Pt2c18JxQyFyfGUmZqtbnIb9G6MxDPz5fSgRLT8MNYQI7OM3E9RDv
ViTdliao8A7W9Ct53jgbYqc9YtOPUqb9hpW08VNFxmiX6fRgj3EG+jYv916i7RKJ
n28vySWUmcDBMoe30x1sHQqUVdSytvnVVzPirPCtckKRwW8TxNjAl8UQ6kvrBkU0
UQSl5Tft0PPGOb9f72UGG23EevLCz7/eYZlrIlMEpsaSZIApfgMNIgBYhnN9OOK8
MkzqljrBvB7tF9Oh8yXMMQs5KVHy3CEK9UAQ55y+nNW8ZvL/LjlCqRQHMU6W0lXr
R7ca8omjAi0Ca2omsfpLa+pd4EtTRRcex4WQwrfuMhl7hhf2y1JQurSpZyWBuN2e
RU88Km15HrsiusmyEjvKBXoXDvd+ydsmugWM+RzBjYvgUR1wrIUz2LV3RkbVun7/
z0Q9xViTAjo3tWSd4jxtJwLriPgfYtvSZ1KzGsqfkvj9QB2u6zU=
=g0x3
-----END PGP SIGNATURE-----

--pWJxWxNlJUNgDlXi--
