Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAA41F5F2E
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Nov 2019 13:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfKIMnJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 9 Nov 2019 07:43:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfKIMnI (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 9 Nov 2019 07:43:08 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABD5C21019;
        Sat,  9 Nov 2019 12:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573303388;
        bh=lfLddIGQZu8yh7JyCypDgx5/iez6bEwoAQmO+JsUsHM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iKEBM0GXOAc+4G624Fx5/UrFhOnzogFtFG+AqARetI+MonQAAGcQcTbFP/rVRnb65
         smwY4/Rp2Tk5MjL76tvIUotNH4eheT4KQ/1Hu5Ti5e7qI5rC9Kf1QLGCEITeLcMsud
         IaUcqUjRkj77/7ggShqYTMw3Whj03WlUxB/j93t8=
Date:   Sat, 9 Nov 2019 12:43:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] dt-bindings: iio: timer: Convert stm32 IIO trigger
 bindings to json-schema
Message-ID: <20191109124301.5ffda04b@archlinux>
In-Reply-To: <CAL_Jsq+b_e1MbXx6918+iKfrTgqoozxOZ2rEYgogChZDWR_+iQ@mail.gmail.com>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
        <20191031123040.26316-3-benjamin.gaignard@st.com>
        <20191103110841.3ad3ecfb@archlinux>
        <CA+M3ks5sZ6wwV-V+HCLC8OLdeLqrxK0Ga-pXTsdktQErbMOk4g@mail.gmail.com>
        <20191106040657.GA5294@bogus>
        <d0196570-9140-c775-742c-89092056e651@st.com>
        <CAL_Jsq+b_e1MbXx6918+iKfrTgqoozxOZ2rEYgogChZDWR_+iQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 6 Nov 2019 17:35:20 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Nov 6, 2019 at 1:52 PM Benjamin GAIGNARD
> <benjamin.gaignard@st.com> wrote:
> >
> >
> > On 11/6/19 5:06 AM, Rob Herring wrote: =20
> > > On Tue, Nov 05, 2019 at 11:07:16AM +0100, Benjamin Gaignard wrote: =20
> > >> Le dim. 3 nov. 2019 =C3=A0 12:08, Jonathan Cameron <jic23@kernel.org=
> a =C3=A9crit : =20
> > >>> On Thu, 31 Oct 2019 13:30:38 +0100
> > >>> Benjamin Gaignard <benjamin.gaignard@st.com> wrote:
> > >>> =20
> > >>>> Convert the STM32 IIO trigger binding to DT schema format using js=
on-schema
> > >>>>
> > >>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com> =20
> > >>> I'm far from great on these as still haven't taken the time I shoul=
d to learn
> > >>> the yaml syntax properly.  A few comments inline however based most=
ly on this
> > >>> doesn't quite look like other ones I've seen recently.
> > >>>
> > >>> Thanks,
> > >>>
> > >>> Jonathan
> > >>> =20
> > >>>> ---
> > >>>>   .../bindings/iio/timer/st,stm32-timer-trigger.yaml | 44 ++++++++=
++++++++++++++
> > >>>>   .../bindings/iio/timer/stm32-timer-trigger.txt     | 25 --------=
----
> > >>>>   2 files changed, 44 insertions(+), 25 deletions(-)
> > >>>>   create mode 100644 Documentation/devicetree/bindings/iio/timer/s=
t,stm32-timer-trigger.yaml
> > >>>>   delete mode 100644 Documentation/devicetree/bindings/iio/timer/s=
tm32-timer-trigger.txt
> > >>>>
> > >>>> diff --git a/Documentation/devicetree/bindings/iio/timer/st,stm32-=
timer-trigger.yaml b/Documentation/devicetree/bindings/iio/timer/st,stm32-t=
imer-trigger.yaml
> > >>>> new file mode 100644
> > >>>> index 000000000000..1c8c8b55e8cd
> > >>>> --- /dev/null
> > >>>> +++ b/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-t=
rigger.yaml
> > >>>> @@ -0,0 +1,44 @@
> > >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > >>>> +%YAML 1.2
> > >>>> +---
> > >>>> +$id: http://devicetree.org/schemas/iio/timer/st,stm32-timer-trigg=
er.yaml#
> > >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >>>> +
> > >>>> +title: STMicroelectronics STM32 Timers IIO timer bindings
> > >>>> +
> > >>>> +maintainers:
> > >>>> +  - Benjamin Gaignard <benjamin.gaignard@st.com>
> > >>>> +  - Fabrice Gasnier <fabrice.gasnier@st.com>
> > >>>> +
> > >>>> +properties:
> > >>>> +  $nodemane: =20
> > >>> nodename? =20
> > >> That will be in v2 =20
> > > No, $nodename is correct. The '$' signifies something we generate and
> > > add in. IOW, not a real property. I guess we could have used 'name' h=
ere
> > > and stuck with traditional OpenFirmware. =20
> > let's go for $name =20
>=20
> No, $nodename is correct. You don't have a choice. That is what the
> tooling generates.

Sorry all, I caused confusion here.  Was just trying to point out the typo!
$node_m_ane

:)

>=20
> Rob

