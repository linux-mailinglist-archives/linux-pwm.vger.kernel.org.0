Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE5848CFB0
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 11:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfHNJdj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 05:33:39 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43573 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfHNJdi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Aug 2019 05:33:38 -0400
Received: by mail-oi1-f193.google.com with SMTP id y8so2801140oih.10
        for <linux-pwm@vger.kernel.org>; Wed, 14 Aug 2019 02:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z3K6SWbM7px/n5gKPd1KAWBDHaZFHlu80p3kmOyIsGk=;
        b=d5M3AT10QcaE7MW1oMDKR9t9+SJhHwYmI4wyXzGa6u8kTuQJ2fz0Y6ZFc1IPaSYI+H
         9ZJy6KfMqLRUZUr7VV+VT9Pw8SyGRSPCyfr3VPQK4md+tHyBnNxu8YDTn6tqKBp3i07D
         HWyyJApnaXXy2mP4zvZTutjZ+XEF9r5rcZkTAn0DahAMcGIZgjk8Vg+DSq8LDoylOcao
         kejK0ZDomi4vfug+XWSYPo7TgfdO6rOiRQ5KnESGZPp1PQg/06SL60a8f8x1oKa8HqWm
         PHOK8SpzduqrAgAr+DD4KtSl43THXSMebzoTQeV/I+0+5oBkUSLjdohxyEUq7Glea9JQ
         g56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z3K6SWbM7px/n5gKPd1KAWBDHaZFHlu80p3kmOyIsGk=;
        b=V1yq2KIwXEvSP4KJAJAkokhgJhmv+FxJNf9W2B5bSK3j3YkzLzALCA4G/DV59tFYlZ
         1qoQUHakx1pb6vamvpZSQTs1QbbNJAO1DpjZo48L1THEOPkVaIBp7COWW424AyjNALf8
         knSJ70ryf2Phgu0MMf9uryQB1VvkbaSRWVtyn2VkrsTPVqPxGs/o7Lr+7v7nzduZnVRO
         /MHruvOlW/pIZ4Izfdvi1DA/gVS0XL1TerG+bM0c/JVeam8EJcGOM0Oe0nw93oj66IG3
         igAwF6pVERs02z8N2EnYxzb/CLV2GBlNgcC0zmpY6Wq6TFvA04C3ZBncG7uIeTF/TUSB
         n9SQ==
X-Gm-Message-State: APjAAAV/qz14sETnf+cON5+iprk6hH0MZjO/lyjahrY3uCX9LUaNoMjW
        PAATALpcEURxRfuwrgPasPffoXZ1hqRGEMF5eSyO9w==
X-Google-Smtp-Source: APXvYqx6uqGsIpp0vjayRb0X/q7brAjdHSmV4gh1mkY/a93D75pf4MXvYlguFjUiakwqoDw0MmG63UPVYNApBX/6vRc=
X-Received: by 2002:aca:6056:: with SMTP id u83mr4713522oib.27.1565775217355;
 Wed, 14 Aug 2019 02:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <20190813141256.jnbrfld42rtigek3@pengutronix.de> <CAMz4kuJA+a=nzFRja4wRkfJu3Gzb0wnvaM8H4Ek9X5u8CNegPg@mail.gmail.com>
 <20190814070121.o53tj2mtky4hcy3n@pengutronix.de> <CAMz4ku+55O6ORVM9xDv4R954QG4PXV8EkcGypSTB5wKni+Dq+Q@mail.gmail.com>
 <20190814073939.ubgzysmkmmel5h4y@pengutronix.de> <CAMz4ku+Q7CV+0dP1P0hAPJR7KiG0HOkZbT_LPXY4Q03hMuvS8A@mail.gmail.com>
 <20190814084929.q3uy7cpf4ullpevo@pengutronix.de>
In-Reply-To: <20190814084929.q3uy7cpf4ullpevo@pengutronix.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 14 Aug 2019 17:33:25 +0800
Message-ID: <CAMz4kuLFeg2OyzgxZLp4Ks5ucTptOBTrxod5yVFXQ+q8ttKjcw@mail.gmail.com>
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
        LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 14 Aug 2019 at 16:49, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Wed, Aug 14, 2019 at 03:52:08PM +0800, Baolin Wang wrote:
