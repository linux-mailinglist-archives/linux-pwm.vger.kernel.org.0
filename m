Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA33C6F287B
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Apr 2023 12:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjD3Kiz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Apr 2023 06:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3Kix (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Apr 2023 06:38:53 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE9110DB;
        Sun, 30 Apr 2023 03:38:52 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3ef35d44612so18366651cf.1;
        Sun, 30 Apr 2023 03:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682851132; x=1685443132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZKBLPSRoLR6E32GNyHWfjJNPT9RqigzUNAEk928+lE=;
        b=EtwzRx2nOX5XIuy9nhrizh2E+jXmM3ISLBoLwg0SIj29erPSQMqXJ4HwPukKlyA2bR
         pBQSO/spe71K3OMP57UerIFGIIeNVRs+M4cI0nmVsZ5XyrxIlF4hwJflN3r3t85aEQtr
         xOqMbSUSmzplCf3nL4B9KX6qyLydqEhnSAuCX15FuNtXCfYs979uXDg2jE1Q2OyzXR64
         MeZJ0ZAwd03/4WOB+IQ4AQRtNLehtq4Vi46Hyqd118jXn/yJWrauWTVk3vNmRthdUP4E
         McH45dg8IPs+bllIFcLPMSXdtQ3HJ55uERxmdckCTvQ2UO8cj2+Wq2SeFh4mna0c9J+K
         t7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682851132; x=1685443132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZKBLPSRoLR6E32GNyHWfjJNPT9RqigzUNAEk928+lE=;
        b=AzxA6/rHgqEmQdTFqeTdAhIHj5zDJ75jDh77+WKFtOP1z+OBggan9U6wbPhqMeJhZR
         t5YSNQ0sWpTbsWQQvfHy3bfWq8ZnjJRH/T5Zci/cuXnI5XlgZynHQnSR35Ef5T+blhkq
         FDWORjllWXYjvd7B/Dexg1Dj8XZZte5I/0NZvnfAM3RKrn+PEdtc7HjGsPF/SQD4QgYk
         XqFHnJs4ffQZsX53rJix/WdA6gcS7d19C2Edm12864z8GLyV0pMMJOz1Y9dUVLYEJFv4
         QkoV5LlWnrf5g+TUpF5wiEEPiH+367iAlU/hU0YCXkSjTLkqMl83lvc28CYU7gihhzcz
         PwaQ==
X-Gm-Message-State: AC+VfDzzuULvOHPYvAHd5eg95gLOnN9LHT6A+wUUV7NGQAbVywxAqJdu
        SjyQbI8Ly3fJ2WRis2YOFc+QvwDLtBAqb9sCkso=
X-Google-Smtp-Source: ACHHUZ7rqGV3XUOXgx8gzu4g0EhjVrxOcq5nG5VFnsobNS/3OtaM3BQ+S6lq90jhKpDed7Wutz4GB/8ScJWQjZRNOLs=
X-Received: by 2002:ac8:7c49:0:b0:3ef:2c3a:faa3 with SMTP id
 o9-20020ac87c49000000b003ef2c3afaa3mr16886054qtv.17.1682851131776; Sun, 30
 Apr 2023 03:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230429181551.98201-1-hdegoede@redhat.com> <20230429181551.98201-11-hdegoede@redhat.com>
In-Reply-To: <20230429181551.98201-11-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 30 Apr 2023 13:38:15 +0300
Message-ID: <CAHp75VfXGC611evXnorLaoWecAX2daFsvSdqmp09UFt4yD-isQ@mail.gmail.com>
Subject: Re: [PATCH 10/19] platform/x86: lenovo-yogabook: Split probe() into
 generic and WMI specific parts
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
> Split probe() and remove() into generic and WMI specific parts.
>
> This is a preparation patch for making lenovo-yogabook-wmi also work
> on the Android version of the Yoga Book 1 which does not have a WMI
> interface to deal with toggling the keyboard half between
> touch-keyboard and wacom-digitizer mode.





>         if (IS_ERR(data->pen_led)) {
>                 r =3D PTR_ERR(data->pen_led);
>                 dev_err_probe(dev, r, "Getting pen icon LED\n");
> -               goto error_put_devs;
> +               return r;
>         }

At the same time you may

return dev_err_probe(PTR_ERR());

Same to the rest of the modified places like this.

...

> +       data->kbd_adev =3D acpi_dev_get_first_match_dev("GDIX1001", NULL,=
 -1);
> +       if (!data->kbd_adev) {
> +               dev_err(dev, "Cannot find the touchpad device in ACPI tab=
les\n");
> +               return -ENODEV;

return dev_err_probe();

> +       }
> +
> +       data->dig_adev =3D acpi_dev_get_first_match_dev("WCOM0019", NULL,=
 -1);
> +       if (!data->dig_adev) {
> +               dev_err(dev, "Cannot find the digitizer device in ACPI ta=
bles\n");
> +               r =3D -ENODEV;

r =3D dev_err_probe(); ?

> +               goto error_put_devs;
> +       }

--=20
With Best Regards,
Andy Shevchenko
