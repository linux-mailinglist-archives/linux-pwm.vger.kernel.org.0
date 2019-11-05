Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 597FCEFA70
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 11:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbfKEKH3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 05:07:29 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33652 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730711AbfKEKH3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 05:07:29 -0500
Received: by mail-qk1-f193.google.com with SMTP id 71so20622015qkl.0
        for <linux-pwm@vger.kernel.org>; Tue, 05 Nov 2019 02:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CNinsozng4H5Ktf3rvHjg3jRh9c0NmbS8rmNz478Pe8=;
        b=VEO755CMkWYZ+HZKjDSD2H8hkfHFILjBODJuUT7dyLJ2VacVXn30QPaKiB2aJr3dFj
         UUfvdFj6N0LnOAXPpkBIo09s0N5k2JqZAjoxblyCjvylpwFmN2gB0t7J2CGgbJNVhTmU
         Xcr/1pKIJxSCw64FjFq0CtKjgFgTUfNVSSd9U2EvGxP5Nf0q3JVy0Cb5eF45Tr0S+WOE
         0zKyddIay8ulBTDwkAa9yHfkd+eUs/9amxlaNsSWxZ5fur+Ya/bxWYGvrXrX0FWTo8vt
         H4Dh97ZxjUuuKm7+8LrgGpf1cTXIb42yHnSZIPyQugGcQMUmFsLEOAZC5E/3rGykiu40
         5mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CNinsozng4H5Ktf3rvHjg3jRh9c0NmbS8rmNz478Pe8=;
        b=LHbLrrLms2SVfAuboq75HWTlJPpcdLBrf5uXDoauGJx+ijmwpmn53Lf1F7UN9FOXvO
         AjPIaaFL4kOkZZQPjfvU9l230bi07Bp3pKq6m0s57hU8w0cueR/cr3RnFldrbZbzNDS1
         j2/oiWs1QDReYL3z7ONwXSfBfYdWtow4oPw83Dftnn5mI7rvxKaJ6dFo6wfYw4lpC16q
         XxAT1oqDDEyuFFOYg3v4hEJh2DrqU0L22p38jb3XPX8hSXVBRdcOg7AG5j+3tyPEWEB2
         KAEjufJNkSn5yrofRhGWcJNC9+nF3nu2ooMEOG5so02Z61s0dVRJieW3rl12Ij8TtBlJ
         73tw==
X-Gm-Message-State: APjAAAXr5pcCauWwzHF1VUWbvCRfQeszWGNgX0zQPC9NzbhtuhPwrBy/
        xQ++qWBcI1unI3sH66EXXxrRFUOx2W1TzIFn13rYYQ==
X-Google-Smtp-Source: APXvYqw9bNDchC8BBBpEdelYeypgmRQMVHiuZm+RJGKYBw6ulBdYAA7iNafLNDZB2gz23179UM0YXlSw8t9Sm2JcFdA=
X-Received: by 2002:ae9:eb07:: with SMTP id b7mr7705763qkg.104.1572948447803;
 Tue, 05 Nov 2019 02:07:27 -0800 (PST)
MIME-Version: 1.0
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
 <20191031123040.26316-3-benjamin.gaignard@st.com> <20191103110841.3ad3ecfb@archlinux>
In-Reply-To: <20191103110841.3ad3ecfb@archlinux>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 5 Nov 2019 11:07:16 +0100
Message-ID: <CA+M3ks5sZ6wwV-V+HCLC8OLdeLqrxK0Ga-pXTsdktQErbMOk4g@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: iio: timer: Convert stm32 IIO trigger
 bindings to json-schema
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-iio@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Le dim. 3 nov. 2019 =C3=A0 12:08, Jonathan Cameron <jic23@kernel.org> a =C3=
=A9crit :
>
> On Thu, 31 Oct 2019 13:30:38 +0100
> Benjamin Gaignard <benjamin.gaignard@st.com> wrote:
>
> > Convert the STM32 IIO trigger binding to DT schema format using json-sc=
hema
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> I'm far from great on these as still haven't taken the time I should to l=
earn
> the yaml syntax properly.  A few comments inline however based mostly on =
this
> doesn't quite look like other ones I've seen recently.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  .../bindings/iio/timer/st,stm32-timer-trigger.yaml | 44 ++++++++++++++=
++++++++
> >  .../bindings/iio/timer/stm32-timer-trigger.txt     | 25 ------------
> >  2 files changed, 44 insertions(+), 25 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/timer/st,stm3=
2-timer-trigger.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-t=
imer-trigger.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iio/timer/st,stm32-timer=
-trigger.yaml b/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-=
trigger.yaml
> > new file mode 100644
> > index 000000000000..1c8c8b55e8cd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigge=
r.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/timer/st,stm32-timer-trigger.ya=
ml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: STMicroelectronics STM32 Timers IIO timer bindings
> > +
> > +maintainers:
> > +  - Benjamin Gaignard <benjamin.gaignard@st.com>
> > +  - Fabrice Gasnier <fabrice.gasnier@st.com>
> > +
> > +properties:
> > +  $nodemane:
>
> nodename?

That will be in v2

>
> > +    pattern: "^timer@[0-9]+$"
> > +    type: object
> > +
> > +    description:
> > +      must be a sub-node of an STM32 Timer device tree node
> > +
> > +    properties:
> > +      compatible:
> > +        oneOf:
>
> enum is I think preferred for these.

as you like it will be in v2

>
> > +          - const: st,stm32-timer-trigger
> > +          - const: st,stm32h7-timer-trigger
> > +
> > +      reg: true
>
> Normally some info for what the reg value is..
I can't put "description" on this field because the syntax doesn't allow it=
.
I will add a comment in v2 to explain what reg is.

Thanks for your review.
Benjamin
>
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +
> > +examples:
> > +  - |
> > +    timers2: timer@40000000 {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      timer@0 {
> > +        compatible =3D "st,stm32-timer-trigger";
> > +        reg =3D <0>;
> > +      };
> > +    };
> > +
> > +...
> > diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-tr=
igger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger=
.txt
> > deleted file mode 100644
> > index b8e8c769d434..000000000000
> > --- a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.t=
xt
> > +++ /dev/null
> > @@ -1,25 +0,0 @@
> > -STMicroelectronics STM32 Timers IIO timer bindings
> > -
> > -Must be a sub-node of an STM32 Timers device tree node.
> > -See ../mfd/stm32-timers.txt for details about the parent node.
> > -
> > -Required parameters:
> > -- compatible:        Must be one of:
> > -             "st,stm32-timer-trigger"
> > -             "st,stm32h7-timer-trigger"
> > -- reg:               Identify trigger hardware block.
> > -
> > -Example:
> > -     timers@40010000 {
> > -             #address-cells =3D <1>;
> > -             #size-cells =3D <0>;
> > -             compatible =3D "st,stm32-timers";
> > -             reg =3D <0x40010000 0x400>;
> > -             clocks =3D <&rcc 0 160>;
> > -             clock-names =3D "int";
> > -
> > -             timer@0 {
> > -                     compatible =3D "st,stm32-timer-trigger";
> > -                     reg =3D <0>;
> > -             };
> > -     };
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
