Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59065379725
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 20:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhEJSnZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 May 2021 14:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhEJSnZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 14:43:25 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3882BC061574
        for <linux-pwm@vger.kernel.org>; Mon, 10 May 2021 11:42:20 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id n184so16650620oia.12
        for <linux-pwm@vger.kernel.org>; Mon, 10 May 2021 11:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0lAsKPwl7H0EAg3P9Py4bjsSkcKpDPZybKUKs0hgExc=;
        b=PaKoxL2CMevbiPvORes55Jde3cMJuwri1HInQoH9mNOkVS32NXqJZeIC+aDgu9opgc
         071fTRPWPHKmaRtX5ku+Mv7JAq1c+cW99HSvUw3B9bDMDm/u0gGWtVuDUKcpop3WlbyN
         nm4CHQGLaU9aRe3KLEWQdbpIeEf2FWXnAuMdCXBlX4cSzizg/6CXMe+HHqtHl7iwyvWh
         W3XV3DCE/blBd5h/HQzcCWgikjTOFvgKZ+qQbyxQELV4tOkZYkvz/FkzE74yAiXcxIaP
         5B+lCQAvhILo5AvE5WPcYsFBtS0NOpRW3Yeqm1JE5CRrA1BR3xUU2MnspA4GUXu0Fsnl
         RdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0lAsKPwl7H0EAg3P9Py4bjsSkcKpDPZybKUKs0hgExc=;
        b=qCZotBgaS9ZEgi2rREKWM2F7KMlhXouaHyOclZva8gpKuLqg7xBWXtK4wT33LjpvPG
         W5bHmWlAmcmGlFWzFq05knt3Ezi+m+kmYTt5aCe1IBRvRPxy8kUPjIVuhUrStFLUIYg0
         RB+vpebLHxPxozVO3ajZ2HOxjuRDesOsubF31Pw/Gw1G6SU+Klfy4tS4l/uhx8OAe7Xf
         QigeEQuv0oskBRRiZRKRuvIVucBtrr4kCzo5GxVMpIyMN9izDgZhQt77gXNvTw47bc98
         k7Q97U74DYw7JRNLAzPvLSJqUsymTJ4V5eGx43RbM3OJYcWgi7QyT3HZIPtgjUre748M
         sulw==
X-Gm-Message-State: AOAM533c8rv4pVCZlBsFw19CKLG+sodi2WTSqnty0RXFYBFCXYuKbnY7
        53+6fN+VqUrLRj2m+l47wp4us2+0DYgnTxn9gRw=
X-Google-Smtp-Source: ABdhPJwHzakuJIZSkrACR4F4NjNFPV6THkT2F4NrQRV8IJDWIsT04BbVgFiy+iEcahsaIQz9DbjOeMl/tYFFHGPDdeI=
X-Received: by 2002:aca:b383:: with SMTP id c125mr434400oif.60.1620672139674;
 Mon, 10 May 2021 11:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210510171046.984246-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210510171046.984246-1-u.kleine-koenig@pengutronix.de>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Mon, 10 May 2021 20:42:07 +0200
Message-ID: <CABgxDoJbnFb+=oSMNrhbBGbFCRZWBQ54Dkyy02YnYm5bveD4gA@mail.gmail.com>
Subject: Re: [PATCH] pwm: meson: Simplify using devm_pwmchip_add
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

The "struct device *" as first argument is missing, nop ?

Regards,
Romain


Le lun. 10 mai 2021 =C3=A0 19:11, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> a =C3=A9crit :
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>
> this obviously depends on https://lore.kernel.org/r/20210407080155.55004-=
2-u.kleine-koenig@pengutronix.de
>
> Best regards
> Uwe
>
>  drivers/pwm/pwm-meson.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 9eb060613cb4..d9de4562e003 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -560,31 +560,21 @@ static int meson_pwm_probe(struct platform_device *=
pdev)
>         if (err < 0)
>                 return err;
>
> -       err =3D pwmchip_add(&meson->chip);
> +       err =3D devm_pwmchip_add(&meson->chip);
>         if (err < 0) {
>                 dev_err(&pdev->dev, "failed to register PWM chip: %d\n", =
err);
>                 return err;
>         }
>
> -       platform_set_drvdata(pdev, meson);
> -
>         return 0;
>  }
>
> -static int meson_pwm_remove(struct platform_device *pdev)
> -{
> -       struct meson_pwm *meson =3D platform_get_drvdata(pdev);
> -
> -       return pwmchip_remove(&meson->chip);
> -}
> -
>  static struct platform_driver meson_pwm_driver =3D {
>         .driver =3D {
>                 .name =3D "meson-pwm",
>                 .of_match_table =3D meson_pwm_matches,
>         },
>         .probe =3D meson_pwm_probe,
> -       .remove =3D meson_pwm_remove,
>  };
>  module_platform_driver(meson_pwm_driver);
>
>
> base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
> prerequisite-patch-id: fa39cd0c852d109ed957dc44dca5bdcf5dff0685
> --
> 2.30.2
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
