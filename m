Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8839D6D52FD
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Apr 2023 23:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjDCVBj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Apr 2023 17:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjDCVBi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Apr 2023 17:01:38 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70282D71
        for <linux-pwm@vger.kernel.org>; Mon,  3 Apr 2023 14:01:35 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eh3so122481710edb.11
        for <linux-pwm@vger.kernel.org>; Mon, 03 Apr 2023 14:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1680555694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1nokc9Y7TFTktzS0k9VBrHIX76o3+AsbuMOReWuMeQ=;
        b=hjvCmVvrQkA0+CTIwn5CBKxYc7pO5Zs+jBdXF3gSK8TcuXnObz7doXpWCpGoPuLk/S
         O02rnOt41ichiKGaSqcp4iVreBvJW/vxGr2fHqz+S3SEqAE1SdAzbza6W62EQ3cJTa+7
         NezjWCYz/ZS8B4hf0wUXGJrNMJCs5CxP+S9J0O0vMN9DKwkhwzeIeJmvIDHUTu5iRW+V
         LLQ8dFavc00tFh3+gJZXshZP0tZ0+d6Evg20qw/1OK+Gkq97ry7QPjKCeTkmwQLaPG1n
         ZDB63lJnjy6CTl9XopMwvTaTy66q+QZ2kQmuB9W4KRsaPkG0tTCKZpJev0rXeAvajlkR
         nuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680555694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1nokc9Y7TFTktzS0k9VBrHIX76o3+AsbuMOReWuMeQ=;
        b=WaQfpCuwKzVvAIKHguZv1mMJc0D9NoeX8hHoryJzRkHzMzwqnfvoL/YDFwNCdaOppp
         3BPHBtoAta9I4bUhRzzY3/Lucgx3rSk0oHk9BLoN/BaQ1HAkgcKefwPOQkgY/99IjJN/
         GiBysTUiW8W19O5pXhDphTedgh4nE+Wv7enI1K3s8kVGHUMWWe0D8QmtNs9tDUT24x1B
         fwrOUUWHok/QOVp0iRwQEhh1ySh7xTzfkcXq6cpezpViFa6X23X9t86/aingFgsVzOgW
         82zmIJpvEgW46jOt0Q6mKE+gTRLpjw3BivfiAK9WTzfKHL6f9eSM0kciuaAz3igW4lSi
         OUOg==
X-Gm-Message-State: AAQBX9cyyKMK9XL9PWMlKaD9Dvm+TfZsHNV/7R9QSpRrUScqcDRYnZsX
        IIPh+rsIiAjOrcvEqU2qd1bS0YSCCH+kc7ZQ3DI=
X-Google-Smtp-Source: AKy350ZrjMX8TvrP/gz2A/Lhmq7tXSB6K2clgxna2vUnVNV6LsNxmdSZNVlJcN0WfA9u6651pqIPMnD2SKaLhvzJx70=
X-Received: by 2002:a50:9f47:0:b0:502:1f98:e14c with SMTP id
 b65-20020a509f47000000b005021f98e14cmr286145edf.4.1680555693913; Mon, 03 Apr
 2023 14:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <abf03223-5745-0c79-7840-176c551134c5@gmail.com>
In-Reply-To: <abf03223-5745-0c79-7840-176c551134c5@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 3 Apr 2023 23:01:22 +0200
Message-ID: <CAFBinCBvubso9G3hrJxCumFYcn1ggZhpsJsLA9Qehas4PH5RoQ@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT] pwm: meson: make full use of common clock framework
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
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Heiner,

On Tue, Mar 28, 2023 at 10:59=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.=
com> wrote:
>
> Newer versions of the PWM block use a core clock with external mux,
> divider, and gate. These components either don't exist any longer in
> the PWM block, or they are bypassed.
> To minimize needed changes for supporting the new version, the internal
> divider and gate should be handled by CCF too.
That sounds like a good way forward to me

