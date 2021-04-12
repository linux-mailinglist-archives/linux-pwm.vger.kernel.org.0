Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA55835B8D6
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 05:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbhDLDQD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Apr 2021 23:16:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235229AbhDLDQD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 11 Apr 2021 23:16:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFF2C6120C;
        Mon, 12 Apr 2021 03:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618197346;
        bh=MEBeMSZwCLiNgtETaZdBAHcB6oSiuhP7OTq68o+q6qU=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=AsixbbEfcJQeCUBLhHHdSKb4PsstJcAjesgFqQSgsFfoutKECCR4Eaxp1XEQ9J4MA
         UpncmUnFRscfoXy9LObT8q5ZtMr00QUTYo5HqsA51O4xxcnUFgycv8ukBAJ5kFwvfW
         GCdyem1GHPp0ihDFB2JDxIlJo6h9TCeoEphym4XnjjKYbXr1+DB/tf3/nn4/FIgsrp
         5KZhWuPZBY5UzZ6L04IG4wzh7/FHm/HK7NcQFTzGO3VU/e5qqW2epzr/SWXh1M8eKr
         KEfd/QXi92cRRaJnwMRfay1AmRuKd8B6DLQjxLIW43EzBCca9X45Xck6pqrw9kaOHE
         l3+6JLRj3CCMg==
Received: by mail-lj1-f176.google.com with SMTP id a36so2722916ljq.8;
        Sun, 11 Apr 2021 20:15:45 -0700 (PDT)
X-Gm-Message-State: AOAM532rxptN0jr3QjYBlmz38QYBe9WQVVCeUHXPk3sRT6g5+zZgk+yL
        3BhKQsSkbTeUM1jmANC7MkIS9HVWtmUm67Dw8OU=
X-Google-Smtp-Source: ABdhPJxY40eVzTueYOpnHIuI8SLf2FP95b6CadyqCzVZkmgU4iiNPf4qkbkYSduLZMay54CJOUuttMeYEXCIdAuFf4o=
X-Received: by 2002:a2e:2f03:: with SMTP id v3mr11027054ljv.463.1618197344265;
 Sun, 11 Apr 2021 20:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210411131007.21757-1-jbx6244@gmail.com> <20210411131007.21757-3-jbx6244@gmail.com>
In-Reply-To: <20210411131007.21757-3-jbx6244@gmail.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 12 Apr 2021 11:15:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v67s7a4GARfAnROKS40kaYQpdW_qWX=HX6GU09jV9wrbXw@mail.gmail.com>
Message-ID: <CAGb2v67s7a4GARfAnROKS40kaYQpdW_qWX=HX6GU09jV9wrbXw@mail.gmail.com>
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

On Sun, Apr 11, 2021 at 9:11 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
> A test with the command below gives this error:
>
> /arch/arm/boot/dts/rv1108-evb.dt.yaml:
> pwm@10280000: 'interrupts' does not match any of the regexes:
> 'pinctrl-[0-9]+'
>
> "interrupts" is an undocumented property, so remove them
> from pwm nodes in rv1108.dtsi.
>
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Given that the interrupts were specified, meaning they are wired up in hardware,
shouldn't the solution be to add the interrupts property to the binding instead?

After all, the device tree describes the actual hardware, not just what the
implementations need.

ChenYu
