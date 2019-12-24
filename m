Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBF112A439
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2019 22:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfLXVzz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Dec 2019 16:55:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:35440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfLXVzz (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 24 Dec 2019 16:55:55 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAC0C2075B;
        Tue, 24 Dec 2019 21:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577224553;
        bh=HVqK7CfYI2xUl/VY8RhNIIuN7SlE4QmZ65u4IzVRZhw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t62XNtjEmgMbOXvdXVy8K2sXKVHY0+afKFFTGLeMdt38fnSd6+IODZncunHhv0cML
         Gtdy1jLaUdQZDyy8qo/owBXJwaEqiieeZZZh1BQFup+hCR2XSrQ9DkKCFia6l7Vh60
         HLRac4hfVrKWgRUuIa4tiQ+8cUB9FJqZHO0n57SA=
Received: by mail-qk1-f175.google.com with SMTP id r14so16785382qke.13;
        Tue, 24 Dec 2019 13:55:53 -0800 (PST)
X-Gm-Message-State: APjAAAVi1sNAzYrzr+d6uvZVlIAFuRBm3zPt1ySW7hSTOXUDNtG8cW5V
        i6TbMMfqZJBftvm/wSMSlHQu/3vgUesqNsLehA==
X-Google-Smtp-Source: APXvYqxVGvLPHR1mrIvpCUghYnPvAUui1kYEJPsuU72+w95fZq0yCkQFo6a5si+ggjARVj7O4mJG+mguFObDzqZnEYE=
X-Received: by 2002:a05:620a:135b:: with SMTP id c27mr30247999qkl.119.1577224552607;
 Tue, 24 Dec 2019 13:55:52 -0800 (PST)
MIME-Version: 1.0
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
 <1575851866-18919-2-git-send-email-jeff@labundy.com> <20191218235252.GA19438@bogus>
 <20191220040042.GB2658@labundy.com>
In-Reply-To: <20191220040042.GB2658@labundy.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 24 Dec 2019 14:55:41 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+eXQKSExm+HU+3iY=zryj-KgfNbJ7sGd=OWQbQ3sn-yg@mail.gmail.com>
Message-ID: <CAL_Jsq+eXQKSExm+HU+3iY=zryj-KgfNbJ7sGd=OWQbQ3sn-yg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: Add bindings for Azoteq IQS620A/621/622/624/625
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Dec 19, 2019 at 9:00 PM Jeff LaBundy <jeff@labundy.com> wrote:
>
> Hi Rob,
>
> Thank you for your prompt review and your kind words. A couple of questions
> and comments for you below.
>
> On Wed, Dec 18, 2019 at 05:52:52PM -0600, Rob Herring wrote:
> > On Mon, Dec 09, 2019 at 12:38:32AM +0000, Jeff LaBundy wrote:
> > > This patch adds device tree bindings for the Azoteq IQS620A, IQS621,
> > > IQS622, IQS624 and IQS625 multi-function sensors.
> > >
> > > A total of three bindings are presented (one MFD and two child nodes);
> > > they are submitted as a single patch because the child node bindings
> > > have no meaning in the absence of the MFD binding.
> > >
> > > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > > ---
> > > Changes in v2:
> > >   - Removed "prox" child node and moved "keys" and "pwm" child nodes to their
> > >     own bindings
> > >   - Replaced linux,fw-file property with more common firmware-name property
> > >   - Converted all bindings to YAML
> >
> > Good job for first go.
> >
> > >
> > >  .../devicetree/bindings/input/iqs62x-keys.yaml     | 126 +++++++++++++++
> > >  Documentation/devicetree/bindings/mfd/iqs62x.yaml  | 177 +++++++++++++++++++++
> > >  .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |  30 ++++
> > >  3 files changed, 333 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
> >
> > A couple of minor things below. With those fixed:
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > >
> > > diff --git a/Documentation/devicetree/bindings/input/iqs62x-keys.yaml b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> > > new file mode 100644
> > > index 0000000..e9b54e0
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> > > @@ -0,0 +1,126 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/input/iqs62x-keys.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Azoteq IQS620A/621/622/624/625 Keys and Switches
> > > +
> > > +maintainers:
> > > +  - Jeff LaBundy <jeff@labundy.com>
> > > +
> > > +description: |
> > > +  The Azoteq IQS620A, IQS621, IQS622, IQS624 and IQS625 multi-function sensors
> > > +  feature a variety of self-capacitive, mutual-inductive and Hall-effect sens-
> > > +  ing capabilities that can facilitate a variety of contactless key and switch
> > > +  applications.
> > > +
> > > +  These functions are collectively represented by a "keys" child node from the
> > > +  parent MFD driver. See Documentation/devicetree/bindings/mfd/iqs62x.yaml for
> > > +  further details and examples. Sensor hardware configuration (self-capacitive
> > > +  vs. mutual-inductive, etc.) is selected based on the device's firmware.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - azoteq,iqs620a-keys
> > > +      - azoteq,iqs621-keys
> > > +      - azoteq,iqs622-keys
> > > +      - azoteq,iqs624-keys
> > > +      - azoteq,iqs625-keys
> > > +
> > > +  linux,keycodes:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +      - minItems: 1
> > > +        maxItems: 16
> > > +    description: |
> > > +      Specifies the numeric keycodes associated with each available touch or
> > > +      proximity event according to the following table. An 'x' indicates the
> > > +      event is supported for a given device. Specify 0 for unused events.
> > > +
> > > +      -------------------------------------------------------------------------
> > > +      | #  | Event              | IQS620A | IQS621 | IQS622 | IQS624 | IQS625 |
> > > +      -------------------------------------------------------------------------
> > > +      | 0  | CH0 Touch          |    x    |    x   |    x   |    x   |    x   |
> > > +      |    | Antenna 1 Touch*   |    x    |        |        |        |        |
> > > +      -------------------------------------------------------------------------
> > > +      | 1  | CH0 Proximity      |    x    |    x   |    x   |    x   |    x   |
> > > +      |    | Antenna 1 Prox.*   |    x    |        |        |        |        |
> > > +      -------------------------------------------------------------------------
> > > +      | 2  | CH1 Touch          |    x    |    x   |    x   |    x   |    x   |
> > > +      |    | Ant. 1 Deep Touch* |    x    |        |        |        |        |
> > > +      -------------------------------------------------------------------------
> > > +      | 3  | CH1 Proximity      |    x    |    x   |    x   |    x   |    x   |
> > > +      -------------------------------------------------------------------------
> > > +      | 4  | CH2 Touch          |    x    |        |        |        |        |
> > > +      -------------------------------------------------------------------------
> > > +      | 5  | CH2 Proximity      |    x    |        |        |        |        |
> > > +      |    | Antenna 2 Prox.*   |    x    |        |        |        |        |
> > > +      -------------------------------------------------------------------------
> > > +      | 6  | Metal (+) Touch**  |    x    |    x   |        |        |        |
> > > +      |    | Ant. 2 Deep Touch* |    x    |        |        |        |        |
> > > +      -------------------------------------------------------------------------
> > > +      | 7  | Metal (+) Prox.**  |    x    |    x   |        |        |        |
> > > +      |    | Antenna 2 Touch*   |    x    |        |        |        |        |
> > > +      -------------------------------------------------------------------------
> > > +      | 8  | Metal (-) Touch**  |    x    |    x   |        |        |        |
> > > +      -------------------------------------------------------------------------
> > > +      | 9  | Metal (-) Prox.**  |    x    |    x   |        |        |        |
> > > +      -------------------------------------------------------------------------
> > > +      | 10 | SAR Active***      |    x    |        |    x   |        |        |
> > > +      -------------------------------------------------------------------------
> > > +      | 11 | SAR Quick Rel.***  |    x    |        |    x   |        |        |
> > > +      -------------------------------------------------------------------------
> > > +      | 12 | SAR Movement***    |    x    |        |    x   |        |        |
> > > +      -------------------------------------------------------------------------
> > > +      | 13 | SAR Filter Halt*** |    x    |        |    x   |        |        |
> > > +      -------------------------------------------------------------------------
> > > +      | 14 | Wheel Up           |         |        |        |    x   |        |
> > > +      -------------------------------------------------------------------------
> > > +      | 15 | Wheel Down         |         |        |        |    x   |        |
> > > +      -------------------------------------------------------------------------
> > > +      *   Two-channel SAR. Replaces CH0-2 plus metal touch and proximity events
> > > +          if enabled via firmware.
> > > +      **  "+" and "-" refer to the polarity of a channel's delta (LTA - counts),
> > > +          where "LTA" is defined as the channel's long-term average.
> > > +      *** One-channel SAR. Replaces CH0-2 touch and proximity events if enabled
> > > +          via firmware.
> > > +
> > > +required:
> > > +  - compatible
> > > +  - linux,keycodes
> >
> > Add:
> >
> > additionalProperties: false
> >
>
> When I add this, the dt_binding_check step complains that the hall switch child nodes
> used in the examples are unrecognized, e.g.:
>
> iqs620a@44: keys: 'hall-switch-south' does not match any of the regexes: 'pinctrl-[0-9]+'
>
> When I originally encountered this, I found that the mdio-mux child node in [0] seems
> to be a similar example and omits additionalProperties, which is why I originally did
> that here. Do you have any advice on how to proceed?

That's because the properties are under an if/then. Your options are
split the schema into 2 files to eliminate the if/then or just define
"^hall-switch-(north|south)$" with just 'true' outside the if/then. A
variation on the 2nd option is invert the if/then and make the schema
false. Then the 'main' schema defines the full superset of properties
and the if/then just filters out ones that don't apply in some cases.

>
> > > +
> > > +if:
> > > +  properties:
> > > +    compatible:
> > > +      contains:
> > > +        enum:
> > > +          - azoteq,iqs620a-keys
> > > +          - azoteq,iqs621-keys
> > > +          - azoteq,iqs622-keys
> > > +then:
> > > +  patternProperties:
> > > +    "^hall-switch-(north|south)$":
> > > +      type: object
> > > +      description:
> > > +        Represents north/south-field Hall-effect sensor touch or proximity
> > > +        events. Note that north/south-field orientation is reversed on the
> > > +        IQS620AXzCSR device due to its flip-chip package.
> > > +
> > > +      properties:
> > > +        linux,code:
> > > +          $ref: /schemas/types.yaml#/definitions/uint32
> > > +          description: Numeric switch code associated with the event.
> > > +
> > > +        azoteq,use-prox:
> > > +          $ref: /schemas/types.yaml#/definitions/flag
> > > +          description:
> > > +            If present, specifies that Hall-effect sensor reporting should
> > > +            use the device's wide-range proximity threshold instead of its
> > > +            close-range touch threshold (default).
> > > +
> > > +      required:
> > > +        - linux,code
> > > +
>
> Do you think I should specify additionalProperties: false within these child nodes?

Yes.
