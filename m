Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE94234ABD
	for <lists+linux-pwm@lfdr.de>; Fri, 31 Jul 2020 20:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbgGaSSO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 31 Jul 2020 14:18:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34655 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbgGaSSO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 31 Jul 2020 14:18:14 -0400
Received: by mail-io1-f66.google.com with SMTP id q75so24397360iod.1;
        Fri, 31 Jul 2020 11:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RGiMdYzUkEPPm3pp0LeiP67GCX2/1SzNgiuC+BC1MUk=;
        b=R1GEoOp6uMvalpq98Nf0D/3mxGfA21rNoAnTZ4fNZZBwBnIx9Jm0RDDSwHUzKs0kow
         1rT2pyPYIB2uC8EVo96dSGz0ZB90SHaWPqc/BBWTim9TnToDcDWR7bnX0ugXomxCypK0
         F4fi2eu2qazQBZHFfq30qNtQ5XxHxPC4wuUzEvGoV9InpsOzCLQI8z8afXh6I77Td/yQ
         kzt9YAeY8k0YqvUbTWPQuTPR2uTrbAzVFklSd1Mq/UTgmIu3d+54+WxTNSMlHAZp3mBy
         k8Qf9AdxaRahrFAIQE6HhVObPSH5MyLjJ40evKLq616FMpYDRy2XzvpxV++hfWronwvT
         gv7w==
X-Gm-Message-State: AOAM5315CIx+Nrc8PSsfV1UEA3risesBTAGw29Ddrbjs4alvjlPsPIMQ
        BdxeQkabseredpydUQ4ZmA==
X-Google-Smtp-Source: ABdhPJxDM7dI1r2+OGQWbscdg/qWt/ZeeT+3XCFBJEix+4GhU7gzuhPEOhHYTD6obv9Aud7lZduc5A==
X-Received: by 2002:a6b:7945:: with SMTP id j5mr4825788iop.143.1596219492991;
        Fri, 31 Jul 2020 11:18:12 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id n67sm4574678ild.71.2020.07.31.11.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 11:18:11 -0700 (PDT)
Received: (nullmailer pid 517182 invoked by uid 1000);
        Fri, 31 Jul 2020 18:18:10 -0000
Date:   Fri, 31 Jul 2020 12:18:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     andriy.shevchenko@intel.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, thierry.reding@gmail.com,
        qi-ming.wu@intel.com, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        rahul.tanwar.linux@gmail.com, cheol.yong.kim@intel.com
Subject: Re: [PATCH v6 1/2] Add DT bindings YAML schema for PWM fan
 controller of LGM SoC
Message-ID: <20200731181810.GA516550@bogus>
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

On Tue, 28 Jul 2020 16:52:12 +0800, Rahul Tanwar wrote:
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


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml: Additional properties are not allowed ('+required' was unexpected)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml: Additional properties are not allowed ('+required' was unexpected)
Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/pwm/intel,lgm-pwm.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/pwm/intel,lgm-pwm.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1337629

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

