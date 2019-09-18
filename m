Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB62B628A
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Sep 2019 13:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfIRLyK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Sep 2019 07:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfIRLyK (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Sep 2019 07:54:10 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2A0621925;
        Wed, 18 Sep 2019 11:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568807648;
        bh=kzrm6fZngJglejuB9xzhoA67Tcw2osTIaU7fAwqMKGc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uQx0FUr8IoDdZVaq+Jj+7J6ZqUGHxuLlNwiVaVIlUi/OKI8xJVzEkICj7lvD6EP1D
         cg3k8nHV8MGRGVhp0WG233Hvc9+LTsHjUbK+a2hgo+NtQSkpkdL23dcoRfVHHIcfnX
         bwxS0rtdm1HKiG/JYxu29Q/pODBmUpenBF7llt/w=
Received: by mail-ot1-f48.google.com with SMTP id z6so6064501otb.2;
        Wed, 18 Sep 2019 04:54:08 -0700 (PDT)
X-Gm-Message-State: APjAAAV7qHvVvch3UOLGybOOVUkTEgdCUKNW8UTFdtJOU1W+p9iVHpwF
        IPHL+4ZkxJttqbfEbeZ5QrHdwifSIKyzOEBv1+I=
X-Google-Smtp-Source: APXvYqxMySumqjsahTYagNepSWzduEcZjCnTcXjLZCN9ySJfnCXOJqZVYcNkW0eHFhR5aSfIMwQqCAuFtB0Zu2153L4=
X-Received: by 2002:a9d:6c9a:: with SMTP id c26mr2573300otr.241.1568807648102;
 Wed, 18 Sep 2019 04:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190909183436.9045-1-krzk@kernel.org> <20190909183436.9045-2-krzk@kernel.org>
 <20190912175001.GA29884@bogus>
In-Reply-To: <20190912175001.GA29884@bogus>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 18 Sep 2019 13:53:56 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeGMZhCNkKa73gE42baJUim3QtQiV_fRm=j7xL9bb1nFw@mail.gmail.com>
Message-ID: <CAJKOXPeGMZhCNkKa73gE42baJUim3QtQiV_fRm=j7xL9bb1nFw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] dt-bindings: pwm: Convert Samsung PWM bindings to json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 13 Sep 2019 at 16:36, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Sep 09, 2019 at 08:34:36PM +0200, Krzysztof Kozlowski wrote:
> > Convert Samsung PWM (S3C, S5P and Exynos SoCs) bindings to DT schema
> > format using json-schema.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../devicetree/bindings/pwm/pwm-samsung.txt   |  51 --------
> >  .../devicetree/bindings/pwm/pwm-samsung.yaml  | 111 ++++++++++++++++++
> >  2 files changed, 111 insertions(+), 51 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
>
>
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
> > new file mode 100644
> > index 000000000000..90fb467bcdd5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
> > @@ -0,0 +1,111 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/pwm-samsung.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Samsung SoC PWM timers
> > +
> > +maintainers:
> > +  - Thierry Reding <thierry.reding@gmail.com>
> > +  - Krzysztof Kozlowski <krzk@kernel.org>
> > +
> > +description: |+
> > +  Samsung SoCs contain PWM timer blocks which can be used for system clock source
> > +  and clock event timers, as well as to drive SoC outputs with PWM signal. Each
> > +  PWM timer block provides 5 PWM channels (not all of them can drive physical
> > +  outputs - see SoC and board manual).
> > +
> > +  Be aware that the clocksource driver supports only uniprocessor systems.
> > +
> > +allOf:
> > +  - $ref: pwm.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - samsung,s3c2410-pwm             # 16-bit, S3C24xx
> > +      - samsung,s3c6400-pwm             # 32-bit, S3C64xx
> > +      - samsung,s5p6440-pwm             # 32-bit, S5P64x0
> > +      - samsung,s5pc100-pwm             # 32-bit, S5PC100, S5PV210, Exynos4210 rev0 SoCs
> > +      - samsung,exynos4210-pwm          # 32-bit, Exynos
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  clock-names:
> > +    description: |
> > +      Should contain all following required clock names:
> > +      - "timers" - PWM base clock used to generate PWM signals,
> > +      and any subset of following optional clock names:
> > +      - "pwm-tclk0" - first external PWM clock source,
> > +      - "pwm-tclk1" - second external PWM clock source.
> > +      Note that not all IP variants allow using all external clock sources.
> > +      Refer to SoC documentation to learn which clock source configurations
> > +      are available.
> > +    oneOf:
> > +      - items:
> > +        - const: "timers"
> > +      - items:
> > +        - const: "timers"
> > +        - const: "pwm-tclk0"
> > +      - items:
> > +        - const: "timers"
> > +        - const: "pwm-tclk1"
> > +      - items:
> > +        - const: "timers"
> > +        - const: "pwm-tclk0"
> > +        - const: "pwm-tclk1"
> > +
> > +  interrupts:
> > +    description:
> > +      One interrupt per timer, starting at timer 0.
> > +    minItems: 1
> > +    maxItems: 5
> > +
> > +  "#pwm-cells":
> > +    description:
> > +      The only third cell flag supported by this binding
> > +      is PWM_POLARITY_INVERTED.
> > +    const: 3
> > +
> > +  samsung,pwm-outputs:
> > +    description:
> > +      A list of PWM channels used as PWM outputs on particular platform.
> > +      It is an array of up to 5 elements being indices of PWM channels
> > +      (from 0 to 4), the order does not matter.
> > +    # TODO: Values should not repeat
>
> uniqueItems: true
>
> Though it looks like we have to enable that keyword. (As silently
> ignoring unknown keywords (such as typos) is 'feature' of json-schema,
> we explicitly list keywords we use.)

This works fine.

>
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> > +      # FIXME: min/max limit of items does not work
> > +      - items:
> > +          minItems: 1
> > +          maxItems: 5
> > +      - items:
> > +          minimum: 0
> > +          maximum: 4
>
> I think you want:
>
> minItems: 1
> maxItems: 2
> items:
>   minimum: 0
>   maximum: 4

This not. However I figured out it is not needed. Since these are
unique values from 0 to 4, then the size of array cannot be longer
than 5 or shorter than 1.

Best regards,
Krzysztof