> I didn't see a good way to split the patch, therefore it's somewhat
> bigger. What it does:
>
> - The internal mux is handled by CCF already. Register also internal
>   divider and gate with CCF, so that we have one representation of the
>   input clock: [mux] parent of [divider] parent of [gate]
>
> - Now that CCF selects an appropriate mux parent, we don't need the
>   DT-provided default parent any longer. Accordingly we can also omit
>   setting the mux parent directly in the driver.
>
> - Instead of manually handling the pre-div divider value, let CCF
>   set the input clock. Targeted input clock frequency is
>   0xffff * 1/period for best precision.
>
> - For the "inverted pwm disabled" scenario target an input clock
>   frequency of 1GHz. This ensures that the remaining low pulses
>   have minimum length.
Unfortunately I didn't have much time today so I didn't get to reviewing th=
is.

> I don't have hw with the old PWM block, therefore I couldn't test this
> patch. With the not yet included extension for the new PWM block
> (channel->clock directly coming from get_clk(external_clk)) I didn't
> notice any problem. My system uses PWM for the CPU voltage regulator
> and for the SDIO 32kHz clock.
>
> Note: The clock gate in the old PWM block is permanently disabled.
> This seems to indicate that it's not used by the new PWM block.
>
> I'd appreciate testing on the different platforms using the old
> PWM block.
I have tested basic functionality on a X96 Air (SM1 SoC, the version
with Gbit/s PHY) where the VDDCPU regulator is PWM based and the 32kHz
clock for wifi is generated by the PWM controller.
The RTL8822CS SDIO wifi card is still working (firmware download,
basic connectivity and connecting to an AP) and the system survived a
minute of 100% CPU usage without hanging.

For reference:
# cat /sys/kernel/debug/pwm
platform/ffd19000.pwm, 2 PWM devices
pwm-0   (wifi32k             ): requested enabled period: 30518 ns
duty: 15259 ns polarity: normal
pwm-1   ((null)              ): period: 0 ns duty: 0 ns polarity: normal

platform/ff807000.pwm, 2 PWM devices
pwm-0   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
pwm-1   ((null)              ): period: 0 ns duty: 0 ns polarity: normal

platform/ff802000.pwm, 2 PWM devices
pwm-0   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
pwm-1   (regulator-vddcpu    ): requested enabled period: 1500 ns
duty: 1125 ns polarity: normal

# grep \.pwm /sys/kernel/debug/clk/clk_summary
               ffd19000.pwm#mux0       1        1        0   648999985
         0     0  50000         Y
                  ffd19000.pwm#div0       1        1        0
648999985          0     0  50000         Y
                     ffd19000.pwm#gate0       1        1        0
648999985          0     0  50000         Y
   ffd19000.pwm#mux1                 0        0        0    24000000
       0     0  50000         Y
      ffd19000.pwm#div1              0        0        0    24000000
       0     0  50000         Y
         ffd19000.pwm#gate1          0        0        0    24000000
       0     0  50000         N
   ff807000.pwm#mux1                 0        0        0    24000000
       0     0  50000         Y
      ff807000.pwm#div1              0        0        0    24000000
       0     0  50000         Y
         ff807000.pwm#gate1          0        0        0    24000000
       0     0  50000         N
   ff807000.pwm#mux0                 0        0        0    24000000
       0     0  50000         Y
      ff807000.pwm#div0              0        0        0    24000000
       0     0  50000         Y
         ff807000.pwm#gate0          0        0        0    24000000
       0     0  50000         N
   ff802000.pwm#mux1                 1        1        0    24000000
       0     0  50000         Y
      ff802000.pwm#div1              1        1        0    24000000
       0     0  50000         Y
         ff802000.pwm#gate1          1        1        0    24000000
       0     0  50000         Y
   ff802000.pwm#mux0                 0        0        0    24000000
       0     0  50000         Y
      ff802000.pwm#div0              0        0        0    24000000
       0     0  50000         Y
         ff802000.pwm#gate0          0        0        0    24000000
       0     0  50000         N

hdmi_pll is the parent of ffd19000.pwm#mux0 - before it was using the
24MHz XTAL.
I haven't tested what happens when I change the video mode (that board
is currently not connected to any HDMI screen).

Later this week I can also try this e.g. on my Odroid-C1 (with 32-bit
Meson8b SoC) to verify that we don't have any 32-bit compatibility
issues.


Best regards,
Martin
