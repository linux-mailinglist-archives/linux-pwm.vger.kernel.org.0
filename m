Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA0636D5FC
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Apr 2021 12:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbhD1Kzr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Apr 2021 06:55:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:17235 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239580AbhD1Kzq (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 28 Apr 2021 06:55:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619607302; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=wM+iIS9aBiosy9WN+kXt89fq97297X7zgtANmIQf60U=;
 b=MVb+FU+tkuvinqYAHTVI5fLHJ58a8TQKcQyIDB2M8Tque5ih6Vm0IYnMW6dmmvTQUKrI5CZh
 g+G8OaXlck/AtUfLn/qQ+5f9C45sOi0z2/hQhSZYopgkDEivVlDN1kzeD2ZvonwW2P8BdePe
 I4tSy5hJnocN5n9x27aLzP6VTbc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJkZWM1ZCIsICJsaW51eC1wd21Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60893eda87ce1fbb56353cfa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 28 Apr 2021 10:54:18
 GMT
Sender: fenglinw=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0A4F0C433D3; Wed, 28 Apr 2021 10:54:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: fenglinw)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 13AF5C433F1;
        Wed, 28 Apr 2021 10:54:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 28 Apr 2021 18:54:16 +0800
From:   fenglinw@codeaurora.org
To:     Rob Herring <robh@kernel.org>
Cc:     collinsd@codeaurora.org, linux-pwm@vger.kernel.org,
        subbaram@codeaurora.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Uwe_K?= =?UTF-8?Q?leine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, aghayal@codeaurora.org,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: add bindings for PWM modules inside
 QCOM PMICs
In-Reply-To: <1619528221.595166.1346447.nullmailer@robh.at.kernel.org>
References: <20210427102247.822-1-fenglinw@codeaurora.org>
 <20210427102247.822-2-fenglinw@codeaurora.org>
 <1619528221.595166.1346447.nullmailer@robh.at.kernel.org>
Message-ID: <9f8c304696d12250293f88b3d6718eee@codeaurora.org>
X-Sender: fenglinw@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2021-04-27 20:57, Rob Herring wrote:
> On Tue, 27 Apr 2021 18:22:09 +0800, Fenglin Wu wrote:
>> Add bindings for QCOM PMIC PWM modules which are accessed through SPMI
>> bus.
>> 
>> Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
>> ---
>>  .../devicetree/bindings/pwm/pwm-qcom.yaml          | 51 
>> ++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/pwm/pwm-qcom.yaml
>> 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/pwm/pwm-qcom.yaml:29:6: [warning]
> wrong indentation: expected 4 but found 5 (indentation)
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/pwm-qcom.yaml:
> Additional properties are not allowed ('Properties' was unexpected)
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/pwm-qcom.yaml:
> Additional properties are not allowed ('Properties' was unexpected)
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/pwm-qcom.yaml:
> 'anyOf' conditional failed, one must be fixed:
> 	'properties' is a required property
> 	'patternProperties' is a required property
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/pwm-qcom.yaml:
> ignoring, error in schema:
> warning: no schema found in file:
> ./Documentation/devicetree/bindings/pwm/pwm-qcom.yaml
> Documentation/devicetree/bindings/pwm/pwm-qcom.example.dts:21.13-28:
> Warning (reg_format): /example-0/pwms@e800:reg: property has invalid
> length (4 bytes) (#address-cells == 1, #size-cells == 1)
> Documentation/devicetree/bindings/pwm/pwm-qcom.example.dt.yaml:
> Warning (pci_device_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/pwm/pwm-qcom.example.dt.yaml:
> Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/pwm/pwm-qcom.example.dt.yaml:
> Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/pwm/pwm-qcom.example.dt.yaml:
> Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/pwm/pwm-qcom.example.dt.yaml:
> Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/pwm-qcom.example.dt.yaml:
> example-0: pwms@e800:reg:0: [59392] is too short
> 	From schema: 
> /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> Documentation/devicetree/bindings/pwm/pwm-qcom.example.dt.yaml:0:0:
> /example-0/pwms@e800: failed to match any schema with compatible:
> ['qcom,pwm']
> 
> See https://patchwork.ozlabs.org/patch/1470623
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

Thanks for the information. It's my 1st time to write binding using yaml 
format, I hadn't noticed there was a checker can be used for sanity 
test. I will update and run the dt_binding_check at my side before 
uploading new patchset.
