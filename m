Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979E66F2FFE
	for <lists+linux-pwm@lfdr.de>; Mon,  1 May 2023 11:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjEAJxy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 May 2023 05:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjEAJxx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 May 2023 05:53:53 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B320E45;
        Mon,  1 May 2023 02:53:52 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-74e1aec175eso88350285a.1;
        Mon, 01 May 2023 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682934831; x=1685526831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+F9Qdc2x8qTyoRaS1w8s4tW89T9gRQhWlGh7a0rFZc=;
        b=PjJNIII/AXw0nfK/PFZru24XKK+41Y8NtAkEhXmaRfpecLxLNbVMUnPT6gMjlBd9Xk
         a2CQVGarL2dfNirdR7pgimLlof/cV+Q1AOmFlrg1i0jxSsZY3AWmifdURRAW5+Q+UWfA
         cxGAkDFHdYO+1RRg4SOmqoNI1NnxYtQ+XNBBdCqd3L68Y/N6fwyuxpvtGfE8EEnF73g6
         yXyrgvkb8FC9Xwey7EMB0LF247mru0OeGMyfH0SHKQZJNQx0K1R0aLsQwbD2dzLI0s6/
         iONzXKxvje5Yhvx+scBS6OmSxwhWHXsGRoYyQL9Cf4HezrxDRjiLwAXzB/ewMgts9odK
         XoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682934831; x=1685526831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+F9Qdc2x8qTyoRaS1w8s4tW89T9gRQhWlGh7a0rFZc=;
        b=WtASclFLJPoW3/OSHVkx7ec9qPWRzvjWZ61FJFEY+ybgmbrOsDQ4mFiYl9hyUd++bw
         SMzb6kW6UqKZQ6N+1zWrA7f7JakbdURQhetSOoCkXT+DRLm6SCMVIqXFZEtyrGOtptq2
         XYipG425DzQPXgHWwOAm6l5FE6xbbbk4DRth32JfUq4FJ+ynnWTHKg+8gg/LYUhIRqMY
         michvwD/H2igwKlWk4VZKgAA24Gc6drpxt1HPdQoLnjF0JvC5OfX1/jNMDCrnbYg3vSM
         mNboqpOXytDPrHHpXceM4pmUpfPJ/Gp4enpr5+C+sW6JeHzqHSTFXO9gwjWIiox7fnba
         0JmA==
X-Gm-Message-State: AC+VfDwqjHyjZsEURNUBrBsXRHvM26qq8L9bex/d5oWP2osNnFZ+2oas
        PiFQlP3UyPp7exIc2kujxjSx3cmbQcEZ6S+y6zU=
X-Google-Smtp-Source: ACHHUZ4hVvYkDsz6banhDjGTgR32TZkKp/S+otek3gXwGgX5JZGMlNjy2tQPbmfepdwgn2zzMwIC+d4jw4/kd4dIshA=
X-Received: by 2002:a05:622a:1a84:b0:3e6:3851:b945 with SMTP id
 s4-20020a05622a1a8400b003e63851b945mr21573181qtc.67.1682934831323; Mon, 01
 May 2023 02:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230430165807.472798-1-hdegoede@redhat.com> <20230430165807.472798-11-hdegoede@redhat.com>
In-Reply-To: <20230430165807.472798-11-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 May 2023 12:53:15 +0300
Message-ID: <CAHp75VejjvfjLSsePfhRetEiWTE7ve=uZR87V9MZLET9KG6C1g@mail.gmail.com>
Subject: Re: [PATCH v2 10/19] platform/x86: lenovo-yogabook: Split probe()
 into generic and WMI specific parts
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

On Sun, Apr 30, 2023 at 7:58=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Split probe() and remove() into generic and WMI specific parts.
>
> This is a preparation patch for making lenovo-yogabook-wmi also work
> on the Android version of the Yoga Book 1 which does not have a WMI
> interface to deal with toggling the keyboard half between
> touch-keyboard and wacom-digitizer mode.

...

> Changes in v2:
> - Use "return dev_err_probe(...);" in several places to simplify
>   error-exits in the new yogabook_probe() function

I'm not sure you have changed previous patches where it makes sense to
use dev_err_probe(). Neither it's done (in full) here (in case you
wanted to split replacement to a separate change). See below.

...

> +       data->kbd_adev =3D acpi_dev_get_first_match_dev("GDIX1001", NULL,=
 -1);
> +       if (!data->kbd_adev) {
> +               dev_err(dev, "Cannot find the touchpad device in ACPI tab=
les\n");
> +               return -ENODEV;

Here...

> +       }
> +
> +       data->dig_adev =3D acpi_dev_get_first_match_dev("WCOM0019", NULL,=
 -1);
> +       if (!data->dig_adev) {
> +               dev_err(dev, "Cannot find the digitizer device in ACPI ta=
bles\n");
> +               r =3D -ENODEV;

...and here.

> +               goto error_put_devs;
> +       }

--=20
With Best Regards,
Andy Shevchenko
