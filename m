Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C876E8FAF
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Apr 2023 12:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbjDTKNv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Apr 2023 06:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbjDTKNT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Apr 2023 06:13:19 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699B01715
        for <linux-pwm@vger.kernel.org>; Thu, 20 Apr 2023 03:10:46 -0700 (PDT)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8E9AF3F212
        for <linux-pwm@vger.kernel.org>; Thu, 20 Apr 2023 10:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681985443;
        bh=kOcmaafFB2AQEmvIg0cTjiZetG/rfnyXfpR41vhnI5I=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=PY1M7GIrlsLGvyWOskxnDKZXhNS10eCxg+ZHMsMkPgx6gIn02K/E45Zu3LFfHtPgf
         nCYmxSpaqZe/f6yY8Jx5rgEn7LaoSvQNMfwYlNttrWzRWFevmOWdYj311rF0JRDbAf
         Bt5M7l+3Lop0VSFctYSmGk+2vB2UpaM79S0c3Jcg0Zu0kfK6to1ReWK9Z/Hc38TNlH
         RMwU0piYJ84VnkqgCXy2ECgrHxq9RtXXEPFaDKMFsD4gRrymXXozVECf2S1wSYBBjm
         U+DxKeXySGHs29Y/F8BPUg9XNcn7ijZhuDh9DLSoUChlthDGX4KfkgWbClH8VwhTUh
         VjPq+fxWM3bUg==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3ef44f554b1so3074311cf.1
        for <linux-pwm@vger.kernel.org>; Thu, 20 Apr 2023 03:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985442; x=1684577442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOcmaafFB2AQEmvIg0cTjiZetG/rfnyXfpR41vhnI5I=;
        b=B48N2GpvFeAlNPHWhzP7718t3D8vwmzzjfH+k6pv6ruuUPTQkdDHI1nU6yuOsWdWo+
         IwVpYoOeNpKOhBWekNeE9VV3xjWLdBnsDkLBs4AOuztjQSWGXjxqAazyxVwb/rUpzo5I
         s69C20lwyFhpSJdx05gnqc107FJo0xuAWbVQpkeSoCjSy4ddp8EJOzYGk+Xu4sSyRrwG
         n6p73S1h1WLR0q7pDRYuNH51PPoOkqvWdEISNQ+9rPiWbRTCkTcqCtlr9oBETfB0cico
         Wme9gjRW/EvbgjHU3WNb9frI3jdUZkgXyh+AUJfCznbNPtqpdQKgfpgQaKIOqVEevcFs
         e5iw==
X-Gm-Message-State: AAQBX9dyXpaRN0HTh5C1PTjQmrVrzds+8THB8o9bwlpCfaaKUchxXD4D
        X5UGiFb3apRox7o6bLQ3uR4uvL5x6WPEHlC6rRAqprjEXGbscW38QlKatQuIMzfnsulxBYdsFLz
        bvuFdnv+DioenZioDjBnJGrL6spDnSMX/D4YkvU583blf5uqzlwvUrw==
X-Received: by 2002:a05:622a:44d:b0:3ef:4100:cd0c with SMTP id o13-20020a05622a044d00b003ef4100cd0cmr852866qtx.63.1681985442650;
        Thu, 20 Apr 2023 03:10:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350aMhBcVKGhtjkBbRGE7xqTUZ0iLDLnmRAX/+0wM0CbmSLYXvwoQ82pVYVXHywu+lJ9/JwBn+E1eoJF7KfdCLQA=
X-Received: by 2002:a05:622a:44d:b0:3ef:4100:cd0c with SMTP id
 o13-20020a05622a044d00b003ef4100cd0cmr852847qtx.63.1681985442457; Thu, 20 Apr
 2023 03:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230418202102.117658-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230418202102.117658-1-u.kleine-koenig@pengutronix.de>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 20 Apr 2023 12:10:26 +0200
Message-ID: <CAJM55Z9Vmbsx_egcDpEmk5mDurOvXaUFdGHxvbBR05CcaA8Wig@mail.gmail.com>
Subject: Re: [PATCH] pwm: sifive: Simplify using devm_clk_get_prepared()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 18 Apr 2023 at 22:23, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Instead of preparing the clk after it was requested and unpreparing in
> .probe()'s error path and .remove(), use devm_clk_get_prepared() which
> copes for unpreparing automatically.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Looks good to me, thanks.
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  drivers/pwm/pwm-sifive.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index 5b0574f635f6..ae49d67ab2b1 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -244,12 +244,12 @@ static int pwm_sifive_probe(struct platform_device =
*pdev)
>         if (IS_ERR(ddata->regs))
>                 return PTR_ERR(ddata->regs);
>
> -       ddata->clk =3D devm_clk_get(dev, NULL);
> +       ddata->clk =3D devm_clk_get_prepared(dev, NULL);
>         if (IS_ERR(ddata->clk))
>                 return dev_err_probe(dev, PTR_ERR(ddata->clk),
>                                      "Unable to find controller clock\n")=
;
>
> -       ret =3D clk_prepare_enable(ddata->clk);
> +       ret =3D clk_enable(ddata->clk);
>         if (ret) {
>                 dev_err(dev, "failed to enable clock for pwm: %d\n", ret)=
;
>                 return ret;
> @@ -308,7 +308,6 @@ static int pwm_sifive_probe(struct platform_device *p=
dev)
>                 clk_disable(ddata->clk);
>                 --enabled_clks;
>         }
> -       clk_unprepare(ddata->clk);
>
>         return ret;
>  }
> @@ -327,8 +326,6 @@ static void pwm_sifive_remove(struct platform_device =
*dev)
>                 if (pwm->state.enabled)
>                         clk_disable(ddata->clk);
>         }
> -
> -       clk_unprepare(ddata->clk);
>  }
>
>  static const struct of_device_id pwm_sifive_of_match[] =3D {
>
> base-commit: 247ee6c780406513c6031a7f4ea41f1648b03295
> --
> 2.39.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
