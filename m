Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B676E001A
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Apr 2023 22:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjDLUrU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Apr 2023 16:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjDLUrT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2023 16:47:19 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A095249
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 13:47:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94a39f6e8caso299062966b.0
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 13:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1681332436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adW1liiXa5DTitRWm/MrMHr2aySyi2H+5VTArVZMM8I=;
        b=JsN8WGSr9uDtkZ0rsGDDGjoppXwP8kEuYggVlfSAxHbuAdVW2r07ASK7bI66v/x/fD
         bnHb81PY6SLdg2WSKm0gRkOLay4I70XgkEAR9/+Eq8Wa6koQ2tL/P4ValKcIb/UGHn4i
         b7tE+PRUDJpeZKWH8yXeCZyocK47W8BIZQEGlaW61gKOjK/ahl0/SeSHDN0XJa5zqwHY
         2PxxbLcLE3l8BQwtTR1BaaGD8P8MYyb+EpDCsis2heEqs020zpycawkpmTLGEOagnREa
         rlhcBQeM0u8wFhDuq6/rXbvvylKH4jsuErp8i/fi4X73URI8/QOEMQASSEMPIIUY+WZc
         80ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681332436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adW1liiXa5DTitRWm/MrMHr2aySyi2H+5VTArVZMM8I=;
        b=DNJp8hsJVbCrQMmWD8kgFpsT3iMbt4UTEcykFpDlNMmOlHNN8ZzwDXPOOEyofiewuy
         TUeZvMmvusE64QSBBhtN0ZlHhkJ9jIA9t3WisZU5hz6iz0mCJcT7fPXU2BxCxwj5cAOV
         UTS7abqVX2B45MGCC7zA+f9nXrcpcKrg7j2XzmGFopuupmNN5btvVAR4NaORBjCXzcma
         FjQBUDVawWc9xzjIw2zvCspuN/wiBW42jIGl9sOYWxsOWIde6ouaUuyc/T0EMJJGO5If
         8/FhG9e0tw9WRxQOxoLsoqn8qAC+gsklOKo9rZoFPK92ECV409gudO6S4BbVZ+Ue2ERr
         2/Cw==
X-Gm-Message-State: AAQBX9di1jH1on6W4l2j19om2Y3oVU9TFBIJf1yIyRT5xQvNY/o4hwIQ
        CP1PDSI1LhWF83FsDubvLmKVvZYRkzXsESQvYHc=
X-Google-Smtp-Source: AKy350aKT9mhtEZLe3+/dPU6KZVDXqdCUxJb6NrFLui1rsW9oEXUrBYezlVHH3CazHEPRcBuD1JQT57SADw4Xty6DjA=
X-Received: by 2002:a50:cc9d:0:b0:4bb:e549:a2ad with SMTP id
 q29-20020a50cc9d000000b004bbe549a2admr8415edi.4.1681332436206; Wed, 12 Apr
 2023 13:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <29973c8a-2b14-3d0c-bee8-8aff36c265e3@gmail.com> <f7291bab-eb51-3f2d-4eb4-78f6330242ef@gmail.com>
In-Reply-To: <f7291bab-eb51-3f2d-4eb4-78f6330242ef@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 12 Apr 2023 22:47:05 +0200
Message-ID: <CAFBinCDs=EQo8-HSSbaprfJB+93sz+Ng1H=MX3hBG_00PTko3g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] pwm: meson: change clk/pwm gate from mask to bit
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Heiner,

On Wed, Apr 12, 2023 at 9:23=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> Change single-bit values from mask to bit. This facilitates
> CCF initialization for the clock gate in a follow-up patch.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> #
meson8b-odroidc1, sm1-x96-air

[...]
>  #define REG_MISC_AB            0x8
> -#define MISC_B_CLK_EN          BIT(23)
> -#define MISC_A_CLK_EN          BIT(15)
> +#define MISC_B_CLK_EN          23
> +#define MISC_A_CLK_EN          15
>  #define MISC_CLK_DIV_MASK      0x7f
>  #define MISC_B_CLK_DIV_SHIFT   16
>  #define MISC_A_CLK_DIV_SHIFT   8
>  #define MISC_B_CLK_SEL_SHIFT   6
>  #define MISC_A_CLK_SEL_SHIFT   4
>  #define MISC_CLK_SEL_MASK      0x3
> -#define MISC_B_EN              BIT(1)
> -#define MISC_A_EN              BIT(0)
> +#define MISC_B_EN              1
> +#define MISC_A_EN              0
Personally I'm fine with this change but it's not how I would have done it:
- I would have kept the BIT() macro for MISC_{A,B}_EN
- then I would have renamed MISC_{A,}_CLK_EN to
MISC_{A,B}_CLK_EN_SHIFT (to be consistent with _SHIFT of the mux and
divider) and drop the BIT() macro there (like you did)

This is possibly/likely personal preference, so my suggestion is to
wait for some more feedback.


Best regards,
Martin
