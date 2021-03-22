Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D36C34403F
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 12:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhCVL43 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 07:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhCVL4Y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 07:56:24 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74887C061574;
        Mon, 22 Mar 2021 04:56:23 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id bx7so18934744edb.12;
        Mon, 22 Mar 2021 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KS85IVDzb0H7K1jO3EiwO+5LR6In+7iTE4xtTzUGrfM=;
        b=MkK0DLI4jGhh0jNi8U1dH8B8/03b5UgOs80kYlp9lhL8YYeqwK/NpJrXn2Nud2lFQB
         tFOy/KwpjyBQWrPJTXgiFKOp8BcuSOsBTmpJ3VNWo3zyv71feWRS9GLna7FtAH7JxC78
         ZYy7XltspQfW2m980z/ZdVvZABkTxsylmnqRlWFnSONUdkAz+g6+idd8uQ0uYc/EG2bi
         pGBfrKbXdT9sXFbwJ8ZT0kG5MgfV0AmrscReIwZ6IIVIDsAh6V2FqvvvNsUzIwuV+hal
         K4uJa9lHcDNL2R4gOlnXVobKc7miHnyG9TSicOHpmnbr3ZcQ+qaL6vOkop/WuWVk7M8Z
         EQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KS85IVDzb0H7K1jO3EiwO+5LR6In+7iTE4xtTzUGrfM=;
        b=b45yIS4PjhSNjLmHgfuh83ajVUilqOCaBJkAgc78NoAL3TYnAyD8pK2uWYTeGMQa3G
         NW/vAqLCqL6AKt/v7nBurKCzfkVzWhKlei3aAMvaz0W2vCXkl2zsYt7+g5/A2OGkrgvQ
         vw7LnN94F73KjTG+U5gb7Cjse2gn4Cbd/bOWkFJOiWnUd72yFojeuEfp6o2+p/OU2O/l
         s75HpRPS+4Z9GoYGLb8qa5f7gBql/uj3JYX2h6Hlm/LKNRfRCdIkapaN/J8Xbn6VpYAE
         fUEJqs4xO+SCCYcia6L7j75j2cV7NSHfC3NauCn7LKSStaxVehXXL53K8+a/D0nkNAKq
         2ajw==
X-Gm-Message-State: AOAM530YTwLT/M1OJEppEUa1mpI+EP4pXYkiOQjFfAy45OipEF5pH0yy
        RJH2qp+9O57WlH3zxxlIPY8=
X-Google-Smtp-Source: ABdhPJwpVsrotPvmpeBqtoqp7lZGoCpny93lpHIapXgAftlRQ4tIEGo2ymIkhjPc4BiaflFrE0JryQ==
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr25409909edb.306.1616414182220;
        Mon, 22 Mar 2021 04:56:22 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id n26sm11201580eds.22.2021.03.22.04.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:56:21 -0700 (PDT)
Date:   Mon, 22 Mar 2021 12:56:39 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     u.kleine-koenig@pengutronix.de, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v8 11/11] pwm: Add Raspberry Pi Firmware based PWM bus
Message-ID: <YFiF94ZDi2xdy8yx@orome.fritz.box>
References: <20210312122454.24480-1-nsaenzjulienne@suse.de>
 <20210312122454.24480-12-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WsDiv438+NmnlX5u"
Content-Disposition: inline
In-Reply-To: <20210312122454.24480-12-nsaenzjulienne@suse.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--WsDiv438+NmnlX5u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 12, 2021 at 01:24:54PM +0100, Nicolas Saenz Julienne wrote:
> Adds support to control the PWM bus available in official Raspberry Pi
> PoE HAT. Only RPi's co-processor has access to it, so commands have to
> be sent through RPi's firmware mailbox interface.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> ---
>=20
> Changes since v7:
>  - Remove unwarranted RPI_PWM_DEF_DUTY_REG usage
>=20
>  Changes since v6:
> - Use %pe
> - Round divisions properly
> - Use dev_err_probe()
> - Pass check_patch
>=20
> Changes since v3:
>  - Rename compatible string to be more explicit WRT to bus's limitations
>=20
> Changes since v2:
>  - Use devm_rpi_firmware_get()
>  - Rename driver
>  - Small cleanups
>=20
> Changes since v1:
>  - Use default pwm bindings and get rid of xlate() function
>  - Correct spelling errors
>  - Correct apply() function
>  - Round values
>  - Fix divisions in arm32 mode
>  - Small cleanups
>=20
>  drivers/pwm/Kconfig               |   9 ++
>  drivers/pwm/Makefile              |   1 +
>  drivers/pwm/pwm-raspberrypi-poe.c | 206 ++++++++++++++++++++++++++++++
>  3 files changed, 216 insertions(+)
>  create mode 100644 drivers/pwm/pwm-raspberrypi-poe.c

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--WsDiv438+NmnlX5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYhfQACgkQ3SOs138+
s6EnXRAAjnwdU3G0KN2XyFF2cU6Hmif3eeSfiKIfBkONfEQKpjd5lXaJQ5NhViG3
keYEFiM/eOnuhXWshnMGzwjq/G22ufO/owlbwlEsZo8Rf9SMkDkK0EgBSvM/9p6A
NshCjKRNEYqd0ajXxY5Pzo6ma/o9Qb6bbYAXzcFP4d3vMPYbA6M1utYAltUQrUBR
GvDmt1K93Jeuk6jbDXkNbi4x+pn3gUDEH4f+/jJfLT0gzAD/JNvD2uR5YDj58f9T
EqA9KHm/yk/6IsYBseBOHFbx1EZ8zO0HLl145Bg19GMfaab2FLEiL4s/3DUZ4U3m
admNIIPzr81WKtXvHPN7gNmzpLu5NEcUavkSKRVviKNXVSXA3geNsY1XCNTJkfk/
ijme2kA3fEkomnyB8KcVz2X96iqE6vAqySeddmBkfM0/HJcfdA93XyRIiDMU6IlJ
JXuuYKDwXthz/kioxs44h8cK04pW8MfJMqf5KESQfwQF57kFH2J3n0pseLtbHySV
w7LZ7rd/BT8zr9WBC5BCVWA43Xfx4kj2wOWEsMjp/6r6iLoPcPUPztEj1OLdskoN
xaGcQFozx6y9PsSLIFd6yn4HmMXMekgGQiuwMYpsiqDWfWMJpgIwMMhszu6F6Twx
OOx8TIiCBT1WQG2hMZY/13Pl1c5HoAxjDd6fPV2ixPH5lz4bjcI=
=2cN9
-----END PGP SIGNATURE-----

--WsDiv438+NmnlX5u--
