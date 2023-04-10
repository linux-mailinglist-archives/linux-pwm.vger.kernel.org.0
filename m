Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858C26DCE11
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Apr 2023 01:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjDJX2S (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 Apr 2023 19:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDJX2Q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Apr 2023 19:28:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E15C213D
        for <linux-pwm@vger.kernel.org>; Mon, 10 Apr 2023 16:27:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qa44so15732463ejc.4
        for <linux-pwm@vger.kernel.org>; Mon, 10 Apr 2023 16:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1681169274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52mSxp3d2SGZP6hWb61sFRa1KWoxrjnPGG+f5rToeBI=;
        b=n4W2GGXp5Tyq3bUY6CKzmVrqBW2JbGeAJh1kbAfEKfXvSJFgokbmZ0UliPgnGlar/b
         BdQbxF79jzKBpbCu2J/tRK0+ChvtZjC833b9/EGeMEgBGdfwFN+xr6/Ya8b3ezMMZeFC
         G+Z2bJwVUTmLKbVXjol5mCFuUzfRQ+f+jHIFPg/tUc0qfY+E5Mf0oPruxfevngKaZtXF
         0hxVHIcFJPPEMfgOH6CJTEU1Cb8+M/pMyXAGn+6A1uoK/Ibgc+HpdqWjkIQXAcSNw5pu
         FW4krzr17cQZSf3/uh7ERhoNcdrMM/F+Q0VxJy17EdtkDrgtwPNUkqBZxfmAm46mBbbG
         5+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681169274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52mSxp3d2SGZP6hWb61sFRa1KWoxrjnPGG+f5rToeBI=;
        b=yb/xV8oGFokt21g95fx1B+/E953JsosZ4lQ11znJU45SC6td2ukWMgBH22Pztydm2c
         96gU8ohR7gxddUX1DmX6d/+1/8upZu9R389Wvsu/IroyfMgxXcWekLJLfgeTH6HiV7ww
         hEwTwrZ/E6eksGTG9ZrbIfHJjtqDgIE2TCe10sM3J5ONV+c/N0H15tJNvaLfC4/cHD76
         DuBGvq1yQnHIF0gSOaQJa/dZFwqdrohH/oXSkOu9vY9HmuGRRhnEewc3OGExLGzZGihY
         4TwoD6r5RluZFXn+XpPhzz7R7B3aF1RlXqDI5sVoZZAd6H1b0/mw+d6Ve9950aA+QTnF
         fAWQ==
X-Gm-Message-State: AAQBX9dUXTe2nqqBph2njliZ3iuu0yjLSQ87Z8hGz//ooIoDrBPBNwAo
        FCHrSx/HaXHJ8c8e6D+w8rdLncVuzGLM6+AA3IZ2t7ag0S8=
X-Google-Smtp-Source: AKy350aTwPPRdnWCaxTzXduln+So6jSYYFDnuI5ZZZ7DxSB/ilfqNWJIVuSDWLVDZ0+uEZtC7/SxJR1ts8OysYy1NfA=
X-Received: by 2002:a17:907:8a0a:b0:949:d4ef:f6ff with SMTP id
 sc10-20020a1709078a0a00b00949d4eff6ffmr4785012ejc.0.1681169274267; Mon, 10
 Apr 2023 16:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <275c72a8-b9cb-e675-f1c0-4da658c3f98e@gmail.com> <08085ec6-0450-2477-e35f-5af19c1de857@gmail.com>
In-Reply-To: <08085ec6-0450-2477-e35f-5af19c1de857@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 11 Apr 2023 01:27:43 +0200
Message-ID: <CAFBinCCaca-VKmxv_SaPxOzBrix98Nj+VDaD1bfqSwvDBg+eKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pwm: meson: make full use of common clock framework
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

Hi Heiner,

On Sat, Apr 8, 2023 at 10:43=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
[...]
> +               init.name =3D name;
> +               init.ops =3D &clk_divider_ops;
> +               init.flags =3D CLK_SET_RATE_PARENT;
> +               parent_hws[0] =3D &channel->mux.hw;
> +               init.parent_hws =3D parent_hws;
> +               init.num_parents =3D 1;
There's a very subtle bug in this code:
You're re-using the same struct clk_init_data for all clocks.
The mux above sets
- init.parent_names
- init.num_parents
- (amongst others)

but for the divider and gate you're only overwriting init.num_parents,
which is why I end up with:
 xtal                                 8        8        1    24000000
        0     0  50000         Y
   [...]
   c1108650.pwm#gate1                1        1        0    24000000
       0     0  50000         Y
   c1108650.pwm#div1                 0        0        0    24000000
       0     0  50000         Y
   c1108650.pwm#mux1                 0        0        0    24000000
       0     0  50000         Y
   c1108650.pwm#gate0                1        1        0    24000000
       0     0  50000         Y
   c1108650.pwm#div0                 0        0        0    24000000
       0     0  50000         Y
   c1108650.pwm#mux0                 0        0        0    24000000
       0     0  50000         Y

My suggestion is to switch to struct clk_parent_data entirely (for the
mux this could be done with a separate commit before this one).
Then keep it consistent and don't mix parent_names/parent_hws and
parent_data (just stick to parent_data, which can manage the previous
two and more).
I *think* struct clk_parent_data can even be used to simplify the
second patch (by just having an "empty" entry - with index =3D -1 - in
the array).

[...]
> +               channel->gate.bit_idx =3D __ffs(meson_pwm_per_channel_dat=
a[i].clk_en_mask);
I's the only place where clk_en_mask is now used. So I think it's
valid to just rename clk_en_mask to clk_en_idx and pass the value
without the BIT macro during initialization.


Best regards,
Martin
