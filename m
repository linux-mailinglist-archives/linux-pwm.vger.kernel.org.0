Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0489F454ADF
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Nov 2021 17:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbhKQQ0i (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 17 Nov 2021 11:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbhKQQ0i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Nov 2021 11:26:38 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48042C061570;
        Wed, 17 Nov 2021 08:23:39 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b12so5778777wrh.4;
        Wed, 17 Nov 2021 08:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PzPx/LjYyE2XV81Gm1zhHDHroV3AcvmLd3/mYMOeJJ0=;
        b=Dzkv7Z4OmT62zAg5Dw/0U+k+xC9fShSsI6C/st2O6alf1laxOjquGX6U4fb/FCJM6w
         aRCWDZNDwxwAmY1ZJzPN4uWauIPCDHvKrVpQ0Y8svdP3Mj35KMyfNVQOdKzsFjytgtWJ
         rkuP4d+hXr/GOsN1KFM1yTEbECwMK6U6ngygW4jyPnVW5rDGlH5KrMDKX1mBFyOxmQxh
         i9N+t+Zhz7PCI7NHQFt8xHFmKp5BMIIOjQYrPqiuv07aEghp2kvW9F443NrKhGDbtMOL
         irArRw3AkpaTvkuKvyuoM1lX4WpfZ3kCb5HqEPBPcF3XOMpzSZbkVH13CMdw+7dxsy50
         OCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PzPx/LjYyE2XV81Gm1zhHDHroV3AcvmLd3/mYMOeJJ0=;
        b=G5JVpo2pJrnQlTwDr70Kne8jluasgCkeQTokaUhbyWJ6QRnJMCMiOednL7AyqLj9JC
         wa+77yHJ+Tq9YcZTonV8s+FIOTWQDJH1vyUTj1EsNemeCCaYnn7eWgqzmoLv/iC5o9IU
         39RupuzPyBZOCCarv+kDPbQGTrDMBbDFqmsYK1IVyyGaunumJ5pRrOmASo8BN4HXY42r
         clqlYvFMHSim3FKDVta4hZa3sx9X41BMiK7g3x8//XkSehzI1mIkfsqpNWIPpaiarVHr
         zMFJtygYDR8wFxO7p2Y1FtjHHDM/ZrHovXcnta4uW7w0La8iAndU2T128TqRWxEUiO5j
         Tw1Q==
X-Gm-Message-State: AOAM530/BlsA1KUHVZavYTKakHw62f0SLl5SYJdG/PYSoXiV6LVFzJpA
        id8cMlCdWiYfs8hpAbZED6I=
X-Google-Smtp-Source: ABdhPJxjx4aSCbcfqBDkbZ8vjTiGtyjvwUCaQ536f5nZ/sJyJeg/ISHoWRxzj4JnEMlx8DOqyXN/+A==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr21813278wrw.166.1637166217830;
        Wed, 17 Nov 2021 08:23:37 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id d15sm564909wri.50.2021.11.17.08.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 08:23:36 -0800 (PST)
Date:   Wed, 17 Nov 2021 17:23:33 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 3/3] pwm: Add support for Xilinx AXI Timer
Message-ID: <YZUshZs2FCfNk5IJ@orome.fritz.box>
References: <20211112185504.1921780-1-sean.anderson@seco.com>
 <20211112185504.1921780-3-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E4jM0zVs9S755EDT"
