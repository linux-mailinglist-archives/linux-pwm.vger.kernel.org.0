Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9311435C40B
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 12:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbhDLKdg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 06:33:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238132AbhDLKdf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 12 Apr 2021 06:33:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F59061249;
        Mon, 12 Apr 2021 10:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618223597;
        bh=DI6Y5IaDG396+b13BKUebb20otLOdsYhFeHZfaDT9V4=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=X7jWGalE6o9E2WtBf29/CWgdQzpRBMTYxl+EbeZ2PjRhAHFbdbilQ48tXTFEzRnLP
         io3b5/xS/UQrSSGZ0uEH4LRw7+wm/iU1USYSmJbGajL71TGEg7ZO/vGl1zsgX8mj9v
         p6RBJDntm/0rpFYQSBjV8yGPZmEAjjt5LGIC2noL4X738OyZuH5UjSYnZ1t+174++H
         uPxyuHpwhH91Q2EFDsDJYeXsWsiE5yi3d81jPKLk1G6W/kU2lg0AJZhaR2Mc1w/EcU
         5F3CtPzWmSDLaO4+vIUk2tHTRoJqe24m0gszc85b5Yq3vQgOBy/TXImag0KzyxLQxC
         yc4uEBdiwzxKA==
Received: by mail-lj1-f175.google.com with SMTP id u20so14709292lja.13;
        Mon, 12 Apr 2021 03:33:17 -0700 (PDT)
X-Gm-Message-State: AOAM531OcGEsnjf3mV2HGbiOV3FnKYDITbPa0pabk1g/Ug0W+OH69S8R
        bB03h8FHzAANaP3x9kIc0e3ijbnmP5d15fru+c0=
X-Google-Smtp-Source: ABdhPJw4UvUUAcyRG4ixDjCJyFywXgHnShAa8N99RTa/8dJVp4vWCnF3DoBG5ylB2oKBUZnkwGZr8tJLGWeZ5bxiQks=
X-Received: by 2002:a2e:7d04:: with SMTP id y4mr18002872ljc.94.1618223595500;
 Mon, 12 Apr 2021 03:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210411131007.21757-1-jbx6244@gmail.com> <20210411131007.21757-3-jbx6244@gmail.com>
 <CAGb2v67s7a4GARfAnROKS40kaYQpdW_qWX=HX6GU09jV9wrbXw@mail.gmail.com> <31b5ff50-afe5-b446-7d3c-943d148814d8@gmail.com>
In-Reply-To: <31b5ff50-afe5-b446-7d3c-943d148814d8@gmail.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 12 Apr 2021 18:33:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v65+A402jCPVRJdDBdxqAEYOJmFTkKB4LJCvnW89hXb8QA@mail.gmail.com>
Message-ID: <CAGb2v65+A402jCPVRJdDBdxqAEYOJmFTkKB4LJCvnW89hXb8QA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] ARM: dts: rockchip: remove interrupts properties
 from pwm nodes rv1108.dtsi
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Apr 12, 2021 at 6:03 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
> On 4/12/21 5:15 AM, Chen-Yu Tsai wrote:
> > On Sun, Apr 11, 2021 at 9:11 PM Johan Jonker <jbx6244@gmail.com> wrote:
> >>
> >> A test with the command below gives this error:
> >>
> >> /arch/arm/boot/dts/rv1108-evb.dt.yaml:
> >> pwm@10280000: 'interrupts' does not match any of the regexes:
> >> 'pinctrl-[0-9]+'
> >>
> >> "interrupts" is an undocumented property, so remove them
> >> from pwm nodes in rv1108.dtsi.
> >>
> >> make ARCH=arm dtbs_check
> >> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> >>
> >> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> >
> > Given that the interrupts were specified, meaning they are wired up in hardware,
> > shouldn't the solution be to add the interrupts property to the binding instead?
> >
> > After all, the device tree describes the actual hardware, not just what the
> > implementations need.
> >
> > ChenYu
> >
>
> Hi,
>
> The question of what to do with it was asked in version 1, but no answer
> was given, so I made a proposal.
> The device tree description should be complete, but also as lean as
> possible. If someone manages to sneak in undocumented properties without
> reason then the ultimate consequence should be removal I think.
>
> Not sure about the (missing?) rv1108 TRM, but for rk3328 the interrupt
> is used for:
>
> PWM_INTSTS 0x0040 W 0x00000000 Interrupt Status Register
>   Channel Interrupt Polarity Flag
>     This bit is used in capture mode in order to identify the
>     transition of the input waveform when interrupt is generated.
>   Channel Interrupt Status
>     Interrupt generated
>
> PWM_INT_EN 0x0044 W 0x00000000 Interrupt Enable Register
>   Channel Interrupt Enable
>
> Is there any current realistic use/setup for it to convince rob+dt this
> should be added to pwm-rockchip.yaml?

Well, the PWM core has capture support, and pwm-sti implements it with
interrupt support, so I guess there's at least a legitimate case for
adding that to the binding. Whether someone has an actual use case for
it and adds code to implement it is another story.

> The rk3328 interrupt rkpwm_int seems shared between channels, but only
> included to pwm3. What is the proper way for that?

I guess the bigger question is why was the PWM controller split into
four device nodes, instead of just one encompassing the whole block.
Now we'd have to introduce a new binding to support capture mode and
interrupts.

In that case I agree with dropping the interrupts for now, as it just
won't fit. But I would add this additional information to the commit
message.


Regards
ChenYu
