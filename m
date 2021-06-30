Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04E73B853B
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Jun 2021 16:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbhF3OtI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Jun 2021 10:49:08 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:48954 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbhF3OtF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Jun 2021 10:49:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1625064397; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=XyKDiODvliERgv50vKj1x6QF0TJ/5j1C/p7t9fvUQXU=;
 b=Tki+cn94S6JkVHEZODsZEFp6OGoq254BH5VzNNZ8Z/g/4+vX4uXGgCosvjKqH8jXGj5Q51si
 hi71BLBLScJ8xBZQ0cumCH5mwXkLTVQWSFH8o1Zy6Lpss+YP5AXyKExfICqhxR9iYNHEzV/q
 ga8G+t4mdTaS6YBqZexxw8Vbxhw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJkZWM1ZCIsICJsaW51eC1wd21Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60dc83bfad0600eede5b20d1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Jun 2021 14:46:23
 GMT
Sender: kathirav=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6E7C9C4338A; Wed, 30 Jun 2021 14:46:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kathirav)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71476C433D3;
        Wed, 30 Jun 2021 14:46:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Jun 2021 20:16:20 +0530
From:   Kathiravan T <kathirav@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: pwm: add IPQ6018 binding
In-Reply-To: <YLgO0Aj1d4w9EcPv@yoga>
References: <ea071bbcab92d4a296c7aee5d72de0427676847a.1621851644.git.baruch@tkos.co.il>
 <249bddc521b15e992d0846edf1813aeb577458b9.1621851644.git.baruch@tkos.co.il>
 <YLgO0Aj1d4w9EcPv@yoga>
Message-ID: <5d1bb3b8b0eeedd82a3a6fb02ff5794d@codeaurora.org>
X-Sender: kathirav@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2021-06-03 04:35, Bjorn Andersson wrote:
> On Mon 24 May 05:20 CDT 2021, Baruch Siach wrote:
> 
>> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
>> 
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>> v2: Make #pwm-cells const (Rob Herring)
>> ---
>>  .../devicetree/bindings/pwm/ipq-pwm.yaml      | 52 
>> +++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml 
>> b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
>> new file mode 100644
>> index 000000000000..f85ce808a14e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
>> @@ -0,0 +1,52 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/ipq-pwm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm IPQ6018 PWM controller
>> +
>> +maintainers:
>> +  - Baruch Siach <baruch@tkos.co.il>
>> +
>> +properties:
>> +  "#pwm-cells":
>> +    const: 2
>> +
>> +  compatible:
>> +    const: qcom,pwm-ipq6018
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: core
>> +
>> +required:
>> +  - "#pwm-cells"
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,gcc-ipq6018.h>
>> +
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        pwm@1941010 {
>> +            #pwm-cells = <2>;
>> +            compatible = "qcom,pwm-ipq6018";
>> +            reg = <0x0 0x1941010 0x0 0x20>;
> 
> These 32 bytes are in the middle of the TCSR block, which is already
> partially described by the &tcsr_q6 node, which is described as only
> compatible = "syscon" - something no longer accepted by the DT
> maintainers.
> 
> As such, I think we should adjust the &tcsr_q6 definition to cover the
> entire TCSR: 0x01937000 of size 0x21000.
> 

To my knowledge, we can cover the entire TCSR region, so that we can use 
it
for the other features like qcom,dload-mode as well.

> 
> @Rob, should we represent the entire tcsr as a simple-mfd and then have
> the pwm and q6 region as children of that? Or can we make the whole
> thing as a simple-mfd and a syscon and only describe the pwm as a 
> child?
> 
> Regards,
> Bjorn
> 
>> +            clocks = <&gcc GCC_ADSS_PWM_CLK>;
>> +            clock-names = "core";
>> +        };
>> +    };
>> --
>> 2.30.2
>> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of Code Aurora Forum, hosted by The Linux Foundation
