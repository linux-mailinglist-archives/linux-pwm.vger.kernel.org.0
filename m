Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB113F7937
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Aug 2021 17:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhHYPl0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 25 Aug 2021 11:41:26 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:43943 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231995AbhHYPl0 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 25 Aug 2021 11:41:26 -0400
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id D5A7944090A;
        Wed, 25 Aug 2021 18:40:30 +0300 (IDT)
References: <3b70f9e757e018d3cd91a882282040c4c0589a93.1629884907.git.baruch@tkos.co.il>
 <dbf064fb60b1654af25f65d89f75bd397162d701.1629884907.git.baruch@tkos.co.il>
 <1629900658.219829.2719822.nullmailer@robh.at.kernel.org>
User-agent: mu4e 1.6.3; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Rob Herring <robh@kernel.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Andy Gross <agross@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        linux-pwm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kathiravan T <kathirav@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 3/4] dt-bindings: pwm: add IPQ6018 binding
Date:   Wed, 25 Aug 2021 17:59:45 +0300
In-reply-to: <1629900658.219829.2719822.nullmailer@robh.at.kernel.org>
Message-ID: <87ilzta5xn.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob,

On Wed, Aug 25 2021, Rob Herring wrote:

> On Wed, 25 Aug 2021 12:48:26 +0300, Baruch Siach wrote:
>> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
>> 
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>> v7:
>> 
>>   Use 'reg' instead of 'offset' (Rob)
>> 
>>   Drop 'clock-names' and 'assigned-clock*' (Bjorn)
>> 
>>   Use single cell address/size in example node (Bjorn)
>> 
>>   Move '#pwm-cells' lower in example node (Bjorn)
>> 
>>   List 'reg' as required
>> 
>> v6:
>> 
>>   Device node is child of TCSR; remove phandle (Rob Herring)
>> 
>>   Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)
>> 
>> v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
>>     Andersson, Kathiravan T)
>> 
>> v4: Update the binding example node as well (Rob Herring's bot)
>> 
>> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
>> 
>> v2: Make #pwm-cells const (Rob Herring)
>> ---
>>  .../devicetree/bindings/pwm/ipq-pwm.yaml      | 52 +++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/pwm/ipq-pwm.example.dt.yaml:0:0:
> /example-0/syscon@1937000: failed to match any schema with compatible:
> ['qcom,tcsr-ipq6018', 'syscon', 'simple-mfd']

What can I do about that? Is it because qcom,tcsr-ipq6018 is documented
in a non-yaml plain .txt file?

Thanks,
baruch

> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/1520591
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

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
