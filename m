Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003FC21DDCE
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jul 2020 18:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgGMQqD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Jul 2020 12:46:03 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38476 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729593AbgGMQqD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Jul 2020 12:46:03 -0400
Received: by mail-io1-f67.google.com with SMTP id l1so14201573ioh.5;
        Mon, 13 Jul 2020 09:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H1m/Teq+x/ilTIvfbGsXt4itCdaLyvafzNxPOtFihBg=;
        b=ELHmd2f2MdsNZSQGC+F6YlXmesAdgvPRey3aYo6+j1becm7KT+crvC0E7pKd+ry2t5
         4WItXeeyeNxiie9Zpp4C3i7pjnKaD61r/m4+vXDsdfSB6DbmenYKKvpJD8KPdJFVeNLP
         4IZCAzIE/eklIUqfSG2Wbe537F85jtFGb/wdwMswpZG8LXv6FDoejBD3fTni7n5rHb7N
         lq4iH0FvtZcHLVb6YY6lXjfo127T6eumcnAQwwOKyhDkDFZAQsQS9H18er+FfYxGqhRu
         TLWMa5c4aWynqeCvC/aRuvdBu3vDvey0eDrh9lmX0SX/BfAENOIrJQKks/59fLLdvm+/
         LxCw==
X-Gm-Message-State: AOAM530/5wyD5qTTIPUd29ZGjZHUcSLZKcSLM+E9yUYr0OYkGoFzBwN+
        0+bqZO7LpyuQyHNArAiU/A==
X-Google-Smtp-Source: ABdhPJxrujumDriuqPPBU6YyvN7fQLld9rwVoqG6+j8iuptKd1wORLde6EnsrYNYBwaOdB0cQ7qrew==
X-Received: by 2002:a02:cf12:: with SMTP id q18mr1034219jar.3.1594658762332;
        Mon, 13 Jul 2020 09:46:02 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y12sm5627632iot.49.2020.07.13.09.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 09:46:01 -0700 (PDT)
Received: (nullmailer pid 364057 invoked by uid 1000);
        Mon, 13 Jul 2020 16:46:00 -0000
Date:   Mon, 13 Jul 2020 10:46:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com
Subject: Re: [PATCH v4 1/2] Add DT bindings YAML schema for PWM fan
 controller of LGM SoC
Message-ID: <20200713164600.GA359372@bogus>
References: <cover.1593503228.git.rahul.tanwar@linux.intel.com>
 <cfef33c19b97a9cfbb8ecc0c6a122f3c9a5b46dd.1593503228.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfef33c19b97a9cfbb8ecc0c6a122f3c9a5b46dd.1593503228.git.rahul.tanwar@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jun 30, 2020 at 03:55:31PM +0800, Rahul Tanwar wrote:
> Intel's LGM(Lightning Mountain) SoC contains a PWM fan controller
> which is only used to control the fan attached to the system. This
> PWM controller does not have any other consumer other than fan.
> Add DT bindings documentation for this PWM fan controller.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
> new file mode 100644
> index 000000000000..120bf3d85a24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
> @@ -0,0 +1,50 @@
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

These are properties of the fan, not the PWM. And probably if you 
need these properties then others would too, so they should be 
common. Look at the pwm-fan.txt binding.

Rob