> > On 14/08/2019, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> w=
rote:
> > > On Wed, Aug 14, 2019 at 03:25:53PM +0800, Baolin Wang wrote:
> > >> On Wed, 14 Aug 2019 at 15:01, Uwe Kleine-K=C3=B6nig
> > >> <u.kleine-koenig@pengutronix.de> wrote:
> > >> > On Wed, Aug 14, 2019 at 09:51:34AM +0800, Baolin Wang wrote:
> > >> > > On Tue, 13 Aug 2019 at 22:13, Uwe Kleine-K=C3=B6nig
> > >> > > <u.kleine-koenig@pengutronix.de> wrote:
> > >> > > > On Tue, Aug 13, 2019 at 09:46:40PM +0800, Baolin Wang wrote:
> > >> > > > > +- assigned-clock-parents: The phandle of the parent clock o=
f PWM
> > >> > > > > clock.
> > >> > > >
> > >> > > > I'm not sure you need to point out assigned-clocks and
> > >> > > > assigned-clock-parents as this is general clk stuff. Also I wo=
nder if
> > >> > > > these should be "required properties".
> > >> > >
> > >> > > I think I should describe any properties used by PWM node, like
> > >> > > 'clocks' and 'clock-names' properties, though they are common cl=
ock
> > >> > > properties.
> > >> >
> > >> > Then you might want to describe also "status", "assigned-clock-rat=
es",
> > >> > "pinctrl-$n", "pinctrl-names", "power-domains", "power-domain-name=
s"
> > >> > and
> > >> > probably another dozen I'm not aware of.
> > >>
> > >> We usually do not describe 'status', but if your device node used
> > >> "pinctrl-$n", "pinctrl-names" ... common properties, yes, you should
> > >> describe them to let users know what is the purpose of these
> > >> properties. That's also asked by DT maintainer Rob.
> > >
> > > Does this convince you that you should also describe "pinctrl-$n" and
> > > the others? If not, why not? We also usually don't describe
> >
> > Our PWM device node did not use "pinctrl-$n" things, why I should
> > describe "pinctrl-$n"?
>
> The binding you implemented supports "pinctrl-$n". And this is described
> somewhere in the generic pinctrl binding docs. The same applies to
> "assigned-clock-parents".
>
> That you happen to use assigned-clock-parents but not pinctrl-$n on the
> board you used to develop your driver is a detail that IMHO shouldn't
> decide about being listed in the binding doc for your PWM type.
>
> > If some devices use pinctrl, yes, they should describe what is the
> > purpose of pinctrl, see:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
>
> I agree that if the driver assumes special pinctrl names this is worth
> mentioning. If however there is nothing special and just some generic
> stuff is used that is described in some other location then I'd chose to
> not add this redundant information to the binding document. So if I
> reviewed the patch that created
> Documentation/devicetree/bindings/mmc/sdhci-sprd.txt I would have
> suggested to drop "assigned-clocks" and "assigned-clock-parents" there,
> too.
>
> > > assigned-clock-parents. For me these are all in the same catagory:
> >
> > Lots of dt bindings describe 'assigned-clock-parents',:
> > ./Documentation/devicetree/bindings/display/msm/dsi.txt
> > ./Documentation/devicetree/bindings/display/msm/dsi.txt
> > ./Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.txt
> > ./Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
> > ./Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
> > ./Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
> > ./Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
> > ./Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
> > ./Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
> > ./Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
> > ......
>
> I didn't check each of them, but I assume the same applies here, too.
> Please don't copy blindly but think before using other people's stuff as

I did not  copy blindly.

> reference. Even in the Linux kernel where reviews seem and are told to
> catch non-optimal stuff, there are places where this doesn't work. IMHO
> the key question is: Does it add value to describe "assigned-clocks" in
> the binding for your PWM device given that you're only using this
> generic and well documented construct?

I just want to remind users that they should set the parent clock for
PWMs, otherwise the PWM source clock can be not available.

>
> > > Common properties supported for each devicetree node that represents =
a
> > > device. The only difference is that on your board you make use of som=
e
> > > but not some others.
> >
> > Fine, let's decide this by PWM maintainer or DT maintainer Rob.
>
> Fine for me.
>
> > >> > > Yes, they are required. Thanks for your comments.
> > >> >
> > >> > required in which sense? Why can a Spreadtrum PWM not work when th=
e
> > >> > clock parents are unspecified?
> > >>
> > >> On some Spreadtrum platforms, the default source clock of PWM may no=
t
> > >> be enabled, so we should force users to select one available source
> > >> clock for PWM output clock.
> > >
> > > Sounds like a bug in the clk tree of your SoC that shouldn't affect h=
ow
> > > the PWM is described in the device tree. After all a parent of a cloc=
k
> > > is supposed to become enabled when the clock gets enabled.
> >
> > That's not a bug, that's like a MUX, the default source clock of PWM
> > can be disabled, since we usually do not use the default source clock.
> > Then we can select a available source clock by the MUX.
>
> In my eyes there is a difference between a) The way the clocks are
> implemented in the XZ SoC implies that to actually use the PWM you need
> to reparent some clock; and b) Each "sprd,ums512-pwm" device really
> needs an "assigned-clock" property, otherwise it cannot work.
>
> If you write "required" in the binding doc the semantic should be b) but
> the motivation here seems to be a). Legal questions aside someone could
> implement a PWM that has the same register layout and behaviour as the
> PWM in your SoC but with a different clock tree. Should they use a
> different compatible just because they don't need "assigned-clock"?

Fair enough, I move them to be optional.

--=20
Baolin Wang
Best Regards
