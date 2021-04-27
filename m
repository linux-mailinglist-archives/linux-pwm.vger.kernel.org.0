Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D608A36C68B
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Apr 2021 14:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbhD0M5z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 27 Apr 2021 08:57:55 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:36641 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbhD0M5v (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 27 Apr 2021 08:57:51 -0400
Received: by mail-oi1-f172.google.com with SMTP id i26so4290683oii.3;
        Tue, 27 Apr 2021 05:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=rFoPXvGb1JtyBzu9l/r6cY4fSMekVIRELQco4ayK1NI=;
        b=CNAc+/18BknFkSuBWnSev6GhO9S8IyMddNeRoqD7gW8rQpnnqxCnFtXMfBBm0tvXC6
         nB/OI90Kc4EUydXwQGWHMObpX6c3NKjWwZUFM+uEmTIIKlOpZlQ5ZE1PKYMzbYztVTxr
         2an9WYy8C6d5UTpqICndG687WxS4nOmYcOEh58du8zTUN338pagbKu+YYzInb/fZQSaX
         N/mPQM6wWaIC+25S29pftAH03WsyLMHSkC1gbQhnr94KaHyA6jB2cItHyU3KS8oP0DJ+
         BUoFLAWNPzGfTbhwp1R5P9xfrJcqjG1eiW/I4Wb5C0TY5p8SEHsQ4hZb2UDJPIOVPk0u
         UiZw==
X-Gm-Message-State: AOAM533eAikCl54RpfNzx9VAxep5BFP7N2OW4SYvQPGk7ygJN4Dkfchj
        bpRYjg/t28eFOkkgyphVXw==
X-Google-Smtp-Source: ABdhPJwM44JxerROpT3ApIxLaKblGtdBJU69E/VgkkOIh7U3tZybzktLqkK+0Ia1ylvgSnPtle4f+w==
X-Received: by 2002:a05:6808:1cc:: with SMTP id x12mr3296849oic.114.1619528226258;
        Tue, 27 Apr 2021 05:57:06 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z197sm3737837oia.3.2021.04.27.05.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 05:57:05 -0700 (PDT)
Received: (nullmailer pid 1346448 invoked by uid 1000);
        Tue, 27 Apr 2021 12:57:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Fenglin Wu <fenglinw@codeaurora.org>
Cc:     collinsd@codeaurora.org, linux-pwm@vger.kernel.org,
        subbaram@codeaurora.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, aghayal@codeaurora.org,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
In-Reply-To: <20210427102247.822-2-fenglinw@codeaurora.org>
References: <20210427102247.822-1-fenglinw@codeaurora.org> <20210427102247.822-2-fenglinw@codeaurora.org>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: add bindings for PWM modules inside QCOM PMICs
Date:   Tue, 27 Apr 2021 07:57:01 -0500
Message-Id: <1619528221.595166.1346447.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 27 Apr 2021 18:22:09 +0800, Fenglin Wu wrote:
> Add bindings for QCOM PMIC PWM modules which are accessed through SPMI
> bus.
> 
> Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
> ---
>  .../devicetree/bindings/pwm/pwm-qcom.yaml          | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-qcom.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pwm/pwm-qcom.yaml:29:6: [warning] wrong indentation: expected 4 but found 5 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/pwm-qcom.yaml: Additional properties are not allowed ('Properties' was unexpected)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/pwm-qcom.yaml: Additional properties are not allowed ('Properties' was unexpected)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/pwm-qcom.yaml: 'anyOf' conditional failed, one must be fixed:
	'properties' is a required property
	'patternProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/pwm-qcom.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/pwm/pwm-qcom.yaml
Documentation/devicetree/bindings/pwm/pwm-qcom.example.dts:21.13-28: Warning (reg_format): /example-0/pwms@e800:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/pwm/pwm-qcom.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/pwm/pwm-qcom.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/pwm/pwm-qcom.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/pwm/pwm-qcom.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/pwm/pwm-qcom.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/pwm-qcom.example.dt.yaml: example-0: pwms@e800:reg:0: [59392] is too short
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
Documentation/devicetree/bindings/pwm/pwm-qcom.example.dt.yaml:0:0: /example-0/pwms@e800: failed to match any schema with compatible: ['qcom,pwm']

See https://patchwork.ozlabs.org/patch/1470623

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

