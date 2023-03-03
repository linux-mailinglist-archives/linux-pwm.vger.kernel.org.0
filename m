Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138C76A9FF4
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 20:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjCCTOe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 14:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjCCTOd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 14:14:33 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7E616303
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 11:14:32 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-53916ab0c6bso60275187b3.7
        for <linux-pwm@vger.kernel.org>; Fri, 03 Mar 2023 11:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677870871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRFCHBII5HxWnVKdRDrtgCThRX8/e7j76YPCdtgTTJE=;
        b=m4oOiUB3+FZax2wPtoA+UBgc6k1LQdfyTtsseoG3abRFYOAUAgV68rye3BoA7iVcly
         TI9q1TTspLr6KnS+qdbRpxlLQ49dnXbrpqR4WvIsJKVOakO+Px+fjaKehlzwEsAtvfpY
         AUeYSXijPGIhMRgM3ohaBE0J8uo4iaL5SPFWjC43w99fqtnUDPoxAydc2GOCamrVqN+s
         QyM4964RS7u/EY8Pe/ZPDdAzFesN9cOdJJpZwbTRyqxAqbFDlckozwNfWpUkkMLZY71+
         vdGKlABM0U8gjLJTUUnl6vkFlx816cF5e/JYz1IUK2FLlW2YqnqojwpLBy51hG90fzPg
         G2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677870871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRFCHBII5HxWnVKdRDrtgCThRX8/e7j76YPCdtgTTJE=;
        b=tWq43X88AFub4x/gd0nm4Aft9bJAySrQ25w1RvfD+SG1kzoijidNWLPO9IOsCPRUL7
         Km+Z+4IfCYInIfJOuBKBTsbSF+nWC6ESwdkjIxfmuAFbEMMTfGNVm9v6wMe2Svi3SFvy
         5phPc1zOP1WePum7gBl0TBjOtN53v/8IVO+bo8jgmpkU94ThkBfyvXM8C+O0eQnFbS0j
         G3HbeHGfcbF3EN7jEMkwGIESK5d4lO/RyA1CE8SFOrwMdba9G95actZCKEnhgEw8PMRQ
         4ba3oB6JMB76LxJS9Aac4MSql2ccETo5Y/WQD3oTEE+F5BC6oe6R90NIW8MM0dpgwZmq
         KxMw==
X-Gm-Message-State: AO0yUKUCfLz5d9Tzq/QDLejcfekedec2g4ubkzGCadNQ8YGE+oI/Eytf
        sY7zEx8cWkbtWRA8fYqRPIUCE7DE4aIWz93W/NkcAg==
X-Google-Smtp-Source: AK7set/axDl9gJ4mM3BPIagqkhYshrlpCAhyrWEAIWhAZL0379oSCnbH0viYM733QwcOWhI5UkNCnMsMbWplCkYqHys=
X-Received: by 2002:a81:af59:0:b0:535:5e8c:65ef with SMTP id
 x25-20020a81af59000000b005355e8c65efmr1549694ywj.6.1677870871418; Fri, 03 Mar
 2023 11:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de> <20230303185445.2112695-10-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230303185445.2112695-10-u.kleine-koenig@pengutronix.de>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 3 Mar 2023 11:14:20 -0800
Message-ID: <CABXOdTddD34WJpTGzRi=KWGVG3uOdxdj_mwsfr8fFb99j3Y2SA@mail.gmail.com>
Subject: Re: [PATCH 09/30] pwm: cros-ec: Convert to platform remove callback
 returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Benson Leung <bleung@chromium.org>, kernel@pengutronix.de,
        Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Mar 3, 2023 at 10:55=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/pwm/pwm-cros-ec.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> index 86df6702cb83..90afce212fb0 100644
> --- a/drivers/pwm/pwm-cros-ec.c
> +++ b/drivers/pwm/pwm-cros-ec.c
> @@ -328,14 +328,12 @@ static int cros_ec_pwm_probe(struct platform_device=
 *pdev)
>         return ret;
>  }
>
> -static int cros_ec_pwm_remove(struct platform_device *dev)
> +static void cros_ec_pwm_remove(struct platform_device *dev)
>  {
>         struct cros_ec_pwm_device *ec_pwm =3D platform_get_drvdata(dev);
>         struct pwm_chip *chip =3D &ec_pwm->chip;
>
>         pwmchip_remove(chip);
> -
> -       return 0;
>  }
>
>  #ifdef CONFIG_OF
> @@ -349,7 +347,7 @@ MODULE_DEVICE_TABLE(of, cros_ec_pwm_of_match);
>
>  static struct platform_driver cros_ec_pwm_driver =3D {
>         .probe =3D cros_ec_pwm_probe,
> -       .remove =3D cros_ec_pwm_remove,
> +       .remove_new =3D cros_ec_pwm_remove,
>         .driver =3D {
>                 .name =3D "cros-ec-pwm",
>                 .of_match_table =3D of_match_ptr(cros_ec_pwm_of_match),
> --
> 2.39.1
>
