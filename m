Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF843C533
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Oct 2021 10:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbhJ0IeK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 27 Oct 2021 04:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240937AbhJ0Id5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 27 Oct 2021 04:33:57 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477AFC0432C2
        for <linux-pwm@vger.kernel.org>; Wed, 27 Oct 2021 01:29:20 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f5so2170341pgc.12
        for <linux-pwm@vger.kernel.org>; Wed, 27 Oct 2021 01:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=thzDWFk9Q0tPB9sJfYt3NFAW2DK3VreaLCq6cyyRMEE=;
        b=I5SHd85j9XYMXkGN3HPiKAs3OiCmon5wOEaUYkYPQEJRzcAsr/i815L/DDBTmgAZlK
         EFp67Jm8jst08kO5YrOlU+k8GkQao+bnmNngHPVii4coZ9DKOPIusqOBSszH1FXQqkWW
         y8arffbFWprqCu3qQ1fUVff5XmPh1QZ5FP4h/8MjNw91DQZeEAqclM0AaRugzY9O42st
         Q018apx9bqf2Y817pghf4orHBr0Qd9HVokKGyqXtr1/sJEtTpAXmPDxYl6jqAEICOz3g
         e89gnZpZjW009WCkYivSwwYbqiz4+RZpXKx6ZT0FSJhL3HFv+ZXsXGu9GwIDQkxv3zP5
         f4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thzDWFk9Q0tPB9sJfYt3NFAW2DK3VreaLCq6cyyRMEE=;
        b=vmfFwImQQCJFqOeNOuFLHrFo6VVQci/MS0DFg/iJsIS5ekIFbuxRVV/DtCiRihMxAr
         auWLZce7YDM5iLJ5Dwk5BlEKxAExuRC3VqzcSVBU3vVjGttvDnsm66fk9k/BfIotFbsL
         ZiUKvIrhuRfThdF2SeIBFlkNGnpM5MRKH6UhMAUJWj3bYxpoiJuY5tC3fxUrGi1knz03
         yhEwN90CwPgU2+V4qfNmW6S2AIJmnoGF5iStyGgjmsZYqHEjhcEOuYdiQvYjpMhAGfN5
         Dtt9yPJvrD58DT2U+c4ogKWHjuatrA8vdgzS0Ddoig/FvUvHTj40Zff39g+RODWU69tE
         obrw==
X-Gm-Message-State: AOAM530TEuVfLE5kJiPOI/z+7RNK7MXvCDOjoiGrXmDtWaBJKV/J5US6
        dyhg+WbpFVDZCiM9NScsI5LIHosJDPdJ8nSxI+9hY4ks9XH+ZA==
X-Google-Smtp-Source: ABdhPJybXgubxhC8DfgFq8g0lwfLwDF6P7AyUiHgxUWktEKQSjPjY4tmPmstfYLTlntkSKzmjZqX9/kk5YEXbxJUJRM=
X-Received: by 2002:a62:dd96:0:b0:47c:1b37:d0f with SMTP id
 w144-20020a62dd96000000b0047c1b370d0fmr7148072pff.1.1635323359684; Wed, 27
 Oct 2021 01:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211025170925.3096444-1-bjorn.andersson@linaro.org> <20211025170925.3096444-2-bjorn.andersson@linaro.org>
In-Reply-To: <20211025170925.3096444-2-bjorn.andersson@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 27 Oct 2021 10:29:08 +0200
Message-ID: <CAG3jFysN4pFqTrF8tGTVapCzysPkvO=MpYosAJnErY-AW7BqgQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] drm/bridge: ti-sn65dsi86: Use regmap_bulk_write API
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hey Bjorn,

On Mon, 25 Oct 2021 at 19:07, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The multi-register u16 write operation can use regmap_bulk_write()
> instead of two separate regmap_write() calls.
>
> It's uncertain if this has any effect on the actual updates of the
> underlying registers, but this at least gives the hardware the
> opportunity and saves us one transation on the bus.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Did you miss including Dougs R-B from v6? As far as I can tell nothing
else changed between v6 & v7.

> ---
>
> Changes since v6:
> - None
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 6154bed0af5b..5b59d8dd3acd 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -193,8 +193,9 @@ static const struct regmap_config ti_sn65dsi86_regmap_config = {
>  static void ti_sn65dsi86_write_u16(struct ti_sn65dsi86 *pdata,
>                                    unsigned int reg, u16 val)
>  {
> -       regmap_write(pdata->regmap, reg, val & 0xFF);
> -       regmap_write(pdata->regmap, reg + 1, val >> 8);
> +       u8 buf[2] = { val & 0xff, val >> 8 };
> +
> +       regmap_bulk_write(pdata->regmap, reg, buf, ARRAY_SIZE(buf));
>  }
>
>  static u32 ti_sn_bridge_get_dsi_freq(struct ti_sn65dsi86 *pdata)
> --
> 2.29.2
>
