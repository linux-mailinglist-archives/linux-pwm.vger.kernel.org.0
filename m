Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EE46F2881
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Apr 2023 12:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjD3Ku2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Apr 2023 06:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3Ku1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Apr 2023 06:50:27 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AEC269E;
        Sun, 30 Apr 2023 03:50:25 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3ef64d8b2b4so7045091cf.2;
        Sun, 30 Apr 2023 03:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682851825; x=1685443825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCGZFVoQLRhj6mvA24nfj9NAsCXvOAZa67Fg6yhrjrM=;
        b=PfMCIhz+ZXSacEELflbDPvyPmal6loJeywpjoS3gp4GL4DDE350WBdYwuCe7jOLUKf
         CjqDnT1H9xHIfKqPHtjSfM6ZVLHG4Kx8psa3Bg440WCH2Gt+BxIK4onqy3w4SCZUuI+c
         IlgfcRkfmCQW1NsraXpiFCfe+9sm3bh/liYUczTIogeTwtIUBgTtMu6YjsGvyYGbqKfG
         hAxz4RNO0ZyikoHjobiSPadllM4T4jOhPwiPMEjHQrqlUmN8ImJJu8xWUAcTP/MbyMvm
         BCLZdnkDkI71zn1qPAeIdhOHLYKVvch/nCPBe8+WdsDre7lAJADikyINypcZxsalx0Mb
         YxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682851825; x=1685443825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCGZFVoQLRhj6mvA24nfj9NAsCXvOAZa67Fg6yhrjrM=;
        b=gaLmHjQaOBWi5pQPaNq8rMGKjmnHCuu2+M2xCjGOTM1zCYuPf4T+aThmd4vUWDgDXR
         Ni0I1f0I6bjBQ8XYcIBUYU+MsCxGBO15TJWiqbGnbujYw+2dvbeFlvY+dCETLN0Tmehw
         FbCCzYbMhUoPVF76MhIiIHRx9MNAn4NE/0jZcsUAnKTJVVrAm/L1+Z8Ioah+7bYlOigj
         2shVb7rou985uJRRR5z3G6dAxyvbTGqsenFRG+GlYYlcxgudOCKujI30y4fGhKPUdtWJ
         V+nlkAVEaM6FOPnQ/Q8PaJimDn6yLKPYrnG2QLOMcwGqtJ1/aIPqdcmDpJMXtNUeWmDK
         ju1g==
X-Gm-Message-State: AC+VfDz6woEtmKU45zlmNsXvfCrfKFWdzaPeHEx20LYX2wUdCVbou/2y
        3zPRz3TJs3X5GaSrr+ok4Rhxjfltbh7TJTOy/WED3Io7hB6unt0V
X-Google-Smtp-Source: ACHHUZ5wvZFgxTyfCR+8kSHWMcYa/88eqL7dN+s3pQFkt/InqHUp4psWPj6xleTuU5w86sG62SOCS/X9gKfwGtxT+Ew=
X-Received: by 2002:ac8:5bc5:0:b0:3f1:fb02:8340 with SMTP id
 b5-20020ac85bc5000000b003f1fb028340mr18105363qtb.4.1682851824918; Sun, 30 Apr
 2023 03:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230429181551.98201-1-hdegoede@redhat.com> <20230429181551.98201-18-hdegoede@redhat.com>
In-Reply-To: <20230429181551.98201-18-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 30 Apr 2023 13:49:48 +0300
Message-ID: <CAHp75VfCzm+ZS=Q4jmeww_12UeU0YKHFqURBfJiSFX-MxxbFbg@mail.gmail.com>
Subject: Re: [PATCH 17/19] platform/x86: lenovo-yogabook: Add platform driver support
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Apr 29, 2023 at 9:16=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> The Lenovo Yoga Book 1 comes in 2 versions.
>
> Version 1: The yb1-x91f/l currently supported by lenovo-yogabook-wmi, whi=
ch
> has a WMI interface to deal with toggling the keyboard half between
> touch-keyboard and wacom-digitizer mode.
>
> Version 2: The yb1-x90f/l which is the same hardware shipping with Androi=
d
> as factory OS. This version has a very different BIOS and ACPI tables whi=
ch
> lack the WMI interface.
>
> Instead the x86-android-tablets.ko code which does devices instantiation
> for devices missing from ACPI on various x86 Android tablets will
> instantiate a platform device for the keyboard half touch-kbd/digitizer
> toggle functionality.
>
> This patch adds a platform driver to the lenovo-yogabook code which binds
> to the platform device instantiated by x86-android-tablets.ko offering
> touch-kbd/digitizer toggle functionality on the Android model.

...

> +/*
> + * Platform driver for Lenovo Yoga Book YB1-X90F/L tablets (Android mode=
l)
> + * WMI driver for Lenovo Yoga Book YB1-X91F/L tablets (Windows model)
> + *
> + * The keyboard half of the YB1 models can function as both a capactive =
touch

capacitive ?

> + * keyboard or as a Wacom digitizer, but not at the same time.
> + *
> + * This driver takes care of switching between the 2 functions.
> + *
> + * Copyright 2023 Hans de Goede <hansg@kernel.org>
> + */

...

>  #include <linux/devm-helpers.h>

Hmm.. TIL!

...

> +       if (IS_ERR(data->pen_touch_event)) {
> +               r =3D PTR_ERR(data->pen_touch_event);
> +               dev_err_probe(dev, r, "Getting pen_touch_event GPIO\n");

Combine them

  r =3D dev_err_probe(...);

> +               goto error_put_devs;
> +       }
> +
> +       if (IS_ERR(data->kbd_bl_led_enable)) {
> +               r =3D PTR_ERR(data->kbd_bl_led_enable);
> +               dev_err_probe(dev, r, "Getting enable_keyboard_led GPIO\n=
");

Ditto.

> +               goto error_put_devs;
> +       }

...

> +       r =3D gpiod_to_irq(data->pen_touch_event);
> +       if (r < 0) {
> +               dev_err_probe(dev, r, "Getting pen_touch_event IRQ\n");
> +               return r;

return dev_err_probe();

> +       }
> +       data->pen_touch_irq =3D r;
> +
> +       r =3D request_irq(data->pen_touch_irq, yogabook_pen_touch_irq, IR=
QF_TRIGGER_FALLING,
> +                       "pen_touch_event", data);
> +       if (r) {
> +               dev_err_probe(dev, r, "Requesting backside_hall_sw IRQ\n"=
);
> +               return r;

Ditto.

> +       }

...

> +MODULE_ALIAS("platform:" YB_PDEV_NAME);

Hmm... Do we need this?


--=20
With Best Regards,
Andy Shevchenko
