Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC8868AD55
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Feb 2023 00:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjBDXHF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 4 Feb 2023 18:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBDXHE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 4 Feb 2023 18:07:04 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE58233CE;
        Sat,  4 Feb 2023 15:07:03 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bk15so24737098ejb.9;
        Sat, 04 Feb 2023 15:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bcb1s9VJkccwiv9hfLYBUmr2IZ71QXiGTqX43dsIWtA=;
        b=iqKZ7/2QMGcNBHl2zhcSWT0Go4Cnn83/XFH+fJ8f93K67lUCYdXWcSgQOCF43tCbe0
         Y3CPT9M0KORfH4ZpO5coHLvsitVIPkgC23pzq1MPZQn5muBUIWDKwpP0ztsCs4WWyIAF
         AGxweuS/dOBKUgWxtLqZbU8VzPt3hEFN6Q3sao4TbKeb8qR8krcFaM4bXSgtc9NP7ViM
         LTGWij20RPkSMZmb19GRAfrWSgHZQIZGxVN8pJrC25rxRjzxWs2YxCC/tl2C/hpksP1c
         +TcmDirlh6/7DBswXvv9tOOux7rJHGzpQM+SVj0bdI5zHmdccbsrR1x12ZWbvP7Xjj4L
         yOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcb1s9VJkccwiv9hfLYBUmr2IZ71QXiGTqX43dsIWtA=;
        b=xehjflKaFEOaOvBzAmZDEhA9Skn1DFzlUr4yyuszyxVbS+saGbi5SqfI1KggXHfZHm
         GOoZPkwPiI/qbltjqk/GZwUx7cNwhC2i8wKW/PL7MOQ03Ndsst4LO5NOPkUTaG2sAWBH
         d75RrGC5ndpQ7FPcPwaB5RRK8PHg/XyB7yIPWsMiQQnBBvK1UHtQ3eoUffkJDvw4qLmA
         r4xmvy+nw5XDUOzbPiehbuL19d/n13+qM8uNZ6vwBf6QT82B6ADBvBboeKhKR2ORX5e2
         JQbloLMHQOfSpVo6FgRNW+lOR/M/ZmD9gWbFkiearWD1VCQ/ofyttzfZFJIEuNUMygQ9
         IHlQ==
X-Gm-Message-State: AO0yUKXhsedWl38YMLk1WOGOMrbZh2ZXA+igI+plxhlSiDcsCHEW5L39
        uFSmmRUPkV6ZSdoQwNwhRBi0tqPDR4c/JpxqeTI=
X-Google-Smtp-Source: AK7set8dlk/12WJdxLKyI1EkZFKpAReFptsRHZJwEP5g7SdpXMu2cnevSl2MhoMzH8y5Q51SWKBrguS9muf+ZfrC1aE=
X-Received: by 2002:a17:907:9916:b0:886:2823:423e with SMTP id
 ka22-20020a170907991600b008862823423emr4321280ejc.284.1675552021901; Sat, 04
 Feb 2023 15:07:01 -0800 (PST)
MIME-Version: 1.0
References: <8df4ceec-663c-dc68-d775-5caeb02c0cca@gmail.com> <66f77c32-2678-3e31-fb00-1294ccaa6045@gmail.com>
In-Reply-To: <66f77c32-2678-3e31-fb00-1294ccaa6045@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 5 Feb 2023 00:06:51 +0100
Message-ID: <CAFBinCC+4WLgWFn6bPrRVnRwZ46_Fi0gVoh6nHwV2BEwFQgh=A@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm: dts: meson: adjust order of some compatibles
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Feb 1, 2023 at 9:02 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> During review of a new yaml binding, affecting these dts, it turned out
> that some compatibles aren't ordered as they should be. Order should be
> most specific to least specific.
>
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
