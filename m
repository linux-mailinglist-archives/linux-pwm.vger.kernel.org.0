Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBBE46462A
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Dec 2021 05:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346645AbhLAE6l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Nov 2021 23:58:41 -0500
Received: from bzq-84-110-109-230.red.bezeqint.net ([84.110.109.230]:42015
        "EHLO mx.tkos.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230301AbhLAE6k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Nov 2021 23:58:40 -0500
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 4FAF1440EF5;
        Wed,  1 Dec 2021 06:55:05 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1638334505;
        bh=/9UgSQBguvDNEg21C4Vht5zcaGeUIg9+CJ/8Ytppoqg=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=CuqDgOeRLuaDyaGPkDXfSRSU7fRiuG8jS25Yb1KgjkS5nAcnHAKoMFCm9xAms7OIX
         +ZmJsIPIAgRQxETU6FmNynvqUuzTfHvwGkW7AUwzY65N4AjcEJSehKc/ZgulSqty/C
         KdzcXj1PEGG5OnHAB2OIDAzjwOr7uzA+9s6zy5BdwPLhKX1tHR9Nz+Sa6l+15Y4CO1
         9kgDoQI/qCg47AHXRhx3LV6FBDv3o9vkmR7F1/XsyuXvPAC2Oe70l7ANc255vRudVF
         C2p+3/GQP9cKIRghHsotxVTIbPQ8hmJqruAbK1dPR3/d2AwqUNgqAZOMdl/jNln75x
         jzl7Pr0pra+ow==
References: <8137a76d66146dd5c1efa0c46c60de5766b7a349.1638293850.git.baruch@tkos.co.il>
 <62ec6016400e80ee379c07ef2c80abbf7f60bbe2.1638293850.git.baruch@tkos.co.il>
 <1638304586.245688.2968346.nullmailer@robh.at.kernel.org>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Robert Marko <robert.marko@sartura.hr>,
        linux-pwm@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Balaji Prakash J <bjagadee@codeaurora.org>
Subject: Re: [PATCH v9 2/3] dt-bindings: pwm: add IPQ6018 binding
Date:   Wed, 01 Dec 2021 06:49:24 +0200
In-reply-to: <1638304586.245688.2968346.nullmailer@robh.at.kernel.org>
Message-ID: <87ee6wgc0b.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob,

On Tue, Nov 30 2021, Rob Herring wrote:
> On Tue, 30 Nov 2021 19:37:29 +0200, Baruch Siach wrote:
>> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
>>=20
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>>=20
>> v9:
>>=20
>>   Add 'ranges' property to example (Rob)
>>=20
>>   Drop label in example (Rob)
>>=20
>> v8:
>>=20
>>   Add size cell to 'reg' (Rob)
>>=20
>> v7:
>>=20
>>   Use 'reg' instead of 'offset' (Rob)
>>=20
>>   Drop 'clock-names' and 'assigned-clock*' (Bjorn)
>>=20
>>   Use single cell address/size in example node (Bjorn)
>>=20
>>   Move '#pwm-cells' lower in example node (Bjorn)
>>=20
>>   List 'reg' as required
>>=20
>> v6:
>>=20
>>   Device node is child of TCSR; remove phandle (Rob Herring)
>>=20
>>   Add assigned-clocks/assigned-clock-rates (Uwe Kleine-K=C3=B6nig)
>>=20
>> v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
>>     Andersson, Kathiravan T)
>>=20
>> v4: Update the binding example node as well (Rob Herring's bot)
>>=20
>> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
>>=20
>> v2: Make #pwm-cells const (Rob Herring)
>> ---
>>  .../devicetree/bindings/pwm/ipq-pwm.yaml      | 53 +++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
>>=20
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/pwm/ipq-pwm.example.dt.yaml:0:0:
> /example-0/syscon@1937000: failed to match any schema with compatible:
> ['qcom,tcsr-ipq6018', 'syscon', 'simple-mfd']

My previous submission[1] had this text above the patch changelog:

---
This series does not convert the TCSR binding documentation to YAML. As
a result, this commit adds new a dt_binding_check warning:

/example-0/syscon@1937000: failed to match any schema with compatible: ['qc=
om,tcsr-ipq 6018', 'syscon', 'simple-mfd']

If that is a blocker to IPQ6018 PWM support, so be it. Patches will wait
for someone else to push them further.
---

This time I missed the 'DT_CHECKER_FLAGS=3D-m' part so I didn't see the
error.

Thanks for the reminder,
baruch

[1] https://lore.kernel.org/all/8238dfb5d5e4a40a995f047db36d9a7240431de5.16=
30323987.git.baruch@tkos.co.il/

> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/1561766
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.


--=20
                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{=3D
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