Content-Disposition: inline
In-Reply-To: <20211112185504.1921780-3-sean.anderson@seco.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--E4jM0zVs9S755EDT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 12, 2021 at 01:55:04PM -0500, Sean Anderson wrote:
> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
> found on Xilinx FPGAs. At the moment clock control is very basic: we
> just enable the clock during probe and pin the frequency. In the future,
> someone could add support for disabling the clock when not in use.
>=20
> Some common code has been specially demarcated. While currently only
> used by the PWM driver, it is anticipated that it may be split off in
> the future to be used by the timer driver as well.
>=20
> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
>=20
> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_tim=
er/v1_03_a/axi_timer_ds764.pdf
>=20
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
>=20
> Changes in v10:
> - Fix compilation error in timer driver
>=20
> Changes in v9:
> - Refactor "if { return } else if { }" to "if { return } if { }"
> - Remove drivers/clocksource/timer-xilinx-common.c from MAINTAINERS
> - Remove xilinx_timer_common_init and integrate it into xilinx_timer_probe
>=20
> Changes in v8:
> - Drop new timer driver; it has been deferred for future series
>=20
> Changes in v7:
> - Add dependency on OF_ADDRESS
> - Fix period_cycles calculation
> - Fix typo in limitations
>=20
> Changes in v6:
> - Capitalize error messages
> - Don't disable regmap locking to allow inspection of registers via
>   debugfs
> - Prevent overflow when calculating period_cycles
> - Remove enabled variable from xilinx_pwm_apply
> - Swap order of period_cycle range comparisons
>=20
> Changes in v5:
> - Allow non-zero #pwm-cells
> - Correctly set duty_cycle in get_state when TLR0=3DTLR1
> - Elaborate on limitation section
> - Perform some additional checks/rounding in apply_state
> - Remove xlnx,axi-timer-2.0 compatible string
> - Rework duty-cycle and period calculations with feedback from Uwe
> - Switch to regmap to abstract endianness issues
> - Use more verbose error messages
>=20
> Changes in v4:
> - Don't use volatile in read/write replacements. Some arches have it and
>   some don't.
> - Put common timer properties into their own struct to better reuse
>   code.
> - Remove references to properties which are not good enough for Linux.
>=20
> Changes in v3:
> - Add clockevent and clocksource support
> - Remove old microblaze driver
> - Rewrite probe to only use a device_node, since timers may need to be
>   initialized before we have proper devices. This does bloat the code a b=
it
>   since we can no longer rely on helpers such as dev_err_probe. We also
>   cannot rely on device resources being free'd on failure, so we must free
>   them manually.
> - We now access registers through xilinx_timer_(read|write). This allows =
us
>   to deal with endianness issues, as originally seen in the microblaze
>   driver. CAVEAT EMPTOR: I have not tested this on big-endian!
>=20
> Changes in v2:
> - Add comment describing device
> - Add comment explaining why we depend on !MICROBLAZE
> - Add dependencies on COMMON_CLK and HAS_IOMEM
> - Cast dividends to u64 to avoid overflow
> - Check for over- and underflow when calculating TLR
> - Check range of xlnx,count-width
> - Don't compile this module by default for arm64
> - Don't set pwmchip.base to -1
> - Ensure the clock is always running when the pwm is registered
> - Remove debugfs file :l
> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
> - Report errors with dev_error_probe
> - Set xilinx_pwm_ops.owner
> - Use NSEC_TO_SEC instead of defining our own
> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
>=20
>  MAINTAINERS                        |   6 +
>  arch/microblaze/kernel/timer.c     |   3 +

Michal,

do you mind giving an Acked-by for this part. It looks harmless enough,
but just making sure you're aware of this.

Thierry

--E4jM0zVs9S755EDT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGVLIUACgkQ3SOs138+
s6HpIhAAiXOT8NHEDsR1yUMYamCbazeXWOrUsI2ZLTexW2ggHU1so4wKt+Bp45/W
9THIP/aNuGXoDl634EeCD5sRXYa1Z9a09h+SwElVeWNW3aJUkTVh9pSvYTw9y4dN
fwWkzJU9HbTf+bmTbI0nESvbpu8TDiLTq09dPbV3vnfhZD6zsRARO8N8TE9s9dcR
sIYQfU8MCvOrie+U54pvdSQLgJbVKn1fGLiKC9yLgDsxOECFhX9cMFYxsTRUDIB4
KKJOcj7gOxy+veyfG8Gyg2oc7fwGfyUQSPRedGmJm/qP/amalSpwhuE/rogssLAD
vlu2guzT6bIeCpIVUa+YvFE+TnB2Iq4kqCdK8Xvlq3kYqwCtBwwPXiKdJJEXQx56
1IWTTFg7X4PBktJ29f/VDAs/OaiZ0Onnu/iZCeYiT4H+/N86ikGy5pSd+W6lv9L3
WbronR/8+YpdV2el9cZ+dr5AB+QdDNer8pukB5E7X07RW9SXC7v6yTlAIJKHR5sb
1d6L0rtoFPUciAfJrotWiJ89TyodnE4ftcWrFiC5MILkNQyycHjbffpLcwz4Fm/8
Gpumb8F1qcpPqMauiEzhmOEjf0HLK3iBPZ5Pa5K3p0sBlqGL5WH2RVVcOmexsCvQ
8A3BcEOafKxJ1LceteCJ7+o4S0T+EP2VFeaUSEoDYVpt4Vxg6Go=
=DHiN
-----END PGP SIGNATURE-----

--E4jM0zVs9S755EDT--
