Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4160846527D
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Dec 2021 17:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbhLAQLI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Dec 2021 11:11:08 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:46880 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhLAQLH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Dec 2021 11:11:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 51CB5CE1EEF;
        Wed,  1 Dec 2021 16:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FBDC53FAD;
        Wed,  1 Dec 2021 16:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638374863;
        bh=WESosVN/5HMxq8EnfCo3XazTasylttxu/o4U2Ep8YXo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IAswSuZn7RFcyKM9Z9Qm3UOk4QOIkQNCzdvhpW2ciZw3s/yUn1We0uNEGrsv42iFw
         27uvQGz0FbJGvBOcugLGoYTOwYU6vHzhEY1+7AFy0F84SQpgi4J3kLd0EEMuTxIZ6X
         S7/z+KNJz3DaAki9BYnPNK5LyyvBk/pIDVwlTQHCSKojJkS8VGprmnyskbEw2w705m
         5kUUVE2KEI9UPoP5ccisCEZfMIAK6PoNg+cBTJCeEZwbCbTPc9CvMfpRnPd8P1D5ib
         12svFYtpZrVT/fA3qk03SUesWftO2VMZjDPkM/36IqAlzqYDqyKgkno4VQ0SVn5GIy
         8orINNtf2nmHw==
Received: by mail-ed1-f42.google.com with SMTP id r25so38383673edq.7;
        Wed, 01 Dec 2021 08:07:43 -0800 (PST)
X-Gm-Message-State: AOAM531rQUfMi0pGnAmwmn5FJGSJQAMY9Xy4urq3B+x3zWDsV12M226h
        OOqiJ/qjHkWGEs4qYPNagDQSYJK/EGAsYPZ9bA==
X-Google-Smtp-Source: ABdhPJyXBMAt4Cr2JNnD4a9r9qlLbYcUZftirjxrAMuCEVE4eeRilbfBJKZm5YnfnuYDTcRpeAi+rkHbij/tbGB03bk=
X-Received: by 2002:a17:907:7f25:: with SMTP id qf37mr8173887ejc.147.1638374857271;
 Wed, 01 Dec 2021 08:07:37 -0800 (PST)
MIME-Version: 1.0
References: <8137a76d66146dd5c1efa0c46c60de5766b7a349.1638293850.git.baruch@tkos.co.il>
 <62ec6016400e80ee379c07ef2c80abbf7f60bbe2.1638293850.git.baruch@tkos.co.il>
 <1638304586.245688.2968346.nullmailer@robh.at.kernel.org> <87ee6wgc0b.fsf@tarshish>
In-Reply-To: <87ee6wgc0b.fsf@tarshish>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 1 Dec 2021 10:07:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKgRMiK9Uvh=EJDW7n_1Sz79NFQ7_K+RzqZ7nBAoQsJLg@mail.gmail.com>
Message-ID: <CAL_JsqKgRMiK9Uvh=EJDW7n_1Sz79NFQ7_K+RzqZ7nBAoQsJLg@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] dt-bindings: pwm: add IPQ6018 binding
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Robert Marko <robert.marko@sartura.hr>,
        linux-pwm@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Balaji Prakash J <bjagadee@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Nov 30, 2021 at 10:55 PM Baruch Siach <baruch@tkos.co.il> wrote:
>
> Hi Rob,
>
> On Tue, Nov 30 2021, Rob Herring wrote:
> > On Tue, 30 Nov 2021 19:37:29 +0200, Baruch Siach wrote:
> >> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> >>
> >> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >> ---
> >>
> >> v9:
> >>
> >>   Add 'ranges' property to example (Rob)
> >>
> >>   Drop label in example (Rob)
> >>
> >> v8:
> >>
> >>   Add size cell to 'reg' (Rob)
> >>
> >> v7:
> >>
> >>   Use 'reg' instead of 'offset' (Rob)
> >>
> >>   Drop 'clock-names' and 'assigned-clock*' (Bjorn)
> >>
> >>   Use single cell address/size in example node (Bjorn)
> >>
> >>   Move '#pwm-cells' lower in example node (Bjorn)
> >>
> >>   List 'reg' as required
> >>
> >> v6:
> >>
> >>   Device node is child of TCSR; remove phandle (Rob Herring)
> >>
> >>   Add assigned-clocks/assigned-clock-rates (Uwe Kleine-K=C3=B6nig)
> >>
> >> v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
> >>     Andersson, Kathiravan T)
> >>
> >> v4: Update the binding example node as well (Rob Herring's bot)
> >>
> >> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
> >>
> >> v2: Make #pwm-cells const (Rob Herring)
> >> ---
> >>  .../devicetree/bindings/pwm/ipq-pwm.yaml      | 53 ++++++++++++++++++=
+
> >>  1 file changed, 53 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> >>
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/pwm/ipq-pwm.example.dt.yaml:0:0:
> > /example-0/syscon@1937000: failed to match any schema with compatible:
> > ['qcom,tcsr-ipq6018', 'syscon', 'simple-mfd']
>
> My previous submission[1] had this text above the patch changelog:
>
> ---
> This series does not convert the TCSR binding documentation to YAML. As
> a result, this commit adds new a dt_binding_check warning:
>
> /example-0/syscon@1937000: failed to match any schema with compatible: ['=
qcom,tcsr-ipq 6018', 'syscon', 'simple-mfd']
>
> If that is a blocker to IPQ6018 PWM support, so be it. Patches will wait
> for someone else to push them further.

That one looks pretty trivial to convert and there are lots of people
working on QCom stuff, so I'm going to say yes it is required.

Rob
