Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4776E2A1F
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Apr 2023 20:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDNSdn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Apr 2023 14:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDNSdm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Apr 2023 14:33:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F534EDD
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 11:33:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id rp27so10846282ejb.12
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1681497219; x=1684089219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIf6PYuTjDTDHZxGxsSMTjaI/J6LADqJdodTRE67zC4=;
        b=BWz02PudPMpPBmM3O7sRMjTt+Erp3EezqseLR6UBuN2fYZMcS2FlW71o3bAAYmsGwQ
         eElZGlGM5DnW4Um2jxqed5mn7CA/JIWIULrCSSNBruZOGqVholmRgo/1NPNrobho3CX5
         1sQAY43kep/S5g21zAsYkKKPAmeGu+/DvnOmDwWiqRJuTBIguMjBR1zVAdtk5S6J1L/9
         3gZB+MX55jAjRuSgzxfHutPh7DLsYWkOn4iE85AQo1iGbtUqH5daEL6HkDJy2WA9V+v4
         THZDWGDTOs/uZI1jJO+LJLyHDd5Fx7ooOVxej/OFCzM6OJLGbF+M15wHkc8pfUCOkrqN
         QTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681497219; x=1684089219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIf6PYuTjDTDHZxGxsSMTjaI/J6LADqJdodTRE67zC4=;
        b=Ajy8LgV56HNXfnY5mJhcavM/Ou/i01xeLVlnRmeezdcs2pjXpkZ9qlRIe/urlQpE5c
         hneuJT3qX/nKDzQS+OgO/w3Y2ls08FIAF9ECShIQD6IFkAEaOB0WyMXm0Kv4Z17NHDDF
         hnzIIRMaZuo1BwkyyuL0blMVonGtZQoDOF4GBjEwoyQPxch/jiACfM9i0ky6rI6nfKgT
         UKR1Eb5fZ7APJZfvCs13G/hAm56tIV8KccGfa/P3tkr8+f+Ca0EDDpA8Ax8wnxVWmt/G
         SPKuMZFqKM9fEpSIExIZPUisav3m1P4lnojgjRIR84GdAbT0777CjyRW77kA+BI5bI2Q
         14Qw==
X-Gm-Message-State: AAQBX9cBdFkFQJXzfFCmFSJuBqKdFGB0TiebxSQSK0tbFiFsK8zVzEUv
        XgRvdwdYZMp0e2akODWuuXf5ABEjxpY5CgCRqxk=
X-Google-Smtp-Source: AKy350YLXEmAtJNKJkWEz0hfaThJ0i/fMSrBL73kyK/Fo8i+L6Gtxeq6N1a2coyzpmofmBTresfqmpVzK2LvD4vlm/o=
X-Received: by 2002:a17:906:af05:b0:933:1b05:8851 with SMTP id
 lx5-20020a170906af0500b009331b058851mr78793ejb.16.1681497219400; Fri, 14 Apr
 2023 11:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <0f087629-810d-f0e0-bf0b-05ca5defc16d@gmail.com>
 <05e3b9de-ee38-97b6-7f39-5b6f7de1674f@gmail.com> <CAFBinCAdXE+3VrPJAoik_0TFW6TsB0033s+fTYUTNehPrn=PZg@mail.gmail.com>
 <ZDfHtvZawSWWGTRP@orome>
In-Reply-To: <ZDfHtvZawSWWGTRP@orome>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 14 Apr 2023 20:33:28 +0200
Message-ID: <CAFBinCBNA_AWy63P9RwSU98xNJ1-F8KHJWm9Dq1kmrZ7aFbpJw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] pwm: meson: make full use of common clock framework
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Thierry and Heiner,

On Thu, Apr 13, 2023 at 11:13=E2=80=AFAM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> On Tue, Apr 11, 2023 at 09:48:46PM +0200, Martin Blumenstingl wrote:
> > On Tue, Apr 11, 2023 at 9:26=E2=80=AFPM Heiner Kallweit <hkallweit1@gma=
il.com> wrote:
> > [...]
> > > +               init.name =3D name;
> > > +               init.ops =3D &clk_gate_ops;
> > > +               init.flags =3D CLK_SET_RATE_PARENT;
> > As much as I don't want it: I think we need CLK_IGNORE_UNUSED here as w=
ell :-(
> > On GXBB, GXL and GXM SoCs the board design typically uses PWM
> > regulators (like the boards using 32-bit SoCs as well as newer boards
> > using G12A or later SoCs).
> > This means: if we enable that PWM controller and one of the channels
> > is firmware managed and the other isn't then we can end up disabling
> > the clock - taking away VCCK (which supplies the CPU) or VDDEE (which
> > supplies GPU and various other components).
> > I'd be happy if there are other suggestions around this though.
>
> What exactly does "firmware managed" mean? Typically we describe all
> supplies in DT to avoid these kinds of workarounds. If VCCK and/or VDDEE
> are PWM-controlled regulators that should never be turned off, can they
> not simply be added to device tree and marked as "always-on"? That would
> propagate to the PWM and make sure the corresponding clock remains
> enabled.
Most Amlogic boards use PWM-controlled regulators. There's three SoC
generations I know of that are "special" when it comes to managing
these regulators (and CPU clocks) though.
Let's start with the simple ones: Meson8/8b/8m2, G12A, G12B, SM1 (and
I assume newer generations as well): here the PWM regulators are
managed by Linux.
Then there's the special cases: GXBB, GXL and GXM which run a SCPI
firmware for managing the CPU clocks, regulators and suspend.

SCPI firmware is running in the "secure world", while Linux is running
in the "normal world".
I don't know if there's boards with secure boot that lock Linux out
from the PWM and CPU clock registers.
This means: so far we've left any PWM controller settings that relate
to the regulators up to the SCPI firmware, not messing with any of the
registers from Linux.

My concern is for example with the Khadas VIM2, see it's schematics [0] pag=
e 4:
- PWM_C is used to manage the VDDEE regulator (I suspect that there's
a typo though and it should be called VDDEE_PWM_C, but the schematics
state that the signal is called "VDDEE_PWM_D")
- PWM_D can routed to the GPIO headers
Now if a user enables &pwm_cd (the PWM controller responsible for
channel PWM_C and PWM_D) to use PWM_D on the pin header we don't want
to turn off PWM_C by accident.
Turning PWM_C off by accident can happen if we register the clock gate
and don't have a consumer for it. CCF (common clock framework) can
then just turn off that clock because it's unused. This would lock up
the board because VDDEE is used for critical functionality on the SoC.

Two extra questions from Heiner:
> I check regarding Thierry's comment and found the vddcpu
> pwm-regulators described in the DT's. Is your concern that
> not for all boards the vddcpu pwm-regulator is described in
> the DT?
Correct, boards that have the pwm-regulators described in their .dts
(typically the boards using a Meson8/8b/8m2, G12A, G12B or SM1 SoC)
are not a problem.
Only the ones that don't describe the pwm-regulators in their .dts are
an issue as these are managed by the SCPI firmware.

> AFAICS pwm channels are independent. How can switching
> off the clock for one channel affect the other channel?
It's not about one channel affecting the other. My thought is that
CCF's "disabled unused clocks" feature will turn off the clock if it's
not used. Since SCPI firmware uses it, Linux doesn't know that CCF may
disable the clock unless CLK_IGNORE_UNUSED is set.

I hope this makes sense. If you have any additional questions then
feel free to ask.


Best regards,
Martin


[0] https://dl.khadas.com/products/vim2/schematic/vim2_sch_v12.pdf
