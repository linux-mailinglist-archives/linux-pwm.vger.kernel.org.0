Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DD34B5600
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 17:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiBNQWH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 11:22:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356353AbiBNQWH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 11:22:07 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1C5C31
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 08:21:59 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id m8so12715523ilg.7
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 08:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/lXxznWJk6t4L5VwAqaMS0+NBIKS0zk3kQAGJ/1b/k=;
        b=JZLXUfRWra54tioTiu2lrYxDJmGtcUX8NNdySo/F7BWBvDruBVnf1bOydWNgXOogN5
         Iz7arnCufrG1kJ9V7DcoDSRxMCbNRVV3btf8XwNiGUJYm3d1E2eS92/RlK7bOd1VQe5G
         IQJLzFRnqEVjliOJs+NOd9nwMMPcEvNaZXjNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/lXxznWJk6t4L5VwAqaMS0+NBIKS0zk3kQAGJ/1b/k=;
        b=Jx++VejUJuz0gEiWVfb/+6b/ZvwXIoLSy2qI8P1R1J74FA6PyzXCrM5hVKivUdvYoQ
         W21gqz/muivJvEZr740adniWzZMfFr+PoN55ZvzeEK6dx1L5AmPgPv38RWaJv0JxXN4r
         vy66Q987DeRR6bHq07yNfHN+cKGSE72mZZjjzsu1aIKJIusZJWBOzt4tpS98NO1C8Fp6
         ASnSwu9w02JMgkYqee2jJABx38Xt+LxJvNgVtVu3bmqRwWxxw6imdYk4rwrtxdgIQrP8
         Ypr6UjCy2DWRs2/S0hwZO4YhB/KhiRl/+phygFlW6hX2owiehqAXvg8Qq5ceD4eFlMWs
         EbCA==
X-Gm-Message-State: AOAM533zo5Sci6pp6gplg9Yjqxu/Pv0wppsVG5yvnO0eBl2Mxz/CItcb
        OFYBbWe/lS7ojkRwe1CS3TmXhNVjfFaMkQ==
X-Google-Smtp-Source: ABdhPJx0OwI1q0yVYED+4fk3FH2fL2pxjZVyFFTUTM7jW94aaZZphQALUAe3d1uOspZal6HR4PHEJQ==
X-Received: by 2002:a92:d304:: with SMTP id x4mr99020ila.181.1644855718590;
        Mon, 14 Feb 2022 08:21:58 -0800 (PST)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id a6sm2212654iow.22.2022.02.14.08.21.57
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 08:21:57 -0800 (PST)
Received: by mail-il1-f179.google.com with SMTP id c14so3110664ilm.4
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 08:21:57 -0800 (PST)
X-Received: by 2002:a05:6e02:19cf:: with SMTP id r15mr119973ill.180.1644855716786;
 Mon, 14 Feb 2022 08:21:56 -0800 (PST)
MIME-Version: 1.0
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com> <20220214081916.162014-4-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220214081916.162014-4-krzysztof.kozlowski@canonical.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Feb 2022 08:21:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VNarYKq8cZVqWfFKccTqxH46Wmm8Tr979EVsiAoOnT_g@mail.gmail.com>
Message-ID: <CAD=FV=VNarYKq8cZVqWfFKccTqxH46Wmm8Tr979EVsiAoOnT_g@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: align Google CROS EC PWM node name
 with dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, chrome-platform@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Mon, Feb 14, 2022 at 12:20 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> dtschema expects PWM node name to be a generic "pwm".  This also matches
> Devicetree specification requirements about generic node names.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi               | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi             | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi             | 2 +-
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi                 | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
