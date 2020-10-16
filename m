Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0DD290929
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Oct 2020 18:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409180AbgJPQEM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Oct 2020 12:04:12 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42479 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409170AbgJPQEL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Oct 2020 12:04:11 -0400
Received: by mail-oi1-f193.google.com with SMTP id 16so2952911oix.9;
        Fri, 16 Oct 2020 09:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zkprbk0K/dvPokaiWlkn/QFdHthGYxnFbcj69izoSew=;
        b=gE8qoEqavyOATCva1uGWumR+Het/mxCiOxUkO7IKVbrDaA4ZwX7LAjZbUe3H7UEuvK
         cMxmX67iWqjbDfcaM52iqM4MgT6EqEaIjiMMKIeTZd++aRKSwAm/HE/VAGj3NtilS3m+
         WGhWErjvnu6IQ4RkkAqkBivMgAgdzslrjsJf3k3TgA9sQyYbNlMD8yGYAHTLQFNqKa83
         iel3+uiZ815tCcwgFmbnrLkBB8vOEcPdGunfDEcQ9gWJeFAyCurUEqhsl3iDBXOn4sxU
         +JmjUllv2LfIAl5ZaI2GQ3/RaxUMd93lsR2aBQOx19/0n8vWcuTSxCCumsDErhdr8+Ce
         CkFw==
X-Gm-Message-State: AOAM530PX0NL2F63pWkbumcj20xUtke7xCmnirQSlRdAyX6wDd8zuU6C
        5sclXU/O7jMoqjyYKj9WqQ==
X-Google-Smtp-Source: ABdhPJx4uuGxP3akS8UJPfnhisJm/Q5p7JbPI7KfJO0oQk/gt3oFAPe2b+T4gOV/1WoD1d9zQxtbcg==
X-Received: by 2002:aca:cc0a:: with SMTP id c10mr3024760oig.166.1602864250851;
        Fri, 16 Oct 2020 09:04:10 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m29sm1098155otj.38.2020.10.16.09.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 09:04:09 -0700 (PDT)
Received: (nullmailer pid 1495258 invoked by uid 1000);
        Fri, 16 Oct 2020 16:04:09 -0000
Date:   Fri, 16 Oct 2020 11:04:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     vijayakannan.ayyathurai@intel.com
Cc:     robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de,
        lakshmi.bai.raja.subramanian@intel.com, mgross@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v12 2/2] dt-bindings: pwm: keembay: Add bindings for
 Intel Keem Bay PWM
Message-ID: <20201016160409.GA1494813@bogus>
References: <cover.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <9cff78f955eb7b1f243380c79cdd48aa6d2ddc81.1602703463.git.vijayakannan.ayyathurai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cff78f955eb7b1f243380c79cdd48aa6d2ddc81.1602703463.git.vijayakannan.ayyathurai@intel.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 15 Oct 2020 03:36:10 +0800, vijayakannan.ayyathurai@intel.com wrote:
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


See https://patchwork.ozlabs.org/patch/1382326

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

