Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD332A6D7D
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Nov 2020 20:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbgKDTGR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 14:06:17 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:33081 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbgKDTGQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 14:06:16 -0500
Received: by mail-oi1-f173.google.com with SMTP id k26so17738oiw.0;
        Wed, 04 Nov 2020 11:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cFN5h9yGsHsZOKXv8QOHIY58GxPhGQOkwRhjB/ZiBHY=;
        b=FbgnidgIt7VLNJxNMEbNFFm3S6Chuc1G5n+V3jGI0MuARAkpiyEI7DJ5nrwuyKBV+1
         +b/CeVSjHeQTcahov28fS48DD66ZAH45QhIvynqnHNcTWf/C3Z1xoNO39Dqmmp/IDbP5
         m78PeMkk9jNAD/YWAl5++rdd53RYRW/PoICBxwiKSV2IdcbJR0r6eqYoEawlYgJQQe+T
         NkDIhhN2OFtaNrXYFdLUEwc9ajb+WliISCgIZQfg7nS8z6AIZp6fEXUmA2hOD8Qhf9wb
         CvjPal0ojb2LFyHc4uVW94NaKThwCkwS8Gyr3fOxuOb6zWV+dT5Gl5fZDiVKO0Db3Qwq
         me6w==
X-Gm-Message-State: AOAM531ZkwxqpnjizheeyfySpTfR6RiqNtQFqeYWdMpnPuvmmshrhMQW
        SiuGu4Evcud2upH65DPiHw==
X-Google-Smtp-Source: ABdhPJxg0zwV09ldz2969D3HBuxab6u1/Ts/gJbn+JECdctdgUFKh5ZxAEiWT0cSOANiSBHnw3BhhA==
X-Received: by 2002:aca:a951:: with SMTP id s78mr3577208oie.114.1604516775469;
        Wed, 04 Nov 2020 11:06:15 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r188sm658438oia.13.2020.11.04.11.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:06:14 -0800 (PST)
Received: (nullmailer pid 3960013 invoked by uid 1000);
        Wed, 04 Nov 2020 19:06:12 -0000
Date:   Wed, 4 Nov 2020 13:06:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>,
        Ray Jui <rjui@broadcom.com>, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        dmitry.torokhov@gmail.com, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-input@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        bgolaszewski@baylibre.com, sboyd@kernel.org,
        linux-gpio@vger.kernel.org, Scott Branden <sbranden@broadcom.com>,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v3 09/11] dt-bindings: pwm: Add binding for RPi firmware
 PWM bus
Message-ID: <20201104190612.GA3959462@bogus>
References: <20201104103938.1286-1-nsaenzjulienne@suse.de>
 <20201104103938.1286-10-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104103938.1286-10-nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 04 Nov 2020 11:39:35 +0100, Nicolas Saenz Julienne wrote:
> The PWM bus controlling the fan in RPi's official PoE hat can only be
> controlled by the board's co-processor.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changes since v1:
>  - Update bindings to use 2 #pwm-cells
> 
>  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 20 +++++++++++++++++++
>  .../pwm/raspberrypi,firmware-pwm.h            | 13 ++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 include/dt-bindings/pwm/raspberrypi,firmware-pwm.h
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.example.dt.yaml: firmware: pwm:#pwm-cells:0:0: 2 was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml


See https://patchwork.ozlabs.org/patch/1393804

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

