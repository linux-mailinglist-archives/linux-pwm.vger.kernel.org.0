Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C0A3D683A
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Jul 2021 22:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhGZT6n (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Jul 2021 15:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232169AbhGZT6n (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 26 Jul 2021 15:58:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5C6A60F93;
        Mon, 26 Jul 2021 20:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627331951;
        bh=jwo7kjnHqUbR60c5VoxUCqCoqYO9MoJQlrQi+4fW4nw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IM1Cyw+uHcMqpcFwB5U40N1+xhiaMW+QGgy8y88TD4v54U/cYQTjnicq9o5a2t5qd
         Huqtohyx1ES7ADhbV+hXCmpd2FfwEUf7nnqYi2eKd1v00GtAWuBe6WFhTSp71Hngz4
         Ac5P7NQRd0mEY6CmBbbDl2U0Z5r7DGJuQhnGADH65RKX1Vl74teoVJXMGtykOJtQEY
         4eMJ3dvlQjMssn2PBx6NIApqmS0j7amH6ipSdLgYNBgaVYcBxt3qHG2TeQpsF1Yx11
         DxBf/ov8CcLuJC062sr5/xJkxB258vf6ezv4ab/J9hmxmf5SfEDSTQ6BH1C28I4IKs
         +ptqSeBkla+xg==
Received: by mail-ej1-f52.google.com with SMTP id gt31so18307817ejc.12;
        Mon, 26 Jul 2021 13:39:11 -0700 (PDT)
X-Gm-Message-State: AOAM531u5mn9+q8Rbhr1marjXeY7Wthzo72S5Sdj05vfaNavpxXEYE/C
        +bNhCkUra9LJ6zR040hL3e817bBK1kRA3udE4g==
X-Google-Smtp-Source: ABdhPJyDv+fNM15O8FW0ikww+Gu4xZZSpQZ6R3qbgI+h6Cc4kEmc6zdHsuCgR+UDTohh/3hVsE7ncmERZ84okNEPzy0=
X-Received: by 2002:a17:906:4917:: with SMTP id b23mr35654ejq.468.1627331950408;
 Mon, 26 Jul 2021 13:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <889aae1b88f120cb6281919d27164a959fbe69d0.1626948070.git.baruch@tkos.co.il>
 <70f0522a9394e9da2f31871442d47f6ad0ff41aa.1626948070.git.baruch@tkos.co.il> <YP2tAR+zZgJZQOgG@yoga>
In-Reply-To: <YP2tAR+zZgJZQOgG@yoga>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 26 Jul 2021 14:38:58 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+a__sQoKLahH3zu9hd2f4fCqaOQ6S82yua38om0D8raA@mail.gmail.com>
Message-ID: <CAL_Jsq+a__sQoKLahH3zu9hd2f4fCqaOQ6S82yua38om0D8raA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] dt-bindings: pwm: add IPQ6018 binding
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Jul 25, 2021 at 12:27 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 22 Jul 05:01 CDT 2021, Baruch Siach wrote:
>
> > DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> >
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > ---
> > v6:
> >
> >   Device node is child of TCSR; remove phandle (Rob Herring)
> >
> >   Add assigned-clocks/assigned-clock-rates (Uwe Kleine-K=C3=B6nig)
> >
> > v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
> >     Andersson, Kathiravan T)
> >
> > v4: Update the binding example node as well (Rob Herring's bot)
> >
> > v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
> >
> > v2: Make #pwm-cells const (Rob Herring)
> > ---
> >  .../devicetree/bindings/pwm/ipq-pwm.yaml      | 69 +++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml b/Docum=
entation/devicetree/bindings/pwm/ipq-pwm.yaml
> > new file mode 100644
> > index 000000000000..ee2bb03a1223
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> > @@ -0,0 +1,69 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/ipq-pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm IPQ6018 PWM controller
> > +
> > +maintainers:
> > +  - Baruch Siach <baruch@tkos.co.il>
> > +
> > +properties:
> > +  "#pwm-cells":
> > +    const: 2
> > +
> > +  compatible:
> > +    const: qcom,ipq6018-pwm
> > +
> > +  offset:
> > +    description: |
>
> '|' maintains the formatting of the text, you don't need that.
>
> > +      Offset of PWM register in the TCSR block.
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    const: core
>
> With a single clock, it's nice to skip the -names.
>
> > +
> > +  assigned-clocks:
> > +    maxItems: 1
> > +
> > +  assigned-clock-rates:
> > +    maxItems: 1
>
> These (assigned-*) are generic properties that may be used on a lot of
> nodes, should they really be part of the individual binding, Rob?

They are allowed on any node with 'clocks', so you don't need them.
However, if you know there's 1 entry only, then I'd keep that. Or was
'maxItems: 1' just copied because I see that alot.

Rob
