Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB317234AC2
	for <lists+linux-pwm@lfdr.de>; Fri, 31 Jul 2020 20:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387705AbgGaSTr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 31 Jul 2020 14:19:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39728 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbgGaSTq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 31 Jul 2020 14:19:46 -0400
Received: by mail-io1-f65.google.com with SMTP id z6so32611205iow.6;
        Fri, 31 Jul 2020 11:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NE4ItpfU50AFnsYbpWCsE7WvzgCYnBK1y1+JGXE6Q40=;
        b=TKKp0dqEZ3CAp6E3iAp9GpPu0MxJ7Bl/vPAmOZiKNJeTUJ4+wJWZOXJGH4CL/kmAtl
         MJCrchpbu5RQMwGE5/IP15yqPu7Cmg2bJP+1p3jf1ab2Kv2KEV0OJC/9gDPxAwsAlxt2
         h+HaYJme9Q6NQRuLMHO3SeXSX6RjUBYE3/IJ5mT2MiyKnHlTYHxNv/U1tQfvKF2fjNgO
         2l8xIlI4feXNUQRcV4WAGyb77Be2qBF29vbD8ZO2zpWCt0FfptUqb63zTdOij+Xzfq0g
         OyS6klqFtd+FM5EzD0b8CwSB8W1EtBek399qd/Q7Vmv3Z5N+oeSLpgHJvNtrUbcoo8RQ
         NQng==
X-Gm-Message-State: AOAM532y579myfjSvKLgo5Y41RcGRAZQzFs899bYwvOnV0vTGpDfoW0Q
        nIiw8Vz+P46hjR/ELa8Iiw==
X-Google-Smtp-Source: ABdhPJyx9267dTDySktREsgujV9q07VAPNW96EA3a/g1w3qYHEMQwM4OoSOAXV+7++XbEX4LpbUhWQ==
X-Received: by 2002:a02:c789:: with SMTP id n9mr6408918jao.40.1596219585405;
        Fri, 31 Jul 2020 11:19:45 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y12sm5038300ilg.84.2020.07.31.11.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 11:19:44 -0700 (PDT)
Received: (nullmailer pid 519607 invoked by uid 1000);
        Fri, 31 Jul 2020 18:19:44 -0000
Date:   Fri, 31 Jul 2020 12:19:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com
Subject: Re: [PATCH v6 1/2] Add DT bindings YAML schema for PWM fan
 controller of LGM SoC
Message-ID: <20200731181944.GB516550@bogus>
References: <cover.1595926036.git.rahul.tanwar@linux.intel.com>
 <e61e6a05353f6242f5450da130b042f195ac7620.1595926036.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e61e6a05353f6242f5450da130b042f195ac7620.1595926036.git.rahul.tanwar@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jul 28, 2020 at 04:52:12PM +0800, Rahul Tanwar wrote:
> Intel's LGM(Lightning Mountain) SoC contains a PWM fan controller
> which is only used to control the fan attached to the system. This
> PWM controller does not have any other consumer other than fan.
> Add DT bindings documentation for this PWM fan controller.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
> new file mode 100644
> index 000000000000..9879972470dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/intel,lgm-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LGM SoC PWM fan controller
> +
> +maintainers:
> +  - Rahul Tanwar <rahul.tanwar@intel.com>
> +
> +properties:
> +  compatible:
> +    const: intel,lgm-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  intel,fan-wire:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: Specifies fan mode. Default when unspecified is 2.
> +
> +  intel,max-rpm:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description:
> +      Specifies maximum RPM of fan attached to the system.
> +      Default when unspecified is 4000.

Again, these are properties of a fan, not the pwm controller. They 
belong in a fan node.

> +
> ++required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm: pwm@e0d00000 {
> +        compatible = "intel,lgm-pwm";
> +        reg = <0xe0d00000 0x30>;
> +        #pwm-cells = <2>;
> +        clocks = <&cgu0 126>;
> +        resets = <&rcu0 0x30 21>;
> +    };
> -- 
> 2.11.0
> 
