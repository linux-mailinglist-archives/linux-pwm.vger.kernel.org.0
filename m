Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D677268AD57
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Feb 2023 00:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjBDXH1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 4 Feb 2023 18:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBDXH0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 4 Feb 2023 18:07:26 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D7E22797;
        Sat,  4 Feb 2023 15:07:18 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id gr7so24776075ejb.5;
        Sat, 04 Feb 2023 15:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bcb1s9VJkccwiv9hfLYBUmr2IZ71QXiGTqX43dsIWtA=;
        b=DnElZdAbz0UA9aV2RnWHh7OySKDvNWkN1m/VIUV+9yTJP6ErTFFBwr8y136ZhwLsUf
         sC0f9oFAe+T9F0Ov5zJdsSJhvUigwkh9P0dR2CoA7GXOxF0YJhx/UhWTu5ZSGxNwwOjh
         Esa8KO84U2Qd2B6XsWzhYhK7CnD8g7uGZLuTNlM7mnw50atlm4rFjr+D+OvKST8hRmv9
         VDllvXpCpkP/RQZnIP+028G5yyZN9MOzimTriJByI9uw8DLirxwDl0KaiS+MX/YrJcNJ
         ZU4rUVQhB8L7RECOcNHBZhMiNHUftZxiBCpMLP5gQQ4FZJrh/Nx38tpGoICyVLf/2xy0
         PInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcb1s9VJkccwiv9hfLYBUmr2IZ71QXiGTqX43dsIWtA=;
        b=LF3quyZjr+CxyCZABZ/IPcADnIdu1CQHfWdtavCyB6RB13NLf+8or/UC9F/DwnRIo+
         JD7f8xKLmAj5lnoS8SSFOENAy/jMkdkhH3Idy3eFJ4lY5wIKzk1G/8J2ZMIx4XNPXtAT
         FR6YOJ6Ht0lElgFT5MViPYcOVinoX5WF5n8laZhZep4ubuRoO+YRXDcDdHWWjwFZrrkx
         0kH04JHSTff9qoyibL1kt33oXR6BjUsMFcpoTLQ3Jt5vxGbLHABKUDpykGKeOX+9uhM0
         0MdhehKVGnNprZS8k4p9dYSR3xce9t+vz+/e5sPj+BffwVoT4NqHLh266Ssnz6vBZH0d
         5AWg==
X-Gm-Message-State: AO0yUKUnnCXwqWezWZSn1ApnPgZybpRBveHDEUyZXWl/Qt40+DRfw3EC
        dEeVh/999ou31cJOiVEAH/40NeKEv+D2peFyHEE=
X-Google-Smtp-Source: AK7set/ODJy/URBkGr9o1ZrujcLOio1cN277qos2Je4uRqqkh3LXE+/ZO3mxrgcpuWIkys8l/g7l1oOcUMKyfOatV6E=
X-Received: by 2002:a17:907:9916:b0:886:2823:423e with SMTP id
 ka22-20020a170907991600b008862823423emr4321388ejc.284.1675552036974; Sat, 04
 Feb 2023 15:07:16 -0800 (PST)
MIME-Version: 1.0
References: <8df4ceec-663c-dc68-d775-5caeb02c0cca@gmail.com> <1ce888df-6096-73de-a98a-354d086428d4@gmail.com>
In-Reply-To: <1ce888df-6096-73de-a98a-354d086428d4@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 5 Feb 2023 00:07:06 +0100
Message-ID: <CAFBinCDqkz_fXV8JGOn=6Zph_MNU7q_1Qb67Jfd+u4o6Gj_3Jg@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: meson: adjust order of some compatibles
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
