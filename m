Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87283F7A4D
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Aug 2021 18:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241237AbhHYQUZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Aug 2021 12:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235078AbhHYQTj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 25 Aug 2021 12:19:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 798046120A;
        Wed, 25 Aug 2021 16:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629908333;
        bh=xYgq4UqeZ57viPLlU1+mZdtyZ6HlMPj2SXftb4EQy/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hbNPwf3z+qxrnY3+Dnn28q8GVGnoMriIspV1HPWx8fNhwim1aMQ3RUQdfC2HU2ZZa
         9aA4FnZ5/l5Gj997kTM5OPvALwoLEW0Q85sbAr7XsWUs6uToScpG9ktPJpEVogPUDd
         z7PPb6Pvu54OFoU2TFl+d1wp7A0QnsDmqHFa2gacnIguti4EdB2dw8h3yoHnH2yQoD
         7eUcVtzTRQYM3V1jNUIxDFqdyeyYvi/17ccPtVXKR5mPsM9uRmsiGwCavldPXIdzcE
         dacpjRHE8VhfI7BISB02YRUWqHcqjkQuTgq1B3O2zFVyLpLks8lQHal8DnZO8HrqNw
         94Jfu96B2Crbg==
Received: by mail-ed1-f43.google.com with SMTP id r19so37747836eds.13;
        Wed, 25 Aug 2021 09:18:53 -0700 (PDT)
X-Gm-Message-State: AOAM533i+W0QbhLSdGOCRCE0FYXpYj8NcCIxQC0CzCDljwviEtL2GMDl
        t/vZgpRH+268Jggk3jM/EUn8I620sJmAoJZjZg==
X-Google-Smtp-Source: ABdhPJxEhciPcbYe1l/5i/0MQashTN8jTOcmq6Duojsg/XqjGPI0pnbWQ2L2MXVjj5RGb/NM5mC/GoWgNriidFK2I1c=
X-Received: by 2002:aa7:c49a:: with SMTP id m26mr50617955edq.258.1629908332121;
 Wed, 25 Aug 2021 09:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <3b70f9e757e018d3cd91a882282040c4c0589a93.1629884907.git.baruch@tkos.co.il>
 <dbf064fb60b1654af25f65d89f75bd397162d701.1629884907.git.baruch@tkos.co.il>
 <1629900658.219829.2719822.nullmailer@robh.at.kernel.org> <87ilzta5xn.fsf@tarshish>
 <YSZr/xo2a60PYTuW@robh.at.kernel.org>
In-Reply-To: <YSZr/xo2a60PYTuW@robh.at.kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 25 Aug 2021 11:18:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJsOjmUWkWCzcbSFQO5hDLW0MBKEncOyN4kEE5zY=pbPQ@mail.gmail.com>
Message-ID: <CAL_JsqJsOjmUWkWCzcbSFQO5hDLW0MBKEncOyN4kEE5zY=pbPQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] dt-bindings: pwm: add IPQ6018 binding
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Andy Gross <agross@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kathiravan T <kathirav@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Aug 25, 2021 at 11:12 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Aug 25, 2021 at 05:59:45PM +0300, Baruch Siach wrote:
> > Hi Rob,
> >
> > On Wed, Aug 25 2021, Rob Herring wrote:
> >
> > > On Wed, 25 Aug 2021 12:48:26 +0300, Baruch Siach wrote:
> > >> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> > >>
> > >> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > >> ---
> > >> v7:
> > >>
> > >>   Use 'reg' instead of 'offset' (Rob)
> > >>
> > >>   Drop 'clock-names' and 'assigned-clock*' (Bjorn)
> > >>
> > >>   Use single cell address/size in example node (Bjorn)
> > >>
> > >>   Move '#pwm-cells' lower in example node (Bjorn)
> > >>
> > >>   List 'reg' as required
> > >>
> > >> v6:
> > >>
> > >>   Device node is child of TCSR; remove phandle (Rob Herring)
> > >>
> > >>   Add assigned-clocks/assigned-clock-rates (Uwe Kleine-K=C3=B6nig)
> > >>
> > >> v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
> > >>     Andersson, Kathiravan T)
> > >>
> > >> v4: Update the binding example node as well (Rob Herring's bot)
> > >>
> > >> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
> > >>
> > >> v2: Make #pwm-cells const (Rob Herring)
> > >> ---
> > >>  .../devicetree/bindings/pwm/ipq-pwm.yaml      | 52 ++++++++++++++++=
+++
> > >>  1 file changed, 52 insertions(+)
> > >>  create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.ya=
ml
> > >
> > > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_ch=
eck'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > >
> > > yamllint warnings/errors:
> > >
> > > dtschema/dtc warnings/errors:
> > > Documentation/devicetree/bindings/pwm/ipq-pwm.example.dt.yaml:0:0:
> > > /example-0/syscon@1937000: failed to match any schema with compatible=
:
> > > ['qcom,tcsr-ipq6018', 'syscon', 'simple-mfd']
> >
> > What can I do about that? Is it because qcom,tcsr-ipq6018 is documented
> > in a non-yaml plain .txt file?
>
> No, it is not documented at all.

Sorry, I should read patch 1 first... Still, before adding new
features to an MFD, the base MFD should be converted.

Rob
