Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F424F0D8C
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2019 05:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfKFEHA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 23:07:00 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45954 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfKFEHA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 23:07:00 -0500
Received: by mail-oi1-f195.google.com with SMTP id k2so19721544oij.12;
        Tue, 05 Nov 2019 20:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pbXWYeEjjc1tNeD8Va0Rn7W5q8WImyzirMTHLiEKYGY=;
        b=HDvT0r1O4hYvec9HRTLyyiRoRCgRpMUAnN8NYp3qonrng2HCXN05NI8IF//H6UzyTz
         s37E6T15SEV+ZNYj4JbFAvNUzQ2njM88WrhHTmWiv2VI/tmYa/GkJYl3fBPghGLjRap7
         TCc6L2ixyel0KqCdeHQaW8MP5faYkPGaNoxdyNQJMbnIdiVoIGr+XxJSIs3+8LSxEZy/
         UhhiL++TWq+rig8o3KvXasRs1axFUSltBNfM5aUZk4uPxbQD9zi5MJ8YMXkTZdyaJTsq
         XrjXuetjq/Kcd+fGjcyCJ6kuZLfd2D+mSCt4hG/lVpagelMVrD1F0IoTJzXR/W67mI93
         KqIA==
X-Gm-Message-State: APjAAAWxQyuhT2AoHxUH1Uqccj9rF26Efe3IdILIKmorCJAh1t8/RZYH
        RZR/QMpzTz8HNSkW/g/R0iBxHjk=
X-Google-Smtp-Source: APXvYqwe0beNgeLE8gya+f9XdJ7ynxnQMAtyk6u+v0005b8KLbqtym2m20lGy9EYFxREtXyxePD27Q==
X-Received: by 2002:aca:f18b:: with SMTP id p133mr406122oih.22.1573013219216;
        Tue, 05 Nov 2019 20:06:59 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k93sm6726958otc.30.2019.11.05.20.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 20:06:58 -0800 (PST)
Date:   Tue, 5 Nov 2019 22:06:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-iio@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] dt-bindings: iio: timer: Convert stm32 IIO trigger
 bindings to json-schema
Message-ID: <20191106040657.GA5294@bogus>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
 <20191031123040.26316-3-benjamin.gaignard@st.com>
 <20191103110841.3ad3ecfb@archlinux>
 <CA+M3ks5sZ6wwV-V+HCLC8OLdeLqrxK0Ga-pXTsdktQErbMOk4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+M3ks5sZ6wwV-V+HCLC8OLdeLqrxK0Ga-pXTsdktQErbMOk4g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Nov 05, 2019 at 11:07:16AM +0100, Benjamin Gaignard wrote:
> Le dim. 3 nov. 2019 à 12:08, Jonathan Cameron <jic23@kernel.org> a écrit :
> >
> > On Thu, 31 Oct 2019 13:30:38 +0100
> > Benjamin Gaignard <benjamin.gaignard@st.com> wrote:
> >
> > > Convert the STM32 IIO trigger binding to DT schema format using json-schema
> > >
> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > I'm far from great on these as still haven't taken the time I should to learn
> > the yaml syntax properly.  A few comments inline however based mostly on this
> > doesn't quite look like other ones I've seen recently.
> >
> > Thanks,
> >
> > Jonathan
> >
> > > ---
> > >  .../bindings/iio/timer/st,stm32-timer-trigger.yaml | 44 ++++++++++++++++++++++
> > >  .../bindings/iio/timer/stm32-timer-trigger.txt     | 25 ------------
> > >  2 files changed, 44 insertions(+), 25 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigger.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigger.yaml b/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigger.yaml
> > > new file mode 100644
> > > index 000000000000..1c8c8b55e8cd
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigger.yaml
> > > @@ -0,0 +1,44 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/timer/st,stm32-timer-trigger.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: STMicroelectronics STM32 Timers IIO timer bindings
> > > +
> > > +maintainers:
> > > +  - Benjamin Gaignard <benjamin.gaignard@st.com>
> > > +  - Fabrice Gasnier <fabrice.gasnier@st.com>
> > > +
> > > +properties:
> > > +  $nodemane:
> >
> > nodename?
> 
> That will be in v2

No, $nodename is correct. The '$' signifies something we generate and 
add in. IOW, not a real property. I guess we could have used 'name' here 
and stuck with traditional OpenFirmware.

> 
> >
> > > +    pattern: "^timer@[0-9]+$"
> > > +    type: object
> > > +
> > > +    description:
> > > +      must be a sub-node of an STM32 Timer device tree node
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        oneOf:
> >
> > enum is I think preferred for these.
> 
> as you like it will be in v2
> 
> >
> > > +          - const: st,stm32-timer-trigger
> > > +          - const: st,stm32h7-timer-trigger
> > > +
> > > +      reg: true
> >
> > Normally some info for what the reg value is..
> I can't put "description" on this field because the syntax doesn't allow it.
> I will add a comment in v2 to explain what reg is.

items:
  - maximum: <max timer number>

Rob
