Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4D66F2883
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Apr 2023 12:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjD3Kvz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Apr 2023 06:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3Kvy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Apr 2023 06:51:54 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF19E269E;
        Sun, 30 Apr 2023 03:51:50 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-75131c2997bso1078081885a.1;
        Sun, 30 Apr 2023 03:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682851910; x=1685443910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/TFEW7DSQxy4UnowCUDLbizXceZKkjU6XPnLi02cMU=;
        b=PezSgJjCpdmYOkykr8NM/7qe+K9UmGZTfUicLQyz7C8XPGI+FckR8TqPpw2x9iNOy/
         BqJSRm4c4DhvmdfreC5D/Ncqv4j09s0zlubOokoJRg1+P7Rrv9HN3CHRPy9ZZIXwKPGf
         xqNfeLZ068SlrUeh7Anx5R5XPj0RDxIleqOiarbRMAwgberrIXtMLP6TFKrwhRO3tgx/
         xh3m9qUy9ww5nL0T1vwIKM/7HbmbU4dKNcCuoLwCjjkWTHlfYoFT6i1Rpdg1FYVGA6Sz
         3OS0bev2AcSAU7UpVXrSxYgI23tIvUM2PTDZZWoplN7DE/BTK2Bp2Bp3Wrbr8gM/VALA
         Aa8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682851910; x=1685443910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/TFEW7DSQxy4UnowCUDLbizXceZKkjU6XPnLi02cMU=;
        b=Vz26nEwqmRK87sg1LatLTPGqqXB7X5tjDDN2Qdac0fpk2nL7PPQGvczi3BfBUK0UH9
         ec2QEArF+XyuH6cnenyPBqYlkYey2p+S7V9STJXE1FhZQaoFJ5oy9n8Myi4gDm21TOSa
         JBYzVi2aLWlThsdInx+IWdsfSiiDtOR0uTQIjy9vyhkrLxSluDDTdKj+4bVYhvUddlG2
         gEhzRBtig3Dm4ZJCVIeh+lxho3jCh0osDcvlCJkR0PlbWr0NlyNRZ1cxkj+mFTTe/s/x
         3EfhNhg9dNyKwV03FGV5KxF3fnHSDcpDnh9ynQORcSfpjznatW7R/1+Jb5ZhtPMpy3sI
         LO8g==
X-Gm-Message-State: AC+VfDwzu6lfZXB/cgrWJ2eAeIzrvw3HTbjmgJD5jTebBt3vruhPSO5M
        usSIkOdSd5mRq5aCuQsY34qM4g/cP8Zw6GT6BVs=
X-Google-Smtp-Source: ACHHUZ6zVMAGpdfMiF+SgTPuzM8L9IWHNhvTNrhguKIiYgBicOYUdfm4LJ4/naI0d728UXYfSZhIaDG/JWNMwYLHP+c=
X-Received: by 2002:ac8:5cc6:0:b0:3db:9289:6949 with SMTP id
 s6-20020ac85cc6000000b003db92896949mr26214632qta.3.1682851909761; Sun, 30 Apr
 2023 03:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230429181551.98201-1-hdegoede@redhat.com> <20230429181551.98201-19-hdegoede@redhat.com>
In-Reply-To: <20230429181551.98201-19-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 30 Apr 2023 13:51:13 +0300
Message-ID: <CAHp75Vf3YhC-cTyDxii1-cV22MEtD8YUVTAJQfwrbDLNTDg1hg@mail.gmail.com>
Subject: Re: [PATCH 18/19] platform/x86: lenovo-yogabook: Add keyboard
 backlight control to platform driver
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
> On the Android yb1-x90f/l models there is not ACPI method to control
> the keyboard backlight brightness. Instead the second PWM controller
> is exposed directly to the OS there.
>
> Add support for controlling keyboard backlight brightness on the Android
> model by using the PWM subsystem to directly control the PWM.

...

> +#define YB_KBD_BL_PWM_PERIOD   13333

Defined...

> +static struct pwm_lookup yogabook_pdev_pwm_lookup[] =3D {
> +       PWM_LOOKUP_WITH_MODULE("80862289:00", 0, YB_PDEV_NAME,
> +                              "kbd_bl_pwm", 13333, PWM_POLARITY_NORMAL,

...but not used?

> +                              "pwm-lpss-platform"),
> +};

...

> +       if (IS_ERR(data->kbd_bl_pwm)) {
> +               r =3D PTR_ERR(data->kbd_bl_pwm);
> +               dev_err_probe(dev, r, "Getting keyboard backlight PWM\n")=
;

r =3D dev_err_probe();

> +               goto error_put_devs;
> +       }

--=20
With Best Regards,
Andy Shevchenko
