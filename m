Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832F737EE70
	for <lists+linux-pwm@lfdr.de>; Thu, 13 May 2021 00:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346191AbhELVnV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 May 2021 17:43:21 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:37786 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385232AbhELUHi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 May 2021 16:07:38 -0400
Received: by mail-oi1-f176.google.com with SMTP id k25so23419961oic.4;
        Wed, 12 May 2021 13:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ZT4JNzSVA4XzKpARhAEfHQrvscUrf/xbLw82kFR8CgM=;
        b=gUYvJSMePg6fhzUY7HrLQWKBXq5ZoZjxqu1wYUjOb894V34suYFMTfeniJfdwigZpC
         tdqyOpCXdPKF3FrJNFlAEXLNYcSOMcROPV2IbPM5BXg/mcVqKwQMWg1Dj60gG7x/4B9+
         FBuvIwXxdOiR5F2Pta7iGt0S8xhBL8DqdvwVo4fob/G2cogTylB0qjTS2M2NZXxHxHDK
         nbsPaKpFq0xixVz1JIDUv45MxX8eQekzr++8zWiyN93zFfySgYkK6/1aUteavS2sd8Bl
         vtUmeT+P472696GFJq5m5Xqtnl2mMXw5MRObuXFt6IHB3JJvLbmrPCym2G8l9RAJK/+C
         86zA==
X-Gm-Message-State: AOAM532YmmW0S3QK66werJdHwr5RkAZ96zCou8DbnjLsXXisNNpwhiyX
        F6TMH2AwdLxrTdTuldTrIw==
X-Google-Smtp-Source: ABdhPJyx3BiGpIeRJ3UIVk48+wQi6XdGs6DMxX1QJJ+UbedL6x3vdBzMYF8skTJgNZgJb8r3EWzcbQ==
X-Received: by 2002:aca:1a05:: with SMTP id a5mr182147oia.26.1620849989353;
        Wed, 12 May 2021 13:06:29 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h184sm191133oia.1.2021.05.12.13.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 13:06:28 -0700 (PDT)
Received: (nullmailer pid 204078 invoked by uid 1000);
        Wed, 12 May 2021 18:35:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     michal.simek@xilinx.com, linux-pwm@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20210511191239.774570-1-sean.anderson@seco.com>
References: <20210511191239.774570-1-sean.anderson@seco.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
Date:   Wed, 12 May 2021 13:35:16 -0500
Message-Id: <1620844516.484369.204077.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 11 May 2021 15:12:37 -0400, Sean Anderson wrote:
> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
> a "soft" block, so it has many parameters which would not be
> configurable in most hardware. This binding is usually automatically
> generated by Xilinx's tools, so the names and values of some properties
> must be kept as they are. Replacement properties have been provided for
> new device trees.
> 
> Because we need to init timer devices so early in boot, the easiest way
> to configure things is to use a device tree property. For the moment
> this is 'xlnx,pwm', but this could be extended/renamed/etc. in the
> future if these is a need for a generic property.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> How should the clocking situation be documented? For the moment I have
> just left clock as optional, but should clock-frequency be documented?
> 
> Changes in v3:
> - Mark all boolean-as-int properties as deprecated
> - Add xlnx,pwm and xlnx,gen?-active-low properties.
> - Make newer replacement properties mutually-exclusive with what they
>   replace
> - Add an example with non-deprecated properties only.
> 
> Changes in v2:
> - Use 32-bit addresses for example binding
> 
>  .../bindings/pwm/xlnx,axi-timer.yaml          | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml:16:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pwm/xlnx,axi-timer.example.dts:49.37-57.11: ERROR (duplicate_label): /example-1/timer@800e0000: Duplicate label 'axi_timer_0' on /example-1/timer@800e0000 and /example-0/timer@800e0000
ERROR: Input tree has errors, aborting (use -f to force output)
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/pwm/xlnx,axi-timer.example.dt.yaml] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1416: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1477288

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

