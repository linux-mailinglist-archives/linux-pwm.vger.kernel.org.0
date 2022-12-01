Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BDB63F529
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Dec 2022 17:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiLAQXi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Dec 2022 11:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLAQXg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Dec 2022 11:23:36 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD8F15713;
        Thu,  1 Dec 2022 08:23:35 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id cg5so1342920qtb.12;
        Thu, 01 Dec 2022 08:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmTEUnhGG9xmVuyhLp+T5UJoMV6vOQdMIsCsbd0HNis=;
        b=g7CBPnry2hrWGQCYHez2q/fC67fVDKD+PeUN51vf/OMiyzGpCcaQM497d87HOJRcDF
         H4/Is74O69VBME/YtkqZTC4FMxsm0BptRaGqTdvuR73MwjjhXJlhkA5APyNzbUwVUTfy
         F8QdY0f1yg9K3NxE2bl848JsW1+3Ox7GPoz2XdD8yFFKD+gnYTmv11Pydbe9rkRHM6oQ
         yT8Ivn9Zy9wuOCw877mhNMjGDy7N5enbDupqsV8XJkiC+/5W6JBiMvS5aeQfVQyI9bnA
         DJ1JgAKg5mG62U/7Aq+t6G31al3Hw+KKqk98bCwbYKdIiUkbwqVV/wAIOGJ+teS7wyND
         bk8g==
X-Gm-Message-State: ANoB5plBki8BAGshGOMCZ2WQaTsxHtS9bfIHsYZP0ld+AATEawoqc5gF
        0pVeqZVVU++ZVhLuJVpvMsmlGPjuTnXoGg==
X-Google-Smtp-Source: AA0mqf6ziAeqpEMbmJwZwGcyspYAcM8yney7KTa1OBBB7Qc/omL89MRwEX9IWJi9zQtoMgxWBGYMhw==
X-Received: by 2002:ac8:6742:0:b0:3a6:8922:b71c with SMTP id n2-20020ac86742000000b003a68922b71cmr10423490qtp.559.1669911814796;
        Thu, 01 Dec 2022 08:23:34 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id f4-20020ac80684000000b0039cc64bcb53sm2725992qth.27.2022.12.01.08.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 08:23:34 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-3bfd998fa53so22409707b3.5;
        Thu, 01 Dec 2022 08:23:34 -0800 (PST)
X-Received: by 2002:a81:a148:0:b0:3b4:8af5:48e with SMTP id
 y69-20020a81a148000000b003b48af5048emr35487304ywg.383.1669911813908; Thu, 01
 Dec 2022 08:23:33 -0800 (PST)
MIME-Version: 1.0
References: <20221124191643.3193423-1-biju.das.jz@bp.renesas.com> <20221124191643.3193423-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221124191643.3193423-3-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Dec 2022 17:23:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVQUN0Tsn7KEsZDWkMcgG+i-SokSa39Tq06AOMzxQNpcg@mail.gmail.com>
Message-ID: <CAMuHMdVQUN0Tsn7KEsZDWkMcgG+i-SokSa39Tq06AOMzxQNpcg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: pwm: Add RZ/V2M PWM binding
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Nov 24, 2022 at 8:17 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Add device tree bindings for the RZ/V2{M, MA} PWM Timer (PWM).
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> v1->v2:
>  * Added Rb tag from Krzysztof and the keep the Rb tag as the below changes
>    are trivial
>  * Updated the description for APB clock
>  * Added resets required property
>  * Updated the example with resets property

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
