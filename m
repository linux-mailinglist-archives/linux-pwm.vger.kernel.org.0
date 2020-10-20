Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF65E293F7F
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Oct 2020 17:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408725AbgJTPYZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Oct 2020 11:24:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37976 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408723AbgJTPYY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Oct 2020 11:24:24 -0400
Received: by mail-oi1-f195.google.com with SMTP id h10so2535146oie.5;
        Tue, 20 Oct 2020 08:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UbDWrjHSxQBCKcopCeTd3/tMtO1BT0WFKcSSPlQlJbs=;
        b=plNO9LYZmjB/IrqCLUYgUw91yJXyv7hNH4Ymo/DU9pEshBLQDH8suZVRFQEs9RKizb
         b/aF7N+GliOysRMG6pwSwo4H715CFIBMOKNI644KjBg3kQXlGkzymrE02u7d1LJ8naHX
         3TNZRCSzL+z3Xzjc/HiroK/yPrIjWQCRC4RRMXHvKzGlDL75zu85EUUG+UvhGE0s1vqr
         GGqO791EoOGXJxFF7Joq0Dm273SQzJvcMdYzI2LmfquE/twoxMdLFzfPzxBB6dC04/CP
         Zy7us3NHX60jvje/VM2yWZQUQwg/T1FLIOCaDQKWpq2zpoS5ozOZClUjWrMRsQHqmSqZ
         dk3g==
X-Gm-Message-State: AOAM533z4SIXiOfaluuaXcyzPRyJpk4yXQpbiZDKSZeU+xafkLUDLwqk
        P5myLY+NBTsy9f/sTdaxQFCVlSxW5Q==
X-Google-Smtp-Source: ABdhPJxcLyb47QZ1eICVfqORcAoUaOfIP0VRucG632r1B+CHlsgQWtOYJHMBPVnvItgkG31SKZytrA==
X-Received: by 2002:aca:4911:: with SMTP id w17mr2111296oia.80.1603207463910;
        Tue, 20 Oct 2020 08:24:23 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b139sm623533oii.19.2020.10.20.08.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 08:24:22 -0700 (PDT)
Received: (nullmailer pid 867186 invoked by uid 1000);
        Tue, 20 Oct 2020 15:24:21 -0000
Date:   Tue, 20 Oct 2020 10:24:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     vijayakannan.ayyathurai@intel.com
Cc:     robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de,
        lakshmi.bai.raja.subramanian@intel.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, mgross@linux.intel.com,
        andriy.shevchenko@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: Re: [PATCH v13 2/2] dt-bindings: pwm: keembay: Add bindings for
 Intel Keem Bay PWM
Message-ID: <20201020152421.GA866676@bogus>
References: <cover.1603127898.git.vijayakannan.ayyathurai@intel.com>
 <48f86a9a525701cfc61e3375d1d6f65ce38a9b26.1603127898.git.vijayakannan.ayyathurai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48f86a9a525701cfc61e3375d1d6f65ce38a9b26.1603127898.git.vijayakannan.ayyathurai@intel.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 20 Oct 2020 01:28:47 +0800, vijayakannan.ayyathurai@intel.com wrote:
> From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> 
> Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.
> 
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> ---
>  .../bindings/pwm/intel,keembay-pwm.yaml       | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

./Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml:31:2: [warning] wrong indentation: expected 2 but found 1 (indentation)


See https://patchwork.ozlabs.org/patch/1384452

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

