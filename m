Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9AA98CD36
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 09:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbfHNHwK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 03:52:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36574 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfHNHwK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Aug 2019 03:52:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id k18so48143462otr.3
        for <linux-pwm@vger.kernel.org>; Wed, 14 Aug 2019 00:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A3FwTQnzXQxQ1tn9puJCL/AccobFRlvOfxXdkmMzNAc=;
        b=ZF66mpLco25PsHUC0Z45Wlas+FiEdMC3mkgmrVy7hzyZGD5YPGjRWRW1CYEAkiei3o
         46MauRHGSRVvFr9uDrdyzuKzaFAtK1YqNdWoJdiF3XHZ+1Rta3dPk3igQlqu+duPJs7n
         pT80bDQF5HDD8IX56+4VUF/v8Pg6dMuY7ZPET0yDJMT3YfA0BVCa7nSlfVRHP5JtFCvC
         71KJPTmobIYH+qGf7HtfsXqHWq3CCGo7joebkNOymI+b3mCibWaoTa3dX4t8ntJR6FiC
         Alqfy5mLpEQmKRBdzxyOMjLhVRupV+nTad5JKv5YELt2yEsfraOg4wsExz6ZM0nd9jj6
         BkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A3FwTQnzXQxQ1tn9puJCL/AccobFRlvOfxXdkmMzNAc=;
        b=hWPC7sX5EuVm0QcdEXXk7sXrsVndstxKz1L60Skj2yQZE2+JMppw3SexCdnNKy+CSU
         6nU7BJqHHT4Yr92uwk89+CHyCV1Bgp4GdcHIS4i91eO9qvnQCk0Y7fEvd7hVJe1oNyGP
         ErEoE2Ys9UbF5bleV1g+U9lzXzKu0DMnyiKj0Tgfr4KRqh5MvLdrlzExuavNJCOmhHOr
         OEXqb8UyKJO6qvHI3l/sLAlXl8JmLWEyzM9RkX1Xsy1g3HRZy8q200LXMwRAYUNOxsJO
         tqMRzLz2HHvTD47oy8yqVwbalNiOINnCHocysU9DhzblWuJ3y5ywVQ1CKY/nh4I1QsSA
         lNYQ==
X-Gm-Message-State: APjAAAUQ2i/N07sR1zOwHryYMp6Pzm/Wn+gd+EolXobTplPhYVF1nosK
        4+9sgXG94VJd4yKhpPSGLNyqDZxeOwYP5yLoCx0/PA==
X-Google-Smtp-Source: APXvYqwrX6eHcXHI70cXxsMFdQLH7Cii35FC5m0TSKZOvb6P4BNQxKbxI0LV5NtKmv0hV1QJkvyKm0Ux1HO9+tNcy3g=
X-Received: by 2002:a05:6830:1e05:: with SMTP id s5mr22188129otr.247.1565769128779;
 Wed, 14 Aug 2019 00:52:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6a:0:0:0:0:0 with HTTP; Wed, 14 Aug 2019 00:52:08 -0700 (PDT)
In-Reply-To: <20190814073939.ubgzysmkmmel5h4y@pengutronix.de>
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <20190813141256.jnbrfld42rtigek3@pengutronix.de> <CAMz4kuJA+a=nzFRja4wRkfJu3Gzb0wnvaM8H4Ek9X5u8CNegPg@mail.gmail.com>
 <20190814070121.o53tj2mtky4hcy3n@pengutronix.de> <CAMz4ku+55O6ORVM9xDv4R954QG4PXV8EkcGypSTB5wKni+Dq+Q@mail.gmail.com>
 <20190814073939.ubgzysmkmmel5h4y@pengutronix.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 14 Aug 2019 15:52:08 +0800
Message-ID: <CAMz4ku+Q7CV+0dP1P0hAPJR7KiG0HOkZbT_LPXY4Q03hMuvS8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: sprd: Add Spreadtrum PWM documentation
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 14/08/2019, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote=
:
> On Wed, Aug 14, 2019 at 03:25:53PM +0800, Baolin Wang wrote:
>> Hi Uwe,
>>
>> On Wed, 14 Aug 2019 at 15:01, Uwe Kleine-K=C3=B6nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> >
>> > Hello Baolin,
>> >
>> > On Wed, Aug 14, 2019 at 09:51:34AM +0800, Baolin Wang wrote:
>> > > On Tue, 13 Aug 2019 at 22:13, Uwe Kleine-K=C3=B6nig
>> > > <u.kleine-koenig@pengutronix.de> wrote:
>> > > > On Tue, Aug 13, 2019 at 09:46:40PM +0800, Baolin Wang wrote:
>> > > > > +- assigned-clock-parents: The phandle of the parent clock of PW=
M
>> > > > > clock.
>> > > >
>> > > > I'm not sure you need to point out assigned-clocks and
>> > > > assigned-clock-parents as this is general clk stuff. Also I wonder
>> > > > if
>> > > > these should be "required properties".
>> > >
>> > > I think I should describe any properties used by PWM node, like
>> > > 'clocks' and 'clock-names' properties, though they are common clock
>> > > properties.
>> >
>> > Then you might want to describe also "status", "assigned-clock-rates",
>> > "pinctrl-$n", "pinctrl-names", "power-domains", "power-domain-names"
>> > and
>> > probably another dozen I'm not aware of.
>>
>> We usually do not describe 'status', but if your device node used
>> "pinctrl-$n", "pinctrl-names" ... common properties, yes, you should
>> describe them to let users know what is the purpose of these
>> properties. That's also asked by DT maintainer Rob.
>
> Does this convince you that you should also describe "pinctrl-$n" and
> the others? If not, why not? We also usually don't describe

Our PWM device node did not use "pinctrl-$n" things, why I should
describe "pinctrl-$n"?
If some devices use pinctrl, yes, they should describe what is the
purpose of pinctrl, see:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Do=
cumentation/devicetree/bindings/mmc/sdhci-sprd.txt

> assigned-clock-parents. For me these are all in the same catagory:

Lots of dt bindings describe 'assigned-clock-parents',:
./Documentation/devicetree/bindings/display/msm/dsi.txt
./Documentation/devicetree/bindings/display/msm/dsi.txt
./Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.txt
./Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
./Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
./Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
./Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
./Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
./Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
./Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
......

> Common properties supported for each devicetree node that represents a
> device. The only difference is that on your board you make use of some
> but not some others.

Fine, let's decide this by PWM maintainer or DT maintainer Rob.

>
>> > > Yes, they are required. Thanks for your comments.
>> >
>> > required in which sense? Why can a Spreadtrum PWM not work when the
>> > clock parents are unspecified?
>>
>> On some Spreadtrum platforms, the default source clock of PWM may not
>> be enabled, so we should force users to select one available source
>> clock for PWM output clock.
>
> Sounds like a bug in the clk tree of your SoC that shouldn't affect how
> the PWM is described in the device tree. After all a parent of a clock
> is supposed to become enabled when the clock gets enabled.

That's not a bug, that's like a MUX, the default source clock of PWM
can be disabled, since we usually do not use the default source clock.
Then we can select a available source clock by the MUX.

--=20
Baolin Wang
Best Regards
