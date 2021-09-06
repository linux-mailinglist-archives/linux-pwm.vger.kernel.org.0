Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D6C4018E9
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Sep 2021 11:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241166AbhIFJfp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Sep 2021 05:35:45 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:40709 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240959AbhIFJfp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Sep 2021 05:35:45 -0400
Received: by mail-vs1-f47.google.com with SMTP id d6so5057526vsr.7;
        Mon, 06 Sep 2021 02:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQFFfF/zEfdunIfsPpRNYvnpmnwxrhT5skPdL/QrZU8=;
        b=W1B7RPuakE6pG9YyfC80x9VEyYbatrqG9xKUxoeeN/jRgq3fuV0TNbqdP3KlGva6B/
         AhWFV4pFiPRszl92ZA/NQYJB+WBAEHdZ7FPsX3HKt0Kr4LQOq9k/XIzpIiAlYhmu0hTg
         W5U/bXCsfk4kOypu0+omkiJrFwixYB+0gLWVSp3MYXQq8ZcDSkYSkRi0OgLgDZv8TujK
         H0/awn9AvCm5skxMAfaAIU1iTmobD4UTWCdL5DpohhAUgwu5gDag6VU8NgmVFQWkGWE6
         Yhl8QQosl4WpWV7pnsAfBhYzYtdoxcsWTGscZ3iYtLcEXLrKwbU0J0kgr2fEPgttjEtO
         vTFg==
X-Gm-Message-State: AOAM530fAje6Ji225SMgl+qmjINiCvibSaD79xmal8m2oQAPgt+CNLAa
        a+bZ4/FLIWRHH1z+hLOaGKwyvbRFUB7cW4EtKrw=
X-Google-Smtp-Source: ABdhPJz1ocWeEFkxIrA9SNHJmT14JRHyWs9jv7d4wHGq6h4sdG80MQsns9XKDPBrWDGtZftTFUcboWsbGXKVMSXar4A=
X-Received: by 2002:a67:efd6:: with SMTP id s22mr5344207vsp.50.1630920880515;
 Mon, 06 Sep 2021 02:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210901090719.35375-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210901090719.35375-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Sep 2021 11:34:29 +0200
Message-ID: <CAMuHMdVPjuvTDXkvQVz0qwpdu-UQXd5yxZCNG6Fc5BoB1e-oyg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: tpu: Add R-Car V3U device tree bindings
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Sep 1, 2021 at 11:08 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> From: Duc Nguyen <duc.nguyen.ub@renesas.com>
>
> Add device tree bindings for TPU with the PWM controller found
> on R-Car V3U SoCs.
>
> Signed-off-by: Duc Nguyen <duc.nguyen.ub@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
