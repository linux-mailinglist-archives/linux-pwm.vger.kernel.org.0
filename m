Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F536E0074
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Apr 2023 23:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjDLVFn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Apr 2023 17:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjDLVFm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2023 17:05:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425C0729F
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 14:05:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id xi5so32200126ejb.13
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 14:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1681333532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yx+vB/vFq6CeEDIMJycMifvuE1xDIqS48HQvE/eryE=;
        b=Qg01jD89AN9DEqUwI45AgkzGAEraJv/t73p4UeXyfLGl6eqwFAt4Z3SnQF0GGE6yL7
         wD9ptD5SVqvSWx0+KQBVxbkBiu/Bor1PrkzytWeelfRfWG5KqKJBfc2m+0xqJNCpwB6c
         MifyxPNsKGVJRp100t+n6z0B0I3OvdcjbGqHyjnmehPw+Xl05U+nJpVVSjkSCpJs5p3B
         egAah7E6/6nQilItp4ROpXXAhyiiW5HovIqr7D86QaUvuCa4ltxoYtws39+JVbSgGkOE
         oS28FCChTFqNHvDgejeBY9WgyfArlASM+QqT97n54imsBJ3gLJ5lL86rcewaeSYps4cd
         d2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yx+vB/vFq6CeEDIMJycMifvuE1xDIqS48HQvE/eryE=;
        b=cTE+T354k4JOmDA1ib2P5wMjWhTrL6LYbVJBqhCiRkqvfRNV+pxTDds0AHY/bgu6bG
         jla+F/PNMaQxW3b2vMD6V8zvjIli/uSCvsk3GfSy7mVL5vc+zJZ5ZUdWiHBILVPITTpX
         sqUkIP7pq3BXg5W/aUqY/XC6nfvjSc+YP4uGBBE2jpZ7DACFIDWCwv2Jg0Cs9QBIdfpy
         bU05qAoST8lnWAtwXwhfXPV07zDb7UYEcUH8ixhoAv/lo1HplwRnR4y/v2AUd27AJs1f
         omAN8c09cm/NXJ+Iux7gjGG8y8pM++4Z8WSUwROgoYa5ogW4iDblhQ4fD2+P87DuGDXK
         mftg==
X-Gm-Message-State: AAQBX9dTVNOd6L4F+9EYlChDo+wwyVhkpTZ+DxwCO4+R0PhGD4hZE695
        YsKjSqgFC2loaejQhdlNFCk13x6lu8nDHIFTkDQ=
X-Google-Smtp-Source: AKy350a6P2vdQtyIEZIORfnHWwjfruvRmjlyRwvvvQmRWccXRwDTP/Lqq0y4ItwZ5z0aqymMWxQ4Gts38UGLXirzxS8=
X-Received: by 2002:a17:907:1c02:b0:932:4577:6705 with SMTP id
 nc2-20020a1709071c0200b0093245776705mr157384ejc.6.1681333532120; Wed, 12 Apr
 2023 14:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <29973c8a-2b14-3d0c-bee8-8aff36c265e3@gmail.com> <12d4fbc1-8ed4-637e-32ca-2c09d25d60a6@gmail.com>
In-Reply-To: <12d4fbc1-8ed4-637e-32ca-2c09d25d60a6@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 12 Apr 2023 23:05:21 +0200
Message-ID: <CAFBinCDME3=3dUx6K5iZHcr=tu6nh-Xm2NMn_VAiTcM_uZD_qQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] pwm: meson: make full use of common clock framework
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
> Newer versions of the PWM block use a core clock with external mux,
> divider, and gate. These components either don't exist any longer in
> the PWM block, or they are bypassed.
> To minimize needed changes for supporting the new version, the internal
> divider and gate should be handled by CCF too.
>
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
>
> I don't have hw with the old PWM block, therefore I couldn't test this
> patch. With the not yet included extension for the new PWM block
> (channel->clock directly coming from get_clk(external_clk)) I didn't
> notice any problem. My system uses PWM for the CPU voltage regulator
> and for the SDIO 32kHz clock.
>
> Note: The clock gate in the old PWM block is permanently disabled.
> This seems to indicate that it's not used by the new PWM block.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> #
meson8b-odroidc1, sm1-x96-air

Generally I'm very happy with this - only a few small questions/comments be=
low.

[...]
> +       state->enabled =3D __clk_is_enabled(channel->clk) && (value & tmp=
) =3D=3D tmp;
I was about to suggest that clk_hw_is_enabled() should be used instead
of __clk_is_enabled()
That would be easy for SoCs where the gate is part of the PWM IP. But
it would not work (at least I don't think that it would) work for the
newer IP that Heiner's described where the gate is part of the SoC's
clock controller (and thus outside the PWM controller registers). To
me this means that we need to keep __clk_is_enabled() here unless
somebody knows of a better approach.

The "(value & tmp) =3D=3D tmp" can now be simplified to !!(value &
BIT(channel_data->pwm_en_bit)) as we're now only checking a single bit
(previously we were checking two bits in one statement, so that more
complex check was needed).

[...]
> +               channel->gate.reg =3D meson->base + REG_MISC_AB;
> +               channel->gate.bit_idx =3D meson_pwm_per_channel_data[i].c=
lk_en_bit;
> +               channel->gate.hw.init =3D &init;
> +               channel->gate.flags =3D 0;
> +               channel->gate.lock =3D &meson->lock;
> +
> +               channel->clk =3D devm_clk_register(dev, &channel->gate.hw=
);
If I recall correctly Jerome previously suggested that I should use:
- devm_clk_hw_register() to initially register the clock
- then use (for example) channel->clk =3D devm_clk_hw_get_clk(dev,
&channel->gate.hw, "pwm0")

It's not the most common pattern (yet) but if I recall correctly this
is also what the CCF maintainers agreed to be the way forward.


Best regards,
Martin
