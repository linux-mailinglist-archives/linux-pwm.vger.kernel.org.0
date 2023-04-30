Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C836F2873
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Apr 2023 12:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjD3KcN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Apr 2023 06:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3KcM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Apr 2023 06:32:12 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF41F10F7;
        Sun, 30 Apr 2023 03:32:10 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f0b30f240eso15261071cf.3;
        Sun, 30 Apr 2023 03:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682850730; x=1685442730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88q4cylknUGQPnEgNEkNRWSqoVDq4Wpv4/ce7oxcsTc=;
        b=kwhnndqIX0ZTJfd2uwcPbrvZe69FW1o8V0XDQDVxmihIUueUKcakv62k/R7fv/Uasj
         EqTd/iTZb1Mw4oNWFC1FI+DycR9chzm8XkOgZ2z1UPrnit0GtZ8v3U3cPopbTCKIdNF9
         Xc5L5O3pkReOqvWSgHcMPDr8xrI7JdPI/IjqkhG/9ft7flTrwJctcukDPr66wmSWOetw
         s7cEHD8szfVLdKYdeiuQRjQwynomYFWKZQTXmPYw7ZZHv7dqGiOryfbZ8Pv6F07HUBlC
         /mgzrIaMydWoMQK/L+8QMFH++IKQPrlMFbXiVmjMfCNYwgfgbjunBlZrxCdRv07Z9lWF
         poLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682850730; x=1685442730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88q4cylknUGQPnEgNEkNRWSqoVDq4Wpv4/ce7oxcsTc=;
        b=H/iRrRqTf2DhJoOCGfKS7dxvT16Jk3BrNs0Cz2X77TWO10HtZ3IAX0iiwvGxX+Ht3Y
         QPaJaYzqlAQf3rFTiNzT0vHQqR6qKzNiKqxJAkqKvDO3gMC0TQPzoYOqJVWsxvHXMp3x
         1dj4yOs3kpiI9VthaT8MnbsBnHtRk9Nt3AUm9KiIv6YP87Afzq5v3WbGmdquW2shOzFp
         EcFp+NMWyKV8iPDZ5Fy0e36nVm40qErlomOtX4o4KlQOI/d65RP4SZqhxvlikK6Ok8YB
         u179YikvhAcoBywUONKriLEHC1aaLHrU+3oXl2jtUROpTAa9cZaBTUiNybxo0PaKVA55
         Ixkw==
X-Gm-Message-State: AC+VfDyR0vyihW+9oU7GfSeBCUWCbH6ldhq0bHxp+PNCDtBB2ke8o44M
        HZEVBt9wlz9NMh/sppAjIUV1uEbTQjzSYbJXvocaS46nbA253P3m
X-Google-Smtp-Source: ACHHUZ7ysxDRJIXIwqloEdjOfVBZum8r3YnorFjgTjRWt92Mm4xXaqE6MvspwQHpLXGJw9W/clktoBj3h4LTDpG6tXM=
X-Received: by 2002:ac8:5d86:0:b0:3eb:6892:2930 with SMTP id
 d6-20020ac85d86000000b003eb68922930mr17155324qtx.39.1682850729848; Sun, 30
 Apr 2023 03:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230429181551.98201-1-hdegoede@redhat.com> <20230429181551.98201-9-hdegoede@redhat.com>
In-Reply-To: <20230429181551.98201-9-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 30 Apr 2023 13:31:33 +0300
Message-ID: <CAHp75Vctex-8_1jOx3jaaCj9MH=d4oMoeCYdw5AYv+F=nzK1Kw@mail.gmail.com>
Subject: Re: [PATCH 08/19] platform/x86: lenovo-yogabook: Add dev local
 variable to probe()
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
> Add a "struct device *dev" local variable to probe().
>
> This is a preparation patch for making lenovo-yogabook-wmi also work
> on the Android version of the Yoga Book 1 which does not have a WMI
> interface to deal with toggling the keyboard half between
> touch-keyboard and wacom-digitizer mode.

...

> -       data =3D devm_kzalloc(&wdev->dev, sizeof(struct yogabook_wmi), GF=
P_KERNEL);
> +       data =3D devm_kzalloc(dev, sizeof(struct yogabook_wmi), GFP_KERNE=
L);
>         if (data =3D=3D NULL)
>                 return -ENOMEM;

> -       dev_set_drvdata(&wdev->dev, data);
> +       dev_set_drvdata(dev, data);

For robustness' sake I would at the same time move this a bit down to
have (some? at least dev seems to be important) fields in data to be
initialized. Yes, this won't change anything, I hope.

> -       data->dev =3D &wdev->dev;
> +       data->dev =3D dev;
>         data->brightness =3D YB_KBD_BL_DEFAULT;
>         set_bit(YB_KBD_IS_ON, &data->flags);
>         set_bit(YB_DIGITIZER_IS_ON, &data->flags);

--=20
With Best Regards,
Andy Shevchenko
